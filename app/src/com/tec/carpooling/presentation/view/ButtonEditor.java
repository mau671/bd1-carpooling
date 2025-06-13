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
    protected final JButton button;
    private boolean isPushed;
    private final JTable table;

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
            int row = table.getSelectedRow();
            // NOW read the hidden trip_id column, not plate+date
            long tripId = (Long) table.getValueAt(row, 0);

            try (Connection conn = DatabaseConnection.getConnection()) {
                TripDAO dao = new TripDAO();
                TripDetails details = dao.getFullTripDetails(tripId, conn);
                if (details == null) {
                    JOptionPane.showMessageDialog(button, 
                        "Trip details not found for ID: " + tripId);
                } else {
                    TripInfo frame = new TripInfo(details);
                    frame.setVisible(true);
                    frame.setLocationRelativeTo(null);
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(button, 
                    "Error loading trip details: " + ex.getMessage());
            }
        }
        isPushed = false;
        return "More Info";
    }
}

