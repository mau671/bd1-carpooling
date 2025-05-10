/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import java.awt.Component;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;
import javax.swing.table.*;
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

        button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                fireEditingStopped();
            }
        });
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

            Object nameObj = table.getValueAt(selectedRow, 0); // Example: first column
            Object timeObj = table.getValueAt(selectedRow, 1); // Example: second column

            if (nameObj != null && timeObj != null) {
                String name = nameObj.toString();
                String time = timeObj.toString();

                TripInfo tripInfoFrame = new TripInfo();
                tripInfoFrame.setVisible(true);
                tripInfoFrame.setLocationRelativeTo(null); // center on screen
            } else {
                JOptionPane.showMessageDialog(button,
                    "This row has incomplete data.",
                    "Warning", JOptionPane.WARNING_MESSAGE);
            }
        }
        isPushed = false;
        return "More Info";
    }
}
