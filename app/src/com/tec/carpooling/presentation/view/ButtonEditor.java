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
import java.sql.SQLException;
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
    private final JButton button = new JButton("More Info");
    private final JTable table;
    private boolean isPushed;

    public ButtonEditor(JCheckBox checkBox, JTable table) {
        super(checkBox);
        this.table = table;
        button.setOpaque(true);
        button.addActionListener((ActionEvent e) -> fireEditingStopped());
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
            // 1) Grab the selected row in view, convert to model
            int viewRow = table.getSelectedRow();
            int modelRow = table.convertRowIndexToModel(viewRow);

            // 2) Read the trip_id from the HIDDEN column 0
            long tripId = (Long) table.getModel().getValueAt(modelRow, 0);

            try (Connection conn = DatabaseConnection.getConnection()) {
                // 3) Fetch full details via your DAO
                TripDAO dao = new TripDAO();
                TripDetails details = dao.getFullTripDetails(tripId, conn);
                if (details == null) {
                    JOptionPane.showMessageDialog(button, 
                        "Trip details not found for ID: " + tripId);
                } else {
                    // 4) Open your details window
                    TripInfo frame = new TripInfo(details);
                    frame.setLocationRelativeTo(null);
                    frame.setVisible(true);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(button, 
                    "Error loading trip details: " + ex.getMessage());
            }
        }
        isPushed = false;
        return "More Info";
    }
}
