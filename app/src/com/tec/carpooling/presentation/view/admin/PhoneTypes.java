/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JPanel.java to edit this template
 */
package com.tec.carpooling.presentation.view.admin;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;
import javax.swing.SwingUtilities;
import javax.swing.table.DefaultTableModel;
import com.tec.carpooling.data.connection.DatabaseConnection;

/**
 *
 * @author mauricio
 */
public class PhoneTypes extends javax.swing.JPanel {

    private DefaultTableModel phoneTypeTableModel;
    private Long selectedPhoneTypeId = null;

    public PhoneTypes() {
        initComponents();
        initTableModel();
        loadPhoneTypes();
        jButtonInstitutionUpdate.setEnabled(false);
        jButtonInstitutionDelete.setEnabled(false);
    }

    private void initTableModel() {
        phoneTypeTableModel = new DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "Name"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Long.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        };
        jTableInstitution.setModel(phoneTypeTableModel);
    }

    private void loadPhoneTypes() {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.list_type_phones()}");
             ResultSet rs = cstmt.executeQuery()) {
            
                phoneTypeTableModel.setRowCount(0);
                while (rs.next()) {
                    phoneTypeTableModel.addRow(new Object[]{
                        rs.getLong("id"),
                        rs.getString("name")
                    });
                }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error loading phone types: " + e.getMessage(), 
                "Load Error", 
                JOptionPane.ERROR_MESSAGE);
        }
        clearSelectionAndFields();
    }
    
   private void clearSelectionAndFields() {
        jTableInstitution.clearSelection();
        jTextFieldInstitutionName.setText("");
        selectedPhoneTypeId = null;
        jButtonInstitutionUpdate.setEnabled(false);
        jButtonInstitutionDelete.setEnabled(false);
        jButtonInstitutionSave.setEnabled(true);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabelInstitutionName = new javax.swing.JLabel();
        jTextFieldInstitutionName = new javax.swing.JTextField();
        jButtonInstitutionSave = new javax.swing.JButton();
        jButtonInstitutionUpdate = new javax.swing.JButton();
        jButtonInstitutionDelete = new javax.swing.JButton();
        jScrollPaneInstitution = new javax.swing.JScrollPane();
        jTableInstitution = new javax.swing.JTable();

        setPreferredSize(new java.awt.Dimension(800, 600));

        jLabelInstitutionName.setText("Name");

        jTextFieldInstitutionName.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextFieldInstitutionNameActionPerformed(evt);
            }
        });

        jButtonInstitutionSave.setText("Save");
        jButtonInstitutionSave.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonInstitutionSaveActionPerformed(evt);
            }
        });

        jButtonInstitutionUpdate.setText("Update");
        jButtonInstitutionUpdate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonInstitutionUpdateActionPerformed(evt);
            }
        });

        jButtonInstitutionDelete.setText("Delete");
        jButtonInstitutionDelete.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonInstitutionDeleteActionPerformed(evt);
            }
        });

        jTableInstitution.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "ID", "Name"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Long.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        jTableInstitution.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jTableInstitutionMouseClicked(evt);
            }
        });
        jScrollPaneInstitution.setViewportView(jTableInstitution);
        if (jTableInstitution.getColumnModel().getColumnCount() > 0) {
            jTableInstitution.getColumnModel().getColumn(0).setPreferredWidth(50);
            jTableInstitution.getColumnModel().getColumn(1).setPreferredWidth(200);
        }

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(107, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(jButtonInstitutionUpdate, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jButtonInstitutionDelete, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jButtonInstitutionSave))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jScrollPaneInstitution, javax.swing.GroupLayout.PREFERRED_SIZE, 564, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabelInstitutionName)
                                .addGap(38, 38, 38)
                                .addComponent(jTextFieldInstitutionName, javax.swing.GroupLayout.PREFERRED_SIZE, 137, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(26, 26, 26)))
                .addGap(103, 103, 103))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(105, 105, 105)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jButtonInstitutionSave)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jButtonInstitutionUpdate)
                        .addGap(12, 12, 12)
                        .addComponent(jButtonInstitutionDelete))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(9, 9, 9)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addGap(6, 6, 6)
                                .addComponent(jLabelInstitutionName))
                            .addComponent(jTextFieldInstitutionName, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addGap(48, 48, 48)
                .addComponent(jScrollPaneInstitution, javax.swing.GroupLayout.PREFERRED_SIZE, 214, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(140, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void jTextFieldInstitutionNameActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jTextFieldInstitutionNameActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jTextFieldInstitutionNameActionPerformed

    private void jButtonInstitutionSaveActionPerformed(java.awt.event.ActionEvent evt) {
        String name = jTextFieldInstitutionName.getText().trim();
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Phone type name cannot be empty.", "Invalid Input", JOptionPane.WARNING_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.insert_type_phone(?)}")) {
            
            cstmt.setString(1, name);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "Phone type '" + name + "' registered successfully.");
            loadPhoneTypes();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error saving phone type: " + e.getMessage(), 
                "Save Error", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonInstitutionUpdateActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedPhoneTypeId == null) {
            JOptionPane.showMessageDialog(this, "Please select a phone type from the table to update.", "No Selection", JOptionPane.WARNING_MESSAGE);
            return;
        }

         String newName = jTextFieldInstitutionName.getText().trim();
        if (newName.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Phone type name cannot be empty.", "Invalid Input", JOptionPane.WARNING_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.update_type_phone(?, ?)}")) {
            
            cstmt.setLong(1, selectedPhoneTypeId);
            cstmt.setString(2, newName);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "Phone type updated successfully.");
            loadPhoneTypes();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error updating phone type: " + e.getMessage(), 
                "Update Error", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonInstitutionDeleteActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedPhoneTypeId == null) {
            JOptionPane.showMessageDialog(this, "Please select a phone type from the table to delete.", "No Selection", JOptionPane.WARNING_MESSAGE);
            return;
        }

        int confirmation = JOptionPane.showConfirmDialog(this,
                "Are you sure you want to delete the selected phone type?\n(ID: " + selectedPhoneTypeId + " - Name: " + jTextFieldInstitutionName.getText() + ")\nThis action cannot be undone!",
                "Confirm Deletion",
                JOptionPane.YES_NO_OPTION,
                JOptionPane.WARNING_MESSAGE);

        if (confirmation == JOptionPane.YES_OPTION) {
            try (Connection conn = DatabaseConnection.getConnection();
                 CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.delete_type_phone(?)}")) {
                
                cstmt.setLong(1, selectedPhoneTypeId);
                cstmt.execute();
                
                JOptionPane.showMessageDialog(this, "Phone type deleted successfully.");
                loadPhoneTypes();
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(this, 
                    "Error deleting phone type: " + e.getMessage() + "\n(Possibly associated with phones or other data).", 
                    "Delete Error", 
                    JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    private void jTableInstitutionMouseClicked(java.awt.event.MouseEvent evt) {
       int selectedRow = jTableInstitution.getSelectedRow();
       if (selectedRow >= 0) {
            selectedPhoneTypeId = (Long) phoneTypeTableModel.getValueAt(selectedRow, 0);
            String selectedName = (String) phoneTypeTableModel.getValueAt(selectedRow, 1);

           jTextFieldInstitutionName.setText(selectedName);

            jButtonInstitutionSave.setEnabled(false);
           jButtonInstitutionUpdate.setEnabled(true);
           jButtonInstitutionDelete.setEnabled(true);
       } else {
            clearSelectionAndFields();
        }
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButtonInstitutionDelete;
    private javax.swing.JButton jButtonInstitutionSave;
    private javax.swing.JButton jButtonInstitutionUpdate;
    private javax.swing.JLabel jLabelInstitutionName;
    private javax.swing.JScrollPane jScrollPaneInstitution;
    private javax.swing.JTable jTableInstitution;
    private javax.swing.JTextField jTextFieldInstitutionName;
    // End of variables declaration//GEN-END:variables
}
