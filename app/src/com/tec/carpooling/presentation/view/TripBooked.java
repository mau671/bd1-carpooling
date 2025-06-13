/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import com.tec.carpooling.domain.entity.User;
import com.tec.carpooling.domain.entity.PassengerTripDisplay;
import com.tec.carpooling.data.dao.PassengerTripDAO;
import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.Connection;
import java.sql.SQLException;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import java.util.List;
import javax.swing.ListSelectionModel;
import javax.swing.RowSorter;
import javax.swing.SortOrder;
import javax.swing.table.TableModel;
import javax.swing.table.TableRowSorter;
import javax.swing.table.TableColumn;
import javax.swing.table.TableColumnModel;

/**
 *
 * @author hidal
 */
public class TripBooked extends javax.swing.JFrame {
    private String userRole;
    private final User user;
    /**
     * Creates new form TripBooked
     */
    public TripBooked(String role, User user) {
        this.user = user;
        this.userRole = role;
        initComponents();
        getContentPane().add(SideMenu.createToolbar(this, userRole, user), BorderLayout.WEST);

        // 1) Replace default model with one that includes a hidden ID column
        String[] cols = { "ID", "Date of Trip", "Start Point", "Destination Point", "Vehicle Plate", "Status", "More Info" };
        DefaultTableModel model = new DefaultTableModel(cols, 0) {
            @Override
            public boolean isCellEditable(int row, int column) {
                // Only the "More Info" button is editable
                return column == getColumnCount() - 1;
            }
        };
        tableTrips.setModel(model);

        // 2) Hide the ID column by zeroing its width
        TableColumnModel colModel = tableTrips.getColumnModel();
        TableColumn idCol = colModel.getColumn(0);
        idCol.setMinWidth(0);
        idCol.setMaxWidth(0);
        idCol.setPreferredWidth(0);

        // 3) Load data into table (includes hidden ID)
        loadBookedTrips();

        // 4) Assign custom renderer/editor to the "More Info" column
        int infoColumn = tableTrips.getColumnCount() - 1;
        tableTrips.getColumnModel().getColumn(infoColumn).setCellRenderer(new ButtonRenderer());
        tableTrips.getColumnModel().getColumn(infoColumn).setCellEditor(new ButtonEditor(new javax.swing.JCheckBox(), tableTrips));

        // 5) Enable sorting, skipping the hidden ID (offset by one)
        TableRowSorter<TableModel> sorter = new TableRowSorter<>(tableTrips.getModel());
        tableTrips.setRowSorter(sorter);
        tableTrips.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);

        boxOrder.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                String selected = (String) boxOrder.getSelectedItem();
                int visibleIndex = getColumnIndexFromLabel(selected);
                if (visibleIndex >= 0) {
                    // +1 offset for hidden ID column
                    sorter.setSortKeys(List.of(
                        new RowSorter.SortKey(visibleIndex + 1, SortOrder.ASCENDING)
                    ));
                }
            }
        });

        this.setExtendedState(JFrame.MAXIMIZED_BOTH);
    }

    private void loadBookedTrips() {
        try (Connection conn = DatabaseConnection.getConnection()) {
            PassengerTripDAO dao = new PassengerTripDAO();
            List<PassengerTripDisplay> trips = dao.getBookedTrips(user.getPersonId(), conn);
            populateBookedTripTable(trips);
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading booked trips: " + ex.getMessage());
        }
    }

    private void populateBookedTripTable(List<PassengerTripDisplay> trips) {
        DefaultTableModel model = (DefaultTableModel) tableTrips.getModel();
        model.setRowCount(0);
        for (PassengerTripDisplay trip : trips) {
            model.addRow(new Object[]{
                trip.getTripId(),          // hidden ID
                trip.getTripDate(),
                trip.getStartPoint(),
                trip.getEndPoint(),
                trip.getPlate(),
                trip.getStatus(),
                "More Info"
            });
        }
    }

    private int getColumnIndexFromLabel(String label) {
        switch (label) {
            case "Date of Trip":       return 0;
            case "Start Point":        return 1;
            case "Destination Point":  return 2;
            case "Vehicle Plate":      return 3;
            case "Status":             return 4;
            default: return -1;
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
        labelTripsBooked = new javax.swing.JLabel();
        panelTable = new javax.swing.JPanel();
        scrollTrips = new javax.swing.JScrollPane();
        tableTrips = new javax.swing.JTable();
        filler1 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler2 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler3 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        jPanel3 = new javax.swing.JPanel();
        buttonBook = new javax.swing.JButton();
        panelOrder = new javax.swing.JPanel();
        labelOrder = new javax.swing.JLabel();
        boxOrder = new javax.swing.JComboBox<>();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanel1.setBackground(new java.awt.Color(225, 239, 255));
        jPanel1.setLayout(new java.awt.GridBagLayout());

        labelTripsBooked.setFont(new java.awt.Font("Yu Gothic UI Semibold", 1, 40)); // NOI18N
        labelTripsBooked.setForeground(new java.awt.Color(18, 102, 160));
        labelTripsBooked.setText("TRIPS BOOKED");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 20;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.weightx = 1.0;
        gridBagConstraints.insets = new java.awt.Insets(10, 290, 0, 0);
        jPanel1.add(labelTripsBooked, gridBagConstraints);

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

        buttonBook.setBackground(new java.awt.Color(246, 172, 30));
        buttonBook.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonBook.setForeground(new java.awt.Color(255, 255, 255));
        buttonBook.setText("Book a Trip");
        buttonBook.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonBookActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipady = 30;
        jPanel3.add(buttonBook, gridBagConstraints);

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

        boxOrder.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Choose organization option", "Start Point", "Destination Point", "Status" }));
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

    private void buttonBookActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonBookActionPerformed
        javax.swing.SwingUtilities.invokeLater(() -> {
            SearchTrip search = new SearchTrip(userRole, user);
            search.setExtendedState(JFrame.MAXIMIZED_BOTH);
            search.setVisible(true);

            TripBooked.this.dispose();
        });
    }//GEN-LAST:event_buttonBookActionPerformed

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
            java.util.logging.Logger.getLogger(TripBooked.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(TripBooked.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(TripBooked.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(TripBooked.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            private String userRole;
            private User user;
            public void run() {
                userRole = "Driver";
                user = new User(1, "testuser", 101);
                new TripBooked(userRole, user).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> boxOrder;
    private javax.swing.JButton buttonBook;
    private javax.swing.Box.Filler filler1;
    private javax.swing.Box.Filler filler2;
    private javax.swing.Box.Filler filler3;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JLabel labelOrder;
    private javax.swing.JLabel labelTripsBooked;
    private javax.swing.JPanel panelOrder;
    private javax.swing.JPanel panelTable;
    private javax.swing.JScrollPane scrollTrips;
    private javax.swing.JTable tableTrips;
    // End of variables declaration//GEN-END:variables
}
