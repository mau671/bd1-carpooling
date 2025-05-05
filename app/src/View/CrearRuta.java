/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package View;

import java.awt.BorderLayout;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JButton;
import javax.swing.BorderFactory;
import javax.swing.JOptionPane;
import javax.swing.JFrame;
import javax.swing.BoxLayout;
import java.awt.FlowLayout;
import java.awt.Color;
import java.awt.Insets;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Dimension;
import java.awt.Component;
import javax.swing.JToolBar;



/**
 *
 * @author hidal
 */
public class CrearRuta extends javax.swing.JFrame {

    /**
     * Creates new form CrearRuta
     */
    public CrearRuta() {
        initComponents();
        JToolBar toolBar = new JToolBar(JToolBar.VERTICAL);
        JButton perfilButton = new JButton("User Profile");
        JButton vehiculoInfoButton = new JButton("Your Vehicle Information");
        JButton agregarVehiculoButton = new JButton("Add a Vehicle");
        JButton agendarViajeButton = new JButton("Schedule a Trip");
        JButton buscarViajesButton = new JButton("Search for Trips");
        JButton historialButton = new JButton("Activity Log");
        JButton adminConsultasButton = new JButton("Queries");
        JButton salirButton = new JButton("Log Out");
        

        // Add to toolbar
        toolBar.add(perfilButton);
        toolBar.add(vehiculoInfoButton);
        toolBar.add(agregarVehiculoButton);
        toolBar.add(agendarViajeButton);
        toolBar.add(buscarViajesButton);
        toolBar.add(historialButton);
        toolBar.add(adminConsultasButton);
        toolBar.add(salirButton);
        getContentPane().add(toolBar, BorderLayout.WEST);
        this.setExtendedState(JFrame.MAXIMIZED_BOTH);
        
        scrollPanelLista.setPreferredSize(new Dimension(200, 200));
        scrollPanelLista.setMaximumSize(new Dimension (200, Integer.MAX_VALUE));
        
        panelParadas.setLayout(new BoxLayout(panelParadas, BoxLayout.Y_AXIS));
        panelParadas.setMaximumSize(new Dimension (200, Integer.MAX_VALUE));
        panelParadas.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        this.setExtendedState(JFrame.MAXIMIZED_BOTH);
        
        perfilButton.addActionListener(e -> {
            javax.swing.SwingUtilities.invokeLater(() -> {
                InfoUsuario profile = new InfoUsuario();
                profile.setExtendedState(JFrame.MAXIMIZED_BOTH);
                profile.setVisible(true);

                this.dispose();
            });
        });

        /*vehiculoInfoButton.addActionListener(e -> {
            javax.swing.SwingUtilities.invokeLater(() -> {
                ModificarPerfil modify = new ModificarPerfil();
                modify.setExtendedState(JFrame.MAXIMIZED_BOTH);
                modify.setVisible(true);

                this.dispose();
            });
        });*/

        agregarVehiculoButton.addActionListener(e -> {
            javax.swing.SwingUtilities.invokeLater(() -> {
                AgregarVehiculo vehicle = new AgregarVehiculo();
                vehicle.setExtendedState(JFrame.MAXIMIZED_BOTH);
                vehicle.setVisible(true);

                this.dispose();
            });
        });

        /*agendarViajeButton.addActionListener(e -> {
            javax.swing.SwingUtilities.invokeLater(() -> {
                ModificarPerfil modify = new ModificarPerfil();
                modify.setExtendedState(JFrame.MAXIMIZED_BOTH);
                modify.setVisible(true);

                this.dispose();
            });
        });*/

        /*buscarViajesButton.addActionListener(e -> {
            javax.swing.SwingUtilities.invokeLater(() -> {
                ModificarPerfil modify = new ModificarPerfil();
                modify.setExtendedState(JFrame.MAXIMIZED_BOTH);
                modify.setVisible(true);

                this.dispose();
            });
        });*/

        /*historialButton.addActionListener(e -> {
            javax.swing.SwingUtilities.invokeLater(() -> {
                ModificarPerfil modify = new ModificarPerfil();
                modify.setExtendedState(JFrame.MAXIMIZED_BOTH);
                modify.setVisible(true);

                this.dispose();
            });
        });*/
        adminConsultasButton.addActionListener(e -> {
            javax.swing.SwingUtilities.invokeLater(() -> {
                ConsultasAdmi queries = new ConsultasAdmi();
                queries.setExtendedState(JFrame.MAXIMIZED_BOTH);
                queries.setVisible(true);

                this.dispose();
            });
        });
        salirButton.addActionListener(e -> {
            javax.swing.SwingUtilities.invokeLater(() -> {
                HomePage home = new HomePage();
                home.setExtendedState(JFrame.MAXIMIZED_BOTH);
                home.setVisible(true);

                this.dispose();
            });
        });
    }
    
    private void agregarParadaVisual(String lat, String lon) {
    JPanel fila = new JPanel(new FlowLayout(FlowLayout.LEFT));
    fila.setMaximumSize(new Dimension(Integer.MAX_VALUE, 25));
    fila.setBackground(new Color(240, 240, 240));
    fila.setOpaque(true);
    
    JLabel lbl = new JLabel("Lat: " + lat + ", Lon: " + lon);
    JButton btnX = new JButton("X");
    
    btnX.setMargin(new Insets(2, 5, 2, 5));
    btnX.setForeground(Color.RED);
    btnX.setBorder(BorderFactory.createEmptyBorder());
    btnX.setContentAreaFilled(false);

    btnX.addActionListener(e -> {
        panelParadas.remove(fila);
        panelParadas.revalidate();
        panelParadas.repaint();
    });

    fila.add(btnX);
    fila.add(lbl);

    panelParadas.add(fila);
    panelParadas.revalidate();
    panelParadas.repaint();
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
        labelCrearViaje = new javax.swing.JLabel();
        botonAgregarViaje = new javax.swing.JButton();
        scrollPanelLista = new javax.swing.JScrollPane();
        panelParadas = new javax.swing.JPanel();
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
        jPanel12 = new javax.swing.JPanel();
        jPanel11 = new javax.swing.JPanel();
        jPanel9 = new javax.swing.JPanel();
        labelLat = new javax.swing.JLabel();
        textLat = new javax.swing.JTextField();
        labelParada = new javax.swing.JLabel();
        jPanel10 = new javax.swing.JPanel();
        labelLon = new javax.swing.JLabel();
        textLon = new javax.swing.JTextField();
        botonParada = new javax.swing.JButton();
        jPanel13 = new javax.swing.JPanel();
        boxPasajeros = new javax.swing.JComboBox<>();
        labelPasajeros = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        panelCrearViaje.setLayout(new java.awt.GridBagLayout());

        labelCrearViaje.setFont(new java.awt.Font("Yu Gothic UI Semilight", 1, 40)); // NOI18N
        labelCrearViaje.setText("CREAR RUTA");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.weightx = 1.0;
        gridBagConstraints.insets = new java.awt.Insets(10, 330, 0, 0);
        panelCrearViaje.add(labelCrearViaje, gridBagConstraints);

        botonAgregarViaje.setBackground(new java.awt.Color(153, 255, 153));
        botonAgregarViaje.setText("Agregar Viaje");
        botonAgregarViaje.setPreferredSize(new java.awt.Dimension(110, 40));
        botonAgregarViaje.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                botonAgregarViajeActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 19;
        gridBagConstraints.gridy = 22;
        gridBagConstraints.weighty = 5.0;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 140);
        panelCrearViaje.add(botonAgregarViaje, gridBagConstraints);

        scrollPanelLista.setPreferredSize(new java.awt.Dimension(200, 200));

        panelParadas.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED));
        panelParadas.setLayout(new javax.swing.BoxLayout(panelParadas, javax.swing.BoxLayout.Y_AXIS));
        scrollPanelLista.setViewportView(panelParadas);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 17;
        gridBagConstraints.gridy = 13;
        gridBagConstraints.gridwidth = 14;
        gridBagConstraints.gridheight = 9;
        gridBagConstraints.weightx = 1.0;
        gridBagConstraints.weighty = 1.0;
        gridBagConstraints.insets = new java.awt.Insets(0, 50, 0, 40);
        panelCrearViaje.add(scrollPanelLista, gridBagConstraints);

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
        gridBagConstraints.insets = new java.awt.Insets(10, 210, 0, 0);
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
        gridBagConstraints.insets = new java.awt.Insets(10, 210, 0, 0);
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
        gridBagConstraints.insets = new java.awt.Insets(50, 200, 0, 0);
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
        gridBagConstraints.insets = new java.awt.Insets(10, 210, 0, 0);
        jPanel1.add(labelPartidaProv, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = 2;
        jPanel7.add(jPanel1, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.gridheight = 6;
        panelCrearViaje.add(jPanel7, gridBagConstraints);

        jPanel8.setLayout(new java.awt.GridBagLayout());

        jPanel6.setLayout(new java.awt.GridBagLayout());

        labelDestinoDis.setText("District:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(10, 210, 0, 0);
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
        jPanel8.add(jPanel6, gridBagConstraints);

        jPanel4.setLayout(new java.awt.GridBagLayout());

        labelDestinoProv.setText("Province:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(10, 210, 0, 0);
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
        jPanel8.add(jPanel4, gridBagConstraints);

        jPanel5.setLayout(new java.awt.GridBagLayout());

        labelDestinoCan.setText("Canton:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(10, 210, 0, 0);
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
        jPanel8.add(jPanel5, gridBagConstraints);

        labelDestino.setText("Add destination point: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(50, 200, 0, 0);
        jPanel8.add(labelDestino, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 11;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.gridheight = 7;
        panelCrearViaje.add(jPanel8, gridBagConstraints);

        jPanel12.setLayout(new java.awt.GridBagLayout());

        jPanel11.setLayout(new java.awt.GridBagLayout());

        jPanel9.setLayout(new java.awt.GridBagLayout());

        labelLat.setText("Latitud:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(10, 210, 0, 5);
        jPanel9.add(labelLat, gridBagConstraints);

        textLat.setPreferredSize(new java.awt.Dimension(80, 25));
        textLat.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                textLatActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.ipadx = 16;
        gridBagConstraints.ipady = 3;
        gridBagConstraints.insets = new java.awt.Insets(6, 0, 0, 0);
        jPanel9.add(textLat, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 3, 0);
        jPanel11.add(jPanel9, gridBagConstraints);

        labelParada.setText("Add stop points:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.insets = new java.awt.Insets(50, 260, 8, 0);
        jPanel11.add(labelParada, gridBagConstraints);

        jPanel10.setLayout(new java.awt.GridBagLayout());

        labelLon.setText("Longitud:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(10, 202, 0, 3);
        jPanel10.add(labelLon, gridBagConstraints);

        textLon.setPreferredSize(new java.awt.Dimension(80, 25));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.ipadx = 16;
        gridBagConstraints.ipady = 3;
        gridBagConstraints.insets = new java.awt.Insets(4, 0, 4, 0);
        jPanel10.add(textLon, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.gridwidth = 3;
        jPanel11.add(jPanel10, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.gridheight = 4;
        jPanel12.add(jPanel11, gridBagConstraints);

        botonParada.setBackground(new java.awt.Color(255, 255, 153));
        botonParada.setText("Agregar Parada");
        botonParada.setPreferredSize(new java.awt.Dimension(120, 40));
        botonParada.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                botonParadaActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 10;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.insets = new java.awt.Insets(6, 240, 0, 0);
        jPanel12.add(botonParada, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 17;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.gridheight = 11;
        panelCrearViaje.add(jPanel12, gridBagConstraints);

        jPanel13.setLayout(new java.awt.GridBagLayout());

        boxPasajeros.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        jPanel13.add(boxPasajeros, gridBagConstraints);

        labelPasajeros.setText("Amount of passangers:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 4);
        jPanel13.add(labelPasajeros, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 4;
        gridBagConstraints.gridy = 21;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.insets = new java.awt.Insets(0, 146, 0, 0);
        panelCrearViaje.add(jPanel13, gridBagConstraints);

        getContentPane().add(panelCrearViaje, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void botonAgregarViajeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_botonAgregarViajeActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_botonAgregarViajeActionPerformed
 
    private void botonParadaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_botonParadaActionPerformed
        String lat = textLat.getText().trim();
        String lon = textLon.getText().trim();

        if(!lat.isEmpty() && !lon.isEmpty()){
        agregarParadaVisual(lat, lon);
        textLat.setText("");
        textLon.setText("");
        } else{
            JOptionPane.showMessageDialog(this, "Ingrese latitud y longitud.");
        }
    }//GEN-LAST:event_botonParadaActionPerformed

    private void textLatActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_textLatActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_textLatActionPerformed

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
            java.util.logging.Logger.getLogger(CrearRuta.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(CrearRuta.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(CrearRuta.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(CrearRuta.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new CrearRuta().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton botonAgregarViaje;
    private javax.swing.JButton botonParada;
    private javax.swing.JComboBox<String> boxDestinoCan;
    private javax.swing.JComboBox<String> boxDestinoDis;
    private javax.swing.JComboBox<String> boxDestinoProv;
    private javax.swing.JComboBox<String> boxPartidaCan;
    private javax.swing.JComboBox<String> boxPartidaDis;
    private javax.swing.JComboBox<String> boxPartidaProv;
    private javax.swing.JComboBox<String> boxPasajeros;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel10;
    private javax.swing.JPanel jPanel11;
    private javax.swing.JPanel jPanel12;
    private javax.swing.JPanel jPanel13;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JPanel jPanel7;
    private javax.swing.JPanel jPanel8;
    private javax.swing.JPanel jPanel9;
    private javax.swing.JLabel labelCrearViaje;
    private javax.swing.JLabel labelDestino;
    private javax.swing.JLabel labelDestinoCan;
    private javax.swing.JLabel labelDestinoDis;
    private javax.swing.JLabel labelDestinoProv;
    private javax.swing.JLabel labelLat;
    private javax.swing.JLabel labelLon;
    private javax.swing.JLabel labelParada;
    private javax.swing.JLabel labelPartida;
    private javax.swing.JLabel labelPartidaCan;
    private javax.swing.JLabel labelPartidaProv;
    private javax.swing.JLabel labelPasajeros;
    private javax.swing.JLabel labelProvinciaDis;
    private javax.swing.JPanel panelCrearViaje;
    private javax.swing.JPanel panelParadas;
    private javax.swing.JScrollPane scrollPanelLista;
    private javax.swing.JTextField textLat;
    private javax.swing.JTextField textLon;
    // End of variables declaration//GEN-END:variables
}
