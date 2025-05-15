/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import java.awt.BorderLayout;
import java.awt.Image;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;

import java.net.URL;
import java.util.Locale;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import javax.swing.DefaultComboBoxModel;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;

/**
 *
 * @author hidal
 */
public class ModifyTrip extends javax.swing.JFrame {
    private String userRole;
    /**
     * Creates new form ModifyTrip
     */
    public ModifyTrip(String role) {
        this.userRole = role;
        initComponents();
        getContentPane().add(SideMenu.createToolbar(this, userRole), BorderLayout.WEST);
        customizeDatePicker();
        textPrice.setToolTipText("Write 0 for no charge.");
        textPrice.addKeyListener(new KeyAdapter() {
             @Override
            public void keyTyped(KeyEvent e) {
                char c = e.getKeyChar();

                // Allow digits and one dot
                if (!Character.isDigit(c) && c != '.') {
                    e.consume();
                    return;
                }

                // Prevent more than one dot
                if (c == '.' && textPrice.getText().contains(".")) {
                    e.consume();
                }
            }
        });
        textPrice.getDocument().addDocumentListener(new DocumentListener() {
        @Override
        public void insertUpdate(DocumentEvent e) {
            checkPriceField();
        }

        @Override
        public void removeUpdate(DocumentEvent e) {
            checkPriceField();
        }

        @Override
        public void changedUpdate(DocumentEvent e) {
            checkPriceField();
        }

        private void checkPriceField() {
            String text = textPrice.getText().trim();
            if (text.isEmpty()) {
                // Optional: disable if empty
                boxCurrency.setEnabled(false);
                boxMethod.setEnabled(false);
                return;
            }

            try {
                double price = Double.parseDouble(text);
                boolean isFree = price == 0.0;

                boxCurrency.setEnabled(!isFree);
                boxMethod.setEnabled(!isFree);
            } catch (NumberFormatException ex) {
                // Optional: disable if invalid input
                boxCurrency.setEnabled(false);
                boxMethod.setEnabled(false);
            }
        }
    });
        
        this.setExtendedState(JFrame.MAXIMIZED_BOTH);
    }
    
    private void filterAvailableTimes(JComboBox<String> comboTime) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("hh:mm a");
        LocalTime now = LocalTime.now();

        String[] allTimes = getAllTimes(); // use same helper for both methods

        DefaultComboBoxModel<String> model = new DefaultComboBoxModel<>();
        for (String timeString : allTimes) {
            LocalTime time = LocalTime.parse(timeString, formatter);
            if (!time.isBefore(now)) {
                model.addElement(timeString);
            }
        }
        comboTime.setModel(model);
        
        if (model.getSize() > 0) {
            boxStartTime.setSelectedIndex(0);
            boxStartTimeActionPerformed(null); // 🟢 Trigger end time update
        }
    }
    
    private String[] getAllTimes() {
        return new String[]{
            "05:00 AM", "05:30 AM", "06:00 AM", "06:30 AM", "07:00 AM", "07:30 AM", "08:00 AM",
            "08:30 AM", "09:00 AM", "09:30 AM", "10:00 AM", "10:30 AM", "11:00 AM",
            "11:30 AM", "12:00 PM", "12:30 PM", "01:00 PM", "01:30 PM", "02:00 PM",
            "02:30 PM", "03:00 PM", "03:30 PM", "04:00 PM", "04:30 PM", "05:00 PM",
            "05:30 PM", "06:00 PM", "06:30 PM", "07:00 PM", "07:30 PM", "08:00 PM",
            "08:30 PM", "09:00 PM", "09:30 PM", "10:00 PM", "10:30 PM", "11:00 PM",
            "11:30 PM"
        };
    }
    
    private void resetAllTimes(JComboBox<String> comboTime) {
        String[] allTimes = getAllTimes();
        DefaultComboBoxModel<String> model = new DefaultComboBoxModel<>(allTimes);
        comboTime.setModel(model);
        
        if (model.getSize() > 0) {
            boxStartTime.setSelectedIndex(0);
            boxStartTimeActionPerformed(null); // 🟢 Trigger end time update
        }
    }
    
    private void customizeDatePicker() {
        URL dateImageURL = getClass().getResource("/Assets/datePickerIcon.png");
        if (dateImageURL != null) {
            Image dateImage = getToolkit().getImage(dateImageURL);
            ImageIcon dateIcon = new ImageIcon(dateImage);

            datePicker.getComponentDateTextField().setEditable(false);
            datePicker.getComponentDateTextField().setEnabled(false);
            datePicker.setDateToToday();
            datePicker.setLocale(Locale.ENGLISH);

            // ✅ Disallow past dates
            datePicker.getSettings().setVetoPolicy(date -> !date.isBefore(LocalDate.now()));

            // ✅ Add listener for date changes
            datePicker.addDateChangeListener(event -> {
                LocalDate selectedDate = event.getNewDate();
                LocalDate today = LocalDate.now();

                if (selectedDate != null) {
                    if (selectedDate.isEqual(today)) {
                        filterAvailableTimes(boxStartTime);
                    } else {
                        resetAllTimes(boxStartTime);
                    }
                }
            });

            // ✅ Set calendar icon
            JButton datePickerButton = datePicker.getComponentToggleCalendarButton();
            datePickerButton.setText("");
            datePickerButton.setIcon(dateIcon);

            // ✅ Manually filter on init (because today is selected by default)
            filterAvailableTimes(boxStartTime);
        } else {
            System.err.println("Image for date picker button not found.");
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
        labelModifyTrip = new javax.swing.JLabel();
        panelDate = new javax.swing.JPanel();
        labelDate = new javax.swing.JLabel();
        datePicker = new com.github.lgooddatepicker.components.DatePicker();
        panelPrice = new javax.swing.JPanel();
        labelPrice = new javax.swing.JLabel();
        textPrice = new javax.swing.JTextField();
        panelPayment = new javax.swing.JPanel();
        boxMethod = new javax.swing.JComboBox<>();
        labelMethod = new javax.swing.JLabel();
        panelPassengers = new javax.swing.JPanel();
        labelSeats = new javax.swing.JLabel();
        boxSeats = new javax.swing.JComboBox<>();
        panelCurrency = new javax.swing.JPanel();
        labelCurrency = new javax.swing.JLabel();
        boxCurrency = new javax.swing.JComboBox<>();
        buttonModifyRoute = new javax.swing.JButton();
        filler1 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler2 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        panelTimes = new javax.swing.JPanel();
        jPanel3 = new javax.swing.JPanel();
        boxStartTime = new javax.swing.JComboBox<>();
        labelStartTime = new javax.swing.JLabel();
        jPanel2 = new javax.swing.JPanel();
        labelEndTime = new javax.swing.JLabel();
        boxEndTime = new javax.swing.JComboBox<>();
        panelDivision = new javax.swing.JPanel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanel1.setBackground(new java.awt.Color(225, 239, 255));
        jPanel1.setLayout(new java.awt.GridBagLayout());

        labelModifyTrip.setText("MODIFY TRIP");
        labelModifyTrip.setFont(new java.awt.Font("Yu Gothic UI Semibold", 1, 40)); // NOI18N
        labelModifyTrip.setForeground(new java.awt.Color(18, 102, 160));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 22;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.weightx = 1.0;
        gridBagConstraints.insets = new java.awt.Insets(10, 290, 0, 0);
        jPanel1.add(labelModifyTrip, gridBagConstraints);

        panelDate.setBackground(new java.awt.Color(225, 239, 255));
        panelDate.setLayout(new java.awt.GridBagLayout());

        labelDate.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        labelDate.setText("<html>Date of Trip: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 67;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        panelDate.add(labelDate, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.ipady = 15;
        panelDate.add(datePicker, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 19;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 70, 30, 0);
        jPanel1.add(panelDate, gridBagConstraints);

        panelPrice.setBackground(new java.awt.Color(225, 239, 255));
        panelPrice.setLayout(new java.awt.GridBagLayout());

        labelPrice.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        labelPrice.setText("<html>Price per Passenger: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 80;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        panelPrice.add(labelPrice, gridBagConstraints);

        textPrice.setPreferredSize(new java.awt.Dimension(150, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.ipadx = 4;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        panelPrice.add(textPrice, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 21;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.ipadx = 25;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.FIRST_LINE_START;
        gridBagConstraints.weightx = 0.1;
        jPanel1.add(panelPrice, gridBagConstraints);

        panelPayment.setBackground(new java.awt.Color(225, 239, 255));
        panelPayment.setLayout(new java.awt.GridBagLayout());

        boxMethod.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipady = 20;
        panelPayment.add(boxMethod, gridBagConstraints);

        labelMethod.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        labelMethod.setText("<html>Payment Method: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 10;
        panelPayment.add(labelMethod, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 21;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.FIRST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 50, 0);
        jPanel1.add(panelPayment, gridBagConstraints);

        panelPassengers.setBackground(new java.awt.Color(225, 239, 255));
        panelPassengers.setLayout(new java.awt.GridBagLayout());

        labelSeats.setText("<html>Amount of Passengers: <span style='color:red'>*</span></html>");
        labelSeats.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.ipadx = 10;
        panelPassengers.add(labelSeats, gridBagConstraints);

        boxSeats.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.ipady = 20;
        panelPassengers.add(boxSeats, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 19;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 70, 50, 0);
        jPanel1.add(panelPassengers, gridBagConstraints);

        panelCurrency.setBackground(new java.awt.Color(225, 239, 255));
        panelCurrency.setLayout(new java.awt.GridBagLayout());

        labelCurrency.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        labelCurrency.setText("<html>Currency: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.ipadx = 10;
        panelCurrency.add(labelCurrency, gridBagConstraints);

        boxCurrency.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.ipady = 20;
        panelCurrency.add(boxCurrency, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 21;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.FIRST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        jPanel1.add(panelCurrency, gridBagConstraints);

        buttonModifyRoute.setText("Modify Route");
        buttonModifyRoute.setBackground(new java.awt.Color(246, 172, 30));
        buttonModifyRoute.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonModifyRoute.setForeground(new java.awt.Color(255, 255, 255));
        buttonModifyRoute.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonModifyRouteActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 20;
        gridBagConstraints.gridy = 8;
        gridBagConstraints.ipady = 30;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 40, 0);
        jPanel1.add(buttonModifyRoute, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 18;
        gridBagConstraints.gridy = 9;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        jPanel1.add(filler1, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 22;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        jPanel1.add(filler2, gridBagConstraints);

        panelTimes.setBackground(new java.awt.Color(225, 239, 255));
        panelTimes.setLayout(new java.awt.GridBagLayout());

        jPanel3.setBackground(new java.awt.Color(225, 239, 255));
        jPanel3.setLayout(new java.awt.GridBagLayout());

        boxStartTime.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "05:00AM", "05:30AM", "06:00AM", "06:30AM", "07:00AM", "07:30AM", "08:00AM", "08:30AM", "09:00AM", "09:30AM", "10:00AM", "10:30AM", "11:00AM", "11:30AM", "12:00PM", "12:30PM", "01:00PM", "01:30PM", "02:00PM", "02:30PM", "03:00PM", "03:30PM", "04:00PM", "04:30PM", "05:00PM", "05:30PM", "06:00PM", "06:30PM", "07:00PM", "07:30PM", "08:00PM", "08:30PM", "09:00PM", "09:30PM", "10:00PM", "10:30PM", "11:00PM", "11:30PM" }));
        boxStartTime.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                boxStartTimeActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipady = 20;
        jPanel3.add(boxStartTime, gridBagConstraints);

        labelStartTime.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        labelStartTime.setText("<html>Start Time: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 10;
        jPanel3.add(labelStartTime, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        panelTimes.add(jPanel3, gridBagConstraints);

        jPanel2.setBackground(new java.awt.Color(225, 239, 255));
        jPanel2.setLayout(new java.awt.GridBagLayout());

        labelEndTime.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        labelEndTime.setText("<html>End Time: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 10;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 7);
        jPanel2.add(labelEndTime, gridBagConstraints);

        boxEndTime.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "05:30AM", "06:00AM", "06:30AM", "07:00AM", "07:30AM", "08:00AM", "08:30AM", "09:00AM", "09:30AM", "10:00AM", "10:30AM", "11:00AM", "11:30AM", "12:00PM", "12:30PM", "01:00PM", "01:30PM", "02:00PM", "02:30PM", "03:00PM", "03:30PM", "04:00PM", "04:30PM", "05:00PM", "05:30PM", "06:00PM", "06:30PM", "07:00PM", "07:30PM", "08:00PM", "08:30PM", "09:00PM", "09:30PM", "10:00PM", "10:30PM", "11:00PM", "11:30PM" }));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipady = 20;
        jPanel2.add(boxEndTime, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 1;
        panelTimes.add(jPanel2, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 19;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 70, 30, 0);
        jPanel1.add(panelTimes, gridBagConstraints);

        panelDivision.setBackground(new java.awt.Color(18, 102, 160));
        panelDivision.setMinimumSize(new java.awt.Dimension(2, 10));
        panelDivision.setPreferredSize(new java.awt.Dimension(2, 10));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 20;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.gridheight = 3;
        gridBagConstraints.fill = java.awt.GridBagConstraints.VERTICAL;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        jPanel1.add(panelDivision, gridBagConstraints);

        getContentPane().add(jPanel1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void buttonModifyRouteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonModifyRouteActionPerformed
        String price = textPrice.getText().trim();

        // Check if any field is empty
        if (price.isEmpty()) {
            JOptionPane.showMessageDialog(null, "Please fill in all required fields.");
            return;
        }
        javax.swing.SwingUtilities.invokeLater(() -> {
            ModifyRoute route = new ModifyRoute(userRole);
            route.setExtendedState(JFrame.MAXIMIZED_BOTH);
            route.setVisible(true);

            ModifyTrip.this.dispose();
        });
    }//GEN-LAST:event_buttonModifyRouteActionPerformed

    private void boxStartTimeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_boxStartTimeActionPerformed
        int startIndex = boxStartTime.getSelectedIndex();

        // Get all available times from that index onward
        DefaultComboBoxModel<String> newEndModel = new DefaultComboBoxModel<>();

        for (int i = startIndex+1; i < boxStartTime.getItemCount(); i++) {
            newEndModel.addElement(boxStartTime.getItemAt(i));
        }

        boxEndTime.setModel(newEndModel);
    }//GEN-LAST:event_boxStartTimeActionPerformed

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
            java.util.logging.Logger.getLogger(ModifyTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(ModifyTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(ModifyTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(ModifyTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            private String userRole;
            public void run() {
                userRole = "Driver";
                new ModifyTrip(userRole).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> boxCurrency;
    private javax.swing.JComboBox<String> boxEndTime;
    private javax.swing.JComboBox<String> boxMethod;
    private javax.swing.JComboBox<String> boxSeats;
    private javax.swing.JComboBox<String> boxStartTime;
    private javax.swing.JButton buttonModifyRoute;
    private com.github.lgooddatepicker.components.DatePicker datePicker;
    private javax.swing.Box.Filler filler1;
    private javax.swing.Box.Filler filler2;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JLabel labelCurrency;
    private javax.swing.JLabel labelDate;
    private javax.swing.JLabel labelEndTime;
    private javax.swing.JLabel labelMethod;
    private javax.swing.JLabel labelModifyTrip;
    private javax.swing.JLabel labelPrice;
    private javax.swing.JLabel labelSeats;
    private javax.swing.JLabel labelStartTime;
    private javax.swing.JPanel panelCurrency;
    private javax.swing.JPanel panelDate;
    private javax.swing.JPanel panelDivision;
    private javax.swing.JPanel panelPassengers;
    private javax.swing.JPanel panelPayment;
    private javax.swing.JPanel panelPrice;
    private javax.swing.JPanel panelTimes;
    private javax.swing.JTextField textPrice;
    // End of variables declaration//GEN-END:variables
}
