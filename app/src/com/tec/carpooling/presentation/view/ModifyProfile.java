/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.domain.entity.User;
import com.tec.carpooling.domain.entity.Gender;
import com.tec.carpooling.domain.entity.IdType;
import com.tec.carpooling.data.dao.PersonDAO;
import com.tec.carpooling.data.dao.GenderInfoDAO;
import com.tec.carpooling.data.dao.PersonCompleteDAO;
import com.tec.carpooling.data.dao.PersonUpdateDAO;
import com.tec.carpooling.data.dao.TypeIdInfoDAO;
import com.tec.carpooling.data.dao.impl.PersonUpdateDAOImpl;
import com.tec.carpooling.data.impl.GenderDAOImpl;
import com.tec.carpooling.domain.entity.Institution;
import com.tec.carpooling.domain.entity.Person;

import java.awt.BorderLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JToolBar;
import javax.swing.JOptionPane;

import java.sql.SQLException;
import java.sql.Connection;

import java.awt.Image;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.net.URL;
import java.util.Locale;
import java.time.LocalDate;
import java.util.List;
import javax.swing.DefaultListModel;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JToolBar;
import javax.swing.ListModel;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author hidal
 */
public class ModifyProfile extends javax.swing.JFrame {
    private String userRole;
    private final User user;
    /**
     * Creates new form ModificarPerfil
     */
    public ModifyProfile(String role, User user) {
        this.user = user;
        this.userRole = role;
        initComponents();
        loadGenders();
        getContentPane().add(SideMenu.createToolbar(this, userRole, user), BorderLayout.WEST);
        customizeDatePicker();
        
        textID.addKeyListener(new KeyAdapter() {
            @Override
            public void keyTyped(KeyEvent e) {
                char c = e.getKeyChar();
                if (!Character.isDigit(c)) {
                    e.consume(); // block the input
                }
            }
        });
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            PersonDAO personDAO = new PersonDAO();
            GenderInfoDAO genderDAO = new GenderInfoDAO();
            TypeIdInfoDAO typeDAO = new TypeIdInfoDAO();

            List<IdType> idTypes = typeDAO.getAllIdTypes(conn);
            boxID.removeAllItems();
            for (IdType type : idTypes) {
                boxID.addItem(type.getName());
            }

            Person person = personDAO.getPersonProfile(user.getPersonId(), conn);
            if (person != null) {
                String genderName = genderDAO.getGenderName(person.getGenderId(), conn);
                String typeIdName = typeDAO.getTypeName(person.getTypeIdentificationId(), conn);

                textName1.setText(person.getFirstName());
                textName2.setText(person.getSecondName());
                textSurname1.setText(person.getFirstSurname());
                textSurname2.setText(person.getSecondSurname());
                textID.setText(person.getIdentificationNumber());
                dateOfBirthPicker.setText(person.getDateOfBirth().toString());
                // Clear any previous items
                boxGender.removeAllItems();
                boxID.removeAllItems();

                // Add the new item
                boxGender.addItem(genderName);
                boxID.addItem(typeIdName);

                // Optionally select the added item (redundant if only one)
                boxGender.setSelectedItem(genderName);
                boxID.setSelectedItem(typeIdName);
            }
            PersonCompleteDAO personCompleteDAO = new PersonCompleteDAO();
            PersonCompleteDAO.CompleteProfile profile = personCompleteDAO.getCompleteProfile(user.getPersonId(), conn);
            
            if (profile.getPerson() != null) {     
                // Load institutions from profile
                DefaultListModel<String> institutionModel = new DefaultListModel<>();
                for (Institution institution : profile.getInstitutions()) {
                    institutionModel.addElement(institution.getName());
                }
                listInstitutions.setModel(institutionModel);
                
                // Load emails from profile
                DefaultListModel<String> emailModel = new DefaultListModel<>();
                for (String email : profile.getEmails()) {
                    emailModel.addElement(email);
                }
                listEmails.setModel(emailModel);
                
                // Load phone numbers into table from profile
                DefaultTableModel phoneTableModel = new DefaultTableModel(
                    new String[]{"Phone Number", "Type"}, 0
                );
                for (PersonCompleteDAO.PhoneInfo phone : profile.getPhones()) {
                    phoneTableModel.addRow(new Object[]{
                        phone.getPhoneNumber(), 
                        phone.getPhoneType()
                    });
                }
                tablePhones.setModel(phoneTableModel);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading profile: " + ex.getMessage());
        }
        
        this.setExtendedState(JFrame.MAXIMIZED_BOTH);
    }
    
    private void loadGenders() {
        try {
            GenderDAOImpl genderDAO = new GenderDAOImpl();
            List<Gender> genders = genderDAO.findAll();

            // Limpiar el ComboBox primero 
            boxGender.removeAllItems();

            // Agregar todos los géneros al ComboBox
            for (Gender gender : genders) {
                boxGender.addItem(gender.getName());
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading genders: " + ex.getMessage());
        }
    }
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
        labelProfile = new javax.swing.JLabel();
        filler1 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler2 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler3 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        filler4 = new javax.swing.Box.Filler(new java.awt.Dimension(0, 0), new java.awt.Dimension(0, 0), new java.awt.Dimension(32767, 32767));
        jPanel2 = new javax.swing.JPanel();
        panelGender = new javax.swing.JPanel();
        jPanel32 = new javax.swing.JPanel();
        name_label9 = new javax.swing.JLabel();
        boxGender = new javax.swing.JComboBox<>();
        panelDateBirth = new javax.swing.JPanel();
        name_label5 = new javax.swing.JLabel();
        dateOfBirthPicker = new com.github.lgooddatepicker.components.DatePicker();
        panelSurname1 = new javax.swing.JPanel();
        name_label3 = new javax.swing.JLabel();
        textSurname1 = new javax.swing.JTextField();
        panelName1 = new javax.swing.JPanel();
        name_label12 = new javax.swing.JLabel();
        textName1 = new javax.swing.JTextField();
        panelName2 = new javax.swing.JPanel();
        name_label2 = new javax.swing.JLabel();
        textName2 = new javax.swing.JTextField();
        panelSurname2 = new javax.swing.JPanel();
        name_label4 = new javax.swing.JLabel();
        textSurname2 = new javax.swing.JTextField();
        jPanel3 = new javax.swing.JPanel();
        panelNumbers = new javax.swing.JPanel();
        name_label7 = new javax.swing.JLabel();
        jScrollPane2 = new javax.swing.JScrollPane();
        tablePhones = new javax.swing.JTable();
        jPanel6 = new javax.swing.JPanel();
        buttonEraseP = new javax.swing.JButton();
        buttonEditP = new javax.swing.JButton();
        panelInstitutions = new javax.swing.JPanel();
        jPanel4 = new javax.swing.JPanel();
        jPanel30 = new javax.swing.JPanel();
        name_label8 = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        listInstitutions = new javax.swing.JList<>();
        jPanel7 = new javax.swing.JPanel();
        buttonEditI = new javax.swing.JButton();
        buttonEraseI = new javax.swing.JButton();
        panelEmails = new javax.swing.JPanel();
        jScrollPane3 = new javax.swing.JScrollPane();
        listEmails = new javax.swing.JList<>();
        jPanel36 = new javax.swing.JPanel();
        name_label11 = new javax.swing.JLabel();
        jPanel8 = new javax.swing.JPanel();
        buttonEraseE = new javax.swing.JButton();
        buttonEditE = new javax.swing.JButton();
        panelIDNumber = new javax.swing.JPanel();
        name_label13 = new javax.swing.JLabel();
        textID = new javax.swing.JTextField();
        panelIDType = new javax.swing.JPanel();
        jPanel15 = new javax.swing.JPanel();
        name_label = new javax.swing.JLabel();
        boxID = new javax.swing.JComboBox<>();
        jPanel9 = new javax.swing.JPanel();
        buttonModify = new javax.swing.JButton();
        buttonPassword = new javax.swing.JButton();
        buttonPhoto = new javax.swing.JButton();
        buttonAddNumber = new javax.swing.JButton();
        buttonAddEmail = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanel1.setBackground(new java.awt.Color(225, 239, 255));
        jPanel1.setLayout(new java.awt.GridBagLayout());

        labelProfile.setText("MODIFY USER PROFILE");
        labelProfile.setFont(new java.awt.Font("Yu Gothic UI Semibold", 1, 40)); // NOI18N
        labelProfile.setForeground(new java.awt.Color(18, 102, 160));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 4;
        gridBagConstraints.ipady = 80;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 50);
        jPanel1.add(labelProfile, gridBagConstraints);
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

        jPanel2.setBackground(new java.awt.Color(225, 239, 255));
        jPanel2.setLayout(new java.awt.GridBagLayout());

        panelGender.setBackground(new java.awt.Color(225, 239, 255));
        panelGender.setLayout(new java.awt.GridBagLayout());

        jPanel32.setBackground(new java.awt.Color(225, 239, 255));
        jPanel32.setLayout(new java.awt.GridBagLayout());

        name_label9.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label9.setText("<html>Gender: <span style='color:red'>*</span></html>");
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
        panelGender.add(jPanel32, gridBagConstraints);

        boxGender.setPreferredSize(new java.awt.Dimension(90, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.FIRST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        panelGender.add(boxGender, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 100, 0, 0);
        jPanel2.add(panelGender, gridBagConstraints);

        panelDateBirth.setBackground(new java.awt.Color(225, 239, 255));
        panelDateBirth.setLayout(new java.awt.GridBagLayout());

        name_label5.setText("<html>Date of Birth: <span style='color:red'>*</span></html>");
        name_label5.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 67;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 8, 10, 0);
        panelDateBirth.add(name_label5, gridBagConstraints);
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 7, 0, 0);
        panelDateBirth.add(dateOfBirthPicker, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 6;
        gridBagConstraints.gridheight = 2;
        gridBagConstraints.insets = new java.awt.Insets(0, 90, 0, 0);
        jPanel2.add(panelDateBirth, gridBagConstraints);

        panelSurname1.setBackground(new java.awt.Color(225, 239, 255));
        panelSurname1.setLayout(new java.awt.GridBagLayout());

        name_label3.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label3.setText("<html>First Surname: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 68;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        panelSurname1.add(name_label3, gridBagConstraints);

        textSurname1.setText("jTextField1");
        textSurname1.setPreferredSize(new java.awt.Dimension(150, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.ipadx = 7;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        panelSurname1.add(textSurname1, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.ipadx = 15;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 100, 0, 0);
        jPanel2.add(panelSurname1, gridBagConstraints);

        panelName1.setBackground(new java.awt.Color(225, 239, 255));
        panelName1.setLayout(new java.awt.GridBagLayout());

        name_label12.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label12.setText("<html>First Name: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 80;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        panelName1.add(name_label12, gridBagConstraints);

        textName1.setText("jTextField1");
        textName1.setPreferredSize(new java.awt.Dimension(150, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.ipadx = 7;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        panelName1.add(textName1, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 25;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 100, 0, 0);
        jPanel2.add(panelName1, gridBagConstraints);

        panelName2.setBackground(new java.awt.Color(225, 239, 255));
        panelName2.setLayout(new java.awt.GridBagLayout());

        name_label2.setText("Second Name:");
        name_label2.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 58;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        panelName2.add(name_label2, gridBagConstraints);

        textName2.setText("jTextField1");
        textName2.setPreferredSize(new java.awt.Dimension(150, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.ipadx = 7;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        panelName2.add(textName2, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 100, 0, 0);
        jPanel2.add(panelName2, gridBagConstraints);

        panelSurname2.setBackground(new java.awt.Color(225, 239, 255));
        panelSurname2.setLayout(new java.awt.GridBagLayout());

        name_label4.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label4.setText("Second Surame:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 48;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        panelSurname2.add(name_label4, gridBagConstraints);

        textSurname2.setText("jTextField1");
        textSurname2.setPreferredSize(new java.awt.Dimension(150, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.ipadx = 7;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        panelSurname2.add(textSurname2, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 100, 0, 0);
        jPanel2.add(panelSurname2, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.PAGE_START;
        jPanel1.add(jPanel2, gridBagConstraints);

        jPanel3.setBackground(new java.awt.Color(225, 239, 255));
        jPanel3.setLayout(new java.awt.GridBagLayout());

        panelNumbers.setBackground(new java.awt.Color(225, 239, 255));
        panelNumbers.setLayout(new java.awt.GridBagLayout());

        name_label7.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label7.setText("Phone Numbers:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        panelNumbers.add(name_label7, gridBagConstraints);

        jScrollPane2.setPreferredSize(new java.awt.Dimension(400, 400));

        tablePhones.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null},
                {null, null}
            },
            new String [] {
                "Phone Type", "Phone Number"
            }
        ));
        jScrollPane2.setViewportView(tablePhones);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.RELATIVE;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipady = 60;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        panelNumbers.add(jScrollPane2, gridBagConstraints);

        jPanel6.setBackground(new java.awt.Color(225, 239, 255));
        jPanel6.setLayout(new java.awt.GridBagLayout());

        buttonEraseP.setText("Erase");
        buttonEraseP.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonErasePActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 10);
        jPanel6.add(buttonEraseP, gridBagConstraints);

        buttonEditP.setText("Edit");
        buttonEditP.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonEditPActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        jPanel6.add(buttonEditP, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.gridwidth = 2;
        gridBagConstraints.insets = new java.awt.Insets(5, 0, 0, 0);
        panelNumbers.add(jPanel6, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipady = 40;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 50, 10, 0);
        jPanel3.add(panelNumbers, gridBagConstraints);

        panelInstitutions.setBackground(new java.awt.Color(225, 239, 255));
        panelInstitutions.setLayout(new java.awt.GridBagLayout());

        jPanel4.setBackground(new java.awt.Color(225, 239, 255));
        jPanel4.setLayout(new java.awt.GridBagLayout());

        jPanel30.setBackground(new java.awt.Color(225, 239, 255));
        jPanel30.setLayout(new java.awt.GridBagLayout());

        name_label8.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label8.setText("Institutions You Belong To:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 5, 0);
        jPanel30.add(name_label8, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LAST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel4.add(jPanel30, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        panelInstitutions.add(jPanel4, gridBagConstraints);

        listInstitutions.setModel(new javax.swing.AbstractListModel<String>() {
            String[] strings = { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5" };
            public int getSize() { return strings.length; }
            public String getElementAt(int i) { return strings[i]; }
        });
        jScrollPane1.setViewportView(listInstitutions);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipady = 60;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        panelInstitutions.add(jScrollPane1, gridBagConstraints);

        jPanel7.setBackground(new java.awt.Color(225, 239, 255));
        jPanel7.setLayout(new java.awt.GridBagLayout());

        buttonEditI.setText("Edit");
        buttonEditI.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonEditIActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        jPanel7.add(buttonEditI, gridBagConstraints);

        buttonEraseI.setText("Erase");
        buttonEraseI.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonEraseIActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 10);
        jPanel7.add(buttonEraseI, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.insets = new java.awt.Insets(5, 0, 0, 0);
        panelInstitutions.add(jPanel7, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipady = 40;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 50, 10, 0);
        jPanel3.add(panelInstitutions, gridBagConstraints);

        panelEmails.setBackground(new java.awt.Color(225, 239, 255));
        panelEmails.setLayout(new java.awt.GridBagLayout());

        listEmails.setModel(new javax.swing.AbstractListModel<String>() {
            String[] strings = { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5" };
            public int getSize() { return strings.length; }
            public String getElementAt(int i) { return strings[i]; }
        });
        jScrollPane3.setViewportView(listEmails);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipady = 60;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        panelEmails.add(jScrollPane3, gridBagConstraints);

        jPanel36.setBackground(new java.awt.Color(225, 239, 255));
        jPanel36.setLayout(new java.awt.GridBagLayout());

        name_label11.setText("Emails:");
        name_label11.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 115;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 5, 0);
        jPanel36.add(name_label11, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        panelEmails.add(jPanel36, gridBagConstraints);

        jPanel8.setBackground(new java.awt.Color(225, 239, 255));
        jPanel8.setLayout(new java.awt.GridBagLayout());

        buttonEraseE.setText("Erase");
        buttonEraseE.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonEraseEActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 10);
        jPanel8.add(buttonEraseE, gridBagConstraints);

        buttonEditE.setText("Edit");
        buttonEditE.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonEditEActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 0;
        jPanel8.add(buttonEditE, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.insets = new java.awt.Insets(5, 0, 0, 0);
        panelEmails.add(jPanel8, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipady = 40;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 50, 60, 0);
        jPanel3.add(panelEmails, gridBagConstraints);

        panelIDNumber.setBackground(new java.awt.Color(225, 239, 255));
        panelIDNumber.setLayout(new java.awt.GridBagLayout());

        name_label13.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label13.setText("<html>Identification Number: <span style='color:red'>*</span></html>");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 70;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        panelIDNumber.add(name_label13, gridBagConstraints);

        textID.setText("jTextField1");
        textID.setPreferredSize(new java.awt.Dimension(150, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.REMAINDER;
        gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints.ipadx = 7;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        panelIDNumber.add(textID, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 50, 0, 0);
        jPanel3.add(panelIDNumber, gridBagConstraints);

        panelIDType.setBackground(new java.awt.Color(225, 239, 255));
        panelIDType.setLayout(new java.awt.GridBagLayout());

        jPanel15.setBackground(new java.awt.Color(225, 239, 255));
        jPanel15.setLayout(new java.awt.GridBagLayout());

        name_label.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label.setText("<html>Type of Identification: <span style='color:red'>*</span></html>");
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
        panelIDType.add(jPanel15, gridBagConstraints);

        boxID.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        boxID.setPreferredSize(new java.awt.Dimension(90, 40));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.FIRST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 25, 0);
        panelIDType.add(boxID, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 50, 0, 0);
        jPanel3.add(panelIDType, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 5;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.30000000000000004;
        jPanel1.add(jPanel3, gridBagConstraints);

        jPanel9.setBackground(new java.awt.Color(225, 239, 255));
        jPanel9.setLayout(new java.awt.GridBagLayout());

        buttonModify.setText("Save Chnages");
        buttonModify.setBackground(new java.awt.Color(246, 172, 30));
        buttonModify.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonModify.setForeground(new java.awt.Color(255, 255, 255));
        buttonModify.setMaximumSize(new java.awt.Dimension(85, 23));
        buttonModify.setMinimumSize(new java.awt.Dimension(85, 23));
        buttonModify.setPreferredSize(new java.awt.Dimension(85, 23));
        buttonModify.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonModifyActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 7;
        gridBagConstraints.ipadx = 65;
        gridBagConstraints.ipady = 27;
        gridBagConstraints.insets = new java.awt.Insets(40, 120, 30, 0);
        jPanel9.add(buttonModify, gridBagConstraints);

        buttonPassword.setText("Change Password");
        buttonPassword.setBackground(new java.awt.Color(255, 90, 90));
        buttonPassword.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonPassword.setForeground(new java.awt.Color(255, 255, 255));
        buttonPassword.setMaximumSize(new java.awt.Dimension(85, 23));
        buttonPassword.setMinimumSize(new java.awt.Dimension(85, 23));
        buttonPassword.setPreferredSize(new java.awt.Dimension(85, 23));
        buttonPassword.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonPasswordActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 6;
        gridBagConstraints.ipadx = 80;
        gridBagConstraints.ipady = 15;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.EAST;
        gridBagConstraints.insets = new java.awt.Insets(40, 120, 30, 0);
        jPanel9.add(buttonPassword, gridBagConstraints);

        buttonPhoto.setText("Change Photo");
        buttonPhoto.setBackground(new java.awt.Color(18, 102, 160));
        buttonPhoto.setFont(new java.awt.Font("Segoe UI", 1, 12)); // NOI18N
        buttonPhoto.setForeground(new java.awt.Color(255, 255, 255));
        buttonPhoto.setMaximumSize(new java.awt.Dimension(85, 23));
        buttonPhoto.setMinimumSize(new java.awt.Dimension(85, 23));
        buttonPhoto.setPreferredSize(new java.awt.Dimension(85, 23));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.ipadx = 80;
        gridBagConstraints.ipady = 15;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.EAST;
        gridBagConstraints.insets = new java.awt.Insets(40, 120, 30, 0);
        jPanel9.add(buttonPhoto, gridBagConstraints);

        buttonAddNumber.setBackground(new java.awt.Color(18, 102, 160));
        buttonAddNumber.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonAddNumber.setForeground(new java.awt.Color(255, 255, 255));
        buttonAddNumber.setText("Add Phone Number");
        buttonAddNumber.setMaximumSize(new java.awt.Dimension(85, 23));
        buttonAddNumber.setMinimumSize(new java.awt.Dimension(85, 23));
        buttonAddNumber.setPreferredSize(new java.awt.Dimension(140, 40));
        buttonAddNumber.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonAddNumberActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 80;
        gridBagConstraints.ipady = 15;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.EAST;
        gridBagConstraints.insets = new java.awt.Insets(40, 120, 30, 0);
        jPanel9.add(buttonAddNumber, gridBagConstraints);

        buttonAddEmail.setBackground(new java.awt.Color(18, 102, 160));
        buttonAddEmail.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonAddEmail.setForeground(new java.awt.Color(255, 255, 255));
        buttonAddEmail.setText("Add Email");
        buttonAddEmail.setMaximumSize(new java.awt.Dimension(85, 23));
        buttonAddEmail.setMinimumSize(new java.awt.Dimension(85, 23));
        buttonAddEmail.setPreferredSize(new java.awt.Dimension(140, 40));
        buttonAddEmail.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonAddEmailActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.ipadx = 80;
        gridBagConstraints.ipady = 15;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.EAST;
        gridBagConstraints.insets = new java.awt.Insets(40, 120, 30, 0);
        jPanel9.add(buttonAddEmail, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTH;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 0, 100);
        jPanel1.add(jPanel9, gridBagConstraints);

        getContentPane().add(jPanel1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void buttonModifyActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonModifyActionPerformed
        String fst_name = textName1.getText().trim();
        String scnd_name = textName2.getText().trim();
        String surname = textSurname1.getText().trim();
        String scnd_surname = textSurname2.getText().trim();
        String id = textID.getText().trim();
        int gender_id = boxGender.getSelectedIndex() + 1; // +1 porque los índices en MySQL empiezan en 1
        int id_type_id = boxID.getSelectedIndex() + 1;
        LocalDate selectedDate = dateOfBirthPicker.getDate();

        if (fst_name.isEmpty() || surname.isEmpty() || id.isEmpty() || 
            gender_id == 0 || id_type_id == 0 || selectedDate == null) {
            JOptionPane.showMessageDialog(this, "Please fill in all required fields.", 
                "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        // Crear objeto Person con los datos
        Person updatedPerson = new Person();
        updatedPerson.setId(user.getPersonId());
        updatedPerson.setFirstName(fst_name);
        updatedPerson.setSecondName(scnd_name.isEmpty() ? null : scnd_name);
        updatedPerson.setFirstSurname(surname);
        updatedPerson.setSecondSurname(scnd_surname.isEmpty() ? null : scnd_surname);
        updatedPerson.setIdentificationNumber(id);
        updatedPerson.setDateOfBirth(java.sql.Date.valueOf(selectedDate));
        updatedPerson.setGenderId(gender_id);
        updatedPerson.setTypeIdentificationId(id_type_id);

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Actualizar la persona
            PersonUpdateDAO personUpdateDAO = new PersonUpdateDAOImpl();
            personUpdateDAO.updatePerson(updatedPerson, conn);

            JOptionPane.showMessageDialog(this, "Changes applied successfully!", 
                "Éxito", JOptionPane.INFORMATION_MESSAGE);

            // Regresar al perfil del usuario
            javax.swing.SwingUtilities.invokeLater(() -> {
                UserProfile profile = new UserProfile(userRole, user);
                profile.setExtendedState(JFrame.MAXIMIZED_BOTH);
                profile.setVisible(true);
                ModifyProfile.this.dispose();
            });

        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, 
                "Error al actualizar el perfil: " + ex.getMessage(), 
                "Error de base de datos", JOptionPane.ERROR_MESSAGE);
        }
    }//GEN-LAST:event_buttonModifyActionPerformed

    private void buttonEditPActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonEditPActionPerformed
        int row = tablePhones.getSelectedRow();
        if (row != -1) {
            //Object valorColumna1 = tablePhones.getValueAt(row, 0); // Columna 0
            //Object valorColumna2 = tablePhones.getValueAt(row, 1); // Columna 1
            javax.swing.SwingUtilities.invokeLater(() -> {
                PhonePage phone = new PhonePage();
                phone.setVisible(true);
                phone.setLocationRelativeTo(null); // center on screen
            });
        } else {
            JOptionPane.showMessageDialog(this, "A row must be selected.");
        }
    }//GEN-LAST:event_buttonEditPActionPerformed

    private void buttonErasePActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonErasePActionPerformed
        int row = tablePhones.getSelectedRow();
        if (row != -1) {
            DefaultTableModel model = (DefaultTableModel) tablePhones.getModel();
            model.removeRow(row);
            JOptionPane.showMessageDialog(this, "Item erased successfully!");
        } else {
            JOptionPane.showMessageDialog(this, "A row must be selected.");
        }
    }//GEN-LAST:event_buttonErasePActionPerformed

    private void buttonEraseIActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonEraseIActionPerformed
        int index = listInstitutions.getSelectedIndex();
        if (index != -1) {
            ListModel model = listInstitutions.getModel();
            if (model instanceof javax.swing.DefaultListModel) {  // Verificamos que sea un DefaultListModel, común
                javax.swing.DefaultListModel defaultListModel = (javax.swing.DefaultListModel) model;
                defaultListModel.removeElementAt(index); // Eliminar el elemento
            }
            listInstitutions.updateUI();
            JOptionPane.showMessageDialog(this, "Item erased successfully!");
        } else {
            JOptionPane.showMessageDialog(this, "An item must be selected.");
        }
    }//GEN-LAST:event_buttonEraseIActionPerformed

    private void buttonEditIActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonEditIActionPerformed
        int index = listInstitutions.getSelectedIndex();
        if (index != -1) {
            //Object selectedValue = listInstitutions.getSelectedValue();
            javax.swing.SwingUtilities.invokeLater(() -> {
            InstitutionPage institution = new InstitutionPage();
            institution.setVisible(true);
            institution.setLocationRelativeTo(null); // center on screen
            });
        } else {
            JOptionPane.showMessageDialog(this, "An item must be selected.");
        }
    }//GEN-LAST:event_buttonEditIActionPerformed

    private void buttonEraseEActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonEraseEActionPerformed
        int index = listEmails.getSelectedIndex();
        if (index != -1) {
            ListModel model = listEmails.getModel();
            if (model instanceof javax.swing.DefaultListModel) {  // Verificamos que sea un DefaultListModel, común
                javax.swing.DefaultListModel defaultListModel = (javax.swing.DefaultListModel) model;
                defaultListModel.removeElementAt(index); // Eliminar el elemento
            }
            listEmails.updateUI();
            JOptionPane.showMessageDialog(this, "Item erased successfully!");
        } else {
            JOptionPane.showMessageDialog(this, "An item must be selected.");
        }
    }//GEN-LAST:event_buttonEraseEActionPerformed

    private void buttonEditEActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonEditEActionPerformed
        int index = listEmails.getSelectedIndex();
        if (index != -1) {
            //Object selectedValue = listInstitutions.getSelectedValue();
            javax.swing.SwingUtilities.invokeLater(() -> {
                EmailPage email = new EmailPage();
                email.setVisible(true);
                email.setLocationRelativeTo(null); // center on screen
            });
        } else {
            JOptionPane.showMessageDialog(this, "An item must be selected.");
        }
    }//GEN-LAST:event_buttonEditEActionPerformed

    private void buttonPasswordActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonPasswordActionPerformed
        javax.swing.SwingUtilities.invokeLater(() -> {
            PasswordPage password = new PasswordPage();
            password.setVisible(true);
            password.setLocationRelativeTo(null); // center on screen
        });
    }//GEN-LAST:event_buttonPasswordActionPerformed

    private void buttonAddNumberActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonAddNumberActionPerformed
        javax.swing.SwingUtilities.invokeLater(() -> {
            PhonePage phone = new PhonePage();
            phone.setVisible(true);
            phone.setLocationRelativeTo(null); // center on screen
        });
    }//GEN-LAST:event_buttonAddNumberActionPerformed

    private void buttonAddEmailActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonAddEmailActionPerformed
        javax.swing.SwingUtilities.invokeLater(() -> {
            EmailPage email = new EmailPage();
            email.setVisible(true);
            email.setLocationRelativeTo(null); // center on screen
        });
    }//GEN-LAST:event_buttonAddEmailActionPerformed

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
            java.util.logging.Logger.getLogger(ModifyProfile.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(ModifyProfile.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(ModifyProfile.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(ModifyProfile.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            private String userRole;
            private User user;
            public void run() {
                userRole = "Driver";
                user = new User(1, "testuser", 101);
                new ModifyProfile(userRole, user).setVisible(true);
            }
        });
    }
    

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> boxGender;
    private javax.swing.JComboBox<String> boxID;
    private javax.swing.JButton buttonAddEmail;
    private javax.swing.JButton buttonAddNumber;
    private javax.swing.JButton buttonEditE;
    private javax.swing.JButton buttonEditI;
    private javax.swing.JButton buttonEditP;
    private javax.swing.JButton buttonEraseE;
    private javax.swing.JButton buttonEraseI;
    private javax.swing.JButton buttonEraseP;
    private javax.swing.JButton buttonModify;
    private javax.swing.JButton buttonPassword;
    private javax.swing.JButton buttonPhoto;
    private com.github.lgooddatepicker.components.DatePicker dateOfBirthPicker;
    private javax.swing.Box.Filler filler1;
    private javax.swing.Box.Filler filler2;
    private javax.swing.Box.Filler filler3;
    private javax.swing.Box.Filler filler4;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel15;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel30;
    private javax.swing.JPanel jPanel32;
    private javax.swing.JPanel jPanel36;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JPanel jPanel7;
    private javax.swing.JPanel jPanel8;
    private javax.swing.JPanel jPanel9;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane3;
    private javax.swing.JLabel labelProfile;
    private javax.swing.JList<String> listEmails;
    private javax.swing.JList<String> listInstitutions;
    private javax.swing.JLabel name_label;
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
    private javax.swing.JPanel panelDateBirth;
    private javax.swing.JPanel panelEmails;
    private javax.swing.JPanel panelGender;
    private javax.swing.JPanel panelIDNumber;
    private javax.swing.JPanel panelIDType;
    private javax.swing.JPanel panelInstitutions;
    private javax.swing.JPanel panelName1;
    private javax.swing.JPanel panelName2;
    private javax.swing.JPanel panelNumbers;
    private javax.swing.JPanel panelSurname1;
    private javax.swing.JPanel panelSurname2;
    private javax.swing.JTable tablePhones;
    private javax.swing.JTextField textID;
    private javax.swing.JTextField textName1;
    private javax.swing.JTextField textName2;
    private javax.swing.JTextField textSurname1;
    private javax.swing.JTextField textSurname2;
    // End of variables declaration//GEN-END:variables
}
