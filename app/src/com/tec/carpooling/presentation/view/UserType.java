/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import javax.swing.JFrame;

import java.awt.Image;
import java.awt.Cursor;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.ImageIcon;
import javax.swing.JOptionPane;
import com.tec.carpooling.business.service.UserTypeService;
import com.tec.carpooling.business.service.impl.UserTypeServiceImpl;
import com.tec.carpooling.domain.entity.User;
import java.sql.SQLException;

/**
 * Window for selecting user type (driver or passenger)
 */
public class UserType extends javax.swing.JFrame {
    private final UserTypeService userTypeService;
    private final User user;

    /**
     * Creates new form UserType
     */
    public UserType(User user) {
        this.userTypeService = new UserTypeServiceImpl();
        this.user = user;
        
        initComponents();
        setupUI();
        setupEventListeners();
        checkAdminStatus();
    }

    private void setupUI() {
        panelPassenger.setCursor(new Cursor(Cursor.HAND_CURSOR));
        panelDriver.setCursor(new Cursor(Cursor.HAND_CURSOR));
        
        // Load and scale images
        ImageIcon passengerIcon = new ImageIcon(getClass().getResource("/Assets/passenger.jpg"));
        Image scaledPassenger = passengerIcon.getImage().getScaledInstance(200, 200, Image.SCALE_SMOOTH);
        photoPassenger.setIcon(new ImageIcon(scaledPassenger));

        ImageIcon driverIcon = new ImageIcon(getClass().getResource("/Assets/driver.png"));
        Image scaledDriver = driverIcon.getImage().getScaledInstance(200, 200, Image.SCALE_SMOOTH);
        photoDriver.setIcon(new ImageIcon(scaledDriver));
        
        this.setExtendedState(JFrame.MAXIMIZED_BOTH);
    }
    
    private void checkAdminStatus() {
        try {
            boolean isAdmin = userTypeService.isAdmin(user.getId());
            if (isAdmin) {
                System.out.println("🔒 ADMIN ACCESS: Usuario " + user.getUsername() + " tiene privilegios de administrador");
                
                // Si es administrador, redirigir directamente al perfil de administrador
                javax.swing.SwingUtilities.invokeLater(() -> {
                    JOptionPane.showMessageDialog(this,
                        "Bienvenido, Administrador " + user.getUsername() + "!\n" +
                        "Redirigiendo al panel de administración...",
                        "Acceso de Administrador",
                        JOptionPane.INFORMATION_MESSAGE);
                    
                    UserProfile adminProfile = new UserProfile("Admin", user);
                    adminProfile.setExtendedState(JFrame.MAXIMIZED_BOTH);
                    adminProfile.setVisible(true);
                    this.dispose();
                });
                
                // Ocultar los paneles de selección ya que el admin va directo al panel
                panelPassenger.setVisible(false);
                panelDriver.setVisible(false);
            } else {
                System.out.println("👤 USER ACCESS: Usuario " + user.getUsername() + " es un usuario regular");
            }
        } catch (SQLException ex) {
            System.err.println("Error verificando estado de administrador: " + ex.getMessage());
        }
    }

    private void setupEventListeners() {
        panelPassenger.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                handlePassengerSelection();
            }
        });

        panelDriver.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                handleDriverSelection();
            }
        });
    }

    private void handlePassengerSelection() {
        try {
            boolean isAdmin = userTypeService.isAdmin(user.getId());
            boolean isDriver = userTypeService.isDriver(user.getId());
            boolean isPassenger = userTypeService.isPassenger(user.getId());
            
            if (isAdmin) {
                JOptionPane.showMessageDialog(this,
                    "Los administradores no pueden registrarse como pasajeros.",
                    "Acceso Restringido",
                    JOptionPane.WARNING_MESSAGE);
                return;
            }
            
            if (isPassenger) {
                // Ya es pasajero, ir directamente al perfil
                openUserProfile("Passenger", user);
            } else if (isDriver) {
                // Es conductor pero no pasajero, preguntar si quiere ser también pasajero
                int response = JOptionPane.showConfirmDialog(
                    this,
                    "¿Te gustaría registrarte también como pasajero? Ya estás registrado como conductor.",
                    "Registrarse como Pasajero",
                    JOptionPane.YES_NO_OPTION,
                    JOptionPane.QUESTION_MESSAGE
                );
                
                if (response == JOptionPane.YES_OPTION) {
                    userTypeService.registerAsPassenger(user.getId());
                    openUserProfile("Passenger", user);
                }
            } else {
                // No es ni conductor ni pasajero, registrar como pasajero
                userTypeService.registerAsPassenger(user.getId());
                openUserProfile("Passenger", user);
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this,
                "Error registrándose como pasajero: " + ex.getMessage(),
                "Error",
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void handleDriverSelection() {
        try {
            boolean isAdmin = userTypeService.isAdmin(user.getId());
            boolean isDriver = userTypeService.isDriver(user.getId());
            boolean isPassenger = userTypeService.isPassenger(user.getId());
            
            if (isAdmin) {
                JOptionPane.showMessageDialog(this,
                    "Los administradores no pueden registrarse como conductores.",
                    "Acceso Restringido",
                    JOptionPane.WARNING_MESSAGE);
                return;
            }
            
            if (isDriver) {
                // Ya es conductor, ir directamente al perfil
                openUserProfile("Driver", user);
            } else if (isPassenger) {
                // Es pasajero pero no conductor, preguntar si quiere ser también conductor
                int response = JOptionPane.showConfirmDialog(
                    this,
                    "¿Te gustaría registrarte también como conductor? Ya estás registrado como pasajero.",
                    "Registrarse como Conductor",
                    JOptionPane.YES_NO_OPTION,
                    JOptionPane.QUESTION_MESSAGE
                );
                
                if (response == JOptionPane.YES_OPTION) {
                    userTypeService.registerAsDriver(user.getId());
                    openUserProfile("Driver", user);
                }
            } else {
                // No es ni conductor ni pasajero, registrar como conductor
                userTypeService.registerAsDriver(user.getId());
                openUserProfile("Driver", user);
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this,
                "Error registrándose como conductor: " + ex.getMessage(),
                "Error",
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void openUserProfile(String userType, User user) {
        UserProfile profile = new UserProfile(userType, user);
        profile.setExtendedState(JFrame.MAXIMIZED_BOTH);
        profile.setVisible(true);
        this.dispose();
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
        panelPassenger = new javax.swing.JPanel();
        photoPassenger = new javax.swing.JLabel();
        labelPassenger = new javax.swing.JLabel();
        filler3 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler4 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        panelDriver = new javax.swing.JPanel();
        photoDriver = new javax.swing.JLabel();
        labelDriver = new javax.swing.JLabel();
        filler1 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler2 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanel1.setLayout(new java.awt.GridLayout(1, 2, 2, 0));

        panelPassenger.setBackground(new java.awt.Color(18, 102, 160));
        panelPassenger.setLayout(new java.awt.GridBagLayout());
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.insets = new java.awt.Insets(150, 0, 80, 0);
        panelPassenger.add(photoPassenger, gridBagConstraints);

        labelPassenger.setFont(new java.awt.Font("Segoe UI", 1, 50)); // NOI18N
        labelPassenger.setForeground(new java.awt.Color(255, 255, 255));
        labelPassenger.setText("Passenger");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 10;
        panelPassenger.add(labelPassenger, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 12;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        panelPassenger.add(filler3, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 5;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        panelPassenger.add(filler4, gridBagConstraints);

        jPanel1.add(panelPassenger);

        panelDriver.setBackground(new java.awt.Color(246, 172, 30));
        panelDriver.setLayout(new java.awt.GridBagLayout());
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.insets = new java.awt.Insets(150, 0, 80, 0);
        panelDriver.add(photoDriver, gridBagConstraints);

        labelDriver.setFont(new java.awt.Font("Segoe UI", 1, 50)); // NOI18N
        labelDriver.setForeground(new java.awt.Color(255, 255, 255));
        labelDriver.setText("Driver");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 10;
        panelDriver.add(labelDriver, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 12;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        panelDriver.add(filler1, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 5;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        panelDriver.add(filler2, gridBagConstraints);

        jPanel1.add(panelDriver);

        getContentPane().add(jPanel1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

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
            java.util.logging.Logger.getLogger(UserType.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(UserType.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(UserType.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(UserType.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                // Este método main no debería ser llamado directamente
                // La ventana debe ser creada desde otra clase que tenga el usuario
                JOptionPane.showMessageDialog(null,
                    "Esta ventana debe ser abierta desde otra clase que tenga el usuario.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.Box.Filler filler1;
    private javax.swing.Box.Filler filler2;
    private javax.swing.Box.Filler filler3;
    private javax.swing.Box.Filler filler4;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JLabel labelDriver;
    private javax.swing.JLabel labelPassenger;
    private javax.swing.JPanel panelDriver;
    private javax.swing.JPanel panelPassenger;
    private javax.swing.JLabel photoDriver;
    private javax.swing.JLabel photoPassenger;
    // End of variables declaration//GEN-END:variables
}
