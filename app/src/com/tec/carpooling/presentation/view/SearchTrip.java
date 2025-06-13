/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import com.tec.carpooling.domain.entity.User;
import com.tec.carpooling.domain.entity.TripSummary;
import com.tec.carpooling.data.dao.TripDAO;
import com.tec.carpooling.domain.entity.Institution;
import com.tec.carpooling.domain.entity.PaymentMethod;
import com.tec.carpooling.domain.entity.Waypoint;
import com.tec.carpooling.data.dao.ProvinceDAO;
import com.tec.carpooling.domain.entity.Province;
import com.tec.carpooling.data.dao.CantonDAO;
import com.tec.carpooling.domain.entity.Canton;
import com.tec.carpooling.data.dao.DistrictDAO;
import com.tec.carpooling.domain.entity.District;
import com.tec.carpooling.data.dao.TripSummaryDAO;
import com.tec.carpooling.data.dao.PassengerXTripDAO;
import com.tec.carpooling.data.dao.PassengerTripPaymentDAO;
import com.tec.carpooling.data.dao.PassengerWaypointDAO;
import com.tec.carpooling.data.dao.PhotoDAO;
import com.tec.carpooling.domain.entity.Photo;

import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.data.dao.CountryDAO;
import com.tec.carpooling.domain.entity.Country;
import com.tec.carpooling.domain.entity.TripDetails;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

import java.awt.*;
import java.awt.event.ItemEvent;
import java.net.URL;
import javax.swing.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Locale;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import java.util.Optional;

/**
 *
 * @author hidal
 */
public class SearchTrip extends javax.swing.JFrame {
    private String userRole;
    private final User user;
    private List<TripSummary> availableTrips;
    /**
     * Creates new form SearchTrip
     */
    public SearchTrip(String role, User user) {
        this.user = user;
        this.userRole = role;
        initComponents();
        getContentPane().add(SideMenu.createToolbar(this, userRole, user), BorderLayout.WEST);

        loadInstitutions();
        loadPaymentMethods();

        // Card layout panels
        cardPanel.add(panelDriver, "Driver Information");
        cardPanel.add(panelVehicle, "Vehicle Information");
        cardPanel.add(panelStops, "Stops During the Trip");
        cardPanel.add(panelTimeCost, "Times and Cost");

        ImageIcon photo = new ImageIcon(getClass().getResource("/Assets/passenger.jpg"));
        Image scaledPassenger = photo.getImage().getScaledInstance(100, 100, Image.SCALE_SMOOTH);
        photoDriver.setIcon(new ImageIcon(scaledPassenger));

        // Wire Information combo to CardLayout
        CardLayout cl = (CardLayout) cardPanel.getLayout();
        boxInfo.addActionListener(e -> {
            String card = (String) boxInfo.getSelectedItem();
            if (card != null) {
                cl.show(cardPanel, card);
            }
        });

        // Trip list selection -> load full details
        listTrips.addListSelectionListener(evt -> {
            if (!evt.getValueIsAdjusting()) {
              int idx = listTrips.getSelectedIndex();
              if (idx >= 0 && availableTrips != null) {
                long tripId = availableTrips.get(idx).getTripId();
                try (Connection conn = DatabaseConnection.getConnection()) {
                  TripDAO dao = new TripDAO();
                  TripDetails details = dao.getFullTripDetails(tripId, conn);
                  if (details != null) {
                    showTripDetails(details);
                    // populate the stops‐combo as well:
                    loadWaypointsForTrip(tripId);

                    // reset to first card:
                    boxInfo.setSelectedItem("Driver Information");
                    ((CardLayout)cardPanel.getLayout())
                        .show(cardPanel, "Driver Information");
                  }
                } catch (SQLException ex) {
                  ex.printStackTrace();
                  JOptionPane.showMessageDialog(this,
                      "Error loading trip details: " + ex.getMessage());
                }
              }
            }
          });

        this.setExtendedState(JFrame.MAXIMIZED_BOTH);
    }

    // ... existing helper methods (loadInstitutions, loadPaymentMethods, loadCountries,
    //     loadProvinces, loadCantons, loadDistricts, customizeDatePicker,
    //     showCoordinatesList, loadWaypointsForTrip, filterAvailableTimes, etc.)

    private void showTripDetails(TripDetails d) {
        // —— Driver photo —— 
        try (Connection conn = DatabaseConnection.getConnection()) {
            PhotoDAO photoDAO = new PhotoDAO();
            Photo driverPhoto = photoDAO.getLatestPhoto(d.getDriverPersonId(), conn);

            if (driverPhoto != null && driverPhoto.getImage() != null) {
                byte[] imgBytes = driverPhoto.getImage();
                Image raw = new ImageIcon(imgBytes).getImage();

                // scale to fit max 200×150, preserving aspect ratio
                int maxW = 120, maxH = 80;
                int w = raw.getWidth(null), h = raw.getHeight(null);
                double scale = Math.min((double)maxW / w, (double)maxH / h);
                int newW = (int)(w * scale), newH = (int)(h * scale);

                Image scaled = raw.getScaledInstance(newW, newH, Image.SCALE_SMOOTH);
                photoDriver.setIcon(new ImageIcon(scaled));
                photoDriver.setText("");  // remove any placeholder text
                photoDriver.setPreferredSize(new Dimension(maxW, maxH));
                photoDriver.setBorder(
                    BorderFactory.createEmptyBorder(0, 60, 0, 0)
                );
            } else {
                photoDriver.setIcon(null);
                photoDriver.setText("No Photo");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            photoDriver.setIcon(null);
            photoDriver.setText("No Photo");
        }

        // —— Driver info —— 
        labelName.setText(d.getDriverName());
        labelGender.setText(d.getGender());
        labelAge.setText(String.valueOf(d.getAge()));
        DefaultListModel<String> phoneModel = new DefaultListModel<>();
        for (String phone : d.getDriverPhones()) {
            phoneModel.addElement(phone);
        }
        listNumbers.setModel(phoneModel);

        // —— Vehicle panel —— 
        labelPlate.setText(d.getPlate());
        labelChosenCapacity.setText(String.valueOf(d.getMaxSeats()));
        labelSeatsLeft.setText(String.valueOf(d.getChosenSeats()));

        // —— Stops panel —— 
        labelStart.setText(d.getStartLocation());
        labelEnd.setText(d.getEndLocation());
        showCoordinatesList(d.getCoordinates());

        // —— Time & Cost panel —— 
        labelStartTime.setText(d.getStartTime().toString());
        labelEndTime  .setText(d.getEndTime().toString());
        labelCost     .setText(String.valueOf(d.getPricePerPassenger()));
    }
    
    private void loadTripsForInstitution(Institution selectedInstitution) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            TripSummaryDAO tripSummaryDAO = new TripSummaryDAO();
            List<TripSummary> trips = tripSummaryDAO.getAvailableTripsByInstitution(selectedInstitution.getId(), user.getPersonId(), conn);

            DefaultListModel<String> model = new DefaultListModel<>();
            for (TripSummary trip : trips) {
                model.addElement(trip.getStartPoint() + " - " + trip.getTripDate());
            }
            listTrips.setModel(model);

            // Optional: save the list for future reference on booking
            this.availableTrips = trips;

        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading trips: " + e.getMessage());
        }
    }
    
    private void showCoordinatesList(List<double[]> coordenates) {
        panelList.removeAll();  // Limpia lista anterior (panel dentro de scroll)

        for (double[] coord : coordenates) {
            double lat = coord[0];
            double lon = coord[1];

            JPanel fila = new JPanel(new FlowLayout(FlowLayout.LEFT));
            fila.setMaximumSize(new Dimension(Integer.MAX_VALUE, 30));
            fila.setBackground(new Color(245, 245, 245));
            fila.setOpaque(true);

            JLabel lbl = new JLabel(String.format("Lat: %.5f, Lon: %.5f", lat, lon));

            JButton btnPin = new JButton("📍");
            btnPin.setBorder(BorderFactory.createEmptyBorder());
            btnPin.setContentAreaFilled(false);
            btnPin.setForeground(Color.BLUE);
            btnPin.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));

            btnPin.addActionListener(e -> {
                new MapViewer(lat, lon).setVisible(true);
            });
            btnPin.setFont(new Font("Dialog", Font.PLAIN, 12)); // Windows
            fila.add(btnPin);
            fila.add(lbl);
            panelList.add(fila);
        }

        panelList.revalidate();
        panelList.repaint();
    }
    
    private void loadWaypointsForTrip(long tripId) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            TripSummaryDAO tripDAO = new TripSummaryDAO();
            List<Waypoint> stops = tripDAO.getWaypointsByTripId(tripId, conn);

            DefaultComboBoxModel<Waypoint> model = new DefaultComboBoxModel<>();
            for (Waypoint wp : stops) {
                // Skip waypoints with null lat or lon
                if (wp.getLatitude() != null && wp.getLongitude() != null) {
                    String label = String.format("Lat: %.5f, Lon: %.5f", wp.getLatitude(), wp.getLongitude());
                    // You can either override toString() in Waypoint to return this label,
                    // or store the label elsewhere and display it manually
                    model.addElement(wp);
                }
            }
            boxStops.setModel(model);

        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading stops: " + e.getMessage());
        }
    }
    
    private void loadInstitutions() {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql =
                "SELECT i.id, i.name                                      " +
                "  FROM carpooling_adm.INSTITUTION i                      " +
                "  JOIN carpooling_pu.institution_person ip               " +
                "    ON ip.institution_id = i.id                          " +
                " WHERE ip.person_id = ?                                  " +
                " ORDER BY i.name";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setLong(1, user.getPersonId());

                try (ResultSet rs = stmt.executeQuery()) {
                    boxInstitutions.removeAllItems();
                    boxInstitutions.addItem(new Institution(0, "Select Institution"));

                    while (rs.next()) {
                        long id   = rs.getLong("id");
                        String nm = rs.getString("name");
                        boxInstitutions.addItem(new Institution(id, nm));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this,
                "Error loading institutions: " + e.getMessage(),
                "Error",
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void loadPaymentMethods() {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT id, name FROM carpooling_adm.PAYMENTMETHOD ORDER BY name";
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                boxMethod.removeAllItems();
                boxMethod.addItem(new PaymentMethod(0, "Payment Method"));

                while (rs.next()) {
                    long id = rs.getLong("id");
                    String name = rs.getString("name");
                    boxMethod.addItem(new PaymentMethod(id, name));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading payment methods: " + e.getMessage());
        }
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {
        java.awt.GridBagConstraints gridBagConstraints;

        jPanel1 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        listTrips = new javax.swing.JList<>();
        labelSearchTrips = new javax.swing.JLabel();
        jLabel1 = new javax.swing.JLabel();
        filler1 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        boxInfo = new javax.swing.JComboBox<>();
        cardPanel = new javax.swing.JPanel();
        panelDriver = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        labelName = new javax.swing.JLabel();
        scrollNumbers = new javax.swing.JScrollPane();
        listNumbers = new javax.swing.JList<>();
        jLabel4 = new javax.swing.JLabel();
        labelGender = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        labelAge = new javax.swing.JLabel();
        jLabel8 = new javax.swing.JLabel();
        photoDriver = new javax.swing.JLabel();
        panelVehicle = new javax.swing.JPanel();
        jLabel9 = new javax.swing.JLabel();
        labelPlate = new javax.swing.JLabel();
        jLabel11 = new javax.swing.JLabel();
        labelChosenCapacity = new javax.swing.JLabel();
        jLabel13 = new javax.swing.JLabel();
        labelSeatsLeft = new javax.swing.JLabel();
        panelTimeCost = new javax.swing.JPanel();
        jLabel3 = new javax.swing.JLabel();
        labelStartTime = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        labelEndTime = new javax.swing.JLabel();
        jLabel12 = new javax.swing.JLabel();
        labelCost = new javax.swing.JLabel();
        panelStops = new javax.swing.JPanel();
        jLabel23 = new javax.swing.JLabel();
        scrollStops = new javax.swing.JScrollPane();
        panelList = new javax.swing.JPanel();
        jPanel3 = new javax.swing.JPanel();
        labelStart = new javax.swing.JLabel();
        jLabel17 = new javax.swing.JLabel();
        jPanel4 = new javax.swing.JPanel();
        labelEnd = new javax.swing.JLabel();
        jLabel20 = new javax.swing.JLabel();
        filler2 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        buttonTrip = new javax.swing.JButton();
        panelTime = new javax.swing.JPanel();
        panelChooseStop = new javax.swing.JPanel();
        jLabel26 = new javax.swing.JLabel();
        boxStops = new javax.swing.JComboBox<>();
        panelPayment = new javax.swing.JPanel();
        boxMethod = new javax.swing.JComboBox<>();
        labelMethod = new javax.swing.JLabel();
        panelCurrency = new javax.swing.JPanel();
        jPanel5 = new javax.swing.JPanel();
        boxInstitutions = new javax.swing.JComboBox<>();
        labelInstitution = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanel1.setBackground(new java.awt.Color(225, 239, 255));
        jPanel1.setLayout(new java.awt.GridBagLayout());

        jScrollPane1.setMinimumSize(new java.awt.Dimension(10, 16));
        jScrollPane1.setPreferredSize(new java.awt.Dimension(30, 146));

        listTrips.setModel(new javax.swing.AbstractListModel<String>() {
            String[] strings = { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5" };
            public int getSize() { return strings.length; }
            public String getElementAt(int i) { return strings[i]; }
        });
        listTrips.setSelectionMode(javax.swing.ListSelectionModel.SINGLE_SELECTION);
        listTrips.addListSelectionListener(new javax.swing.event.ListSelectionListener() {
            public void valueChanged(javax.swing.event.ListSelectionEvent evt) {
                listTripsValueChanged(evt);
            }
        });
        jScrollPane1.setViewportView(listTrips);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 7;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipadx = 160;
        gridBagConstraints.insets = new java.awt.Insets(0, 30, 0, 0);
        jPanel1.add(jScrollPane1, gridBagConstraints);

        labelSearchTrips.setText("SEARCH TRIPS");
        labelSearchTrips.setFont(new java.awt.Font("Yu Gothic UI Semibold", 1, 40)); // NOI18N
        labelSearchTrips.setForeground(new java.awt.Color(18, 102, 160));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = 7;
        gridBagConstraints.ipadx = 50;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(60, 0, 60, 40);
        jPanel1.add(labelSearchTrips, gridBagConstraints);

        jLabel1.setText("Information:");
        jLabel1.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 7;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 100);
        jPanel1.add(jLabel1, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        jPanel1.add(filler1, gridBagConstraints);

        boxInfo.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Driver Information", "Vehicle Information", "Stops During the Trip", "Times and Cost" }));
        boxInfo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                boxInfoActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 7;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 100);
        jPanel1.add(boxInfo, gridBagConstraints);

        cardPanel.setBackground(new java.awt.Color(225, 239, 255));
        cardPanel.setLayout(new java.awt.CardLayout());

        panelDriver.setBackground(new java.awt.Color(225, 239, 255));
        panelDriver.setLayout(new java.awt.GridBagLayout());

        jLabel2.setText("Full Name: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(15, 0, 20, 5);
        panelDriver.add(jLabel2, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 5, 0);
        panelDriver.add(labelName, gridBagConstraints);

        scrollNumbers.setViewportView(listNumbers);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.gridheight = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipady = 50;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        panelDriver.add(scrollNumbers, gridBagConstraints);

        jLabel4.setText("Gender: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 5);
        panelDriver.add(jLabel4, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 0);
        panelDriver.add(labelGender, gridBagConstraints);

        jLabel6.setText("Age: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 5);
        panelDriver.add(jLabel6, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 3;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 0);
        panelDriver.add(labelAge, gridBagConstraints);

        jLabel8.setText("Phone Numbers:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        panelDriver.add(jLabel8, gridBagConstraints);
        panelDriver.add(photoDriver, new java.awt.GridBagConstraints());

        cardPanel.add(panelDriver, "card2");

        panelVehicle.setBackground(new java.awt.Color(225, 239, 255));
        panelVehicle.setLayout(new java.awt.GridBagLayout());

        jLabel9.setText("Plate: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelVehicle.add(jLabel9, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelVehicle.add(labelPlate, gridBagConstraints);

        jLabel11.setText("Amount of seats: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelVehicle.add(jLabel11, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelVehicle.add(labelChosenCapacity, gridBagConstraints);

        jLabel13.setText("Seats left: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelVehicle.add(jLabel13, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 2;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelVehicle.add(labelSeatsLeft, gridBagConstraints);

        cardPanel.add(panelVehicle, "card3");

        panelTimeCost.setBackground(new java.awt.Color(225, 239, 255));
        panelTimeCost.setLayout(new java.awt.GridBagLayout());

        jLabel3.setText("Start Time: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 5);
        panelTimeCost.add(jLabel3, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelTimeCost.add(labelStartTime, gridBagConstraints);

        jLabel7.setText("Time of Arrival: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 5);
        panelTimeCost.add(jLabel7, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 3;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelTimeCost.add(labelEndTime, gridBagConstraints);

        jLabel12.setText("Cost: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 4;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 5);
        panelTimeCost.add(jLabel12, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 5;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelTimeCost.add(labelCost, gridBagConstraints);

        cardPanel.add(panelTimeCost, "card4");

        panelStops.setBackground(new java.awt.Color(225, 239, 255));
        panelStops.setLayout(new java.awt.GridBagLayout());

        jLabel23.setText("Stops:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 5, 0);
        panelStops.add(jLabel23, gridBagConstraints);

        panelList.setBackground(new java.awt.Color(225, 239, 255));
        panelList.setLayout(new javax.swing.BoxLayout(panelList, javax.swing.BoxLayout.Y_AXIS));
        scrollStops.setViewportView(panelList);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipadx = 130;
        gridBagConstraints.ipady = 178;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.weightx = 1.0;
        gridBagConstraints.weighty = 1.0;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        panelStops.add(scrollStops, gridBagConstraints);

        jPanel3.setBackground(new java.awt.Color(225, 239, 255));
        jPanel3.setLayout(new java.awt.GridBagLayout());
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.ipadx = 50;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 20, 0);
        jPanel3.add(labelStart, gridBagConstraints);

        jLabel17.setText("Start: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 50;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 20, 0);
        jPanel3.add(jLabel17, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        panelStops.add(jPanel3, gridBagConstraints);

        jPanel4.setBackground(new java.awt.Color(225, 239, 255));
        jPanel4.setLayout(new java.awt.GridBagLayout());
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.ipadx = 50;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 0);
        jPanel4.add(labelEnd, gridBagConstraints);

        jLabel20.setText("End: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 50;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 0);
        jPanel4.add(jLabel20, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = 3;
        panelStops.add(jPanel4, gridBagConstraints);

        cardPanel.add(panelStops, "card6");

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 7;
        gridBagConstraints.gridy = 7;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.PAGE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 100);
        jPanel1.add(cardPanel, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 8;
        gridBagConstraints.gridy = 8;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        jPanel1.add(filler2, gridBagConstraints);

        buttonTrip.setText("Book Trip");
        buttonTrip.setBackground(new java.awt.Color(246, 172, 30));
        buttonTrip.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonTrip.setForeground(new java.awt.Color(255, 255, 255));
        buttonTrip.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonTripActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 7;
        gridBagConstraints.ipadx = 15;
        gridBagConstraints.ipady = 5;
        gridBagConstraints.insets = new java.awt.Insets(120, 0, 0, 20);
        jPanel1.add(buttonTrip, gridBagConstraints);

        panelTime.setBackground(new java.awt.Color(225, 239, 255));
        panelTime.setLayout(new java.awt.GridBagLayout());
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.insets = new java.awt.Insets(0, 30, 0, 0);
        jPanel1.add(panelTime, gridBagConstraints);

        panelChooseStop.setBackground(new java.awt.Color(225, 239, 255));
        panelChooseStop.setLayout(new java.awt.GridBagLayout());

        jLabel26.setText("<html>Pick up Point: <span style='color:red'>*</span></html>");
        jLabel26.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 90;
        gridBagConstraints.insets = new java.awt.Insets(0, 5, 0, 0);
        panelChooseStop.add(jLabel26, gridBagConstraints);

        boxStops.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                boxStopsActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        panelChooseStop.add(boxStops, gridBagConstraints);

        panelPayment.setBackground(new java.awt.Color(225, 239, 255));
        panelPayment.setLayout(new java.awt.GridBagLayout());

        boxMethod.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                boxMethodActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        panelPayment.add(boxMethod, gridBagConstraints);

        labelMethod.setText("<html>Payment Method: <span style='color:red'>*</span></html>");
        labelMethod.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 10;
        gridBagConstraints.insets = new java.awt.Insets(0, 5, 0, 0);
        panelPayment.add(labelMethod, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(20, 0, 20, 0);
        panelChooseStop.add(panelPayment, gridBagConstraints);

        panelCurrency.setBackground(new java.awt.Color(225, 239, 255));
        panelCurrency.setLayout(new java.awt.GridBagLayout());
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.gridwidth = 2;
        panelChooseStop.add(panelCurrency, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.ipadx = 10;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.FIRST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 30, 5, 0);
        jPanel1.add(panelChooseStop, gridBagConstraints);

        jPanel5.setBackground(new java.awt.Color(225, 239, 255));
        jPanel5.setLayout(new java.awt.GridBagLayout());

        boxInstitutions.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                boxInstitutionsActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.PAGE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 3, 0);
        jPanel5.add(boxInstitutions, gridBagConstraints);

        labelInstitution.setText("Institution:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 5, 0);
        jPanel5.add(labelInstitution, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 5;
        jPanel1.add(jPanel5, gridBagConstraints);

        getContentPane().add(jPanel1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void listTripsValueChanged(javax.swing.event.ListSelectionEvent evt) {//GEN-FIRST:event_listTripsValueChanged
        if (!evt.getValueIsAdjusting()) {
            int idx = listTrips.getSelectedIndex();
            if (idx != -1 && availableTrips != null) {
              long tripId = availableTrips.get(idx).getTripId();

              // fetch full details
              try (Connection conn = DatabaseConnection.getConnection()) {
                TripDAO dao = new TripDAO();
                TripDetails d = dao.getFullTripDetails(tripId, conn);
                if (d != null) {
                  showTripDetails(d);
                  // optionally switch to the first card so user sees driver info:
                  ((CardLayout)cardPanel.getLayout()).show(cardPanel, "Driver Information");
                  boxInfo.setSelectedItem("Driver Information");
                } else {
                  JOptionPane.showMessageDialog(this, "No details found for trip " + tripId);
                }
              } catch (SQLException ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(this, "Error loading details: " + ex.getMessage());
              }
            }
          }
    }//GEN-LAST:event_listTripsValueChanged

    private void boxInfoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_boxInfoActionPerformed
        CardLayout layout = (CardLayout) cardPanel.getLayout();
        String selected = (String) boxInfo.getSelectedItem();
        layout.show(cardPanel, selected);
    }//GEN-LAST:event_boxInfoActionPerformed

    private void buttonTripActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonTripActionPerformed
        int selectedIndex = listTrips.getSelectedIndex();
        if (selectedIndex == -1) {
            JOptionPane.showMessageDialog(this, "You must select a trip from the list first.");
            return;
        }

        // Get selected trip
        TripSummary selectedTrip = availableTrips.get(selectedIndex);
        long tripId = selectedTrip.getTripId(); // You MUST store tripId in TripDisplay

        // Get selected payment method
        PaymentMethod selectedMethod = (PaymentMethod) boxMethod.getSelectedItem();
        if (selectedMethod == null || selectedMethod.getId() == 0) {
            JOptionPane.showMessageDialog(this, "You must select a payment method.");
            return;
        }

        // Get selected stop
        Waypoint selectedStop = (Waypoint) boxStops.getSelectedItem();
        if (selectedStop == null) {
            JOptionPane.showMessageDialog(this, "You must select a pickup stop.");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);

            // Step 1: Insert into PASSENGERXTRIP
            PassengerXTripDAO passengerXTripDAO = new PassengerXTripDAO();
            long pxTripId = passengerXTripDAO.bookTrip(user.getPersonId(), tripId, conn); // returns ID

            // Step 2: Insert into PASSENGERXTRIPXPAYMENT
            PassengerTripPaymentDAO payDAO = new PassengerTripPaymentDAO();
            payDAO.assignPaymentMethod(pxTripId, selectedMethod.getId(), conn);

            // Step 3: Insert into PASSENGERXWAYPOINT
            PassengerWaypointDAO waypointDAO = new PassengerWaypointDAO();
            waypointDAO.addPassengerWaypoint(user.getPersonId(), selectedStop.getId(), conn);

            conn.commit();
            JOptionPane.showMessageDialog(this, "Trip booked successfully!");
            
            SwingUtilities.invokeLater(() -> {
                TripBooked bookTrip = new TripBooked(userRole, user);
                bookTrip.setExtendedState(JFrame.MAXIMIZED_BOTH);
                bookTrip.setVisible(true);
                SearchTrip.this.dispose();
            });
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error booking trip: " + ex.getMessage());
        }
    }//GEN-LAST:event_buttonTripActionPerformed

    private void boxInstitutionsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_boxInstitutionsActionPerformed
        Institution selected = (Institution) boxInstitutions.getSelectedItem();
            if (selected != null) {
                loadTripsForInstitution(selected);
            }
    }//GEN-LAST:event_boxInstitutionsActionPerformed

    private void boxStopsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_boxStopsActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_boxStopsActionPerformed

    private void boxMethodActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_boxMethodActionPerformed
        PaymentMethod selectedMethod = (PaymentMethod) boxMethod.getSelectedItem();
        if (selectedMethod != null) {
            // ✅ Do something with the selected payment method
            long paymentMethodId = selectedMethod.getId();
        }
    }//GEN-LAST:event_boxMethodActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(SearchTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(SearchTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(SearchTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(SearchTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            private String userRole;
            private User user;
            public void run() {
                userRole = "Driver";
                user = new User(1, "testuser", 101);
                SearchTrip trips = new SearchTrip(userRole, user);
                trips.setVisible(true);
                
                List<double[]> coords = new ArrayList<>();
                coords.add(new double[]{9.9281, -84.0907});
                coords.add(new double[]{10.0021, -84.1111});

                trips.showCoordinatesList(coords);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> boxInfo;
    private javax.swing.JComboBox<Institution> boxInstitutions;
    private javax.swing.JComboBox<PaymentMethod> boxMethod;
    private javax.swing.JComboBox<Waypoint> boxStops;
    private javax.swing.JButton buttonTrip;
    private javax.swing.JPanel cardPanel;
    private javax.swing.Box.Filler filler1;
    private javax.swing.Box.Filler filler2;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel17;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel20;
    private javax.swing.JLabel jLabel23;
    private javax.swing.JLabel jLabel26;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JLabel labelAge;
    private javax.swing.JLabel labelChosenCapacity;
    private javax.swing.JLabel labelCost;
    private javax.swing.JLabel labelEnd;
    private javax.swing.JLabel labelEndTime;
    private javax.swing.JLabel labelGender;
    private javax.swing.JLabel labelInstitution;
    private javax.swing.JLabel labelMethod;
    private javax.swing.JLabel labelName;
    private javax.swing.JLabel labelPlate;
    private javax.swing.JLabel labelSearchTrips;
    private javax.swing.JLabel labelSeatsLeft;
    private javax.swing.JLabel labelStart;
    private javax.swing.JLabel labelStartTime;
    private javax.swing.JList<String> listNumbers;
    private javax.swing.JList<String> listTrips;
    private javax.swing.JPanel panelChooseStop;
    private javax.swing.JPanel panelCurrency;
    private javax.swing.JPanel panelDriver;
    private javax.swing.JPanel panelList;
    private javax.swing.JPanel panelPayment;
    private javax.swing.JPanel panelStops;
    private javax.swing.JPanel panelTime;
    private javax.swing.JPanel panelTimeCost;
    private javax.swing.JPanel panelVehicle;
    private javax.swing.JLabel photoDriver;
    private javax.swing.JScrollPane scrollNumbers;
    private javax.swing.JScrollPane scrollStops;
    // End of variables declaration//GEN-END:variables
}
