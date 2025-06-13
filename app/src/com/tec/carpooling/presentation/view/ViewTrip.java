/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import com.tec.carpooling.domain.entity.User;
import com.tec.carpooling.domain.entity.TripDisplay;
import com.tec.carpooling.data.dao.TripDAO;

import com.tec.carpooling.data.connection.DatabaseConnection;

import java.awt.BorderLayout;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JCheckBox;
import javax.swing.table.DefaultTableModel;
import javax.swing.ListSelectionModel;
import javax.swing.table.TableRowSorter;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.table.TableModel;
import javax.swing.RowSorter;
import javax.swing.SortOrder;

import java.util.List;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author hidal
 */
public class ViewTrip extends javax.swing.JFrame {
    private String userRole;
    private final User user;
    /**
     * Creates new form Trips
     */
    public ViewTrip(String role, User user) {
        this.user     = user;
        this.userRole = role;
        initComponents();

        // 1) Build the model with an “ID” column first
        String[] cols = { "ID", "Date", "Start", "End", "Plate", "Status", "More Info" };
        DefaultTableModel model = new DefaultTableModel(cols, 0);
        tableTrips.setModel(model);

        // 2) Hide the ID column (so it's in the model but not visible)
        tableTrips.removeColumn(tableTrips.getColumnModel().getColumn(0));

        // 3) Load rows
        refreshTripTable();

        // 4) “More Info” button integration
        int infoCol = tableTrips.getColumnCount() - 1;
        tableTrips.getColumnModel().getColumn(infoCol)
                  .setCellRenderer(new ButtonRenderer());
        tableTrips.getColumnModel().getColumn(infoCol)
                  .setCellEditor(new ButtonEditor(new JCheckBox(), tableTrips));

        // 5) Sorting combobox listener
        TableRowSorter<TableModel> sorter = new TableRowSorter<>(tableTrips.getModel());
        tableTrips.setRowSorter(sorter);
        tableTrips.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);

        boxOrder.addActionListener(e -> {
            String selected = (String) boxOrder.getSelectedItem();
            int colIndex = getColumnIndexFromLabel(selected);
            if (colIndex >= 0) {
                // +1 because column 0 is the hidden ID
                sorter.setSortKeys(List.of(
                    new RowSorter.SortKey(colIndex + 1, SortOrder.ASCENDING)
                ));
            }
        });

        // 6) Add sidebar, maximize
        getContentPane().add(SideMenu.createToolbar(this, userRole, user), BorderLayout.WEST);
        setExtendedState(JFrame.MAXIMIZED_BOTH);
    }

    private void refreshTripTable() {
        try (Connection conn = DatabaseConnection.getConnection()) {
            TripDAO dao = new TripDAO();
            List<TripDisplay> trips = dao.getTripsByDriver(user.getPersonId(), conn);
            populateTripTable(trips);
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading trips: " + e.getMessage());
        }
    }

    public void populateTripTable(List<TripDisplay> trips) {
        DefaultTableModel model = (DefaultTableModel) tableTrips.getModel();
        model.setRowCount(0);
        for (TripDisplay t : trips) {
            model.addRow(new Object[]{
                t.getTripId(),          // hidden ID
                t.getTripDate(),
                t.getStartPoint(),
                t.getDestinationPoint(),
                t.getPlate(),
                t.getStatus(),
                "More Info"
            });
        }
    }

    private int getColumnIndexFromLabel(String label) {
        // note: these indices correspond to the VISIBLE columns
        switch (label) {
            case "Date of Trip":       return 0;
            case "Start Point":        return 1;
            case "Destination Point":  return 2;
            case "Vehicle Plate":      return 3;
            case "Status":             return 4;
            default: return -1;
        }
    }

    private void cancelSelectedTrip() {
        int viewRow = tableTrips.getSelectedRow();
        if (viewRow < 0) {
            JOptionPane.showMessageDialog(this, "Please select a trip to cancel.");
            return;
        }
        // Convert to model index so we read from the hidden-ID model
        int modelRow = tableTrips.convertRowIndexToModel(viewRow);

        long tripId  = (Long) tableTrips.getModel().getValueAt(modelRow, 0);
        String status= (String) tableTrips.getModel().getValueAt(modelRow, 5);

        if (!"Pending".equalsIgnoreCase(status)) {
            JOptionPane.showMessageDialog(this, "Only Pending trips can be cancelled.");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall("{CALL carpooling_pu.cancel_trip(?)}")) {

            // MySQL proc signature: CANCEL_TRIP(IN p_trip_id)
            cs.setLong(1, tripId);
            cs.execute();

            JOptionPane.showMessageDialog(this, "Trip cancelled successfully.");
            refreshTripTable();
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error cancelling trip: " + ex.getMessage());
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
        labelTrips = new javax.swing.JLabel();
        panelTable = new javax.swing.JPanel();
        scrollTrips = new javax.swing.JScrollPane();
        tableTrips = new javax.swing.JTable();
        filler1 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler2 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler3 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        jPanel3 = new javax.swing.JPanel();
        buttonModify = new javax.swing.JButton();
        buttonCancel = new javax.swing.JButton();
        buttonAdd = new javax.swing.JButton();
        panelOrder = new javax.swing.JPanel();
        labelOrder = new javax.swing.JLabel();
        boxOrder = new javax.swing.JComboBox<>();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanel1.setBackground(new java.awt.Color(225, 239, 255));
        jPanel1.setLayout(new java.awt.GridBagLayout());

        labelTrips.setFont(new java.awt.Font("Yu Gothic UI Semibold", 1, 40)); // NOI18N
        labelTrips.setForeground(new java.awt.Color(18, 102, 160));
        labelTrips.setText("TRIPS");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 20;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.weightx = 1.0;
        gridBagConstraints.insets = new java.awt.Insets(10, 360, 0, 0);
        jPanel1.add(labelTrips, gridBagConstraints);

        panelTable.setBackground(new java.awt.Color(225, 239, 255));
        panelTable.setLayout(new java.awt.BorderLayout());

        scrollTrips.setBackground(new java.awt.Color(225, 239, 255));

        tableTrips.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null, null},
                {null, null, null, null, null, null},
                {null, null, null, null, null, null},
                {null, null, null, null, null, null}
            },
            new String [] {
                "Date of Trip", "Start Point", "Destination Point", "Vehicle Plate", "Status", "More Info"
            }
        ));
        scrollTrips.setViewportView(tableTrips);

        panelTable.add(scrollTrips, java.awt.BorderLayout.CENTER);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 7;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.ipadx = 300;
        gridBagConstraints.ipady = 100;
        jPanel1.add(panelTable, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 7;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        jPanel1.add(filler1, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 7;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 10);
        jPanel1.add(filler2, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 7;
        gridBagConstraints.gridy = 6;
        gridBagConstraints.weighty = 0.1;
        jPanel1.add(filler3, gridBagConstraints);

        jPanel3.setBackground(new java.awt.Color(225, 239, 255));
        jPanel3.setLayout(new java.awt.GridBagLayout());

        buttonModify.setBackground(new java.awt.Color(18, 102, 160));
        buttonModify.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonModify.setForeground(new java.awt.Color(255, 255, 255));
        buttonModify.setText("Modify Trip");
        buttonModify.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonModifyActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipady = 30;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 50);
        jPanel3.add(buttonModify, gridBagConstraints);

        buttonCancel.setBackground(new java.awt.Color(255, 90, 90));
        buttonCancel.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonCancel.setForeground(new java.awt.Color(255, 255, 255));
        buttonCancel.setText("Cancel Trip");
        buttonCancel.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonCancelActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipady = 30;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 50);
        jPanel3.add(buttonCancel, gridBagConstraints);

        buttonAdd.setBackground(new java.awt.Color(246, 172, 30));
        buttonAdd.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonAdd.setForeground(new java.awt.Color(255, 255, 255));
        buttonAdd.setText("Schedule a Trip");
        buttonAdd.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonAddActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipady = 30;
        jPanel3.add(buttonAdd, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 0, 0);
        jPanel1.add(jPanel3, gridBagConstraints);

        panelOrder.setBackground(new java.awt.Color(225, 239, 255));
        panelOrder.setLayout(new java.awt.GridBagLayout());

        labelOrder.setText("Order By:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 10);
        panelOrder.add(labelOrder, gridBagConstraints);

        boxOrder.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Choose organization option", "Start Point", "Destination Point", "Vehicle Plate", "Status" }));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        panelOrder.add(boxOrder, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 7;
        gridBagConstraints.gridy = 1;
        jPanel1.add(panelOrder, gridBagConstraints);

        getContentPane().add(jPanel1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void buttonModifyActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonModifyActionPerformed
        int row = tableTrips.getSelectedRow();
        if (row != -1) {
            Object valorColumna1 = tableTrips.getValueAt(row, 0); // Columna 0
            Object valorColumna2 = tableTrips.getValueAt(row, 1); // Columna 1
            javax.swing.SwingUtilities.invokeLater(() -> {
                ModifyTrip modify = new ModifyTrip(userRole, user);
                modify.setExtendedState(JFrame.MAXIMIZED_BOTH);
                modify.setVisible(true);

                ViewTrip.this.dispose();
            });
        } else {
            JOptionPane.showMessageDialog(this, "A row must be selected.");
        }
    }//GEN-LAST:event_buttonModifyActionPerformed

    private void buttonAddActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonAddActionPerformed
        javax.swing.SwingUtilities.invokeLater(() -> {
            ScheduleTrip add = new ScheduleTrip(userRole, user);
            add.setExtendedState(JFrame.MAXIMIZED_BOTH);
            add.setVisible(true);

            ViewTrip.this.dispose();
        });
    }//GEN-LAST:event_buttonAddActionPerformed

    private void buttonCancelActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonCancelActionPerformed
        cancelSelectedTrip();
    }//GEN-LAST:event_buttonCancelActionPerformed

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
            java.util.logging.Logger.getLogger(ViewTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(ViewTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(ViewTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(ViewTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            private String userRole;
            private User user;
            public void run() {
                userRole = "Driver";
                user = new User(1, "testuser", 101);
                new ViewTrip(userRole, user).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> boxOrder;
    private javax.swing.JButton buttonAdd;
    private javax.swing.JButton buttonCancel;
    private javax.swing.JButton buttonModify;
    private javax.swing.Box.Filler filler1;
    private javax.swing.Box.Filler filler2;
    private javax.swing.Box.Filler filler3;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JLabel labelOrder;
    private javax.swing.JLabel labelTrips;
    private javax.swing.JPanel panelOrder;
    private javax.swing.JPanel panelTable;
    private javax.swing.JScrollPane scrollTrips;
    private javax.swing.JTable tableTrips;
    // End of variables declaration//GEN-END:variables
}
