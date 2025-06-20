/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import com.tec.carpooling.presentation.view.InitialPage;
import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.domain.entity.User;
import com.tec.carpooling.data.dao.PersonCompleteDAO;
import com.tec.carpooling.data.dao.PhotoDAO;
import com.tec.carpooling.domain.entity.Person;
import com.tec.carpooling.domain.entity.Photo;
import com.tec.carpooling.domain.entity.Institution;

import javax.swing.ImageIcon;
import javax.swing.DefaultListModel;
import javax.swing.table.DefaultTableModel;
import java.awt.Image;
import java.awt.Dimension;
import javax.swing.BorderFactory;
import java.util.List;

import java.awt.BorderLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JToolBar;
import javax.swing.JOptionPane;

import java.sql.SQLException;
import java.sql.Connection;

/**
 *
 * @author hidal
 */
public class UserProfile extends javax.swing.JFrame {
    private String userRole;
    private final User user;
    /**
     * Creates new form InfoUsuario
     */
    public UserProfile(String role, User user) {
        this.userRole = role;
        this.user = user;
        initComponents();
        getContentPane().add(SideMenu.createToolbar(this, userRole, user), BorderLayout.WEST);
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            PersonCompleteDAO personCompleteDAO = new PersonCompleteDAO();
            PhotoDAO photoDAO = new PhotoDAO();

            // Get complete profile information in a single procedure call
            PersonCompleteDAO.CompleteProfile profile = personCompleteDAO.getCompleteProfile(user.getPersonId(), conn);
            
            if (profile.getPerson() != null) {
                Person person = profile.getPerson();
                
                // Load basic person information
                jLabelFirstName.setText(person.getFirstName() != null ? person.getFirstName() : "");
                jLabelSecondName.setText(person.getSecondName() != null ? person.getSecondName() : "");
                jLabelFirstSurname.setText(person.getFirstSurname() != null ? person.getFirstSurname() : "");
                jLabelSecondSurname.setText(person.getSecondSurname() != null ? person.getSecondSurname() : "");
                jLabelIDNumber.setText(person.getIdentificationNumber() != null ? person.getIdentificationNumber() : "");
                jLabelDateOfBirth.setText(person.getDateOfBirth() != null ? person.getDateOfBirth().toString() : "");
                
                // Display actual names instead of IDs
                jLabelGender.setText(profile.getGenderName() != null ? profile.getGenderName() : "Unknown");
                jLabelTypeofID.setText(profile.getTypeIdentificationName() != null ? profile.getTypeIdentificationName() : "Unknown");
                
                // Load and display profile photo
                Photo profilePhoto = photoDAO.getLatestPhoto(user.getPersonId(), conn);
                if (profilePhoto != null && profilePhoto.getImage() != null) {
                    byte[] imgBytes = profilePhoto.getImage();
                    ImageIcon rawIcon = new ImageIcon(imgBytes);
                    Image raw = rawIcon.getImage();

                    // 1) compute a scale that fits within maxW×maxH but keeps aspect ratio
                    int maxW = 200, maxH = 150;
                    int w = raw.getWidth(null), h = raw.getHeight(null);
                    double scale = Math.min((double)maxW / w, (double)maxH / h);
                    int newW = (int)(w * scale);
                    int newH = (int)(h * scale);

                    Image scaled = raw.getScaledInstance(newW, newH, Image.SCALE_SMOOTH);
                    jLabelPhoto.setIcon(new ImageIcon(scaled));
                    jLabelPhoto.setText("");             // no text

                    // 2) force your label to occupy the “full box” so it won’t collapse smaller
                    jLabelPhoto.setPreferredSize(new Dimension(maxW, maxH));

                    // 3) add a left‐padding so it shifts right a bit
                    jLabelPhoto.setBorder(
                      BorderFactory.createEmptyBorder(0, 120, 0, 0)
                    );
                }
                else {
                    jLabelPhoto.setIcon(null);
                    jLabelPhoto.setText("No Photo");
                }
                
                // Load institutions from profile
                DefaultListModel<String> institutionModel = new DefaultListModel<>();
                for (Institution institution : profile.getInstitutions()) {
                    institutionModel.addElement(institution.getName());
                }
                jListInstitutionsYouBelongs.setModel(institutionModel);
                
                // Load emails from profile
                DefaultListModel<String> emailModel = new DefaultListModel<>();
                for (String email : profile.getEmails()) {
                    emailModel.addElement(email);
                }
                jListEmails.setModel(emailModel);
                
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
                jTablePhoneNumbers.setModel(phoneTableModel);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading profile: " + ex.getMessage());
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
        jLabelPhoto = new javax.swing.JLabel();
        jPanel6 = new javax.swing.JPanel();
        jPanel34 = new javax.swing.JPanel();
        buttonModifyProfile = new javax.swing.JButton();
        jPanel5 = new javax.swing.JPanel();
        jPanel25 = new javax.swing.JPanel();
        jPanel10 = new javax.swing.JPanel();
        jLabelFirstSurname = new javax.swing.JLabel();
        jPanel20 = new javax.swing.JPanel();
        name_label3 = new javax.swing.JLabel();
        jPanel11 = new javax.swing.JPanel();
        jLabelSecondSurname = new javax.swing.JLabel();
        jPanel22 = new javax.swing.JPanel();
        name_label4 = new javax.swing.JLabel();
        jPanel9 = new javax.swing.JPanel();
        jPanel18 = new javax.swing.JPanel();
        name_label2 = new javax.swing.JLabel();
        jLabelSecondName = new javax.swing.JLabel();
        jPanel8 = new javax.swing.JPanel();
        jLabelFirstName = new javax.swing.JLabel();
        jPanel38 = new javax.swing.JPanel();
        name_label12 = new javax.swing.JLabel();
        jPanel23 = new javax.swing.JPanel();
        jPanel13 = new javax.swing.JPanel();
        jLabelDateOfBirth = new javax.swing.JLabel();
        jPanel24 = new javax.swing.JPanel();
        name_label5 = new javax.swing.JLabel();
        jPanel12 = new javax.swing.JPanel();
        jLabelGender = new javax.swing.JLabel();
        jPanel7 = new javax.swing.JPanel();
        jPanel32 = new javax.swing.JPanel();
        name_label9 = new javax.swing.JLabel();
        jPanel14 = new javax.swing.JPanel();
        jPanel19 = new javax.swing.JPanel();
        name_label7 = new javax.swing.JLabel();
        jScrollPane2 = new javax.swing.JScrollPane();
        jTablePhoneNumbers = new javax.swing.JTable();
        jPanel21 = new javax.swing.JPanel();
        jScrollPane3 = new javax.swing.JScrollPane();
        jListEmails = new javax.swing.JList<>();
        jPanel36 = new javax.swing.JPanel();
        name_label11 = new javax.swing.JLabel();
        jPanel3 = new javax.swing.JPanel();
        jPanel4 = new javax.swing.JPanel();
        jPanel30 = new javax.swing.JPanel();
        name_label8 = new javax.swing.JLabel();
        jPanel31 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        jListInstitutionsYouBelongs = new javax.swing.JList<>();
        jPanel17 = new javax.swing.JPanel();
        jLabelIDNumber = new javax.swing.JLabel();
        jPanel40 = new javax.swing.JPanel();
        name_label13 = new javax.swing.JLabel();
        jPanel16 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        jPanel15 = new javax.swing.JPanel();
        name_label = new javax.swing.JLabel();
        jLabelTypeofID = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanel1.setBackground(new java.awt.Color(225, 239, 255));
        jPanel1.setLayout(new java.awt.GridBagLayout());

        labelProfile.setFont(new java.awt.Font("Yu Gothic UI Semibold", 1, 40)); // NOI18N
        labelProfile.setForeground(new java.awt.Color(18, 102, 160));
        labelProfile.setText("USER PROFILE");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 4;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(60, 0, 60, 20);
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

        jLabelPhoto.setToolTipText("");
        jLabelPhoto.setPreferredSize(new java.awt.Dimension(200, 200));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.ipadx = 170;
        gridBagConstraints.ipady = 170;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 0);
        jPanel1.add(jLabelPhoto, gridBagConstraints);

        jPanel6.setBackground(new java.awt.Color(225, 239, 255));
        jPanel6.setLayout(new java.awt.GridBagLayout());

        jPanel34.setBackground(new java.awt.Color(225, 239, 255));
        jPanel34.setLayout(new java.awt.GridBagLayout());

        buttonModifyProfile.setBackground(new java.awt.Color(246, 172, 30));
        buttonModifyProfile.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        buttonModifyProfile.setForeground(new java.awt.Color(255, 255, 255));
        buttonModifyProfile.setText("Modify Profile");
        buttonModifyProfile.setMaximumSize(new java.awt.Dimension(85, 23));
        buttonModifyProfile.setMinimumSize(new java.awt.Dimension(85, 23));
        buttonModifyProfile.setPreferredSize(new java.awt.Dimension(90, 40));
        buttonModifyProfile.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonModifyProfileActionPerformed(evt);
            }
        });
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.ipadx = 65;
        gridBagConstraints.ipady = 15;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.WEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 30, 0, 0);
        jPanel34.add(buttonModifyProfile, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.gridwidth = 3;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 120);
        jPanel6.add(jPanel34, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 6;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.insets = new java.awt.Insets(0, 80, 50, 0);
        jPanel1.add(jPanel6, gridBagConstraints);

        jPanel5.setBackground(new java.awt.Color(225, 239, 255));
        jPanel5.setLayout(new java.awt.GridBagLayout());

        jPanel25.setBackground(new java.awt.Color(225, 239, 255));
        jPanel25.setLayout(new java.awt.GridBagLayout());

        jPanel10.setBackground(new java.awt.Color(225, 239, 255));
        jPanel10.setLayout(new java.awt.GridBagLayout());

        jLabelFirstSurname.setText("jLabel3");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        jPanel10.add(jLabelFirstSurname, gridBagConstraints);

        jPanel20.setBackground(new java.awt.Color(225, 239, 255));
        jPanel20.setLayout(new java.awt.GridBagLayout());

        name_label3.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label3.setText("First Surname:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 68;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(10, 0, 10, 0);
        jPanel20.add(name_label3, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        jPanel10.add(jPanel20, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 60, 20, 0);
        jPanel25.add(jPanel10, gridBagConstraints);

        jPanel11.setBackground(new java.awt.Color(225, 239, 255));
        jPanel11.setLayout(new java.awt.GridBagLayout());

        jLabelSecondSurname.setText("jLabel4");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        jPanel11.add(jLabelSecondSurname, gridBagConstraints);

        jPanel22.setBackground(new java.awt.Color(225, 239, 255));
        jPanel22.setLayout(new java.awt.GridBagLayout());

        name_label4.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label4.setText("Second Surname:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 48;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel22.add(name_label4, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        jPanel11.add(jPanel22, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 60, 20, 0);
        jPanel25.add(jPanel11, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.insets = new java.awt.Insets(0, 100, 0, 0);
        jPanel5.add(jPanel25, gridBagConstraints);

        jPanel9.setBackground(new java.awt.Color(225, 239, 255));
        jPanel9.setLayout(new java.awt.GridBagLayout());

        jPanel18.setBackground(new java.awt.Color(225, 239, 255));
        jPanel18.setLayout(new java.awt.GridBagLayout());

        name_label2.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label2.setText("Second Name:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 58;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel18.add(name_label2, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        jPanel9.add(jPanel18, gridBagConstraints);

        jLabelSecondName.setText("jLabel2");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        jPanel9.add(jLabelSecondName, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 155, 0, 0);
        jPanel5.add(jPanel9, gridBagConstraints);

        jPanel8.setBackground(new java.awt.Color(225, 239, 255));
        jPanel8.setLayout(new java.awt.GridBagLayout());

        jLabelFirstName.setText("jLabel1");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        jPanel8.add(jLabelFirstName, gridBagConstraints);

        jPanel38.setBackground(new java.awt.Color(225, 239, 255));
        jPanel38.setLayout(new java.awt.GridBagLayout());

        name_label12.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label12.setText("First Name:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 80;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(2, 0, 17, 0);
        jPanel38.add(name_label12, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        jPanel8.add(jPanel38, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.PAGE_END;
        gridBagConstraints.insets = new java.awt.Insets(0, 155, 20, 0);
        jPanel5.add(jPanel8, gridBagConstraints);

        jPanel23.setBackground(new java.awt.Color(225, 239, 255));
        jPanel23.setLayout(new java.awt.GridBagLayout());

        jPanel13.setBackground(new java.awt.Color(225, 239, 255));
        jPanel13.setLayout(new java.awt.GridBagLayout());

        jLabelDateOfBirth.setText("jLabel6");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.ipady = 10;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        jPanel13.add(jLabelDateOfBirth, gridBagConstraints);

        jPanel24.setBackground(new java.awt.Color(225, 239, 255));
        jPanel24.setLayout(new java.awt.GridBagLayout());

        name_label5.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label5.setText("Date of birth:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 67;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel24.add(name_label5, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        jPanel13.add(jPanel24, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new java.awt.Insets(0, 60, 0, 0);
        jPanel23.add(jPanel13, gridBagConstraints);

        jPanel12.setBackground(new java.awt.Color(225, 239, 255));
        jPanel12.setLayout(new java.awt.GridBagLayout());

        jLabelGender.setText("jLabel5");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        jPanel12.add(jLabelGender, gridBagConstraints);

        jPanel7.setBackground(new java.awt.Color(225, 239, 255));
        jPanel7.setLayout(new java.awt.GridBagLayout());

        jPanel32.setBackground(new java.awt.Color(225, 239, 255));
        jPanel32.setLayout(new java.awt.GridBagLayout());

        name_label9.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label9.setText("Gender:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel32.add(name_label9, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LAST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 5, 0);
        jPanel7.add(jPanel32, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        jPanel12.add(jPanel7, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 45);
        jPanel23.add(jPanel12, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.ipady = 10;
        gridBagConstraints.insets = new java.awt.Insets(0, 100, 0, 0);
        jPanel5.add(jPanel23, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 3;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.gridheight = 4;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.PAGE_START;
        jPanel1.add(jPanel5, gridBagConstraints);

        jPanel14.setBackground(new java.awt.Color(225, 239, 255));
        jPanel14.setLayout(new java.awt.GridBagLayout());

        jPanel19.setBackground(new java.awt.Color(225, 239, 255));
        jPanel19.setLayout(new java.awt.GridBagLayout());

        name_label7.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label7.setText("Phone Numbers:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel19.add(name_label7, gridBagConstraints);

        jScrollPane2.setBackground(new java.awt.Color(225, 239, 255));
        jScrollPane2.setPreferredSize(new java.awt.Dimension(400, 400));

        jTablePhoneNumbers.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null},
                {null, null}
            },
            new String [] {
                "Phone Type", "Phone Number"
            }
        ));
        jScrollPane2.setViewportView(jTablePhoneNumbers);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridwidth = java.awt.GridBagConstraints.RELATIVE;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipady = 60;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        jPanel19.add(jScrollPane2, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipady = 30;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 0);
        jPanel14.add(jPanel19, gridBagConstraints);

        jPanel21.setBackground(new java.awt.Color(225, 239, 255));
        jPanel21.setLayout(new java.awt.GridBagLayout());

        jScrollPane3.setBackground(new java.awt.Color(225, 239, 255));

        jListEmails.setModel(new javax.swing.AbstractListModel<String>() {
            String[] strings = { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5" };
            public int getSize() { return strings.length; }
            public String getElementAt(int i) { return strings[i]; }
        });
        jScrollPane3.setViewportView(jListEmails);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipady = 60;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        jPanel21.add(jScrollPane3, gridBagConstraints);

        jPanel36.setBackground(new java.awt.Color(225, 239, 255));
        jPanel36.setLayout(new java.awt.GridBagLayout());

        name_label11.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label11.setText("Emails:");
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
        jPanel21.add(jPanel36, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipady = 40;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 70, 0);
        jPanel14.add(jPanel21, gridBagConstraints);

        jPanel3.setBackground(new java.awt.Color(225, 239, 255));
        jPanel3.setLayout(new java.awt.GridBagLayout());

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

        jPanel31.setLayout(new java.awt.GridBagLayout());
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.gridheight = 2;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.NORTHWEST;
        jPanel30.add(jPanel31, gridBagConstraints);

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
        jPanel3.add(jPanel4, gridBagConstraints);

        jScrollPane1.setBackground(new java.awt.Color(225, 239, 255));

        jListInstitutionsYouBelongs.setModel(new javax.swing.AbstractListModel<String>() {
            String[] strings = { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5" };
            public int getSize() { return strings.length; }
            public String getElementAt(int i) { return strings[i]; }
        });
        jScrollPane1.setViewportView(jListInstitutionsYouBelongs);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipady = 60;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        jPanel3.add(jScrollPane1, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.ipady = 30;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.1;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 0);
        jPanel14.add(jPanel3, gridBagConstraints);

        jPanel17.setBackground(new java.awt.Color(225, 239, 255));
        jPanel17.setLayout(new java.awt.GridBagLayout());

        jLabelIDNumber.setText("jLabel8");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        jPanel17.add(jLabelIDNumber, gridBagConstraints);

        jPanel40.setBackground(new java.awt.Color(225, 239, 255));
        jPanel40.setLayout(new java.awt.GridBagLayout());

        name_label13.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label13.setText("Identification Number:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 5;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel40.add(name_label13, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.weightx = 0.1;
        jPanel17.add(jPanel40, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel14.add(jPanel17, gridBagConstraints);

        jPanel16.setBackground(new java.awt.Color(225, 239, 255));
        jPanel16.setLayout(new java.awt.GridBagLayout());

        jPanel2.setBackground(new java.awt.Color(225, 239, 255));
        jPanel2.setLayout(new java.awt.GridBagLayout());

        jPanel15.setBackground(new java.awt.Color(225, 239, 255));
        jPanel15.setLayout(new java.awt.GridBagLayout());

        name_label.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        name_label.setText("Type of Identification:");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.SOUTHWEST;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel15.add(name_label, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LAST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 10, 0);
        jPanel2.add(jPanel15, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        jPanel16.add(jPanel2, gridBagConstraints);

        jLabelTypeofID.setText("jLabel7");
        jLabelTypeofID.setMaximumSize(new java.awt.Dimension(110, 16));
        jLabelTypeofID.setMinimumSize(new java.awt.Dimension(110, 16));
        jLabelTypeofID.setPreferredSize(new java.awt.Dimension(110, 16));
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LINE_START;
        jPanel16.add(jLabelTypeofID, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.anchor = java.awt.GridBagConstraints.LAST_LINE_START;
        gridBagConstraints.insets = new java.awt.Insets(0, 0, 20, 0);
        jPanel14.add(jPanel16, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 5;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.gridheight = 18;
        gridBagConstraints.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints.weightx = 0.1;
        gridBagConstraints.weighty = 0.30000000000000004;
        jPanel1.add(jPanel14, gridBagConstraints);

        getContentPane().add(jPanel1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void buttonModifyProfileActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonModifyProfileActionPerformed
        javax.swing.SwingUtilities.invokeLater(() -> {
            ModifyProfile modify = new ModifyProfile(userRole, user);
            modify.setExtendedState(JFrame.MAXIMIZED_BOTH);
            modify.setVisible(true);

            UserProfile.this.dispose();
        });
    }//GEN-LAST:event_buttonModifyProfileActionPerformed

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
            java.util.logging.Logger.getLogger(UserProfile.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(UserProfile.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(UserProfile.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(UserProfile.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
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
                new UserProfile(userRole, user).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton buttonModifyProfile;
    private javax.swing.Box.Filler filler1;
    private javax.swing.Box.Filler filler2;
    private javax.swing.Box.Filler filler3;
    private javax.swing.Box.Filler filler4;
    private javax.swing.JLabel jLabelDateOfBirth;
    private javax.swing.JLabel jLabelFirstName;
    private javax.swing.JLabel jLabelFirstSurname;
    private javax.swing.JLabel jLabelGender;
    private javax.swing.JLabel jLabelIDNumber;
    private javax.swing.JLabel jLabelPhoto;
    private javax.swing.JLabel jLabelSecondName;
    private javax.swing.JLabel jLabelSecondSurname;
    private javax.swing.JLabel jLabelTypeofID;
    private javax.swing.JList<String> jListEmails;
    private javax.swing.JList<String> jListInstitutionsYouBelongs;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel10;
    private javax.swing.JPanel jPanel11;
    private javax.swing.JPanel jPanel12;
    private javax.swing.JPanel jPanel13;
    private javax.swing.JPanel jPanel14;
    private javax.swing.JPanel jPanel15;
    private javax.swing.JPanel jPanel16;
    private javax.swing.JPanel jPanel17;
    private javax.swing.JPanel jPanel18;
    private javax.swing.JPanel jPanel19;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel20;
    private javax.swing.JPanel jPanel21;
    private javax.swing.JPanel jPanel22;
    private javax.swing.JPanel jPanel23;
    private javax.swing.JPanel jPanel24;
    private javax.swing.JPanel jPanel25;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel30;
    private javax.swing.JPanel jPanel31;
    private javax.swing.JPanel jPanel32;
    private javax.swing.JPanel jPanel34;
    private javax.swing.JPanel jPanel36;
    private javax.swing.JPanel jPanel38;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel40;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JPanel jPanel7;
    private javax.swing.JPanel jPanel8;
    private javax.swing.JPanel jPanel9;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane3;
    private javax.swing.JTable jTablePhoneNumbers;
    private javax.swing.JLabel labelProfile;
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
    // End of variables declaration//GEN-END:variables
}
