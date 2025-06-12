package com.tec.carpooling.presentation.view.admin;

import com.tec.carpooling.data.connection.DatabaseConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

public class Logs extends javax.swing.JPanel {
    private DefaultTableModel logsTableModel;

    public Logs() {
        initComponents();
        initTableModel();
        loadLogs();
    }

    private void initTableModel() {
        logsTableModel = new DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "Schema", "Table", "Field", "Previous Value", "Current Value", "Creator", "Creation Date", "Modifier", "Modification Date"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Long.class, java.lang.String.class, java.lang.String.class, java.lang.String.class,
                java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class,
                java.lang.String.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false, false, false, false, false, false
            };
            public Class getColumnClass(int columnIndex) { return types[columnIndex]; }
            public boolean isCellEditable(int rowIndex, int columnIndex) { return canEdit[columnIndex]; }
        };
        jTableLogs.setModel(logsTableModel);
    }

    private void loadLogs() {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{ call carpooling_adm.get_all_logs() }");
             ResultSet rs = cstmt.executeQuery()) {
            logsTableModel.setRowCount(0);
            while (rs.next()) {
                logsTableModel.addRow(new Object[]{
                    rs.getLong("id"),
                    rs.getString("schema_name"),
                    rs.getString("table_name"),
                    rs.getString("field_name"),
                    rs.getString("previous_value"),
                    rs.getString("current_value"),
                    rs.getString("creator"),
                    rs.getString("creation_date"),
                    rs.getString("modifier"),
                    rs.getString("modification_date")
                });
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this,
                    "Error al cargar logs: " + e.getMessage(),
                    "Error de Carga",
                    JOptionPane.ERROR_MESSAGE);
        }
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        jTableLogs = new javax.swing.JTable();
        jButtonRefresh = new javax.swing.JButton();

        setPreferredSize(new java.awt.Dimension(900, 600));

        jTableLogs.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "Schema", "Table", "Field", "Previous Value", "Current Value", "Creator", "Creation Date", "Modifier", "Modification Date"
            }
        ));
        jScrollPane1.setViewportView(jTableLogs);

        jButtonRefresh.setText("Refrescar");
        jButtonRefresh.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonRefreshActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 880, Short.MAX_VALUE)
                    .addComponent(jButtonRefresh))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 450, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jButtonRefresh)
                .addContainerGap(117, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void jButtonRefreshActionPerformed(java.awt.event.ActionEvent evt) {
        loadLogs();
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButtonRefresh;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable jTableLogs;
    // End of variables declaration//GEN-END:variables
}
