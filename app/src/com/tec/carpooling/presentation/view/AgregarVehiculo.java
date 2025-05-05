/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import com.tec.carpooling.presentation.view.HomePage;
import javax.swing.JFrame;
import javax.swing.JToolBar;
import javax.swing.JButton;
import java.awt.BorderLayout;
import java.awt.Image;
import javax.swing.ImageIcon;

/**
 *
 * @author hidal
 */
public class AgregarVehiculo extends javax.swing.JFrame {

    /**
     * Creates new form AgregarVehiculo
     */
    public AgregarVehiculo() {
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
        
        // Load the image
        ImageIcon icon = new ImageIcon(getClass().getResource("/Assets/carro.png"));

        // Scale it to fit the label
        //Image scaledImage = icon.getImage().getScaledInstance(labelImagen.getWidth(), labelImagen.getHeight(), Image.SCALE_SMOOTH);

        // Set the scaled image as icon
        //labelImagen.setIcon(new ImageIcon(scaledImage));
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

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        panelAgregarVehiculo = new javax.swing.JPanel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setBackground(new java.awt.Color(204, 255, 51));
        setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N

        panelAgregarVehiculo.setLayout(new java.awt.GridBagLayout());
        getContentPane().add(panelAgregarVehiculo, java.awt.BorderLayout.CENTER);

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
            java.util.logging.Logger.getLogger(AgregarVehiculo.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(AgregarVehiculo.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(AgregarVehiculo.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(AgregarVehiculo.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new AgregarVehiculo().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JPanel panelAgregarVehiculo;
    // End of variables declaration//GEN-END:variables
}
