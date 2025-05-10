/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import java.awt.BorderLayout;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JButton;
import javax.swing.BorderFactory;
import javax.swing.JOptionPane;
import javax.swing.JFrame;
import javax.swing.BoxLayout;
import javax.swing.JToolBar;

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
    /**
     * Creates new form CrearRuta
     */
    public CreateRoute(String role) {
        this.userRole = role;
        System.setProperty("http.agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) CarpoolingApp/1.0");
        initComponents();
        getContentPane().add(SideMenu.createToolbar(this, userRole), BorderLayout.WEST);
        
        scrollPanelLista.setPreferredSize(new Dimension(200, 200));
        scrollPanelLista.setMaximumSize(new Dimension (200, Integer.MAX_VALUE));
        
        panelParadas.setLayout(new BoxLayout(panelParadas, BoxLayout.Y_AXIS));
        panelParadas.setMaximumSize(new Dimension (200, Integer.MAX_VALUE));
        panelParadas.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        loadMap();     // Llamas aquí o desde algún botón
        this.setExtendedState(JFrame.MAXIMIZED_BOTH);
    }
    
    private void loadMap() {
        panelMapa.removeAll(); // Limpiar si ya había algo

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

        panelMapa.setLayout(new BorderLayout());
        panelMapa.add(map, BorderLayout.CENTER);
        panelMapa.revalidate();
        panelMapa.repaint();
    }
    
    private void addVisualStop(String lat, String lon) {
        JPanel fila = new JPanel(new FlowLayout(FlowLayout.LEFT));
        fila.setMaximumSize(new Dimension(Integer.MAX_VALUE, 25));
        fila.setBackground(new Color(240, 240, 240));
        fila.setOpaque(true);

        JLabel lbl = new JLabel("Lat: " + lat + ", Lon: " + lon);

        // Botón para centrar el mapa en este punto
        JButton btnPin = new JButton("📍");
        btnPin.setBorder(BorderFactory.createEmptyBorder());
        btnPin.setContentAreaFilled(false);
        btnPin.setForeground(Color.BLUE);
        btnPin.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));

        btnPin.addActionListener(e -> {
            try {
                double latitude = Double.parseDouble(lat);
                double longitude = Double.parseDouble(lon);
                if (map != null) {
                    map.removeAllMapMarkers(); // Si quieres limpiar anteriores
                    map.setDisplayPosition(new Coordinate(latitude, longitude), 15);
                    map.addMapMarker(new MapMarkerDot(latitude, longitude));
                }
            } catch (NumberFormatException ex) {
                System.err.println("Coordenadas inválidas: " + lat + ", " + lon);
            }
        });

        // Botón para eliminar la fila
        JButton btnX = new JButton("X");
        btnX.setMargin(new Insets(2, 5, 2, 5));
        btnX.setForeground(Color.RED);
        btnX.setBorder(BorderFactory.createEmptyBorder());
        btnX.setContentAreaFilled(false);
        btnX.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));

        btnX.addActionListener(e -> {
            panelParadas.remove(fila);
            panelParadas.revalidate();
            panelParadas.repaint();
        });

        fila.add(btnX);
        fila.add(btnPin);
        fila.add(lbl);

        panelParadas.add(fila);
        panelParadas.revalidate();
        panelParadas.repaint();
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

        panelCrearViaje = new javax.swing.JPanel();
        labelCreateRoute = new javax.swing.JLabel();
        labelParada = new javax.swing.JLabel();
        jPanel9 = new javax.swing.JPanel();
        panelMapa = new javax.swing.JPanel();
        scrollPanelLista = new javax.swing.JScrollPane();
        panelParadas = new javax.swing.JPanel();
        filler1 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler2 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        jPanel14 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        textSearchPlace = new javax.swing.JTextField();
        jPanel10 = new javax.swing.JPanel();
        jPanel15 = new javax.swing.JPanel();
        jPanel8 = new javax.swing.JPanel();
        jPanel6 = new javax.swing.JPanel();
        labelDestinoDis = new javax.swing.JLabel();
        boxDestinoDis = new javax.swing.JComboBox<>();
        jPanel4 = new javax.swing.JPanel();
        labelDestinoProv = new javax.swing.JLabel();
        boxDestinoProv = new javax.swing.JComboBox<>();
        jPanel5 = new javax.swing.JPanel();
        labelDestinoCan = new javax.swing.JLabel();
        boxDestinoCan = new javax.swing.JComboBox<>();
        labelDestino = new javax.swing.JLabel();
        jPanel7 = new javax.swing.JPanel();
        jPanel3 = new javax.swing.JPanel();
        boxPartidaDis = new javax.swing.JComboBox<>();
        labelProvinciaDis = new javax.swing.JLabel();
        jPanel2 = new javax.swing.JPanel();
        labelPartidaCan = new javax.swing.JLabel();
        boxPartidaCan = new javax.swing.JComboBox<>();
        labelPartida = new javax.swing.JLabel();
        jPanel1 = new javax.swing.JPanel();
        boxPartidaProv = new javax.swing.JComboBox<>();
        labelPartidaProv = new javax.swing.JLabel();
        jPanel13 = new javax.swing.JPanel();
        boxPasajeros = new javax.swing.JComboBox<>();
        labelPasajeros = new javax.swing.JLabel();
        buttonAddTrip = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        panelCrearViaje.setLayout(new java.awt.GridBagLayout());

        labelCreateRoute.setFont(new java.awt.Font("Yu Gothic UI Semibold", 1, 40)); // NOI18N
        labelCreateRoute.setForeground(new java.awt.Color(18, 102, 160));
        labelCreateRoute.setText("CREATE ROUTE");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 20;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.weightx = 1.0;
        gridBagConstraints.insets = new java.awt.Insets(10, 330, 0, 0);
        panelCrearViaje.add(labelCreateRoute, gridBagConstraints);

        labelParada.setText("Add stop points:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 17;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.insets = new java.awt.Insets(50, 0, 10, 30);
        panelCrearViaje.add(labelParada, gridBagConstraints);

        jPanel9.setLayout(new javax.swing.BoxLayout(jPanel9, javax.swing.BoxLayout.Y_AXIS));

        panelMapa.setMinimumSize(new java.awt.Dimension(280, 300));
        panelMapa.setPreferredSize(new java.awt.Dimension(500, 300));
        panelMapa.setLayout(new javax.swing.BoxLayout(panelMapa, javax.swing.BoxLayout.LINE_AXIS));
        jPanel9.add(panelMapa);

        scrollPanelLista.setMinimumSize(new java.awt.Dimension(200, 200));
        scrollPanelLista.setPreferredSize(new java.awt.Dimension(200, 300));
        scrollPanelLista.setRequestFocusEnabled(false);

        panelParadas.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED));
        panelParadas.setAlignmentY(0.0F);
        panelParadas.setLayout(new javax.swing.BoxLayout(panelParadas, javax.swing.BoxLayout.Y_AXIS));
        scrollPanelLista.setViewportView(panelParadas);

        jPanel9.add(scrollPanelLista);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 17;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 50);
        panelCrearViaje.add(jPanel9, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 23;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.weightx = 0.1;
        panelCrearViaje.add(filler1, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 18;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.weightx = 0.1;
        panelCrearViaje.add(filler2, gridBagConstraints);

        jPanel14.setLayout(new java.awt.GridBagLayout());

        jLabel1.setText("Search Place: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 5);
        jPanel14.add(jLabel1, gridBagConstraints);

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
        jPanel14.add(textSearchPlace, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 17;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 20);
        panelCrearViaje.add(jPanel14, gridBagConstraints);

        jPanel10.setLayout(new java.awt.GridBagLayout());

        jPanel15.setLayout(new java.awt.GridBagLayout());

        jPanel8.setLayout(new java.awt.GridBagLayout());

        jPanel6.setLayout(new java.awt.GridBagLayout());

        labelDestinoDis.setText("District:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 0, 0);
        jPanel6.add(labelDestinoDis, gridBagConstraints);

        boxDestinoDis.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(7, 23, 0, 0);
        jPanel6.add(boxDestinoDis, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 6;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        jPanel8.add(jPanel6, gridBagConstraints);

        jPanel4.setLayout(new java.awt.GridBagLayout());

        labelDestinoProv.setText("Province:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 0, 0);
        jPanel4.add(labelDestinoProv, gridBagConstraints);

        boxDestinoProv.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(7, 14, 0, 0);
        jPanel4.add(boxDestinoProv, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        jPanel8.add(jPanel4, gridBagConstraints);

        jPanel5.setLayout(new java.awt.GridBagLayout());

        labelDestinoCan.setText("Canton:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 0, 0);
        jPanel5.add(labelDestinoCan, gridBagConstraints);

        boxDestinoCan.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(7, 21, 0, 0);
        jPanel5.add(boxDestinoCan, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        jPanel8.add(jPanel5, gridBagConstraints);

        labelDestino.setText("Add destination point: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(50, 0, 0, 0);
        jPanel8.add(labelDestino, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 30, 0, 0);
        jPanel15.add(jPanel8, gridBagConstraints);

        jPanel7.setLayout(new java.awt.GridBagLayout());

        jPanel3.setLayout(new java.awt.GridBagLayout());

        boxPartidaDis.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(7, 23, 0, 0);
        jPanel3.add(boxPartidaDis, gridBagConstraints);

        labelProvinciaDis.setText("District:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 0, 0);
        jPanel3.add(labelProvinciaDis, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.gridwidth = 2;
        jPanel7.add(jPanel3, gridBagConstraints);

        jPanel2.setLayout(new java.awt.GridBagLayout());

        labelPartidaCan.setText("Canton:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 0, 0);
        jPanel2.add(labelPartidaCan, gridBagConstraints);

        boxPartidaCan.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(7, 21, 0, 0);
        jPanel2.add(boxPartidaCan, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.gridwidth = 2;
        jPanel7.add(jPanel2, gridBagConstraints);

        labelPartida.setText("Add starting point:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.insets = new java.awt.Insets(50, 0, 0, 0);
        jPanel7.add(labelPartida, gridBagConstraints);

        jPanel1.setLayout(new java.awt.GridBagLayout());

        boxPartidaProv.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(7, 14, 0, 0);
        jPanel1.add(boxPartidaProv, gridBagConstraints);

        labelPartidaProv.setText("Province:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 0, 0);
        jPanel1.add(labelPartidaProv, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = 2;
        jPanel7.add(jPanel1, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 30, 0, 0);
        jPanel15.add(jPanel7, gridBagConstraints);

        jPanel13.setLayout(new java.awt.GridBagLayout());

        boxPasajeros.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        jPanel13.add(boxPasajeros, gridBagConstraints);

        labelPasajeros.setText("Amount of passangers:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 4);
        jPanel13.add(labelPasajeros, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_END;
        gridBagConstraints.insets = new java.awt.Insets(50, 30, 0, 0);
        jPanel15.add(jPanel13, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.gridheight = 19;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.PAGE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 50, 0, 0);
        jPanel10.add(jPanel15, gridBagConstraints);

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
        gridBagConstraints.insets = new java.awt.Insets(50, 50, 0, 0);
        jPanel10.add(buttonAddTrip, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.gridheight = 23;
        gridBagConstraints.ipadx = 50;
        panelCrearViaje.add(jPanel10, gridBagConstraints);

        getContentPane().add(panelCrearViaje, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void buttonAddTripActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonAddTripActionPerformed
        /*String plate = textPlate.getText().trim();

        // Check if any field is empty
        if (plate.isEmpty()) {
            JOptionPane.showMessageDialog(null, "Please fill in all required fields.");
            return;
        }*/
        JOptionPane.showMessageDialog(null, "Trip scheduled successfully!");
        // Go back to vehicle registration screen
        javax.swing.SwingUtilities.invokeLater(() -> {
            ViewTrip trip = new ViewTrip(userRole);
            trip.setExtendedState(JFrame.MAXIMIZED_BOTH);
            trip.setVisible(true);

            CreateRoute.this.dispose();
        });
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
            private String userRole;
            public void run() {
                userRole = "Driver";
                new CreateRoute(userRole).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> boxDestinoCan;
    private javax.swing.JComboBox<String> boxDestinoDis;
    private javax.swing.JComboBox<String> boxDestinoProv;
    private javax.swing.JComboBox<String> boxPartidaCan;
    private javax.swing.JComboBox<String> boxPartidaDis;
    private javax.swing.JComboBox<String> boxPartidaProv;
    private javax.swing.JComboBox<String> boxPasajeros;
    private javax.swing.JButton buttonAddTrip;
    private javax.swing.Box.Filler filler1;
    private javax.swing.Box.Filler filler2;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel10;
    private javax.swing.JPanel jPanel13;
    private javax.swing.JPanel jPanel14;
    private javax.swing.JPanel jPanel15;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JPanel jPanel7;
    private javax.swing.JPanel jPanel8;
    private javax.swing.JPanel jPanel9;
    private javax.swing.JLabel labelCreateRoute;
    private javax.swing.JLabel labelDestino;
    private javax.swing.JLabel labelDestinoCan;
    private javax.swing.JLabel labelDestinoDis;
    private javax.swing.JLabel labelDestinoProv;
    private javax.swing.JLabel labelParada;
    private javax.swing.JLabel labelPartida;
    private javax.swing.JLabel labelPartidaCan;
    private javax.swing.JLabel labelPartidaProv;
    private javax.swing.JLabel labelPasajeros;
    private javax.swing.JLabel labelProvinciaDis;
    private javax.swing.JPanel panelCrearViaje;
    private javax.swing.JPanel panelMapa;
    private javax.swing.JPanel panelParadas;
    private javax.swing.JScrollPane scrollPanelLista;
    private javax.swing.JTextField textSearchPlace;
    // End of variables declaration//GEN-END:variables
}
