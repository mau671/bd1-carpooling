/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view.admin;

import java.awt.BorderLayout;
import javax.swing.JComboBox;
import java.awt.CardLayout;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JToolBar;
/**
 *
 * @author hidal
 */
public class Queries extends javax.swing.JFrame {

    /**
     * Creates new form ConsultasAdmi
     */
    public Queries() {
        initComponents();
        
        // Para el panel con card layout
        cardPanel.add(scrollConductores, "Top 5 drivers with the most trips done");
        cardPanel.add(scrollPuntos, "First 5 most concurrent points");
        cardPanel.add(scrollUsuarios, "Top 5 most active users");
        cardPanel.add(scrollViajes, "All the trips that have been done");
        cardPanel.add(montoCobrado, "Average amount of charged by drivers");
        cardPanel.add(cantidadUsuarios, "Amount of new users in the last 3 months");
        this.setExtendedState(JFrame.MAXIMIZED_BOTH);
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
        boxConsultas = new javax.swing.JComboBox<>();
        labelIngresar = new javax.swing.JLabel();
        cardPanel = new javax.swing.JPanel();
        montoCobrado = new javax.swing.JLabel();
        cantidadUsuarios = new javax.swing.JLabel();
        scrollViajes = new javax.swing.JScrollPane();
        viajes = new javax.swing.JTable();
        scrollConductores = new javax.swing.JScrollPane();
        conductores = new javax.swing.JTable();
        scrollPuntos = new javax.swing.JScrollPane();
        puntosConcurrentes = new javax.swing.JTable();
        scrollUsuarios = new javax.swing.JScrollPane();
        usuarios = new javax.swing.JTable();
        jLabel1 = new javax.swing.JLabel();
        filler1 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        jPanel2 = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanel1.setLayout(new java.awt.GridBagLayout());

        boxConsultas.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Top 5 drivers with the most trips done", "First 5 most concurrent points", "Top 5 most active users", "All the trips that have been done", "Average amount of charged by drivers", "Amount of new users in the last 3 months" }));
        boxConsultas.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                boxConsultasActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 20, 0);
        jPanel1.add(boxConsultas, gridBagConstraints);

        labelIngresar.setFont(new java.awt.Font("Yu Gothic UI Semibold", 1, 40)); // NOI18N
        labelIngresar.setForeground(new java.awt.Color(18, 102, 160));
        labelIngresar.setText("QUERIES");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 4;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(60, 0, 60, 0);
        jPanel1.add(labelIngresar, gridBagConstraints);

        cardPanel.setPreferredSize(new java.awt.Dimension(200, 200));
        cardPanel.setLayout(new java.awt.CardLayout());

        montoCobrado.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        montoCobrado.setText("Average Amount Paid");
        montoCobrado.setVerticalAlignment(javax.swing.SwingConstants.TOP);
        cardPanel.add(montoCobrado, "card7");

        cantidadUsuarios.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        cantidadUsuarios.setText("Amount of Users");
        cantidadUsuarios.setVerticalAlignment(javax.swing.SwingConstants.TOP);
        cardPanel.add(cantidadUsuarios, "card6");

        viajes.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null},
                {null, null, null, null, null},
                {null, null, null, null, null},
                {null, null, null, null, null}
            },
            new String [] {
                "Trip", "Route", "Driver", "Vehicle", "Passangers"
            }
        ));
        scrollViajes.setViewportView(viajes);

        cardPanel.add(scrollViajes, "card2");

        conductores.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null, null},
                {null, null, null, null, null, null},
                {null, null, null, null, null, null},
                {null, null, null, null, null, null}
            },
            new String [] {
                "ID number", "First Name", "Second Name", "First Surname", "Second Surname", "Trips completed"
            }
        ));
        scrollConductores.setViewportView(conductores);

        cardPanel.add(scrollConductores, "card8");

        puntosConcurrentes.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null},
                {null, null, null},
                {null, null, null},
                {null, null, null}
            },
            new String [] {
                "Point", "Date Start", "Date End"
            }
        ));
        scrollPuntos.setViewportView(puntosConcurrentes);

        cardPanel.add(scrollPuntos, "card8");

        usuarios.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null, null},
                {null, null, null, null, null, null},
                {null, null, null, null, null, null},
                {null, null, null, null, null, null}
            },
            new String [] {
                "ID number", "First Name", "Second Name", "First Surname", "Second Surname", "Trips taken"
            }
        ));
        scrollUsuarios.setViewportView(usuarios);

        cardPanel.add(scrollUsuarios, "card8");

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.ipadx = 600;
        gridBagConstraints.ipady = 300;
        jPanel1.add(cardPanel, gridBagConstraints);

        jLabel1.setText("Inquire about:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 10, 0);
        jPanel1.add(jLabel1, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.weighty = 0.1;
        jPanel1.add(filler1, gridBagConstraints);

        jPanel2.setLayout(new java.awt.GridBagLayout());

        jLabel2.setText("jLabel2");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        jPanel2.add(jLabel2, gridBagConstraints);

        jLabel3.setText("Amount of queried records: ");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 10);
        jPanel2.add(jLabel3, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 5;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 20, 0);
        jPanel1.add(jPanel2, gridBagConstraints);

        getContentPane().add(jPanel1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void boxConsultasActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_boxConsultasActionPerformed
        CardLayout layout = (CardLayout) cardPanel.getLayout();
        String selected = (String) boxConsultas.getSelectedItem();
        layout.show(cardPanel, selected);
    }//GEN-LAST:event_boxConsultasActionPerformed

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
            java.util.logging.Logger.getLogger(Queries.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Queries.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Queries.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Queries.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Queries().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> boxConsultas;
    private javax.swing.JLabel cantidadUsuarios;
    private javax.swing.JPanel cardPanel;
    private javax.swing.JTable conductores;
    private javax.swing.Box.Filler filler1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JLabel labelIngresar;
    private javax.swing.JLabel montoCobrado;
    private javax.swing.JTable puntosConcurrentes;
    private javax.swing.JScrollPane scrollConductores;
    private javax.swing.JScrollPane scrollPuntos;
    private javax.swing.JScrollPane scrollUsuarios;
    private javax.swing.JScrollPane scrollViajes;
    private javax.swing.JTable usuarios;
    private javax.swing.JTable viajes;
    // End of variables declaration//GEN-END:variables
}
