/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import com.tec.carpooling.domain.entity.User;
import com.tec.carpooling.domain.entity.TripSummary;
import com.tec.carpooling.domain.entity.Institution;
import com.tec.carpooling.domain.entity.PaymentMethod;
import com.tec.carpooling.domain.entity.Waypoint;
import com.tec.carpooling.domain.entity.Province;
import com.tec.carpooling.domain.entity.Canton;
import com.tec.carpooling.domain.entity.District;
import com.tec.carpooling.data.dao.TripSummaryDAO;
import com.tec.carpooling.data.dao.PassengerXTripDAO;
import com.tec.carpooling.data.dao.PassengerTripPaymentDAO;
import com.tec.carpooling.data.dao.PassengerWaypointDAO;

import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

import java.awt.*;
import java.net.URL;
import javax.swing.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Locale;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

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
        customizeDatePicker();
        getContentPane().add(SideMenu.createToolbar(this, userRole, user), BorderLayout.WEST);
        
        loadInstitutions();
        loadPaymentMethods();
        
        // Para el panel con card layout
        cardPanel.add(panelDriver, "Driver Information");
        cardPanel.add(panelVehicle, "Vehicle Information");
        cardPanel.add(panelStops, "Stops During the Trip");
        cardPanel.add(panelTimeCost, "Times and Cost");
        
        ImageIcon photo = new ImageIcon(getClass().getResource("/Assets/passenger.jpg"));
        Image scaledPassenger = photo.getImage().getScaledInstance(100, 100, Image.SCALE_SMOOTH);
        photoDriver.setIcon(new ImageIcon(scaledPassenger));
        
        this.setExtendedState(JFrame.MAXIMIZED_BOTH);
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
    
    private void filterAvailableTimes(JComboBox<String> comboTime) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("hh:mm a");
        LocalTime now = LocalTime.now();

        String[] allTimes = getAllTimes(); // use same helper for both methods

        DefaultComboBoxModel<String> model = new DefaultComboBoxModel<>();
        for (String timeString : allTimes) {
            LocalTime time = LocalTime.parse(timeString, formatter);
            if (!time.isBefore(now)) {
                model.addElement(timeString);
            }
        }
        comboTime.setModel(model);
    }
    
    private String[] getAllTimes() {
        return new String[]{
            "05:30 AM", "06:00 AM", "06:30 AM", "07:00 AM", "07:30 AM", "08:00 AM",
            "08:30 AM", "09:00 AM", "09:30 AM", "10:00 AM", "10:30 AM", "11:00 AM",
            "11:30 AM", "12:00 PM", "12:30 PM", "01:00 PM", "01:30 PM", "02:00 PM",
            "02:30 PM", "03:00 PM", "03:30 PM", "04:00 PM", "04:30 PM", "05:00 PM",
            "05:30 PM", "06:00 PM", "06:30 PM", "07:00 PM", "07:30 PM", "08:00 PM",
            "08:30 PM", "09:00 PM", "09:30 PM", "10:00 PM", "10:30 PM", "11:00 PM",
            "11:30 PM"
        };
    }
    
    private void resetAllTimes(JComboBox<String> comboTime) {
        String[] allTimes = getAllTimes();
        DefaultComboBoxModel<String> model = new DefaultComboBoxModel<>(allTimes);
        comboTime.setModel(model);
    }
    
    private void customizeDatePicker() {
        URL dateImageURL = getClass().getResource("/Assets/datePickerIcon.png");
        if (dateImageURL != null) {
            Image dateImage = getToolkit().getImage(dateImageURL);
            ImageIcon dateIcon = new ImageIcon(dateImage);

            datePicker.getComponentDateTextField().setEditable(false);
            datePicker.getComponentDateTextField().setEnabled(false);
            datePicker.setDateToToday();
            datePicker.setLocale(Locale.ENGLISH);

            // ✅ Disallow past dates
            datePicker.getSettings().setVetoPolicy(date -> !date.isBefore(LocalDate.now()));

            // ✅ Add listener for date changes
            datePicker.addDateChangeListener(event -> {
                LocalDate selectedDate = event.getNewDate();
                LocalDate today = LocalDate.now();

                if (selectedDate != null) {
                    if (selectedDate.isEqual(today)) {
                        filterAvailableTimes(boxTime);
                    } else {
                        resetAllTimes(boxTime);
                    }
                }
            });

            // ✅ Set calendar icon
            JButton datePickerButton = datePicker.getComponentToggleCalendarButton();
            datePickerButton.setText("");
            datePickerButton.setIcon(dateIcon);

            // ✅ Manually filter on init (because today is selected by default)
            filterAvailableTimes(boxTime);
        } else {
            System.err.println("Image for date picker button not found.");
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
            String sql = "SELECT id, name FROM ADM.INSTITUTION ORDER BY name";
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                boxInstitutions.removeAllItems(); // Clear previous entries
                boxInstitutions.addItem(new Institution(0, "Select Institution"));

                while (rs.next()) {
                    long id = rs.getLong("id");
                    String name = rs.getString("name");
                    boxInstitutions.addItem(new Institution(id, name));
                }

            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading institutions: " + e.getMessage());
        }
    }
    
    private void loadPaymentMethods() {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT id, name FROM ADM.PAYMENTMETHOD ORDER BY name";

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
        jLabel5 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        jLabel10 = new javax.swing.JLabel();
        jLabel12 = new javax.swing.JLabel();
        jLabel14 = new javax.swing.JLabel();
        jLabel15 = new javax.swing.JLabel();
        jLabel16 = new javax.swing.JLabel();
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
        jLabel19 = new javax.swing.JLabel();
        buttonTrip = new javax.swing.JButton();
        panelTime = new javax.swing.JPanel();
        labelTimeArrival = new javax.swing.JLabel();
        boxTime = new javax.swing.JComboBox<>();
        panelDatePlace = new javax.swing.JPanel();
        boxProvince = new javax.swing.JComboBox<>();
        boxCanton = new javax.swing.JComboBox<>();
        boxDistrict = new javax.swing.JComboBox<>();
        jLabel24 = new javax.swing.JLabel();
        jPanel2 = new javax.swing.JPanel();
        datePicker = new com.github.lgooddatepicker.components.DatePicker();
        labelDate = new javax.swing.JLabel();
        labelInstitution = new javax.swing.JLabel();
        boxInstitutions = new javax.swing.JComboBox<>();
        panelChooseStop = new javax.swing.JPanel();
        jLabel26 = new javax.swing.JLabel();
        boxStops = new javax.swing.JComboBox<>();
        panelPayment = new javax.swing.JPanel();
        boxMethod = new javax.swing.JComboBox<>();
        labelMethod = new javax.swing.JLabel();
        panelCurrency = new javax.swing.JPanel();

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
        gridBagConstraints.insets = new java.awt.Insets(0, 30, 0, 0);
        jPanel1.add(jScrollPane1, gridBagConstraints);

        labelSearchTrips.setText("SEARCH TRIPS");
        labelSearchTrips.setFont(new java.awt.Font("Yu Gothic UI Semibold", 1, 40)); // NOI18N
        labelSearchTrips.setForeground(new java.awt.Color(18, 102, 160));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = 4;
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
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_END;
        gridBagConstraints.insets = new java.awt.Insets(15, 0, 20, 5);
        panelDriver.add(jLabel2, gridBagConstraints);

        labelName.setText("jLabel3");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 5, 0);
        panelDriver.add(labelName, gridBagConstraints);

        listNumbers.setModel(new javax.swing.AbstractListModel<String>() {
            String[] strings = { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5" };
            public int getSize() { return strings.length; }
            public String getElementAt(int i) { return strings[i]; }
        });
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
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_END;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 5);
        panelDriver.add(jLabel4, gridBagConstraints);

        labelGender.setText("jLabel5");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 0);
        panelDriver.add(labelGender, gridBagConstraints);

        jLabel6.setText("Age: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_END;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 5);
        panelDriver.add(jLabel6, gridBagConstraints);

        labelAge.setText("jLabel7");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 3;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 0);
        panelDriver.add(labelAge, gridBagConstraints);

        jLabel8.setText("Phone Numbers:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        panelDriver.add(jLabel8, gridBagConstraints);
        panelDriver.add(photoDriver, new java.awt.GridBagConstraints());

        cardPanel.add(panelDriver, "card2");

        panelVehicle.setBackground(new java.awt.Color(225, 239, 255));
        panelVehicle.setLayout(new java.awt.GridBagLayout());

        jLabel9.setText("Plate: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_END;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelVehicle.add(jLabel9, gridBagConstraints);

        labelPlate.setText("jLabel10");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelVehicle.add(labelPlate, gridBagConstraints);

        jLabel11.setText("Amount of seats: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelVehicle.add(jLabel11, gridBagConstraints);

        labelChosenCapacity.setText("jLabel12");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelVehicle.add(labelChosenCapacity, gridBagConstraints);

        jLabel13.setText("Seats left: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_END;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelVehicle.add(jLabel13, gridBagConstraints);

        labelSeatsLeft.setText("jLabel14");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 2;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelVehicle.add(labelSeatsLeft, gridBagConstraints);

        cardPanel.add(panelVehicle, "card3");

        panelTimeCost.setBackground(new java.awt.Color(225, 239, 255));
        panelTimeCost.setLayout(new java.awt.GridBagLayout());

        jLabel3.setText("Start Time: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_END;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 5);
        panelTimeCost.add(jLabel3, gridBagConstraints);

        jLabel5.setText("jLabel5");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelTimeCost.add(jLabel5, gridBagConstraints);

        jLabel7.setText("Time of Arrival: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_END;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 5);
        panelTimeCost.add(jLabel7, gridBagConstraints);

        jLabel10.setText("jLabel10");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelTimeCost.add(jLabel10, gridBagConstraints);

        jLabel12.setText("Cost: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_END;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 5);
        panelTimeCost.add(jLabel12, gridBagConstraints);

        jLabel14.setText("jLabel14");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 2;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelTimeCost.add(jLabel14, gridBagConstraints);

        jLabel15.setText("Payment Method: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 3;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_END;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 5);
        panelTimeCost.add(jLabel15, gridBagConstraints);

        jLabel16.setText("jLabel16");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 3;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelTimeCost.add(jLabel16, gridBagConstraints);

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

        labelStart.setText("jLabel18");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 2;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 20, 0);
        jPanel3.add(labelStart, gridBagConstraints);

        jLabel17.setText("Start: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_END;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 20, 0);
        jPanel3.add(jLabel17, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        panelStops.add(jPanel3, gridBagConstraints);

        jPanel4.setBackground(new java.awt.Color(225, 239, 255));
        jPanel4.setLayout(new java.awt.GridBagLayout());

        labelEnd.setText("jLabel21");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 2;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 0);
        jPanel4.add(labelEnd, gridBagConstraints);

        jLabel20.setText("End: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.EAST;
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

        jLabel19.setText("Search Trip By: ");
        jLabel19.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.insets = new java.awt.Insets(0, 30, 10, 0);
        jPanel1.add(jLabel19, gridBagConstraints);

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

        labelTimeArrival.setText("Time of Arrival: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 5);
        panelTime.add(labelTimeArrival, gridBagConstraints);

        boxTime.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "05:30AM", "06:00AM", "06:30AM", "07:00AM", "07:30AM", "08:00AM", "08:30AM", "09:00AM", "09:30AM", "10:00AM", "10:30AM", "11:00AM", "11:30AM", "12:00PM", "12:30PM", "01:00PM", "01:30PM", "02:00PM", "02:30PM", "03:00PM", "03:30PM", "04:00PM", "04:30PM", "05:00PM", "05:30PM", "06:00PM", "06:30PM", "07:00PM", "07:30PM", "08:00PM", "08:30PM", "09:00PM", "09:30PM", "10:00PM", "10:30PM", "11:00PM", "11:30PM" }));
        panelTime.add(boxTime, new java.awt.GridBagConstraints());

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.insets = new java.awt.Insets(0, 30, 0, 0);
        jPanel1.add(panelTime, gridBagConstraints);

        panelDatePlace.setBackground(new java.awt.Color(225, 239, 255));
        panelDatePlace.setLayout(new java.awt.GridBagLayout());

        boxProvince.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                boxProvinceActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 5, 5);
        panelDatePlace.add(boxProvince, gridBagConstraints);

        boxCanton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                boxCantonActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 2;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 5, 5);
        panelDatePlace.add(boxCanton, gridBagConstraints);

        boxDistrict.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                boxDistrictActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 5, 0);
        panelDatePlace.add(boxDistrict, gridBagConstraints);

        jLabel24.setText("Destination: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 5, 5);
        panelDatePlace.add(jLabel24, gridBagConstraints);

        jPanel2.setBackground(new java.awt.Color(225, 239, 255));
        jPanel2.setLayout(new java.awt.GridBagLayout());
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        jPanel2.add(datePicker, gridBagConstraints);

        labelDate.setText("Date: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        jPanel2.add(labelDate, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 4;
        gridBagConstraints.insets = new java.awt.Insets(0, 30, 10, 0);
        panelDatePlace.add(jPanel2, gridBagConstraints);

        labelInstitution.setText("Institution:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 2;
        panelDatePlace.add(labelInstitution, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.ipadx = 20;
        gridBagConstraints.insets = new java.awt.Insets(0, 30, 5, 0);
        jPanel1.add(panelDatePlace, gridBagConstraints);

        boxInstitutions.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                boxInstitutionsActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 6;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.PAGE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 3, 0);
        jPanel1.add(boxInstitutions, gridBagConstraints);

        panelChooseStop.setBackground(new java.awt.Color(225, 239, 255));
        panelChooseStop.setLayout(new java.awt.GridBagLayout());

        jLabel26.setText("<html>Pick up Point: <span style='color:red'>*</span></html>");
        jLabel26.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 7;
        gridBagConstraints.insets = new java.awt.Insets(0, 33, 0, 0);
        panelChooseStop.add(jLabel26, gridBagConstraints);

        boxStops.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                boxStopsActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        panelChooseStop.add(boxStops, gridBagConstraints);

        panelPayment.setBackground(new java.awt.Color(225, 239, 255));
        panelPayment.setLayout(new java.awt.GridBagLayout());

        boxMethod.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                boxMethodActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
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
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = 2;
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
        gridBagConstraints.insets = new java.awt.Insets(20, 30, 10, 0);
        jPanel1.add(panelChooseStop, gridBagConstraints);

        getContentPane().add(jPanel1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void listTripsValueChanged(javax.swing.event.ListSelectionEvent evt) {//GEN-FIRST:event_listTripsValueChanged
        if (!evt.getValueIsAdjusting()) {
            int selectedIndex = listTrips.getSelectedIndex();
            if (selectedIndex != -1) {
                TripSummary selectedTrip = availableTrips.get(selectedIndex);
                loadWaypointsForTrip(selectedTrip.getTripId());
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

    private void boxProvinceActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_boxProvinceActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_boxProvinceActionPerformed

    private void boxCantonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_boxCantonActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_boxCantonActionPerformed

    private void boxDistrictActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_boxDistrictActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_boxDistrictActionPerformed

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
    private javax.swing.JComboBox<Canton> boxCanton;
    private javax.swing.JComboBox<District> boxDistrict;
    private javax.swing.JComboBox<String> boxInfo;
    private javax.swing.JComboBox<Institution> boxInstitutions;
    private javax.swing.JComboBox<PaymentMethod> boxMethod;
    private javax.swing.JComboBox<Province> boxProvince;
    private javax.swing.JComboBox<Waypoint> boxStops;
    private javax.swing.JComboBox<String> boxTime;
    private javax.swing.JButton buttonTrip;
    private javax.swing.JPanel cardPanel;
    private com.github.lgooddatepicker.components.DatePicker datePicker;
    private javax.swing.Box.Filler filler1;
    private javax.swing.Box.Filler filler2;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel14;
    private javax.swing.JLabel jLabel15;
    private javax.swing.JLabel jLabel16;
    private javax.swing.JLabel jLabel17;
    private javax.swing.JLabel jLabel19;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel20;
    private javax.swing.JLabel jLabel23;
    private javax.swing.JLabel jLabel24;
    private javax.swing.JLabel jLabel26;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JLabel labelAge;
    private javax.swing.JLabel labelChosenCapacity;
    private javax.swing.JLabel labelDate;
    private javax.swing.JLabel labelEnd;
    private javax.swing.JLabel labelGender;
    private javax.swing.JLabel labelInstitution;
    private javax.swing.JLabel labelMethod;
    private javax.swing.JLabel labelName;
    private javax.swing.JLabel labelPlate;
    private javax.swing.JLabel labelSearchTrips;
    private javax.swing.JLabel labelSeatsLeft;
    private javax.swing.JLabel labelStart;
    private javax.swing.JLabel labelTimeArrival;
    private javax.swing.JList<String> listNumbers;
    private javax.swing.JList<String> listTrips;
    private javax.swing.JPanel panelChooseStop;
    private javax.swing.JPanel panelCurrency;
    private javax.swing.JPanel panelDatePlace;
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
