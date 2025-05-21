package com.tec.carpooling.presentation.view.admin;

import com.tec.carpooling.data.connection.DatabaseConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import oracle.jdbc.OracleTypes;

public class PaymentMethods extends javax.swing.JPanel {
    private DefaultTableModel paymentMethodTableModel;
    private Long selectedPaymentMethodId = null;

    public PaymentMethods() {
        initComponents();
        initTableModel();
        loadPaymentMethods();
    }

    private void initTableModel() {
        paymentMethodTableModel = new DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "Nombre", "Creador", "Fecha Creación", "Modificador", "Fecha Modificación"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Long.class, java.lang.String.class, java.lang.String.class,
                java.lang.String.class, java.lang.String.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        };
        jTablePaymentMethods.setModel(paymentMethodTableModel);
    }

    private void loadPaymentMethods() {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{ call ADM.LIST_PAYMENT_METHODS(?) }")) {
            
            cstmt.registerOutParameter(1, OracleTypes.CURSOR);
            cstmt.execute();
            
            try (ResultSet rs = (ResultSet) cstmt.getObject(1)) {
                paymentMethodTableModel.setRowCount(0);
                while (rs.next()) {
                    paymentMethodTableModel.addRow(new Object[]{
                        rs.getLong("id"),
                        rs.getString("name"),
                        rs.getString("creator"),
                        rs.getString("creation_date"),
                        rs.getString("modifier"),
                        rs.getString("modification_date")
                    });
                }
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al cargar métodos de pago: " + e.getMessage(), 
                "Error de Carga", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void clearFields() {
        jTextFieldName.setText("");
        selectedPaymentMethodId = null;
        jButtonUpdate.setEnabled(false);
        jButtonDelete.setEnabled(false);
        jButtonSave.setEnabled(true);
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {
        jScrollPane = new javax.swing.JScrollPane();
        jTablePaymentMethods = new javax.swing.JTable();
        jLabelName = new javax.swing.JLabel();
        jTextFieldName = new javax.swing.JTextField();
        jButtonSave = new javax.swing.JButton();
        jButtonUpdate = new javax.swing.JButton();
        jButtonDelete = new javax.swing.JButton();

        setPreferredSize(new java.awt.Dimension(800, 600));

        jTablePaymentMethods.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "Nombre", "Creador", "Fecha Creación", "Modificador", "Fecha Modificación"
            }
        ));
        jTablePaymentMethods.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jTablePaymentMethodsMouseClicked(evt);
            }
        });
        jScrollPane.setViewportView(jTablePaymentMethods);

        jLabelName.setText("Nombre:");

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
                    .addComponent(jButtonSave)
                    .addComponent(jButtonUpdate)
                    .addComponent(jButtonDelete))
                .addContainerGap(251, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void jTablePaymentMethodsMouseClicked(java.awt.event.MouseEvent evt) {
        int selectedRow = jTablePaymentMethods.getSelectedRow();
        if (selectedRow >= 0) {
            selectedPaymentMethodId = (Long) paymentMethodTableModel.getValueAt(selectedRow, 0);
            String selectedName = (String) paymentMethodTableModel.getValueAt(selectedRow, 1);

            jTextFieldName.setText(selectedName);

            jButtonSave.setEnabled(false);
            jButtonUpdate.setEnabled(true);
            jButtonDelete.setEnabled(true);
        } else {
            clearFields();
        }
    }

    private void jButtonSaveActionPerformed(java.awt.event.ActionEvent evt) {
        String name = jTextFieldName.getText().trim();
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El nombre del método de pago no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{ call ADM.INSERT_PAYMENT_METHOD(?) }")) {
            
            cstmt.setString(1, name);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "Método de pago registrado exitosamente.");
            loadPaymentMethods();
            clearFields();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al guardar método de pago: " + e.getMessage(), 
                "Error de Guardado", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonUpdateActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedPaymentMethodId == null) {
            JOptionPane.showMessageDialog(this, "Por favor seleccione un método de pago para actualizar.", "Sin Selección", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String name = jTextFieldName.getText().trim();
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El nombre del método de pago no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{ call ADM.UPDATE_PAYMENT_METHOD(?, ?) }")) {
            
            cstmt.setLong(1, selectedPaymentMethodId);
            cstmt.setString(2, name);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "Método de pago actualizado exitosamente.");
            loadPaymentMethods();
            clearFields();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al actualizar método de pago: " + e.getMessage(), 
                "Error de Actualización", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonDeleteActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedPaymentMethodId == null) {
            JOptionPane.showMessageDialog(this, "Por favor seleccione un método de pago para eliminar.", "Sin Selección", JOptionPane.WARNING_MESSAGE);
            return;
        }

        int confirmation = JOptionPane.showConfirmDialog(this,
                "¿Está seguro que desea eliminar el método de pago seleccionado?\n(ID: " + selectedPaymentMethodId + " - Nombre: " + jTextFieldName.getText() + ")\n¡Esta acción no se puede deshacer!",
                "Confirmar Eliminación",
                JOptionPane.YES_NO_OPTION,
                JOptionPane.WARNING_MESSAGE);

        if (confirmation == JOptionPane.YES_OPTION) {
            try (Connection conn = DatabaseConnection.getConnection();
                 CallableStatement cstmt = conn.prepareCall("{ call ADM.DELETE_PAYMENT_METHOD(?) }")) {
                
                cstmt.setLong(1, selectedPaymentMethodId);
                cstmt.execute();
                
                JOptionPane.showMessageDialog(this, "Método de pago eliminado exitosamente.");
                loadPaymentMethods();
                clearFields();
            } catch (SQLException e) {
                String errorMessage = e.getMessage();
                if (errorMessage.contains("ORA-20082")) {
                    JOptionPane.showMessageDialog(this, 
                        "No se puede eliminar el método de pago porque está siendo utilizado en pagos.", 
                        "Error de Eliminación", 
                        JOptionPane.ERROR_MESSAGE);
                } else {
                    JOptionPane.showMessageDialog(this, 
                        "Error al eliminar método de pago: " + errorMessage, 
                        "Error de Eliminación", 
                        JOptionPane.ERROR_MESSAGE);
                }
            }
        }
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButtonDelete;
    private javax.swing.JButton jButtonSave;
    private javax.swing.JButton jButtonUpdate;
    private javax.swing.JLabel jLabelName;
    private javax.swing.JScrollPane jScrollPane;
    private javax.swing.JTable jTablePaymentMethods;
    private javax.swing.JTextField jTextFieldName;
    // End of variables declaration//GEN-END:variables
} 