/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import com.github.lgooddatepicker.components.DatePickerSettings;
import com.github.lgooddatepicker.components.TimePickerSettings;
import java.net.URL;
import java.util.Locale;
import java.time.LocalDate;
import java.util.List;
import java.sql.SQLException;

import java.awt.Image;
import java.awt.Color;
import java.awt.Cursor;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;

import javax.swing.JTextArea;
import javax.swing.JScrollPane;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import com.tec.carpooling.business.service.CatalogService;
import com.tec.carpooling.business.service.impl.CatalogServiceImpl;
import com.tec.carpooling.domain.entity.Gender;
import com.tec.carpooling.domain.entity.Institution;
import com.tec.carpooling.domain.entity.IdType;
import com.tec.carpooling.domain.entity.PhoneType;
import com.tec.carpooling.domain.entity.Domain;

/**
 *
 * @author hidal
 */
public class UserSignUp extends javax.swing.JFrame {

    private static final String ERROR_LOADING_CATALOGS = "Error loading catalog data: ";
    private static final String ERROR_TERMS_NOT_ACCEPTED = "You must accept the terms and conditions to continue.";
    private static final String TITLE_ERROR = "Error";
    private static final String TITLE_VALIDATION = "Validation Error";
    
    private final CatalogService catalogService;

    /**
     * Creates new form UserSignUp
     */
    public UserSignUp() {
        initComponents();
        customizeDatePicker();
        catalogService = new CatalogServiceImpl();
        setupWindow();
        loadCatalogs();
        
        textNumber.addKeyListener(new KeyAdapter() {
            @Override
            public void keyTyped(KeyEvent e) {
                char c = e.getKeyChar();
                if (!Character.isDigit(c)) {
                    e.consume(); // block the input
                }
            }
        });
        
        textID.addKeyListener(new KeyAdapter() {
            @Override
            public void keyTyped(KeyEvent e) {
                char c = e.getKeyChar();
                if (!Character.isDigit(c)) {
                    e.consume(); // block the input
                }
            }
        });
        
        termsLink.setForeground(Color.BLUE);
        termsLink.setCursor(new Cursor(Cursor.HAND_CURSOR));

        termsLink.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                JFrame termsFrame = new JFrame("Terms and Conditions");
                JTextArea textArea = new JTextArea("Terms and conditions go here...");
                textArea.setWrapStyleWord(true);
                textArea.setLineWrap(true);
                textArea.setEditable(false);
                termsFrame.add(new JScrollPane(textArea));
                termsFrame.setSize(400, 300);
                termsFrame.setLocationRelativeTo(null);
                termsFrame.setVisible(true);
            }
        });
        
        labelLogIn.setForeground(Color.BLUE);
        labelLogIn.setCursor(new Cursor(Cursor.HAND_CURSOR));
        labelLogIn.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                javax.swing.SwingUtilities.invokeLater(() -> {
                    UserLogIn login = new UserLogIn();
                    login.setExtendedState(JFrame.MAXIMIZED_BOTH);
                    login.setVisible(true);

                    UserSignUp.this.dispose();
                });
            }
        });
        
        this.setExtendedState(JFrame.MAXIMIZED_BOTH);
    }
    
    /**
     * Customizes the date picker component with a specific icon and locale settings.
     * Sets up the visual appearance and behavior of the date picker.
     */
    private void customizeDatePicker() {
        URL dateImageURL = getClass().getResource("/Assets/datePickerIcon.png");
        if (dateImageURL != null) {
            Image dateImage = getToolkit().getImage(dateImageURL);
            ImageIcon dateIcon = new ImageIcon(dateImage);

            dateOfBirthPicker.getComponentDateTextField().setEditable(false);
            dateOfBirthPicker.getComponentDateTextField().setEnabled(false);
            dateOfBirthPicker.setDateToToday();
            dateOfBirthPicker.setLocale(Locale.ENGLISH);

            // ✅ Inline veto policy to block past dates
            dateOfBirthPicker.getSettings().setVetoPolicy(date -> !date.isAfter(LocalDate.now()));

            JButton datePickerButton = dateOfBirthPicker.getComponentToggleCalendarButton();
            datePickerButton.setText("");
            datePickerButton.setIcon(dateIcon);
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
        labelLogIn = new javax.swing.JLabel();
        buttonRegister = new javax.swing.JButton();
        labelRegister = new javax.swing.JLabel();
        buttonPhoto = new javax.swing.JButton();
        filler1 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler2 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler3 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler4 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        jPanel18 = new javax.swing.JPanel();
        name_label2 = new javax.swing.JLabel();
        textName2 = new javax.swing.JTextField();
        jPanel20 = new javax.swing.JPanel();
        name_label3 = new javax.swing.JLabel();
        textSurname1 = new javax.swing.JTextField();
        jPanel22 = new javax.swing.JPanel();
        name_label4 = new javax.swing.JLabel();
        textSurname2 = new javax.swing.JTextField();
        jPanel2 = new javax.swing.JPanel();
        jPanel15 = new javax.swing.JPanel();
        name_label = new javax.swing.JLabel();
        comboBoxID = new javax.swing.JComboBox<>();
        jPanel3 = new javax.swing.JPanel();
        jPanel28 = new javax.swing.JPanel();
        name_label7 = new javax.swing.JLabel();
        comboBoxNumber = new javax.swing.JComboBox<>();
        jPanel4 = new javax.swing.JPanel();
        jPanel30 = new javax.swing.JPanel();
        name_label8 = new javax.swing.JLabel();
        comboBoxInstitution = new javax.swing.JComboBox<>();
        jPanel7 = new javax.swing.JPanel();
        jPanel32 = new javax.swing.JPanel();
        name_label9 = new javax.swing.JLabel();
        comboBoxGender = new javax.swing.JComboBox<>();
        jPanel34 = new javax.swing.JPanel();
        name_label10 = new javax.swing.JLabel();
        textNumber = new javax.swing.JTextField();
        jPanel36 = new javax.swing.JPanel();
        name_label11 = new javax.swing.JLabel();
        textEmail = new javax.swing.JTextField();
        jLabel1 = new javax.swing.JLabel();
        jComboBoxDomain = new javax.swing.JComboBox<>();
        jPanel38 = new javax.swing.JPanel();
        name_label12 = new javax.swing.JLabel();
        textName1 = new javax.swing.JTextField();
        jPanel40 = new javax.swing.JPanel();
        name_label13 = new javax.swing.JLabel();
        textID = new javax.swing.JTextField();
        jPanel8 = new javax.swing.JPanel();
        termsLink = new javax.swing.JLabel();
        termsCheckBox = new javax.swing.JCheckBox();
        jPanel6 = new javax.swing.JPanel();
        name_label5 = new javax.swing.JLabel();
        dateOfBirthPicker = new com.github.lgooddatepicker.components.DatePicker();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanel1.setBackground(new java.awt.Color(225, 239, 255));
        jPanel1.setLayout(new java.awt.GridBagLayout());

        labelLogIn.setText("Already have an account?");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.PAGE_END;
        gridBagConstraints.insets = new java.awt.Insets(10, 20, 20, 0);
        jPanel1.add(labelLogIn, gridBagConstraints);

        buttonRegister.setText("Register");
        buttonRegister.setBackground(new java.awt.Color(246, 172, 30));
        buttonRegister.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonRegister.setForeground(new java.awt.Color(255, 255, 255));
        buttonRegister.setMaximumSize(new java.awt.Dimension(85, 23));
        buttonRegister.setMinimumSize(new java.awt.Dimension(85, 23));
        buttonRegister.setPreferredSize(new java.awt.Dimension(90, 40));
        buttonRegister.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonRegisterActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 6;
        gridBagConstraints.gridwidth = 5;
        gridBagConstraints.ipadx = 65;
        gridBagConstraints.ipady = 27;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(6, 120, 31, 0);
        jPanel1.add(buttonRegister, gridBagConstraints);

        labelRegister.setText("REGISTER");
        labelRegister.setFont(new java.awt.Font("Yu Gothic UI Semibold", 1, 40)); // NOI18N
        labelRegister.setForeground(new java.awt.Color(18, 102, 160));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 4;
        gridBagConstraints.insets = new java.awt.Insets(40, 100, 40, 0);
        jPanel1.add(labelRegister, gridBagConstraints);

        buttonPhoto.setText("Add Photo");
        buttonPhoto.setPreferredSize(new java.awt.Dimension(80, 23));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.ipady = 20;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 150, 0, 0);
        jPanel1.add(buttonPhoto, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.weighty = 0.1;
        jPanel1.add(filler1, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 17;
        gridBagConstraints.weighty = 0.1;
        jPanel1.add(filler2, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 7;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.weightx = 0.1;
        jPanel1.add(filler3, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.weightx = 0.1;
        jPanel1.add(filler4, gridBagConstraints);

        jPanel18.setBackground(new java.awt.Color(225, 239, 255));
        jPanel18.setLayout(new java.awt.GridBagLayout());

        name_label2.setText("Second Name:");
        name_label2.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 58;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel18.add(name_label2, gridBagConstraints);

        textName2.setPreferredSize(new java.awt.Dimension(150, 40));
        textName2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                textName2ActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.ipadx = 7;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        jPanel18.add(textName2, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 60, 0, 0);
        jPanel1.add(jPanel18, gridBagConstraints);

        jPanel20.setBackground(new java.awt.Color(225, 239, 255));
        jPanel20.setLayout(new java.awt.GridBagLayout());

        name_label3.setText("<html>First Surname: <span style='color:red'>*</span></html>");
        name_label3.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 68;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel20.add(name_label3, gridBagConstraints);

        textSurname1.setPreferredSize(new java.awt.Dimension(150, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.ipadx = 7;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        jPanel20.add(textSurname1, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.ipadx = 18;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 60, 0, 0);
        jPanel1.add(jPanel20, gridBagConstraints);

        jPanel22.setBackground(new java.awt.Color(225, 239, 255));
        jPanel22.setLayout(new java.awt.GridBagLayout());

        name_label4.setText("Second Surame:");
        name_label4.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 48;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel22.add(name_label4, gridBagConstraints);

        textSurname2.setPreferredSize(new java.awt.Dimension(150, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.ipadx = 7;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        jPanel22.add(textSurname2, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 6;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 60, 0, 0);
        jPanel1.add(jPanel22, gridBagConstraints);

        jPanel2.setBackground(new java.awt.Color(225, 239, 255));
        jPanel2.setLayout(new java.awt.GridBagLayout());

        jPanel15.setBackground(new java.awt.Color(225, 239, 255));
        jPanel15.setLayout(new java.awt.GridBagLayout());

        name_label.setText("<html>Type of Identification: <span style='color:red'>*</span></html>");
        name_label.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 70;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel15.add(name_label, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LAST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel2.add(jPanel15, gridBagConstraints);

        comboBoxID.setModel(new javax.swing.DefaultComboBoxModel<>());
        comboBoxID.setPreferredSize(new java.awt.Dimension(90, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.FIRST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        jPanel2.add(comboBoxID, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 5;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 120, 0, 0);
        jPanel1.add(jPanel2, gridBagConstraints);

        jPanel3.setBackground(new java.awt.Color(225, 239, 255));
        jPanel3.setLayout(new java.awt.GridBagLayout());

        jPanel28.setBackground(new java.awt.Color(225, 239, 255));
        jPanel28.setLayout(new java.awt.GridBagLayout());

        name_label7.setText("<html>Type of Phone Number: <span style='color:red'>*</span></html>");
        name_label7.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 105;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel28.add(name_label7, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LAST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel3.add(jPanel28, gridBagConstraints);

        comboBoxNumber.setModel(new javax.swing.DefaultComboBoxModel<>());
        comboBoxNumber.setPreferredSize(new java.awt.Dimension(90, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.FIRST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        jPanel3.add(comboBoxNumber, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 5;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 120, 0, 0);
        jPanel1.add(jPanel3, gridBagConstraints);

        jPanel4.setBackground(new java.awt.Color(225, 239, 255));
        jPanel4.setLayout(new java.awt.GridBagLayout());

        jPanel30.setBackground(new java.awt.Color(225, 239, 255));
        jPanel30.setLayout(new java.awt.GridBagLayout());

        name_label8.setText("<html>Institution You Belong To: <span style='color:red'>*</span></html>");
        name_label8.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 110;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel30.add(name_label8, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LAST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel4.add(jPanel30, gridBagConstraints);

        comboBoxInstitution.setModel(new javax.swing.DefaultComboBoxModel<>());
        comboBoxInstitution.setPreferredSize(new java.awt.Dimension(90, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.FIRST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        jPanel4.add(comboBoxInstitution, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 5;
        gridBagConstraints.gridy = 7;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 120, 0, 0);
        jPanel1.add(jPanel4, gridBagConstraints);

        jPanel7.setBackground(new java.awt.Color(225, 239, 255));
        jPanel7.setLayout(new java.awt.GridBagLayout());

        jPanel32.setBackground(new java.awt.Color(225, 239, 255));
        jPanel32.setLayout(new java.awt.GridBagLayout());

        name_label9.setText("<html>Gender: <span style='color:red'>*</span></html>");
        name_label9.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label9.setPreferredSize(new java.awt.Dimension(65, 20));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 5;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel32.add(name_label9, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LAST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel7.add(jPanel32, gridBagConstraints);

        comboBoxGender.setModel(new javax.swing.DefaultComboBoxModel<>());
        comboBoxGender.setPreferredSize(new java.awt.Dimension(90, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.FIRST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        jPanel7.add(comboBoxGender, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 7;
        gridBagConstraints.ipadx = 5;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 60, 0, 0);
        jPanel1.add(jPanel7, gridBagConstraints);

        jPanel34.setBackground(new java.awt.Color(225, 239, 255));
        jPanel34.setLayout(new java.awt.GridBagLayout());

        name_label10.setText("<html>Phone Number: <span style='color:red'>*</span></html>");
        name_label10.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 51;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel34.add(name_label10, gridBagConstraints);

        textNumber.setPreferredSize(new java.awt.Dimension(150, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.ipadx = 7;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        jPanel34.add(textNumber, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 5;
        gridBagConstraints.gridy = 6;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.ipadx = 50;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 120, 0, 0);
        jPanel1.add(jPanel34, gridBagConstraints);

        jPanel36.setBackground(new java.awt.Color(225, 239, 255));
        jPanel36.setLayout(new java.awt.GridBagLayout());

        name_label11.setText("<html>Email: <span style='color:red'>*</span></html>");
        name_label11.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 115;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel36.add(name_label11, gridBagConstraints);

        textEmail.setPreferredSize(new java.awt.Dimension(150, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.ipadx = 7;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        jPanel36.add(textEmail, gridBagConstraints);

        jLabel1.setText("@");
        jPanel36.add(jLabel1, new java.awt.GridBagConstraints());

        jComboBoxDomain.setModel(new javax.swing.DefaultComboBoxModel<>());
        jPanel36.add(jComboBoxDomain, new java.awt.GridBagConstraints());

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 5;
        gridBagConstraints.gridy = 8;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.ipadx = 8;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 120, 0, 0);
        jPanel1.add(jPanel36, gridBagConstraints);

        jPanel38.setBackground(new java.awt.Color(225, 239, 255));
        jPanel38.setLayout(new java.awt.GridBagLayout());

        name_label12.setText("<html>First Name: <span style='color:red'>*</span></html>");
        name_label12.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 80;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel38.add(name_label12, gridBagConstraints);

        textName1.setPreferredSize(new java.awt.Dimension(150, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.ipadx = 7;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        jPanel38.add(textName1, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.ipadx = 23;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 60, 0, 0);
        jPanel1.add(jPanel38, gridBagConstraints);

        jPanel40.setBackground(new java.awt.Color(225, 239, 255));
        jPanel40.setLayout(new java.awt.GridBagLayout());

        name_label13.setText("<html>Identification Number: <span style='color:red'>*</span></html>");
        name_label13.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 70;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel40.add(name_label13, gridBagConstraints);

        textID.setPreferredSize(new java.awt.Dimension(150, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.ipadx = 7;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        jPanel40.add(textID, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 5;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 120, 0, 0);
        jPanel1.add(jPanel40, gridBagConstraints);

        jPanel8.setBackground(new java.awt.Color(225, 239, 255));
        jPanel8.setLayout(new java.awt.GridBagLayout());

        termsLink.setText("Terms and Conditions");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(2, 0, 0, 0);
        jPanel8.add(termsLink, gridBagConstraints);

        termsCheckBox.setText("I have read and agree to the ");
        termsCheckBox.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                termsCheckBoxActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel8.add(termsCheckBox, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.gridwidth = 2;
        jPanel1.add(jPanel8, gridBagConstraints);

        jPanel6.setBackground(new java.awt.Color(225, 239, 255));
        jPanel6.setLayout(new java.awt.GridBagLayout());

        name_label5.setText("<html>Date of Birth: <span style='color:red'>*</span></html>");
        name_label5.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 67;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 8, 10, 0);
        jPanel6.add(name_label5, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 7, 0, 0);
        jPanel6.add(dateOfBirthPicker, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 8;
        gridBagConstraints.gridheight = 2;
        gridBagConstraints.insets = new java.awt.Insets(0, 60, 0, 0);
        jPanel1.add(jPanel6, gridBagConstraints);

        getContentPane().add(jPanel1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void termsCheckBoxActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_termsCheckBoxActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_termsCheckBoxActionPerformed

    private void buttonRegisterActionPerformed(java.awt.event.ActionEvent evt) {
        try {
            // Validar campos requeridos
            if (!validateRequiredFields()) {
                return;
            }

            // Validar términos y condiciones
            if (!termsCheckBox.isSelected()) {
                JOptionPane.showMessageDialog(this,
                    ERROR_TERMS_NOT_ACCEPTED,
                    TITLE_VALIDATION,
                    JOptionPane.WARNING_MESSAGE);
                return;
            }

            // Obtener valores de los campos
            String firstName = textName1.getText().trim();
            String secondName = textName2.getText().trim();
            String firstSurname = textSurname1.getText().trim();
            String secondSurname = textSurname2.getText().trim();
            String idNumber = textID.getText().trim();
            String phoneNumber = textNumber.getText().trim();
            String email = textEmail.getText().trim();
            LocalDate dateOfBirth = dateOfBirthPicker.getDate();

            // Obtener valores de los combos
            IdType idType = (IdType) comboBoxID.getSelectedItem();
            PhoneType phoneType = (PhoneType) comboBoxNumber.getSelectedItem();
            Institution institution = (Institution) comboBoxInstitution.getSelectedItem();
            Gender gender = (Gender) comboBoxGender.getSelectedItem();
            Domain domain = (Domain) jComboBoxDomain.getSelectedItem();

            // Validar que se hayan seleccionado todos los combos
            if (idType == null || phoneType == null || institution == null || 
                gender == null || domain == null) {
                JOptionPane.showMessageDialog(this,
                    "Please select all required options from the dropdown menus.",
                    TITLE_VALIDATION,
                    JOptionPane.WARNING_MESSAGE);
                return;
            }

            // TODO: Implementar el registro de usuario
            // Por ahora solo mostramos un mensaje de éxito
            JOptionPane.showMessageDialog(this,
                "Registration successful!",
                "Success",
                JOptionPane.INFORMATION_MESSAGE);

            // Volver a la pantalla inicial
            javax.swing.SwingUtilities.invokeLater(() -> {
                InitialPage home = new InitialPage();
                home.setExtendedState(JFrame.MAXIMIZED_BOTH);
                home.setVisible(true);
                this.dispose();
            });

        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this,
                "An error occurred during registration: " + ex.getMessage(),
                TITLE_ERROR,
                JOptionPane.ERROR_MESSAGE);
        }
    }

    /**
     * Valida que todos los campos requeridos estén completos.
     * 
     * @return true si todos los campos requeridos están completos, false en caso contrario
     */
    private boolean validateRequiredFields() {
        if (textName1.getText().trim().isEmpty() ||
            textSurname1.getText().trim().isEmpty() ||
            textID.getText().trim().isEmpty() ||
            textNumber.getText().trim().isEmpty() ||
            textEmail.getText().trim().isEmpty() ||
            dateOfBirthPicker.getDate() == null) {
            
            JOptionPane.showMessageDialog(this,
                "Please fill in all required fields.",
                TITLE_VALIDATION,
                JOptionPane.WARNING_MESSAGE);
            return false;
        }
        return true;
    }

    private void textName2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_textName2ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_textName2ActionPerformed
 
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
            java.util.logging.Logger.getLogger(UserSignUp.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(UserSignUp.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(UserSignUp.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(UserSignUp.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new UserSignUp().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton buttonPhoto;
    private javax.swing.JButton buttonRegister;
    private javax.swing.JComboBox<Gender> comboBoxGender;
    private javax.swing.JComboBox<IdType> comboBoxID;
    private javax.swing.JComboBox<Institution> comboBoxInstitution;
    private javax.swing.JComboBox<PhoneType> comboBoxNumber;
    private com.github.lgooddatepicker.components.DatePicker dateOfBirthPicker;
    private javax.swing.Box.Filler filler1;
    private javax.swing.Box.Filler filler2;
    private javax.swing.Box.Filler filler3;
    private javax.swing.Box.Filler filler4;
    private javax.swing.JComboBox<Domain> jComboBoxDomain;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel15;
    private javax.swing.JPanel jPanel18;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel20;
    private javax.swing.JPanel jPanel22;
    private javax.swing.JPanel jPanel28;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel30;
    private javax.swing.JPanel jPanel32;
    private javax.swing.JPanel jPanel34;
    private javax.swing.JPanel jPanel36;
    private javax.swing.JPanel jPanel38;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel40;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JPanel jPanel7;
    private javax.swing.JPanel jPanel8;
    private javax.swing.JLabel labelLogIn;
    private javax.swing.JLabel labelRegister;
    private javax.swing.JLabel name_label;
    private javax.swing.JLabel name_label10;
    private javax.swing.JLabel name_label11;
    private javax.swing.JLabel name_label12;
    private javax.swing.JLabel name_label13;
    private javax.swing.JLabel name_label2;
    private javax.swing.JLabel name_label3;
    private javax.swing.JLabel name_label4;
    private javax.swing.JLabel name_label5;
    private javax.swing.JLabel name_label7;
    private javax.swing.JLabel name_label8;
    private javax.swing.JLabel name_label9;
    private javax.swing.JCheckBox termsCheckBox;
    private javax.swing.JLabel termsLink;
    private javax.swing.JTextField textEmail;
    private javax.swing.JTextField textID;
    private javax.swing.JTextField textName1;
    private javax.swing.JTextField textName2;
    private javax.swing.JTextField textNumber;
    private javax.swing.JTextField textSurname1;
    private javax.swing.JTextField textSurname2;
    // End of variables declaration//GEN-END:variables

    /**
     * Configura la ventana de registro.
     * Establece el título, ícono y comportamiento de la ventana.
     */
    private void setupWindow() {
        setTitle("User Registration");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        
        // Configurar el comportamiento del combo de instituciones
        comboBoxInstitution.addActionListener(e -> {
            Institution selectedInstitution = (Institution) comboBoxInstitution.getSelectedItem();
            if (selectedInstitution != null) {
                loadDomainsForInstitution(selectedInstitution.getId());
            }
        });
    }
    
    /**
     * Carga todos los catálogos necesarios para el formulario.
     * Incluye géneros, instituciones, tipos de identificación y tipos de teléfono.
     */
    private void loadCatalogs() {
        try {
            // Cargar géneros
            comboBoxGender.removeAllItems();
            comboBoxGender.addItem(new Gender(0, "Select Gender")); // Item por defecto
            List<Gender> genders = catalogService.getAllGenders();
            for (Gender gender : genders) {
                if (gender.getId() != 0) { // Evitar duplicar el item por defecto
                    comboBoxGender.addItem(gender);
                }
            }
            
            // Cargar instituciones
            comboBoxInstitution.removeAllItems();
            comboBoxInstitution.addItem(new Institution(0, "Select Institution")); // Item por defecto
            List<Institution> institutions = catalogService.getAllInstitutions();
            for (Institution institution : institutions) {
                if (institution.getId() != 0) { // Evitar duplicar el item por defecto
                    comboBoxInstitution.addItem(institution);
                }
            }
            
            // Cargar tipos de identificación
            comboBoxID.removeAllItems();
            comboBoxID.addItem(new IdType(0, "Select ID Type")); // Item por defecto
            List<IdType> idTypes = catalogService.getAllIdTypes();
            for (IdType idType : idTypes) {
                if (idType.getId() != 0) { // Evitar duplicar el item por defecto
                    comboBoxID.addItem(idType);
                }
            }
            
            // Cargar tipos de teléfono
            comboBoxNumber.removeAllItems();
            comboBoxNumber.addItem(new PhoneType(0, "Select Phone Type")); // Item por defecto
            List<PhoneType> phoneTypes = catalogService.getAllPhoneTypes();
            for (PhoneType phoneType : phoneTypes) {
                if (phoneType.getId() != 0) { // Evitar duplicar el item por defecto
                    comboBoxNumber.addItem(phoneType);
                }
            }
            
            // Inicializar el combo de dominios con un item por defecto
            jComboBoxDomain.removeAllItems();
            jComboBoxDomain.addItem(new Domain(0, "Select Domain", 0));
            
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this,
                ERROR_LOADING_CATALOGS + ex.getMessage(),
                TITLE_ERROR,
                JOptionPane.ERROR_MESSAGE);
        }
    }
    
    /**
     * Carga los dominios de correo electrónico para una institución específica.
     * 
     * @param institutionId El ID de la institución
     */
    private void loadDomainsForInstitution(long institutionId) {
        try {
            jComboBoxDomain.removeAllItems();
            jComboBoxDomain.addItem(new Domain(0, "Select Domain", institutionId)); // Item por defecto
            List<Domain> domains = catalogService.getDomainsByInstitution(institutionId);
            for (Domain domain : domains) {
                if (domain.getId() != 0) { // Evitar duplicar el item por defecto
                    jComboBoxDomain.addItem(domain);
                }
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this,
                ERROR_LOADING_CATALOGS + ex.getMessage(),
                TITLE_ERROR,
                JOptionPane.ERROR_MESSAGE);
        }
    }
}
