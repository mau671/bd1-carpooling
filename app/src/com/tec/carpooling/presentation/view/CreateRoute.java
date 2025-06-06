/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import com.tec.carpooling.domain.entity.User;
import com.tec.carpooling.business.service.TripService;
import com.tec.carpooling.data.dao.CountryDAO;
import com.tec.carpooling.domain.entity.Country;
import com.tec.carpooling.data.dao.ProvinceDAO;
import com.tec.carpooling.domain.entity.Province;
import com.tec.carpooling.data.dao.CantonDAO;
import com.tec.carpooling.domain.entity.Canton;
import com.tec.carpooling.data.dao.DistrictDAO;
import com.tec.carpooling.domain.entity.District;

import com.tec.carpooling.data.connection.DatabaseConnection;
import javax.swing.SwingUtilities;
import java.util.List;
import java.sql.Connection;

import java.awt.BorderLayout;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JButton;
import javax.swing.BorderFactory;
import javax.swing.JOptionPane;
import javax.swing.JFrame;
import javax.swing.JComboBox;
import javax.swing.BoxLayout;
import javax.swing.JToolBar;
import java.util.List;
import java.util.ArrayList;

import java.awt.Container;
import java.awt.FlowLayout;
import java.awt.Color;
import java.awt.Insets;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Dimension;
import java.awt.Component;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.KeyEvent;
import java.awt.Cursor;
import java.awt.Font;
import java.awt.event.ItemListener;
import java.awt.event.ItemEvent;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.sql.Date;
import java.sql.SQLException;

import java.net.URI;
import java.net.URL;
import java.net.URISyntaxException;
import java.net.MalformedURLException;
import java.net.HttpURLConnection;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.json.JSONArray;
import org.json.JSONObject;

import org.openstreetmap.gui.jmapviewer.JMapViewer;
import org.openstreetmap.gui.jmapviewer.Coordinate;
import org.openstreetmap.gui.jmapviewer.MapMarkerDot;
import org.openstreetmap.gui.jmapviewer.interfaces.ICoordinate;

/**
 *
 * @author hidal
 */
public class CreateRoute extends javax.swing.JFrame {
    private String userRole;
    private JMapViewer map;
    private final User user;
    private Timestamp startTime;
    private Timestamp endTime;
    private Date tripDate;
    private int amountOfPassengers;
    private BigDecimal pricePerPassenger;
    private Long currencyId;
    private long vehicleId;
    /**
     * Creates new form CrearRuta
     */
    public CreateRoute(String role, User user, Timestamp startTime,
                       Timestamp endTime, Date tripDate, int amountOfPassengers,
                       BigDecimal pricePerPassenger, Long currencyId,
                       long vehicleId) {
        this.user = user;
        this.userRole = role;
        this.startTime = startTime;
        this.endTime = endTime;
        this.tripDate = tripDate;
        this.amountOfPassengers = amountOfPassengers;
        this.pricePerPassenger = pricePerPassenger;
        this.currencyId = currencyId;
        this.vehicleId = vehicleId;
        
        System.out.println("start selected: " + startTime);
        System.out.println("end selected: " + endTime);
        System.out.println("date selected: " + tripDate);
        System.out.println("passengers selected: " + amountOfPassengers);
        System.out.println("price selected: " + pricePerPassenger);
        System.out.println("Currency ID selected: " + currencyId);
        System.out.println("vehicle ID selected: " + vehicleId);
        
        System.setProperty("http.agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) CarpoolingApp/1.0");
        initComponents();
        getContentPane().add(SideMenu.createToolbar(this, userRole, user), BorderLayout.WEST);
        
        scrollPanelList.setPreferredSize(new Dimension(200, 200));
        scrollPanelList.setMaximumSize(new Dimension (200, Integer.MAX_VALUE));
        
        panelStops.setLayout(new BoxLayout(panelStops, BoxLayout.Y_AXIS));
        panelStops.setMaximumSize(new Dimension (200, Integer.MAX_VALUE));
        panelStops.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        loadMap();     // Llamas aquí o desde algún botón
        loadCountries();
        
        boxStartP.setEnabled(false);
        boxEndP.setEnabled(false);
        boxStartC.setEnabled(false);
        boxEndC.setEnabled(false);
        boxStartD.setEnabled(false);
        boxEndD.setEnabled(false);
        
        boxStartP.removeAllItems();
        boxEndP.removeAllItems();
        boxStartC.removeAllItems();
        boxEndC.removeAllItems();
        boxStartD.removeAllItems();
        boxEndD.removeAllItems();
        
        boxCountry.addItemListener(e -> {
            if (e.getStateChange() == ItemEvent.SELECTED) {
                Country selected = (Country) boxCountry.getSelectedItem();
                if (selected != null && selected.getId() != 0) {
                    boxStartP.setEnabled(true);
                    boxEndP.setEnabled(true);
                    loadProvinces(selected.getId(), boxStartP);
                    loadProvinces(selected.getId(), boxEndP);
                    boxStartC.setEnabled(false);
                    boxEndC.setEnabled(false);
                    boxStartD.setEnabled(false);
                    boxEndD.setEnabled(false);
                    
                    boxStartC.removeAllItems();
                    boxEndC.removeAllItems();
                    boxStartD.removeAllItems();
                    boxEndD.removeAllItems();
                }
            }
        });
        
        boxStartP.addItemListener(e -> {
            if (e.getStateChange() == ItemEvent.SELECTED) {
                Province selected = (Province) boxStartP.getSelectedItem();
                if (selected != null && selected.getId() != 0) {
                    boxStartC.setEnabled(true);
                    boxEndC.setEnabled(true);
                    loadCantons(selected.getId(), boxStartC);
                    boxStartD.setEnabled(false);
                    boxEndD.setEnabled(false);
                    
                    boxStartD.removeAllItems();
                    boxEndD.removeAllItems();
                }
            }
        });
        
        boxStartC.addItemListener(e -> {
            if (e.getStateChange() == ItemEvent.SELECTED) {
                Canton selected = (Canton) boxStartC.getSelectedItem();
                if (selected != null && selected.getId() != 0) {
                    boxStartD.setEnabled(true);
                    boxEndD.setEnabled(true);
                    loadDistricts(selected.getId(), boxStartD);
                }
            }
        });
        
        boxEndP.addItemListener(e -> {
            if (e.getStateChange() == ItemEvent.SELECTED) {
                Province selected = (Province) boxEndP.getSelectedItem();
                if (selected != null && selected.getId() != 0) {
                    loadCantons(selected.getId(), boxEndC);
                }
            }
        });
        
        boxEndC.addItemListener(e -> {
            if (e.getStateChange() == ItemEvent.SELECTED) {
                Canton selected = (Canton) boxEndC.getSelectedItem();
                if (selected != null && selected.getId() != 0) {
                    loadDistricts(selected.getId(), boxEndD);
                }
            }
        });
        
        this.setExtendedState(JFrame.MAXIMIZED_BOTH);
    }
    
    private void loadCountries() {
        try {
            CountryDAO countryDAO = new CountryDAO();
            List<Country> countries = countryDAO.getAllCountries();
            boxCountry.removeAllItems();
            boxCountry.addItem(new Country(0, "Select Country")); // Default

            for (Country c : countries) {
                boxCountry.addItem(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Failed to load countries: " + e.getMessage());
        }
    }
    
    private void loadProvinces(long id, JComboBox<Province> boxP) {
        try {
            ProvinceDAO provinceDAO = new ProvinceDAO();
            List<Province> provinces = provinceDAO.getProvincesByCountry(id);
            boxP.removeAllItems();
            boxP.addItem(new Province(0, "Select Province", id)); // Default

            for (Province p : provinces) {
                boxP.addItem(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Failed to load provinces: " + e.getMessage());
        }
    }
    
    private void loadCantons(long id, JComboBox<Canton> boxP) {
        try {
            CantonDAO cantonDAO = new CantonDAO();
            List<Canton> cantons = cantonDAO.getCantonsByProvince(id);
            boxP.removeAllItems();
            boxP.addItem(new Canton(0, "Select Canton", id)); // Default

            for (Canton c : cantons) {
                boxP.addItem(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Failed to load cantons: " + e.getMessage());
        }
    }
    
    private void loadDistricts(long id, JComboBox<District> boxP) {
        try {
            DistrictDAO districtDAO = new DistrictDAO();
            List<District> districts = districtDAO.getDistrictsByCanton(id);
            boxP.removeAllItems();
            boxP.addItem(new District(0, "Select District", id)); // Default

            for (District d : districts) {
                boxP.addItem(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Failed to load districts: " + e.getMessage());
        }
    }
    
    private void loadMap() {
        panelMap.removeAll(); // Limpiar si ya había algo

        map = new JMapViewer();
        map.setDisplayPosition(new Coordinate(9.9281, -84.0907), 12);

        map.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                if (javax.swing.SwingUtilities.isLeftMouseButton(e)) {
                    ICoordinate coord = map.getPosition(e.getPoint());
                    double lat = coord.getLat();
                    double lon = coord.getLon();
                    map.removeAllMapMarkers(); // Si quieres limpiar anteriores
                    map.addMapMarker(new MapMarkerDot(lat, lon));
                    addVisualStop(String.format("%.5f", lat), String.format("%.5f", lon));
                }
            }
        });

        panelMap.setLayout(new BorderLayout());
        panelMap.add(map, BorderLayout.CENTER);
        panelMap.revalidate();
        panelMap.repaint();
    }
    
    private void addVisualStop(String lat, String lon) {
        JPanel fila = new JPanel(new FlowLayout(FlowLayout.LEFT));
        fila.setMaximumSize(new Dimension(Integer.MAX_VALUE, 25));
        fila.setBackground(new Color(240, 240, 240));
        fila.setOpaque(true);

        JLabel lbl = new JLabel("Lat: " + lat + ", Lon: " + lon);

        // 📍 Button: Center on map
        JButton btnPin = new JButton("📍");
        btnPin.setBorder(BorderFactory.createEmptyBorder());
        btnPin.setContentAreaFilled(false);
        btnPin.setForeground(Color.BLUE);
        btnPin.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        btnPin.addActionListener(e -> {
            setSelectedRow(fila); // persistently highlight
            try {
                double latitude = Double.parseDouble(lat);
                double longitude = Double.parseDouble(lon);
                if (map != null) {
                    map.removeAllMapMarkers();
                    map.setDisplayPosition(new Coordinate(latitude, longitude), 15);
                    map.addMapMarker(new MapMarkerDot(latitude, longitude));
                }
            } catch (NumberFormatException ex) {
                System.err.println("Coordenadas inválidas: " + lat + ", " + lon);
            }
        });

        // ❌ Button: Delete row
        JButton btnX = new JButton("X");
        btnX.setMargin(new Insets(2, 5, 2, 5));
        btnX.setForeground(Color.RED);
        btnX.setBorder(BorderFactory.createEmptyBorder());
        btnX.setContentAreaFilled(false);
        btnX.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        btnX.addActionListener(e -> {
            panelStops.remove(fila);
            panelStops.revalidate();
            panelStops.repaint();
        });

        // ⬆️ Button: Move Up
        JButton btnUp = new JButton("↑");
        btnUp.setMargin(new Insets(2, 5, 2, 5));
        btnUp.setBorder(BorderFactory.createEmptyBorder());
        btnUp.setContentAreaFilled(false);
        btnUp.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        btnUp.addActionListener(e -> {
            int index = getIndexOfComponent(panelStops, fila);
            if (index > 0) {
                panelStops.remove(fila);
                panelStops.add(fila, index - 1);
                panelStops.revalidate();
                panelStops.repaint();
                setSelectedRow(fila); // persistently highlight
            }
        });

        // ⬇️ Button: Move Down
        JButton btnDown = new JButton("↓");
        btnDown.setMargin(new Insets(2, 5, 2, 5));
        btnDown.setBorder(BorderFactory.createEmptyBorder());
        btnDown.setContentAreaFilled(false);
        btnDown.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        btnDown.addActionListener(e -> {
            int index = getIndexOfComponent(panelStops, fila);
            if (index < panelStops.getComponentCount() - 1) {
                panelStops.remove(fila);
                panelStops.add(fila, index + 1);
                panelStops.revalidate();
                panelStops.repaint();
                setSelectedRow(fila); // persistently highlight
            }
        });

        btnPin.setFont(new Font("Dialog", Font.PLAIN, 12)); // Windows
        btnUp.setFont(new Font("Dialog", Font.PLAIN, 12));
        btnDown.setFont(new Font("Dialog", Font.PLAIN, 12));
        // Add components to row
        fila.add(btnX);
        fila.add(btnUp);
        fila.add(btnDown);
        fila.add(btnPin);
        fila.add(lbl);

        // Add row to list
        panelStops.add(fila);
        panelStops.revalidate();
        panelStops.repaint();
    }

    // Utility: get index of a component
    private int getIndexOfComponent(Container parent, Component comp) {
        Component[] components = parent.getComponents();
        for (int i = 0; i < components.length; i++) {
            if (components[i] == comp) {
                return i;
            }
        }
        return -1;
    }
    // Highlight a selected row
    private void setSelectedRow(JPanel selected) {
        for (Component comp : panelStops.getComponents()) {
            if (comp instanceof JPanel) {
                comp.setBackground(new Color(240, 240, 240)); // normal color
            }
        }
        selected.setBackground(new Color(200, 220, 255)); // highlight color
    }
    
    private void searchPlace(String lugar, JMapViewer map) {
        try {
            String urlStr = "https://nominatim.openstreetmap.org/search?format=json&q=" + URLEncoder.encode(lugar, StandardCharsets.UTF_8);

            URI uri = new URI(urlStr);                     // ✅ Use URI
            URL url = uri.toURL();                         // ✅ Convert to URL

            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestProperty("User-Agent", "Mozilla/5.0");

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // Parse JSON response
            JSONArray results = new JSONArray(response.toString());
            if (results.length() > 0) {
                JSONObject result = results.getJSONObject(0);
                double lat = result.getDouble("lat");
                double lon = result.getDouble("lon");

                map.setDisplayPosition(new Coordinate(lat, lon), 15);
                map.removeAllMapMarkers();
                map.addMapMarker(new MapMarkerDot(lat, lon));

                addVisualStop(String.format("%.5f", lat), String.format("%.5f", lon));
            } else {
                JOptionPane.showMessageDialog(this, "No se encontró la ubicación.");
            }

        } catch (URISyntaxException | MalformedURLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "URL inválida.");
        } catch (IOException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error de conexión.");
        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error al buscar la ubicación.");
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

        panelAddRoute = new javax.swing.JPanel();
        labelCreateRoute = new javax.swing.JLabel();
        labelStop = new javax.swing.JLabel();
        panelMapStops = new javax.swing.JPanel();
        panelMap = new javax.swing.JPanel();
        jPanel11 = new javax.swing.JPanel();
        scrollPanelList = new javax.swing.JScrollPane();
        panelStops = new javax.swing.JPanel();
        filler1 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler2 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        panelSearch = new javax.swing.JPanel();
        labelSearch = new javax.swing.JLabel();
        textSearchPlace = new javax.swing.JTextField();
        panelInfo = new javax.swing.JPanel();
        panelTimes = new javax.swing.JPanel();
        panelEnd = new javax.swing.JPanel();
        panelEndD = new javax.swing.JPanel();
        labelEndD = new javax.swing.JLabel();
        boxEndD = new javax.swing.JComboBox<>();
        panelEndP = new javax.swing.JPanel();
        labelEndP = new javax.swing.JLabel();
        boxEndP = new javax.swing.JComboBox<>();
        panelEndC = new javax.swing.JPanel();
        labelEndC = new javax.swing.JLabel();
        boxEndC = new javax.swing.JComboBox<>();
        labelEnd = new javax.swing.JLabel();
        panelStart = new javax.swing.JPanel();
        panelStartD = new javax.swing.JPanel();
        boxStartD = new javax.swing.JComboBox<>();
        labelStartD = new javax.swing.JLabel();
        panelStartC = new javax.swing.JPanel();
        labelStartC = new javax.swing.JLabel();
        boxStartC = new javax.swing.JComboBox<>();
        labelStart = new javax.swing.JLabel();
        panelStartP = new javax.swing.JPanel();
        boxStartP = new javax.swing.JComboBox<>();
        labelStartP = new javax.swing.JLabel();
        buttonAddTrip = new javax.swing.JButton();
        panelCountry = new javax.swing.JPanel();
        boxCountry = new javax.swing.JComboBox<>();
        jLabel1 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        panelAddRoute.setBackground(new java.awt.Color(225, 239, 255));
        panelAddRoute.setLayout(new java.awt.GridBagLayout());

        labelCreateRoute.setText("CREATE ROUTE");
        labelCreateRoute.setFont(new java.awt.Font("Yu Gothic UI Semibold", 1, 40)); // NOI18N
        labelCreateRoute.setForeground(new java.awt.Color(18, 102, 160));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 20;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.weightx = 1.0;
        gridBagConstraints.insets = new java.awt.Insets(10, 280, 0, 0);
        panelAddRoute.add(labelCreateRoute, gridBagConstraints);

        labelStop.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        labelStop.setText("<html>Add Stop Points: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 17;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.ipadx = 80;
        gridBagConstraints.insets = new java.awt.Insets(50, 0, 10, 30);
        panelAddRoute.add(labelStop, gridBagConstraints);

        panelMapStops.setBackground(new java.awt.Color(225, 239, 255));
        panelMapStops.setMinimumSize(new java.awt.Dimension(500, 500));
        panelMapStops.setLayout(new javax.swing.BoxLayout(panelMapStops, javax.swing.BoxLayout.Y_AXIS));

        panelMap.setBackground(new java.awt.Color(225, 239, 255));
        panelMap.setMinimumSize(new java.awt.Dimension(280, 300));
        panelMap.setPreferredSize(new java.awt.Dimension(500, 300));
        panelMap.setLayout(new java.awt.BorderLayout());
        panelMapStops.add(panelMap);

        jPanel11.setBackground(new java.awt.Color(225, 239, 255));
        jPanel11.setLayout(new java.awt.BorderLayout());

        scrollPanelList.setAlignmentX(0.0F);
        scrollPanelList.setAlignmentY(0.1F);
        scrollPanelList.setMaximumSize(new java.awt.Dimension(300, 200));
        scrollPanelList.setMinimumSize(new java.awt.Dimension(280, 200));
        scrollPanelList.setRequestFocusEnabled(false);

        panelStops.setAlignmentY(0.0F);
        panelStops.setBackground(new java.awt.Color(225, 239, 255));
        panelStops.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED));
        panelStops.setMaximumSize(new java.awt.Dimension(300, 200));
        panelStops.setMinimumSize(new java.awt.Dimension(300, 200));
        panelStops.setLayout(new javax.swing.BoxLayout(panelStops, javax.swing.BoxLayout.Y_AXIS));
        scrollPanelList.setViewportView(panelStops);

        jPanel11.add(scrollPanelList, java.awt.BorderLayout.CENTER);

        panelMapStops.add(jPanel11);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 17;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 50);
        panelAddRoute.add(panelMapStops, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 23;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.weightx = 0.1;
        panelAddRoute.add(filler1, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 18;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.weightx = 0.1;
        panelAddRoute.add(filler2, gridBagConstraints);

        panelSearch.setBackground(new java.awt.Color(225, 239, 255));
        panelSearch.setLayout(new java.awt.GridBagLayout());

        labelSearch.setText("Search Place: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 5);
        panelSearch.add(labelSearch, gridBagConstraints);

        textSearchPlace.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                textSearchPlaceKeyPressed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipadx = 100;
        gridBagConstraints.ipady = 10;
        panelSearch.add(textSearchPlace, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 17;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 15, 20);
        panelAddRoute.add(panelSearch, gridBagConstraints);

        panelInfo.setBackground(new java.awt.Color(225, 239, 255));
        panelInfo.setLayout(new java.awt.GridBagLayout());

        panelTimes.setBackground(new java.awt.Color(225, 239, 255));
        panelTimes.setLayout(new java.awt.GridBagLayout());

        panelEnd.setBackground(new java.awt.Color(225, 239, 255));
        panelEnd.setLayout(new java.awt.GridBagLayout());

        panelEndD.setBackground(new java.awt.Color(225, 239, 255));
        panelEndD.setLayout(new java.awt.GridBagLayout());

        labelEndD.setText("District:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 0, 0);
        panelEndD.add(labelEndD, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipady = 10;
        gridBagConstraints.insets = new java.awt.Insets(7, 23, 0, 0);
        panelEndD.add(boxEndD, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 6;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        panelEnd.add(panelEndD, gridBagConstraints);

        panelEndP.setBackground(new java.awt.Color(225, 239, 255));
        panelEndP.setLayout(new java.awt.GridBagLayout());

        labelEndP.setText("Province:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 0, 0);
        panelEndP.add(labelEndP, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipady = 10;
        gridBagConstraints.insets = new java.awt.Insets(7, 14, 0, 0);
        panelEndP.add(boxEndP, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        panelEnd.add(panelEndP, gridBagConstraints);

        panelEndC.setBackground(new java.awt.Color(225, 239, 255));
        panelEndC.setLayout(new java.awt.GridBagLayout());

        labelEndC.setText("Canton:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 0, 0);
        panelEndC.add(labelEndC, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipady = 10;
        gridBagConstraints.insets = new java.awt.Insets(7, 21, 0, 0);
        panelEndC.add(boxEndC, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        panelEnd.add(panelEndC, gridBagConstraints);

        labelEnd.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        labelEnd.setText("<html>Add Destination Point: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.ipadx = 90;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(50, 0, 0, 0);
        panelEnd.add(labelEnd, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 30, 0, 0);
        panelTimes.add(panelEnd, gridBagConstraints);

        panelStart.setBackground(new java.awt.Color(225, 239, 255));
        panelStart.setLayout(new java.awt.GridBagLayout());

        panelStartD.setBackground(new java.awt.Color(225, 239, 255));
        panelStartD.setLayout(new java.awt.GridBagLayout());

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipady = 10;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(7, 23, 0, 0);
        panelStartD.add(boxStartD, gridBagConstraints);

        labelStartD.setText("District:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 0, 0);
        panelStartD.add(labelStartD, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.gridwidth = 2;
        panelStart.add(panelStartD, gridBagConstraints);

        panelStartC.setBackground(new java.awt.Color(225, 239, 255));
        panelStartC.setLayout(new java.awt.GridBagLayout());

        labelStartC.setText("Canton:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 0, 0);
        panelStartC.add(labelStartC, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipady = 10;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(7, 21, 0, 0);
        panelStartC.add(boxStartC, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.gridwidth = 2;
        panelStart.add(panelStartC, gridBagConstraints);

        labelStart.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        labelStart.setText("<html>Add Starting Point: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.ipadx = 80;
        gridBagConstraints.insets = new java.awt.Insets(50, 0, 0, 0);
        panelStart.add(labelStart, gridBagConstraints);

        panelStartP.setBackground(new java.awt.Color(225, 239, 255));
        panelStartP.setLayout(new java.awt.GridBagLayout());

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipady = 10;
        gridBagConstraints.insets = new java.awt.Insets(7, 14, 0, 0);
        panelStartP.add(boxStartP, gridBagConstraints);

        labelStartP.setText("Province:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 0, 0);
        panelStartP.add(labelStartP, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = 2;
        panelStart.add(panelStartP, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 10, 0, 0);
        panelTimes.add(panelStart, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.gridheight = 19;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.PAGE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 50, 0, 0);
        panelInfo.add(panelTimes, gridBagConstraints);

        buttonAddTrip.setBackground(new java.awt.Color(246, 172, 30));
        buttonAddTrip.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonAddTrip.setForeground(new java.awt.Color(255, 255, 255));
        buttonAddTrip.setText("Add Trip");
        buttonAddTrip.setPreferredSize(new java.awt.Dimension(110, 40));
        buttonAddTrip.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonAddTripActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 2;
        gridBagConstraints.gridy = 22;
        gridBagConstraints.ipadx = 50;
        gridBagConstraints.ipady = 20;
        gridBagConstraints.insets = new java.awt.Insets(10, 50, 0, 0);
        panelInfo.add(buttonAddTrip, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.gridheight = 23;
        gridBagConstraints.ipadx = 50;
        panelAddRoute.add(panelInfo, gridBagConstraints);

        panelCountry.setBackground(new java.awt.Color(225, 239, 255));
        panelCountry.setLayout(new java.awt.GridBagLayout());

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 10, 30);
        panelCountry.add(boxCountry, gridBagConstraints);

        jLabel1.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        jLabel1.setText("<html>Country: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        panelCountry.add(jLabel1, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 5;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.gridheight = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.PAGE_END;
        gridBagConstraints.insets = new java.awt.Insets(0, 30, 0, 0);
        panelAddRoute.add(panelCountry, gridBagConstraints);

        getContentPane().add(panelAddRoute, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void buttonAddTripActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonAddTripActionPerformed
        try {
            // 1. Validate start and end districts
            District startDistrict = (District) boxStartD.getSelectedItem();
            District endDistrict = (District) boxEndD.getSelectedItem();
            if (startDistrict == null || startDistrict.getId() == 0 ||
                endDistrict == null || endDistrict.getId() == 0) {
                JOptionPane.showMessageDialog(this, "Please select start and end districts.");
                return;
            }

            // 2. Validate and collect intermediate stop coordinates
            if (panelStops.getComponentCount() == 0) {
                JOptionPane.showMessageDialog(this, "Please add at least one stop.");
                return;
            }

            List<Coordinate> stopCoords = new ArrayList<>();
            for (Component comp : panelStops.getComponents()) {
                if (comp instanceof JPanel row) {
                    for (Component inner : row.getComponents()) {
                        if (inner instanceof JLabel label) {
                            String[] parts = label.getText().split(",");
                            double lat = Double.parseDouble(parts[0].replace("Lat:", "").trim());
                            double lon = Double.parseDouble(parts[1].replace("Lon:", "").trim());
                            stopCoords.add(new Coordinate(lat, lon));
                            break;
                        }
                    }
                }
            }

            // 3. Save everything using TripService
            try (Connection conn = DatabaseConnection.getConnection()) {
                TripService service = new TripService();
                service.createFullTripWithWaypoints(
                    startTime,
                    endTime,
                    tripDate,
                    vehicleId,
                    amountOfPassengers,
                    pricePerPassenger,
                    currencyId,
                    startDistrict.getId(),
                    endDistrict.getId(),
                    stopCoords,
                    conn
                );
            }

            // 4. Show confirmation and return
            JOptionPane.showMessageDialog(this, "Trip scheduled successfully!");

            SwingUtilities.invokeLater(() -> {
                ViewTrip trip = new ViewTrip(userRole, user);
                trip.setExtendedState(JFrame.MAXIMIZED_BOTH);
                trip.setVisible(true);
                CreateRoute.this.dispose();
            });

        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error saving trip: " + e.getMessage());
    }
    }//GEN-LAST:event_buttonAddTripActionPerformed

    private void textSearchPlaceKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_textSearchPlaceKeyPressed
        if (evt.getKeyCode() == KeyEvent.VK_ENTER) {
            String place = textSearchPlace.getText();
            if (!place.isBlank()) {
                searchPlace(place, map);
            }
        }
    }//GEN-LAST:event_textSearchPlaceKeyPressed
 
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
            java.util.logging.Logger.getLogger(CreateRoute.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(CreateRoute.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(CreateRoute.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(CreateRoute.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
    public void run() {
        String userRole = "Driver";
        User user = new User(1, "testuser", 101);

        // Sample values for testing:
        Timestamp startTime = Timestamp.valueOf("2025-06-01 07:30:00");
        Timestamp endTime = Timestamp.valueOf("2025-06-01 08:30:00");
        java.sql.Date tripDate = java.sql.Date.valueOf("2025-06-01");
        int passengers = 2;
        BigDecimal price = new BigDecimal("5.50");
        Long currencyId = 1L;
        long vehicleId = 10L;

        new CreateRoute(userRole, user, startTime, endTime, tripDate, passengers, price, currencyId, vehicleId).setVisible(true);
    }
});
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<Country> boxCountry;
    private javax.swing.JComboBox<Canton> boxEndC;
    private javax.swing.JComboBox<District> boxEndD;
    private javax.swing.JComboBox<Province> boxEndP;
    private javax.swing.JComboBox<Canton> boxStartC;
    private javax.swing.JComboBox<District> boxStartD;
    private javax.swing.JComboBox<Province> boxStartP;
    private javax.swing.JButton buttonAddTrip;
    private javax.swing.Box.Filler filler1;
    private javax.swing.Box.Filler filler2;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel11;
    private javax.swing.JLabel labelCreateRoute;
    private javax.swing.JLabel labelEnd;
    private javax.swing.JLabel labelEndC;
    private javax.swing.JLabel labelEndD;
    private javax.swing.JLabel labelEndP;
    private javax.swing.JLabel labelSearch;
    private javax.swing.JLabel labelStart;
    private javax.swing.JLabel labelStartC;
    private javax.swing.JLabel labelStartD;
    private javax.swing.JLabel labelStartP;
    private javax.swing.JLabel labelStop;
    private javax.swing.JPanel panelAddRoute;
    private javax.swing.JPanel panelCountry;
    private javax.swing.JPanel panelEnd;
    private javax.swing.JPanel panelEndC;
    private javax.swing.JPanel panelEndD;
    private javax.swing.JPanel panelEndP;
    private javax.swing.JPanel panelInfo;
    private javax.swing.JPanel panelMap;
    private javax.swing.JPanel panelMapStops;
    private javax.swing.JPanel panelSearch;
    private javax.swing.JPanel panelStart;
    private javax.swing.JPanel panelStartC;
    private javax.swing.JPanel panelStartD;
    private javax.swing.JPanel panelStartP;
    private javax.swing.JPanel panelStops;
    private javax.swing.JPanel panelTimes;
    private javax.swing.JScrollPane scrollPanelList;
    private javax.swing.JTextField textSearchPlace;
    // End of variables declaration//GEN-END:variables
}
