/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import com.tec.carpooling.data.dao.VehicleDAO;
import com.tec.carpooling.domain.entity.User;
import com.tec.carpooling.domain.entity.VehicleInfo;
import com.tec.carpooling.data.dao.CurrencyDAO;
import com.tec.carpooling.domain.entity.Currency;
import com.tec.carpooling.domain.entity.ChosenCapacity;


import java.awt.BorderLayout;
import java.awt.Image;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.sql.Date;

import java.net.URL;
import java.util.Locale;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JComboBox;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import java.awt.event.ItemListener;
import java.awt.event.ItemEvent;
import javax.swing.SwingUtilities;

/**
 *
 * @author hidal
 */
public class ScheduleTrip extends javax.swing.JFrame {
    private String userRole;
    private final User user;
    /**
     * Creates new form AddTrip
     */
    public ScheduleTrip(String role, User user) {
        this.user = user;
        this.userRole = role;
        initComponents();
        getContentPane().add(SideMenu.createToolbar(this, userRole, user), BorderLayout.WEST);
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
                toggleCurrencyBox();
            }

            @Override
            public void removeUpdate(DocumentEvent e) {
                toggleCurrencyBox();
            }

            @Override
            public void changedUpdate(DocumentEvent e) {
                toggleCurrencyBox(); // Not needed for plain text fields but included for completeness
            }

            private void toggleCurrencyBox() {
                boxCurrency.setSelectedIndex(0);
                String text = textPrice.getText().trim();
                try {
                    BigDecimal price = new BigDecimal(text);
                    boxCurrency.setEnabled(price.compareTo(BigDecimal.ZERO) > 0);
                } catch (NumberFormatException ex) {
                    // Disable currency selection on invalid input
                    boxCurrency.setEnabled(false);
                }
            }
        });
        
        try {
            VehicleDAO dao = new VehicleDAO();
            List<VehicleInfo> vehicles = dao.getVehiclesByDriver(user.getPersonId());
            boxVehicles.removeAllItems();
            boxVehicles.addItem(new VehicleInfo(0, "Select Vehicle", 0, 0)); // Item por defecto
            for (VehicleInfo v : vehicles) {
                if (v.getId() != 0) { // Evitar duplicar el item por defecto
                    boxVehicles.addItem(v);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Failed to load vehicles: " + e.getMessage());
        }
        boxVehicles.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                if (e.getStateChange() == ItemEvent.SELECTED) {
                    VehicleInfo selectedVehicle = (VehicleInfo) boxVehicles.getSelectedItem();
                    if (selectedVehicle != null && selectedVehicle.getId() != 0) {
                        int maxCapacity = selectedVehicle.getMaxCapacity();

                        boxSeats.removeAllItems();
                        for (int i = 1; i <= maxCapacity; i++) {
                            boxSeats.addItem(i);  // Use the full object
                        }
                    } else {
                        // Reset combo box if placeholder selected
                        boxSeats.removeAllItems();
                    }
                }
            }
        });
        try {
            CurrencyDAO cdao = new CurrencyDAO();
            List<Currency> currencies = cdao.getAllCurrencies();
            boxCurrency.removeAllItems();
            boxCurrency.addItem(new Currency(0, "No Currency Selected")); // Item por defecto
            for (Currency c : currencies) {
                if (c.getId() != 0) { // Evitar duplicar el item por defecto
                    boxCurrency.addItem(c);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Failed to load currencies: " + e.getMessage());
        }
        
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
        labelAddTrip = new javax.swing.JLabel();
        panelDate = new javax.swing.JPanel();
        labelDate = new javax.swing.JLabel();
        datePicker = new com.github.lgooddatepicker.components.DatePicker();
        panelVehicles = new javax.swing.JPanel();
        labelVehicles = new javax.swing.JLabel();
        boxVehicles = new javax.swing.JComboBox<>();
        buttonAddRoute = new javax.swing.JButton();
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
        jPanel4 = new javax.swing.JPanel();
        panelCurrency = new javax.swing.JPanel();
        labelCurrency = new javax.swing.JLabel();
        boxCurrency = new javax.swing.JComboBox<>();
        panelPassenger = new javax.swing.JPanel();
        labelSeats = new javax.swing.JLabel();
        boxSeats = new javax.swing.JComboBox<>();
        panelPrice = new javax.swing.JPanel();
        labelPrice = new javax.swing.JLabel();
        textPrice = new javax.swing.JTextField();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanel1.setBackground(new java.awt.Color(225, 239, 255));
        jPanel1.setLayout(new java.awt.GridBagLayout());

        labelAddTrip.setText("SCHEDULE TRIP");
        labelAddTrip.setFont(new java.awt.Font("Yu Gothic UI Semibold", 1, 40)); // NOI18N
        labelAddTrip.setForeground(new java.awt.Color(18, 102, 160));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 22;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.weightx = 1.0;
        gridBagConstraints.insets = new java.awt.Insets(10, 220, 0, 0);
        jPanel1.add(labelAddTrip, gridBagConstraints);

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

        panelVehicles.setBackground(new java.awt.Color(225, 239, 255));
        panelVehicles.setLayout(new java.awt.GridBagLayout());

        labelVehicles.setText("<html>Vehicle: <span style='color:red'>*</span></html>");
        labelVehicles.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.ipadx = 10;
        panelVehicles.add(labelVehicles, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.ipady = 20;
        panelVehicles.add(boxVehicles, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 19;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 70, 50, 0);
        jPanel1.add(panelVehicles, gridBagConstraints);

        buttonAddRoute.setText("Add Route");
        buttonAddRoute.setBackground(new java.awt.Color(18, 102, 160));
        buttonAddRoute.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonAddRoute.setForeground(new java.awt.Color(255, 255, 255));
        buttonAddRoute.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonAddRouteActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 20;
        gridBagConstraints.gridy = 8;
        gridBagConstraints.ipady = 30;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 40, 0);
        jPanel1.add(buttonAddRoute, gridBagConstraints);
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
        gridBagConstraints.gridheight = 4;
        gridBagConstraints.fill = java.awt.GridBagConstraints.VERTICAL;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        jPanel1.add(panelDivision, gridBagConstraints);

        jPanel4.setBackground(new java.awt.Color(225, 239, 255));
        jPanel4.setLayout(new java.awt.GridBagLayout());

        panelCurrency.setBackground(new java.awt.Color(225, 239, 255));
        panelCurrency.setLayout(new java.awt.GridBagLayout());

        labelCurrency.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        labelCurrency.setText("<html>Currency: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.ipadx = 10;
        panelCurrency.add(labelCurrency, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.ipady = 20;
        panelCurrency.add(boxCurrency, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.FIRST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        jPanel4.add(panelCurrency, gridBagConstraints);

        panelPassenger.setBackground(new java.awt.Color(225, 239, 255));
        panelPassenger.setLayout(new java.awt.GridBagLayout());

        labelSeats.setText("<html>Amount of Passengers: <span style='color:red'>*</span></html>");
        labelSeats.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.ipadx = 10;
        panelPassenger.add(labelSeats, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.ipady = 20;
        panelPassenger.add(boxSeats, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        jPanel4.add(panelPassenger, gridBagConstraints);

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
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.ipadx = 25;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.FIRST_LINE_START;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 30, 0);
        jPanel4.add(panelPrice, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 21;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.gridheight = 3;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.FIRST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 130);
        jPanel1.add(jPanel4, gridBagConstraints);

        getContentPane().add(jPanel1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void buttonAddRouteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonAddRouteActionPerformed
        try {
            // 1. Get and validate price
            String priceText = textPrice.getText().trim();
            if (priceText.isEmpty()) {
                JOptionPane.showMessageDialog(null, "Please enter a price.");
                return;
            }

            BigDecimal price = new BigDecimal(textPrice.getText().trim());
            Long currencyId = null;

            if (price.compareTo(BigDecimal.ZERO) > 0) {
                Currency selectedCurrency = (Currency) boxCurrency.getSelectedItem();
                if (selectedCurrency == null || selectedCurrency.getId() == 0) {
                    JOptionPane.showMessageDialog(null, "Please select a currency.");
                    return;
                }
                currencyId = selectedCurrency.getId();
            }

            // 2. Get selected vehicle
            VehicleInfo selectedVehicle = (VehicleInfo) boxVehicles.getSelectedItem();
            if (selectedVehicle == null || selectedVehicle.getId() == 0) {
                JOptionPane.showMessageDialog(null, "Please select a vehicle.");
                return;
            }
            long vehicleId = selectedVehicle.getId();

            // 3. Get number of passengers (chosen capacity)
            Integer passengers = (Integer) boxSeats.getSelectedItem();
            if (passengers == null) {
                JOptionPane.showMessageDialog(null, "Please select the number of passengers.");
                return;
            }

            // 4. Get selected date
            LocalDate tripDate = datePicker.getDate(); // from your date picker component
            if (tripDate == null) {
                JOptionPane.showMessageDialog(null, "Please select a date.");
                return;
            }
            java.sql.Date sqlTripDate = java.sql.Date.valueOf(tripDate);
            
            final Long finalCurrencyId = currencyId;
            System.out.println("Currency ID selected: " + finalCurrencyId);
            final java.sql.Date finalTripDate = sqlTripDate;
            
            // 5. Get start and end time from combo boxes
            String startTimeText = (String) boxStartTime.getSelectedItem();
            String endTimeText = (String) boxEndTime.getSelectedItem();
            if (startTimeText == null || endTimeText == null) {
                JOptionPane.showMessageDialog(null, "Please select start and end time.");
                return;
            }

            // Combine date + time to create full Timestamp
            
            // Time formatter to parse combo box values like "10:30 AM"
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");

            // Parse LocalTime from combo box text
            LocalTime startTimeParsed = LocalTime.parse(startTimeText, timeFormatter);
            LocalTime endTimeParsed = LocalTime.parse(endTimeText, timeFormatter);

            // Combine date and time
            LocalDateTime startDateTime = LocalDateTime.of(tripDate, startTimeParsed);
            LocalDateTime endDateTime = LocalDateTime.of(tripDate, endTimeParsed);

            // Convert to SQL Timestamp
            Timestamp startTimestamp = Timestamp.valueOf(startDateTime);
            Timestamp endTimestamp = Timestamp.valueOf(endDateTime);

            // 6. Move to CreateRoute screen
            SwingUtilities.invokeLater(() -> {
                CreateRoute routeScreen = new CreateRoute(userRole, user, startTimestamp, endTimestamp, finalTripDate,
                                                          passengers, price,
                                                          finalCurrencyId, vehicleId);
                routeScreen.setExtendedState(JFrame.MAXIMIZED_BOTH);
                routeScreen.setVisible(true);
                ScheduleTrip.this.dispose();
            });

        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error: " + e.getMessage());
        }
    }//GEN-LAST:event_buttonAddRouteActionPerformed

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
            java.util.logging.Logger.getLogger(ScheduleTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(ScheduleTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(ScheduleTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(ScheduleTrip.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            private String userRole;
            private User user;
            public void run() {
                userRole = "Driver";
                user = new User(1, "testuser", 101);
                new ScheduleTrip(userRole, user).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<Currency> boxCurrency;
    private javax.swing.JComboBox<String> boxEndTime;
    private javax.swing.JComboBox<Integer> boxSeats;
    private javax.swing.JComboBox<String> boxStartTime;
    private javax.swing.JComboBox<VehicleInfo> boxVehicles;
    private javax.swing.JButton buttonAddRoute;
    private com.github.lgooddatepicker.components.DatePicker datePicker;
    private javax.swing.Box.Filler filler1;
    private javax.swing.Box.Filler filler2;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JLabel labelAddTrip;
    private javax.swing.JLabel labelCurrency;
    private javax.swing.JLabel labelDate;
    private javax.swing.JLabel labelEndTime;
    private javax.swing.JLabel labelPrice;
    private javax.swing.JLabel labelSeats;
    private javax.swing.JLabel labelStartTime;
    private javax.swing.JLabel labelVehicles;
    private javax.swing.JPanel panelCurrency;
    private javax.swing.JPanel panelDate;
    private javax.swing.JPanel panelDivision;
    private javax.swing.JPanel panelPassenger;
    private javax.swing.JPanel panelPrice;
    private javax.swing.JPanel panelTimes;
    private javax.swing.JPanel panelVehicles;
    private javax.swing.JTextField textPrice;
    // End of variables declaration//GEN-END:variables
}
