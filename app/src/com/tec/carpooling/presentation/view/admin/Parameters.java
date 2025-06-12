package com.tec.carpooling.presentation.view.admin;

import com.tec.carpooling.data.connection.DatabaseConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

public class Parameters extends javax.swing.JPanel {
    private DefaultTableModel parameterTableModel;
    private Long selectedParameterId = null;

    public Parameters() {
        initComponents();
        initTableModel();
        loadParameters();
    }

    private void initTableModel() {
        parameterTableModel = new DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "Nombre", "Valor"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Long.class, java.lang.String.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        };
        jTableParameters.setModel(parameterTableModel);
    }

    private void loadParameters() {
        try (Connection conn = DatabaseConnection.getConnection()) {
            CallableStatement cstmt = conn.prepareCall("{ call carpooling_adm.get_all_parameters() }");
            ResultSet rs = cstmt.executeQuery();
            
            parameterTableModel.setRowCount(0);
            while (rs.next()) {
                parameterTableModel.addRow(new Object[]{
                    rs.getLong("id"),
                    rs.getString("name"),
                    rs.getString("value")
                });
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al cargar parámetros: " + e.getMessage(), 
                "Error de Carga", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void clearFields() {
        jTextFieldName.setText("");
        jTextFieldValue.setText("");
        selectedParameterId = null;
        jButtonUpdate.setEnabled(false);
        jButtonDelete.setEnabled(false);
        jButtonSave.setEnabled(true);
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {
        jScrollPane = new javax.swing.JScrollPane();
        jTableParameters = new javax.swing.JTable();
        jLabelName = new javax.swing.JLabel();
        jTextFieldName = new javax.swing.JTextField();
        jLabelValue = new javax.swing.JLabel();
        jTextFieldValue = new javax.swing.JTextField();
        jButtonSave = new javax.swing.JButton();
        jButtonUpdate = new javax.swing.JButton();
        jButtonDelete = new javax.swing.JButton();

        setPreferredSize(new java.awt.Dimension(800, 600));

        jTableParameters.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "Nombre", "Valor"
            }
        ));
        jTableParameters.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jTableParametersMouseClicked(evt);
            }
        });
        jScrollPane.setViewportView(jTableParameters);

        jLabelName.setText("Nombre:");

        jLabelValue.setText("Valor:");

        jButtonSave.setText("Guardar");
        jButtonSave.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonSaveActionPerformed(evt);
            }
        });

        jButtonUpdate.setText("Actualizar");
        jButtonUpdate.setEnabled(false);
        jButtonUpdate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonUpdateActionPerformed(evt);
            }
        });

        jButtonDelete.setText("Eliminar");
        jButtonDelete.setEnabled(false);
        jButtonDelete.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonDeleteActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane, javax.swing.GroupLayout.DEFAULT_SIZE, 780, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabelName)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jTextFieldName, javax.swing.GroupLayout.PREFERRED_SIZE, 200, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(jLabelValue)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jTextFieldValue, javax.swing.GroupLayout.PREFERRED_SIZE, 200, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(jButtonSave)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jButtonUpdate)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jButtonDelete)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane, javax.swing.GroupLayout.PREFERRED_SIZE, 300, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabelName)
                    .addComponent(jTextFieldName, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabelValue)
                    .addComponent(jTextFieldValue, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButtonSave)
                    .addComponent(jButtonUpdate)
                    .addComponent(jButtonDelete))
                .addContainerGap(251, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void jTableParametersMouseClicked(java.awt.event.MouseEvent evt) {
        int selectedRow = jTableParameters.getSelectedRow();
        if (selectedRow >= 0) {
            selectedParameterId = (Long) parameterTableModel.getValueAt(selectedRow, 0);
            String selectedName = (String) parameterTableModel.getValueAt(selectedRow, 1);
            String selectedValue = (String) parameterTableModel.getValueAt(selectedRow, 2);

            jTextFieldName.setText(selectedName);
            jTextFieldValue.setText(selectedValue);

            jButtonSave.setEnabled(false);
            jButtonUpdate.setEnabled(true);
            jButtonDelete.setEnabled(true);
        } else {
            clearFields();
        }
    }

    private void jButtonSaveActionPerformed(java.awt.event.ActionEvent evt) {
        String name = jTextFieldName.getText().trim();
        String value = jTextFieldValue.getText().trim();
        
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El nombre del parámetro no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }
        
        if (value.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El valor del parámetro no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            CallableStatement cstmt = conn.prepareCall("{ call carpooling_adm.create_parameter(?, ?, ?) }");

            cstmt.setString(1, name);
            cstmt.setString(2, value);
            cstmt.registerOutParameter(3, java.sql.Types.BIGINT);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "Parámetro registrado exitosamente.");
            loadParameters();
            clearFields();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al guardar parámetro: " + e.getMessage(), 
                "Error de Guardado", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonUpdateActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedParameterId == null) {
            JOptionPane.showMessageDialog(this, "Por favor seleccione un parámetro para actualizar.", "Sin Selección", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String name = jTextFieldName.getText().trim();
        String value = jTextFieldValue.getText().trim();
        
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El nombre del parámetro no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }
        
        if (value.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El valor del parámetro no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            CallableStatement cstmt = conn.prepareCall("{ call carpooling_adm.update_parameter(?, ?, ?) }");
            
            cstmt.setLong(1, selectedParameterId);
            cstmt.setString(2, name);
            cstmt.setString(3, value);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "Parámetro actualizado exitosamente.");
            loadParameters();
            clearFields();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al actualizar parámetro: " + e.getMessage(), 
                "Error de Actualización", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonDeleteActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedParameterId == null) {
            JOptionPane.showMessageDialog(this, "Por favor seleccione un parámetro para eliminar.", "Sin Selección", JOptionPane.WARNING_MESSAGE);
            return;
        }

        int confirmation = JOptionPane.showConfirmDialog(this,
                "¿Está seguro que desea eliminar el parámetro seleccionado?\n(ID: " + selectedParameterId + " - Nombre: " + jTextFieldName.getText() + ")\n¡Esta acción no se puede deshacer!",
                "Confirmar Eliminación",
                JOptionPane.YES_NO_OPTION,
                JOptionPane.WARNING_MESSAGE);

        if (confirmation == JOptionPane.YES_OPTION) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                CallableStatement cstmt = conn.prepareCall("{ call carpooling_adm.delete_parameter(?) }");
                
                cstmt.setLong(1, selectedParameterId);
                cstmt.execute();
                
                JOptionPane.showMessageDialog(this, "Parámetro eliminado exitosamente.");
                loadParameters();
                clearFields();
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(this, 
                    "Error al eliminar parámetro: " + e.getMessage(), 
                    "Error de Eliminación", 
                    JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButtonDelete;
    private javax.swing.JButton jButtonSave;
    private javax.swing.JButton jButtonUpdate;
    private javax.swing.JLabel jLabelName;
    private javax.swing.JLabel jLabelValue;
    private javax.swing.JScrollPane jScrollPane;
    private javax.swing.JTable jTableParameters;
    private javax.swing.JTextField jTextFieldName;
    private javax.swing.JTextField jTextFieldValue;
    // End of variables declaration//GEN-END:variables
} 