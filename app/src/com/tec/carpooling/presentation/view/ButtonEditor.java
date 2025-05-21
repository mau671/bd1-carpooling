/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.data.dao.TripDAO;
import com.tec.carpooling.domain.entity.TripDetails;

import java.awt.Component;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;
import javax.swing.table.*;
import java.sql.Date;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author hidal
 */
public class ButtonEditor extends DefaultCellEditor {
    protected JButton button;
    private boolean isPushed;
    private JTable table;

    public ButtonEditor(JCheckBox checkBox, JTable table) {
        super(checkBox);
        this.table = table;

        button = new JButton("More Info");
        button.setOpaque(true);

        button.addActionListener(e -> fireEditingStopped());
    }

    @Override
    public Component getTableCellEditorComponent(JTable table, Object value,
            boolean isSelected, int row, int column) {
        isPushed = true;
        return button;
    }

    @Override
    public Object getCellEditorValue() {
        if (isPushed) {
            int selectedRow = table.getSelectedRow();

            Date tripDate = (Date) table.getValueAt(selectedRow, 0);
            String plate = (String) table.getValueAt(selectedRow, 3);

            try (Connection conn = DatabaseConnection.getConnection()) {
                // Get trip ID from plate and date
                String findTripIdSQL = "SELECT T.id FROM PU.TRIP T " +
                                       "JOIN PU.ROUTE R ON T.route_id = R.id " +
                                       "JOIN PU.VEHICLEXROUTE VR ON VR.route_id = R.id " +
                                       "JOIN PU.VEHICLE VEH ON VEH.id = VR.vehicle_id " +
                                       "WHERE VEH.plate = ? AND R.programming_date = ?";
                try (PreparedStatement stmt = conn.prepareStatement(findTripIdSQL)) {
                    stmt.setString(1, plate);
                    stmt.setDate(2, new java.sql.Date(tripDate.getTime()));
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            long tripId = rs.getLong("id");

                            // Fetch detailed trip info
                            TripDAO dao = new TripDAO();
                            TripDetails details = dao.getFullTripDetails(tripId, conn);
                            if (details == null) {
                                JOptionPane.showMessageDialog(button, "Trip details not found for ID: " + tripId);
                                return "More Info";
                            }

                            // Open the window
                            TripInfo tripInfoFrame = new TripInfo(details);
                            tripInfoFrame.setVisible(true);
                            tripInfoFrame.setLocationRelativeTo(null);
                        } else {
                            JOptionPane.showMessageDialog(button, "Trip not found.");
                        }
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(button, "Error loading trip details: " + ex.getMessage());
            }
        }
        isPushed = false;
        return "More Info";
    }
}
