package com.tec.carpooling.presentation.view.admin;

import com.tec.carpooling.data.connection.DatabaseConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

public class Locations extends javax.swing.JPanel {
    private DefaultTableModel countryTableModel;
    private DefaultTableModel provinceTableModel;
    private DefaultTableModel cantonTableModel;
    private DefaultTableModel districtTableModel;
    
    private Long selectedCountryId = null;
    private Long selectedProvinceId = null;
    private Long selectedCantonId = null;
    private Long selectedDistrictId = null;

    private javax.swing.JComboBox<String> jComboBoxProvinceCountry;
    private javax.swing.JComboBox<String> jComboBoxCantonProvince;
    private javax.swing.JComboBox<String> jComboBoxDistrictCanton;

    public Locations() {
        initComponents();
        initTableModels();
        initComboBoxes();
        loadAllData();
        // Recargar datos al cambiar de pestaña para reflejar cambios recientes
        jTabbedPane1.addChangeListener(new javax.swing.event.ChangeListener() {
            @Override
            public void stateChanged(javax.swing.event.ChangeEvent e) {
                loadAllData();
            }
        });
    }

    private void initTableModels() {
        // Modelo para países
        countryTableModel = new DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "Nombre"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Long.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        };
        jTableCountries.setModel(countryTableModel);

        // Modelo para provincias
        provinceTableModel = new DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "País", "Nombre"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Long.class, java.lang.String.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        };
        jTableProvinces.setModel(provinceTableModel);

        // Modelo para cantones
        cantonTableModel = new DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "Provincia", "Nombre"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Long.class, java.lang.String.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        };
        jTableCantons.setModel(cantonTableModel);

        // Modelo para distritos
        districtTableModel = new DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "Cantón", "Nombre"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Long.class, java.lang.String.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        };
        jTableDistricts.setModel(districtTableModel);
    }

    private void initComboBoxes() {
        // Inicializar ComboBoxes
        jComboBoxProvinceCountry = new javax.swing.JComboBox<>();
        jComboBoxCantonProvince = new javax.swing.JComboBox<>();
        jComboBoxDistrictCanton = new javax.swing.JComboBox<>();

        // Agregar etiquetas y ComboBoxes a los paneles
        javax.swing.JLabel jLabelProvinceCountry = new javax.swing.JLabel("País:");
        javax.swing.JLabel jLabelCantonProvince = new javax.swing.JLabel("Provincia:");
        javax.swing.JLabel jLabelDistrictCanton = new javax.swing.JLabel("Cantón:");

        // Panel de Provincias
        jPanelProvinces.add(jLabelProvinceCountry, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 320, -1, -1));
        jPanelProvinces.add(jComboBoxProvinceCountry, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 320, 200, -1));
        jPanelProvinces.add(jLabelProvinceName, new org.netbeans.lib.awtextra.AbsoluteConstraints(290, 320, -1, -1));
        jPanelProvinces.add(jTextFieldProvinceName, new org.netbeans.lib.awtextra.AbsoluteConstraints(350, 320, 200, -1));
        jPanelProvinces.add(jButtonProvinceSave, new org.netbeans.lib.awtextra.AbsoluteConstraints(570, 320, 100, 30));
        jPanelProvinces.add(jButtonProvinceUpdate, new org.netbeans.lib.awtextra.AbsoluteConstraints(570, 360, 100, 30));
        jPanelProvinces.add(jButtonProvinceDelete, new org.netbeans.lib.awtextra.AbsoluteConstraints(680, 360, 100, 30));

        // Panel de Cantones
        jPanelCantons.add(jLabelCantonProvince, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 320, -1, -1));
        jPanelCantons.add(jComboBoxCantonProvince, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 320, 200, -1));
        jPanelCantons.add(jLabelCantonName, new org.netbeans.lib.awtextra.AbsoluteConstraints(290, 320, -1, -1));
        jPanelCantons.add(jTextFieldCantonName, new org.netbeans.lib.awtextra.AbsoluteConstraints(350, 320, 200, -1));
        jPanelCantons.add(jButtonCantonSave, new org.netbeans.lib.awtextra.AbsoluteConstraints(570, 320, 100, 30));
        jPanelCantons.add(jButtonCantonUpdate, new org.netbeans.lib.awtextra.AbsoluteConstraints(570, 360, 100, 30));
        jPanelCantons.add(jButtonCantonDelete, new org.netbeans.lib.awtextra.AbsoluteConstraints(680, 360, 100, 30));

        // Panel de Distritos
        jPanelDistricts.add(jLabelDistrictCanton, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 320, -1, -1));
        jPanelDistricts.add(jComboBoxDistrictCanton, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 320, 200, -1));
        jPanelDistricts.add(jLabelDistrictName, new org.netbeans.lib.awtextra.AbsoluteConstraints(290, 320, -1, -1));
        jPanelDistricts.add(jTextFieldDistrictName, new org.netbeans.lib.awtextra.AbsoluteConstraints(350, 320, 200, -1));
        jPanelDistricts.add(jButtonDistrictSave, new org.netbeans.lib.awtextra.AbsoluteConstraints(570, 320, 100, 30));
        jPanelDistricts.add(jButtonDistrictUpdate, new org.netbeans.lib.awtextra.AbsoluteConstraints(570, 360, 100, 30));
        jPanelDistricts.add(jButtonDistrictDelete, new org.netbeans.lib.awtextra.AbsoluteConstraints(680, 360, 100, 30));

        // Agregar listeners para actualizar los ComboBoxes dependientes
        jComboBoxProvinceCountry.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                loadProvinceComboBox();
            }
        });

        jComboBoxCantonProvince.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                loadCantonComboBox();
            }
        });
    }

    private void loadAllData() {
        loadCountries();
        loadProvinces();
        loadCantons();
        loadDistricts();
        loadComboBoxes();
    }

    private void loadCountries() {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.get_all_countries()}");
             ResultSet rs = cstmt.executeQuery()) {
            
            countryTableModel.setRowCount(0);
            while (rs.next()) {
                countryTableModel.addRow(new Object[]{
                    rs.getLong("id"),
                    rs.getString("name")
                });
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al cargar países: " + e.getMessage(), 
                "Error de Carga", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void loadProvinces() {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.get_all_provinces()}");
             ResultSet rs = cstmt.executeQuery()) {
            
            provinceTableModel.setRowCount(0);
            while (rs.next()) {
                provinceTableModel.addRow(new Object[]{
                    rs.getLong("id"),
                    rs.getString("country_name"),
                    rs.getString("name")
                });
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al cargar provincias: " + e.getMessage(), 
                "Error de Carga", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void loadCantons() {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.get_all_cantons()}");
             ResultSet rs = cstmt.executeQuery()) {
            
            cantonTableModel.setRowCount(0);
            while (rs.next()) {
                cantonTableModel.addRow(new Object[]{
                    rs.getLong("id"),
                    rs.getString("province_name"),
                    rs.getString("name")
                });
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al cargar cantones: " + e.getMessage(), 
                "Error de Carga", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void loadDistricts() {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.get_all_districts()}");
             ResultSet rs = cstmt.executeQuery()) {
            
            districtTableModel.setRowCount(0);
            while (rs.next()) {
                districtTableModel.addRow(new Object[]{
                    rs.getLong("id"),
                    rs.getString("canton_name"),
                    rs.getString("name")
                });
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al cargar distritos: " + e.getMessage(), 
                "Error de Carga", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void clearCountryFields() {
        jTextFieldCountryName.setText("");
        selectedCountryId = null;
        jButtonCountryUpdate.setEnabled(false);
        jButtonCountryDelete.setEnabled(false);
        jButtonCountrySave.setEnabled(true);
    }

    private void clearProvinceFields() {
        jTextFieldProvinceName.setText("");
        selectedProvinceId = null;
        jButtonProvinceUpdate.setEnabled(false);
        jButtonProvinceDelete.setEnabled(false);
        jButtonProvinceSave.setEnabled(true);
        jComboBoxProvinceCountry.setSelectedIndex(-1);
    }

    private void clearCantonFields() {
        jTextFieldCantonName.setText("");
        selectedCantonId = null;
        jButtonCantonUpdate.setEnabled(false);
        jButtonCantonDelete.setEnabled(false);
        jButtonCantonSave.setEnabled(true);
        jComboBoxCantonProvince.setSelectedIndex(-1);
    }

    private void clearDistrictFields() {
        jTextFieldDistrictName.setText("");
        selectedDistrictId = null;
        jButtonDistrictUpdate.setEnabled(false);
        jButtonDistrictDelete.setEnabled(false);
        jButtonDistrictSave.setEnabled(true);
        jComboBoxDistrictCanton.setSelectedIndex(-1);
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {
        jTabbedPane1 = new javax.swing.JTabbedPane();
        jPanelCountries = new javax.swing.JPanel();
        jScrollPaneCountries = new javax.swing.JScrollPane();
        jTableCountries = new javax.swing.JTable();
        jLabelCountryName = new javax.swing.JLabel();
        jTextFieldCountryName = new javax.swing.JTextField();
        jButtonCountrySave = new javax.swing.JButton();
        jButtonCountryUpdate = new javax.swing.JButton();
        jButtonCountryDelete = new javax.swing.JButton();
        jPanelProvinces = new javax.swing.JPanel();
        jScrollPaneProvinces = new javax.swing.JScrollPane();
        jTableProvinces = new javax.swing.JTable();
        jLabelProvinceName = new javax.swing.JLabel();
        jTextFieldProvinceName = new javax.swing.JTextField();
        jButtonProvinceSave = new javax.swing.JButton();
        jButtonProvinceUpdate = new javax.swing.JButton();
        jButtonProvinceDelete = new javax.swing.JButton();
        jPanelCantons = new javax.swing.JPanel();
        jScrollPaneCantons = new javax.swing.JScrollPane();
        jTableCantons = new javax.swing.JTable();
        jLabelCantonName = new javax.swing.JLabel();
        jTextFieldCantonName = new javax.swing.JTextField();
        jButtonCantonSave = new javax.swing.JButton();
        jButtonCantonUpdate = new javax.swing.JButton();
        jButtonCantonDelete = new javax.swing.JButton();
        jPanelDistricts = new javax.swing.JPanel();
        jScrollPaneDistricts = new javax.swing.JScrollPane();
        jTableDistricts = new javax.swing.JTable();
        jLabelDistrictName = new javax.swing.JLabel();
        jTextFieldDistrictName = new javax.swing.JTextField();
        jButtonDistrictSave = new javax.swing.JButton();
        jButtonDistrictUpdate = new javax.swing.JButton();
        jButtonDistrictDelete = new javax.swing.JButton();

        setPreferredSize(new java.awt.Dimension(800, 600));

        // Panel de Países
        jPanelCountries.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jTableCountries.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "Nombre"
            }
        ));
        jTableCountries.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jTableCountriesMouseClicked(evt);
            }
        });
        jScrollPaneCountries.setViewportView(jTableCountries);
        jPanelCountries.add(jScrollPaneCountries, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 10, 760, 300));

        jLabelCountryName.setText("Nombre:");
        jPanelCountries.add(jLabelCountryName, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 320, -1, -1));

        jTextFieldCountryName.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextFieldCountryNameActionPerformed(evt);
            }
        });
        jPanelCountries.add(jTextFieldCountryName, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 320, 200, -1));

        jButtonCountrySave.setText("Guardar");
        jButtonCountrySave.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonCountrySaveActionPerformed(evt);
            }
        });
        jPanelCountries.add(jButtonCountrySave, new org.netbeans.lib.awtextra.AbsoluteConstraints(290, 320, -1, -1));

        jButtonCountryUpdate.setText("Actualizar");
        jButtonCountryUpdate.setEnabled(false);
        jButtonCountryUpdate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonCountryUpdateActionPerformed(evt);
            }
        });
        jPanelCountries.add(jButtonCountryUpdate, new org.netbeans.lib.awtextra.AbsoluteConstraints(380, 320, -1, -1));

        jButtonCountryDelete.setText("Eliminar");
        jButtonCountryDelete.setEnabled(false);
        jButtonCountryDelete.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonCountryDeleteActionPerformed(evt);
            }
        });
        jPanelCountries.add(jButtonCountryDelete, new org.netbeans.lib.awtextra.AbsoluteConstraints(480, 320, -1, -1));

        jTabbedPane1.addTab("Países", jPanelCountries);

        // Panel de Provincias
        jPanelProvinces.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jTableProvinces.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "País", "Nombre"
            }
        ));
        jTableProvinces.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jTableProvincesMouseClicked(evt);
            }
        });
        jScrollPaneProvinces.setViewportView(jTableProvinces);
        jPanelProvinces.add(jScrollPaneProvinces, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 10, 760, 300));

        jLabelProvinceName.setText("Nombre:");
        jPanelProvinces.add(jLabelProvinceName, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 320, -1, -1));

        jTextFieldProvinceName.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextFieldProvinceNameActionPerformed(evt);
            }
        });
        jPanelProvinces.add(jTextFieldProvinceName, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 320, 200, -1));

        jButtonProvinceSave.setText("Guardar");
        jButtonProvinceSave.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonProvinceSaveActionPerformed(evt);
            }
        });
        jPanelProvinces.add(jButtonProvinceSave, new org.netbeans.lib.awtextra.AbsoluteConstraints(290, 320, -1, -1));

        jButtonProvinceUpdate.setText("Actualizar");
        jButtonProvinceUpdate.setEnabled(false);
        jButtonProvinceUpdate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonProvinceUpdateActionPerformed(evt);
            }
        });
        jPanelProvinces.add(jButtonProvinceUpdate, new org.netbeans.lib.awtextra.AbsoluteConstraints(380, 320, -1, -1));

        jButtonProvinceDelete.setText("Eliminar");
        jButtonProvinceDelete.setEnabled(false);
        jButtonProvinceDelete.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonProvinceDeleteActionPerformed(evt);
            }
        });
        jPanelProvinces.add(jButtonProvinceDelete, new org.netbeans.lib.awtextra.AbsoluteConstraints(480, 320, -1, -1));

        jTabbedPane1.addTab("Provincias", jPanelProvinces);

        // Panel de Cantones
        jPanelCantons.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jTableCantons.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "Provincia", "Nombre"
            }
        ));
        jTableCantons.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jTableCantonsMouseClicked(evt);
            }
        });
        jScrollPaneCantons.setViewportView(jTableCantons);
        jPanelCantons.add(jScrollPaneCantons, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 10, 760, 300));

        jLabelCantonName.setText("Nombre:");
        jPanelCantons.add(jLabelCantonName, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 320, -1, -1));

        jTextFieldCantonName.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextFieldCantonNameActionPerformed(evt);
            }
        });
        jPanelCantons.add(jTextFieldCantonName, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 320, 200, -1));

        jButtonCantonSave.setText("Guardar");
        jButtonCantonSave.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonCantonSaveActionPerformed(evt);
            }
        });
        jPanelCantons.add(jButtonCantonSave, new org.netbeans.lib.awtextra.AbsoluteConstraints(290, 320, -1, -1));

        jButtonCantonUpdate.setText("Actualizar");
        jButtonCantonUpdate.setEnabled(false);
        jButtonCantonUpdate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonCantonUpdateActionPerformed(evt);
            }
        });
        jPanelCantons.add(jButtonCantonUpdate, new org.netbeans.lib.awtextra.AbsoluteConstraints(380, 320, -1, -1));

        jButtonCantonDelete.setText("Eliminar");
        jButtonCantonDelete.setEnabled(false);
        jButtonCantonDelete.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonCantonDeleteActionPerformed(evt);
            }
        });
        jPanelCantons.add(jButtonCantonDelete, new org.netbeans.lib.awtextra.AbsoluteConstraints(480, 320, -1, -1));

        jTabbedPane1.addTab("Cantones", jPanelCantons);

        // Panel de Distritos
        jPanelDistricts.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jTableDistricts.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {},
            new String [] {
                "ID", "Cantón", "Nombre"
            }
        ));
        jTableDistricts.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jTableDistrictsMouseClicked(evt);
            }
        });
        jScrollPaneDistricts.setViewportView(jTableDistricts);
        jPanelDistricts.add(jScrollPaneDistricts, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 10, 760, 300));

        jLabelDistrictName.setText("Nombre:");
        jPanelDistricts.add(jLabelDistrictName, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 320, -1, -1));

        jTextFieldDistrictName.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextFieldDistrictNameActionPerformed(evt);
            }
        });
        jPanelDistricts.add(jTextFieldDistrictName, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 320, 200, -1));

        jButtonDistrictSave.setText("Guardar");
        jButtonDistrictSave.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonDistrictSaveActionPerformed(evt);
            }
        });
        jPanelDistricts.add(jButtonDistrictSave, new org.netbeans.lib.awtextra.AbsoluteConstraints(290, 320, -1, -1));

        jButtonDistrictUpdate.setText("Actualizar");
        jButtonDistrictUpdate.setEnabled(false);
        jButtonDistrictUpdate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonDistrictUpdateActionPerformed(evt);
            }
        });
        jPanelDistricts.add(jButtonDistrictUpdate, new org.netbeans.lib.awtextra.AbsoluteConstraints(380, 320, -1, -1));

        jButtonDistrictDelete.setText("Eliminar");
        jButtonDistrictDelete.setEnabled(false);
        jButtonDistrictDelete.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonDistrictDeleteActionPerformed(evt);
            }
        });
        jPanelDistricts.add(jButtonDistrictDelete, new org.netbeans.lib.awtextra.AbsoluteConstraints(480, 320, -1, -1));

        jTabbedPane1.addTab("Distritos", jPanelDistricts);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jTabbedPane1)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jTabbedPane1)
        );
    }// </editor-fold>//GEN-END:initComponents

    private void jTextFieldCountryNameActionPerformed(java.awt.event.ActionEvent evt) {
        // TODO add your handling code here:
    }

    private void jTextFieldProvinceNameActionPerformed(java.awt.event.ActionEvent evt) {
        // TODO add your handling code here:
    }

    private void jTextFieldCantonNameActionPerformed(java.awt.event.ActionEvent evt) {
        // TODO add your handling code here:
    }

    private void jTextFieldDistrictNameActionPerformed(java.awt.event.ActionEvent evt) {
        // TODO add your handling code here:
    }

    private void jTableCountriesMouseClicked(java.awt.event.MouseEvent evt) {
        int selectedRow = jTableCountries.getSelectedRow();
        if (selectedRow >= 0) {
            selectedCountryId = (Long) countryTableModel.getValueAt(selectedRow, 0);
            String selectedName = (String) countryTableModel.getValueAt(selectedRow, 1);

            jTextFieldCountryName.setText(selectedName);

            jButtonCountrySave.setEnabled(false);
            jButtonCountryUpdate.setEnabled(true);
            jButtonCountryDelete.setEnabled(true);
        } else {
            clearCountryFields();
        }
    }

    private void jTableProvincesMouseClicked(java.awt.event.MouseEvent evt) {
        int selectedRow = jTableProvinces.getSelectedRow();
        if (selectedRow >= 0) {
            selectedProvinceId = (Long) provinceTableModel.getValueAt(selectedRow, 0);
            String selectedName = (String) provinceTableModel.getValueAt(selectedRow, 2);
            String countryName = (String) provinceTableModel.getValueAt(selectedRow, 1);

            jTextFieldProvinceName.setText(selectedName);

            jComboBoxProvinceCountry.setSelectedItem(countryName);

            jButtonProvinceSave.setEnabled(false);
            jButtonProvinceUpdate.setEnabled(true);
            jButtonProvinceDelete.setEnabled(true);
        } else {
            clearProvinceFields();
        }
    }

    private void jTableCantonsMouseClicked(java.awt.event.MouseEvent evt) {
        int selectedRow = jTableCantons.getSelectedRow();
        if (selectedRow >= 0) {
            selectedCantonId = (Long) cantonTableModel.getValueAt(selectedRow, 0);
            String selectedName = (String) cantonTableModel.getValueAt(selectedRow, 2);
            String provinceName = (String) cantonTableModel.getValueAt(selectedRow, 1);

            jTextFieldCantonName.setText(selectedName);

            populateProvincesForCantonCombo();
            jComboBoxCantonProvince.setSelectedItem(provinceName);

            loadCantonComboBox();

            jButtonCantonSave.setEnabled(false);
            jButtonCantonUpdate.setEnabled(true);
            jButtonCantonDelete.setEnabled(true);
        } else {
            clearCantonFields();
        }
    }

    private void jTableDistrictsMouseClicked(java.awt.event.MouseEvent evt) {
        int selectedRow = jTableDistricts.getSelectedRow();
        if (selectedRow >= 0) {
            selectedDistrictId = (Long) districtTableModel.getValueAt(selectedRow, 0);
            String selectedName = (String) districtTableModel.getValueAt(selectedRow, 2);
            String cantonName = (String) districtTableModel.getValueAt(selectedRow, 1);

            jTextFieldDistrictName.setText(selectedName);

            String provinceName = getProvinceNameByCanton(cantonName);

            populateProvincesForCantonCombo();
            if (provinceName != null) {
                jComboBoxCantonProvince.setSelectedItem(provinceName);
            }

            loadCantonComboBox();

            jComboBoxDistrictCanton.setSelectedItem(cantonName);

            jButtonDistrictSave.setEnabled(false);
            jButtonDistrictUpdate.setEnabled(true);
            jButtonDistrictDelete.setEnabled(true);
        } else {
            clearDistrictFields();
        }
    }

    private void jButtonCountrySaveActionPerformed(java.awt.event.ActionEvent evt) {
        String name = jTextFieldCountryName.getText().trim();
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El nombre del país no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.create_country(?)}")) {
            
            cstmt.setString(1, name);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "País registrado exitosamente.");
            loadCountries();
            clearCountryFields();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al guardar país: " + e.getMessage(), 
                "Error de Guardado", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonCountryUpdateActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedCountryId == null) {
            JOptionPane.showMessageDialog(this, "Por favor seleccione un país para actualizar.", "Sin Selección", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String name = jTextFieldCountryName.getText().trim();
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El nombre del país no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.update_country_name(?, ?)}")) {
            
            cstmt.setLong(1, selectedCountryId);
            cstmt.setString(2, name);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "País actualizado exitosamente.");
            loadCountries();
            clearCountryFields();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al actualizar país: " + e.getMessage(), 
                "Error de Actualización", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonCountryDeleteActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedCountryId == null) {
            JOptionPane.showMessageDialog(this, "Por favor seleccione un país para eliminar.", "Sin Selección", JOptionPane.WARNING_MESSAGE);
            return;
        }

        int confirmation = JOptionPane.showConfirmDialog(this,
                "¿Está seguro que desea eliminar el país seleccionado?\n(ID: " + selectedCountryId + " - Nombre: " + jTextFieldCountryName.getText() + ")\n¡Esta acción no se puede deshacer!",
                "Confirmar Eliminación",
                JOptionPane.YES_NO_OPTION,
                JOptionPane.WARNING_MESSAGE);

        if (confirmation == JOptionPane.YES_OPTION) {
            try (Connection conn = DatabaseConnection.getConnection();
                 CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.delete_country(?)}")) {
                
                cstmt.setLong(1, selectedCountryId);
                cstmt.execute();
                
                JOptionPane.showMessageDialog(this, "País eliminado exitosamente.");
                loadCountries();
                clearCountryFields();
            } catch (SQLException e) {
                String errorMessage = e.getMessage();
                if (errorMessage.contains("ORA-20004")) {
                    JOptionPane.showMessageDialog(this, 
                        "No se puede eliminar el país porque tiene provincias asociadas.", 
                        "Error de Eliminación", 
                        JOptionPane.ERROR_MESSAGE);
                } else {
                    JOptionPane.showMessageDialog(this, 
                        "Error al eliminar país: " + errorMessage, 
                        "Error de Eliminación", 
                        JOptionPane.ERROR_MESSAGE);
                }
            }
        }
    }

    private void jButtonProvinceSaveActionPerformed(java.awt.event.ActionEvent evt) {
        String name = jTextFieldProvinceName.getText().trim();
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El nombre de la provincia no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String countryName = (String) jComboBoxProvinceCountry.getSelectedItem();
        if (countryName == null) {
            JOptionPane.showMessageDialog(this, "Debe seleccionar un país.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        Long countryId = getCountryIdByName(countryName);
        if (countryId == null) {
            JOptionPane.showMessageDialog(this, "Error al obtener el ID del país seleccionado.", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.create_province(?, ?)}")) {
            
            cstmt.setLong(1, countryId);
            cstmt.setString(2, name);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "Provincia registrada exitosamente.");
            loadProvinces();
            loadProvinceComboBox();
            clearProvinceFields();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al guardar provincia: " + e.getMessage(), 
                "Error de Guardado", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonProvinceUpdateActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedProvinceId == null) {
            JOptionPane.showMessageDialog(this, "Por favor seleccione una provincia para actualizar.", "Sin Selección", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String name = jTextFieldProvinceName.getText().trim();
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El nombre de la provincia no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String countryName = (String) jComboBoxProvinceCountry.getSelectedItem();
        if (countryName == null) {
            JOptionPane.showMessageDialog(this, "Debe seleccionar un país.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        Long countryId = getCountryIdByName(countryName);
        if (countryId == null) {
            JOptionPane.showMessageDialog(this, "Error al obtener el ID del país seleccionado.", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.update_province_name(?, ?, ?)}")) {
            
            cstmt.setLong(1, selectedProvinceId);
            cstmt.setLong(2, countryId);
            cstmt.setString(3, name);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "Provincia actualizada exitosamente.");
            loadProvinces();
            loadProvinceComboBox();
            clearProvinceFields();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al actualizar provincia: " + e.getMessage(), 
                "Error de Actualización", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonProvinceDeleteActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedProvinceId == null) {
            JOptionPane.showMessageDialog(this, "Por favor seleccione una provincia para eliminar.", "Sin Selección", JOptionPane.WARNING_MESSAGE);
            return;
        }

        int confirmation = JOptionPane.showConfirmDialog(this,
                "¿Está seguro que desea eliminar la provincia seleccionada?\n(ID: " + selectedProvinceId + " - Nombre: " + jTextFieldProvinceName.getText() + ")\n¡Esta acción no se puede deshacer!",
                "Confirmar Eliminación",
                JOptionPane.YES_NO_OPTION,
                JOptionPane.WARNING_MESSAGE);

        if (confirmation == JOptionPane.YES_OPTION) {
            try (Connection conn = DatabaseConnection.getConnection();
                 CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.delete_province(?)}")) {
                
                cstmt.setLong(1, selectedProvinceId);
                cstmt.execute();
                
                JOptionPane.showMessageDialog(this, "Provincia eliminada exitosamente.");
                loadProvinces();
                clearProvinceFields();
            } catch (SQLException e) {
                String errorMessage = e.getMessage();
                if (errorMessage.contains("ORA-20014")) {
                    JOptionPane.showMessageDialog(this, 
                        "No se puede eliminar la provincia porque tiene cantones asociados.", 
                        "Error de Eliminación", 
                        JOptionPane.ERROR_MESSAGE);
                } else {
                    JOptionPane.showMessageDialog(this, 
                        "Error al eliminar provincia: " + errorMessage, 
                        "Error de Eliminación", 
                        JOptionPane.ERROR_MESSAGE);
                }
            }
        }
    }

    private void jButtonCantonSaveActionPerformed(java.awt.event.ActionEvent evt) {
        String name = jTextFieldCantonName.getText().trim();
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El nombre del cantón no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String provinceName = (String) jComboBoxCantonProvince.getSelectedItem();
        if (provinceName == null) {
            JOptionPane.showMessageDialog(this, "Debe seleccionar una provincia.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        Long provinceId = getProvinceIdByName(provinceName);
        if (provinceId == null) {
            JOptionPane.showMessageDialog(this, "Error al obtener el ID de la provincia seleccionada.", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.create_canton(?, ?)}")) {
            
            cstmt.setLong(1, provinceId);
            cstmt.setString(2, name);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "Cantón registrado exitosamente.");
            loadCantons();
            loadCantonComboBox();
            clearCantonFields();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al guardar cantón: " + e.getMessage(), 
                "Error de Guardado", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonCantonUpdateActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedCantonId == null) {
            JOptionPane.showMessageDialog(this, "Por favor seleccione un cantón para actualizar.", "Sin Selección", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String name = jTextFieldCantonName.getText().trim();
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El nombre del cantón no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String provinceName = (String) jComboBoxCantonProvince.getSelectedItem();
        if (provinceName == null) {
            JOptionPane.showMessageDialog(this, "Debe seleccionar una provincia.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        Long provinceId = getProvinceIdByName(provinceName);
        if (provinceId == null) {
            JOptionPane.showMessageDialog(this, "Error al obtener el ID de la provincia seleccionada.", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.update_canton_name(?, ?, ?)}")) {
            
            cstmt.setLong(1, selectedCantonId);
            cstmt.setLong(2, provinceId);
            cstmt.setString(3, name);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "Cantón actualizado exitosamente.");
            loadCantons();
            loadCantonComboBox();
            clearCantonFields();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al actualizar cantón: " + e.getMessage(), 
                "Error de Actualización", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonCantonDeleteActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedCantonId == null) {
            JOptionPane.showMessageDialog(this, "Por favor seleccione un cantón para eliminar.", "Sin Selección", JOptionPane.WARNING_MESSAGE);
            return;
        }

        int confirmation = JOptionPane.showConfirmDialog(this,
                "¿Está seguro que desea eliminar el cantón seleccionado?\n(ID: " + selectedCantonId + " - Nombre: " + jTextFieldCantonName.getText() + ")\n¡Esta acción no se puede deshacer!",
                "Confirmar Eliminación",
                JOptionPane.YES_NO_OPTION,
                JOptionPane.WARNING_MESSAGE);

        if (confirmation == JOptionPane.YES_OPTION) {
            try (Connection conn = DatabaseConnection.getConnection();
                 CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.delete_canton(?)}")) {
                
                cstmt.setLong(1, selectedCantonId);
                cstmt.execute();
                
                JOptionPane.showMessageDialog(this, "Cantón eliminado exitosamente.");
                loadCantons();
                clearCantonFields();
            } catch (SQLException e) {
                String errorMessage = e.getMessage();
                if (errorMessage.contains("ORA-20024")) {
                    JOptionPane.showMessageDialog(this, 
                        "No se puede eliminar el cantón porque tiene distritos asociados.", 
                        "Error de Eliminación", 
                        JOptionPane.ERROR_MESSAGE);
                } else {
                    JOptionPane.showMessageDialog(this, 
                        "Error al eliminar cantón: " + errorMessage, 
                        "Error de Eliminación", 
                        JOptionPane.ERROR_MESSAGE);
                }
            }
        }
    }

    private void jButtonDistrictSaveActionPerformed(java.awt.event.ActionEvent evt) {
        String name = jTextFieldDistrictName.getText().trim();
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El nombre del distrito no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String cantonName = (String) jComboBoxDistrictCanton.getSelectedItem();
        if (cantonName == null) {
            JOptionPane.showMessageDialog(this, "Debe seleccionar un cantón.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        Long cantonId = getCantonIdByName(cantonName);
        if (cantonId == null) {
            JOptionPane.showMessageDialog(this, "Error al obtener el ID del cantón seleccionado.", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.create_district(?, ?)}")) {
            
            cstmt.setLong(1, cantonId);
            cstmt.setString(2, name);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "Distrito registrado exitosamente.");
            loadDistricts();
            clearDistrictFields();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al guardar distrito: " + e.getMessage(), 
                "Error de Guardado", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonDistrictUpdateActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedDistrictId == null) {
            JOptionPane.showMessageDialog(this, "Por favor seleccione un distrito para actualizar.", "Sin Selección", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String name = jTextFieldDistrictName.getText().trim();
        if (name.isEmpty()) {
            JOptionPane.showMessageDialog(this, "El nombre del distrito no puede estar vacío.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String cantonName = (String) jComboBoxDistrictCanton.getSelectedItem();
        if (cantonName == null) {
            JOptionPane.showMessageDialog(this, "Debe seleccionar un cantón.", "Entrada Inválida", JOptionPane.WARNING_MESSAGE);
            return;
        }

        Long cantonId = getCantonIdByName(cantonName);
        if (cantonId == null) {
            JOptionPane.showMessageDialog(this, "Error al obtener el ID del cantón seleccionado.", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.update_district_name(?, ?, ?)}")) {
            
            cstmt.setLong(1, selectedDistrictId);
            cstmt.setLong(2, cantonId);
            cstmt.setString(3, name);
            cstmt.execute();
            
            JOptionPane.showMessageDialog(this, "Distrito actualizado exitosamente.");
            loadDistricts();
            clearDistrictFields();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al actualizar distrito: " + e.getMessage(), 
                "Error de Actualización", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void jButtonDistrictDeleteActionPerformed(java.awt.event.ActionEvent evt) {
        if (selectedDistrictId == null) {
            JOptionPane.showMessageDialog(this, "Por favor seleccione un distrito para eliminar.", "Sin Selección", JOptionPane.WARNING_MESSAGE);
            return;
        }

        int confirmation = JOptionPane.showConfirmDialog(this,
                "¿Está seguro que desea eliminar el distrito seleccionado?\n(ID: " + selectedDistrictId + " - Nombre: " + jTextFieldDistrictName.getText() + ")\n¡Esta acción no se puede deshacer!",
                "Confirmar Eliminación",
                JOptionPane.YES_NO_OPTION,
                JOptionPane.WARNING_MESSAGE);

        if (confirmation == JOptionPane.YES_OPTION) {
            try (Connection conn = DatabaseConnection.getConnection();
                 CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.delete_district(?)}")) {
                
                cstmt.setLong(1, selectedDistrictId);
                cstmt.execute();
                
                JOptionPane.showMessageDialog(this, "Distrito eliminado exitosamente.");
                loadDistricts();
                clearDistrictFields();
            } catch (SQLException e) {
                String errorMessage = e.getMessage();
                if (errorMessage.contains("ORA-20034")) {
                    JOptionPane.showMessageDialog(this, 
                        "No se puede eliminar el distrito porque está siendo utilizado en waypoints.", 
                        "Error de Eliminación", 
                        JOptionPane.ERROR_MESSAGE);
                } else {
                    JOptionPane.showMessageDialog(this, 
                        "Error al eliminar distrito: " + errorMessage, 
                        "Error de Eliminación", 
                        JOptionPane.ERROR_MESSAGE);
                }
            }
        }
    }

    private void loadComboBoxes() {
        loadCountryComboBox();
        loadProvinceComboBox();
        loadCantonComboBox();
    }

    private void loadCountryComboBox() {
        jComboBoxProvinceCountry.removeAllItems();
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.get_all_countries()}");
             ResultSet rs = cstmt.executeQuery()) {
            
            while (rs.next()) {
                jComboBoxProvinceCountry.addItem(rs.getString("name"));
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al cargar países: " + e.getMessage(), 
                "Error de Carga", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void loadProvinceComboBox() {
        jComboBoxCantonProvince.removeAllItems();
        String selectedCountry = (String) jComboBoxProvinceCountry.getSelectedItem();
        if (selectedCountry == null) return;

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.get_provinces_by_country(?)}")) {
            
            Long countryId = getCountryIdByName(selectedCountry);
            if (countryId == null) {
                return;
            }
            cstmt.setLong(1, countryId);
            ResultSet rs = cstmt.executeQuery();
            
            while (rs.next()) {
                jComboBoxCantonProvince.addItem(rs.getString("name"));
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al cargar provincias: " + e.getMessage(), 
                "Error de Carga", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private void loadCantonComboBox() {
        jComboBoxDistrictCanton.removeAllItems();
        String selectedProvince = (String) jComboBoxCantonProvince.getSelectedItem();
        if (selectedProvince == null) return;

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.get_cantons_by_province(?)}")) {
            
            cstmt.setLong(1, getProvinceIdByName(selectedProvince));
            ResultSet rs = cstmt.executeQuery();
            
            while (rs.next()) {
                jComboBoxDistrictCanton.addItem(rs.getString("name"));
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al cargar cantones: " + e.getMessage(), 
                "Error de Carga", 
                JOptionPane.ERROR_MESSAGE);
        }
    }

    private Long getCountryIdByName(String name) {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.get_country_by_name(?)}")) {
            
            cstmt.setString(1, name);
            ResultSet rs = cstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getLong("id");
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al obtener ID del país: " + e.getMessage(), 
                "Error", 
                JOptionPane.ERROR_MESSAGE);
        }
        return null;
    }

    private Long getProvinceIdByName(String name) {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.get_province_by_name(?)}")) {
            
            cstmt.setString(1, name);
            ResultSet rs = cstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getLong("id");
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al obtener ID de la provincia: " + e.getMessage(), 
                "Error", 
                JOptionPane.ERROR_MESSAGE);
        }
        return null;
    }

    private Long getCantonIdByName(String name) {
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.get_canton_by_name(?)}")) {
            
            cstmt.setString(1, name);
            ResultSet rs = cstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getLong("id");
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, 
                "Error al obtener ID del cantón: " + e.getMessage(), 
                "Error", 
                JOptionPane.ERROR_MESSAGE);
        }
        return null;
    }

    /**
     * Llena el combo de provincias (panel Cantones) con todas las provincias existentes.
     */
    private void populateProvincesForCantonCombo() {
        jComboBoxCantonProvince.removeAllItems();
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cstmt = conn.prepareCall("{call carpooling_adm.get_all_provinces()}");
             ResultSet rs = cstmt.executeQuery()) {

            while (rs.next()) {
                jComboBoxCantonProvince.addItem(rs.getString("name"));
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this,
                "Error al cargar provincias: " + e.getMessage(),
                "Error de Carga",
                JOptionPane.ERROR_MESSAGE);
        }
    }

    /**
     * Busca en el modelo de cantones el nombre de la provincia a la que pertenece un cantón.
     * @param cantonName Nombre del cantón
     * @return Nombre de la provincia o null si no se encuentra
     */
    private String getProvinceNameByCanton(String cantonName) {
        for (int i = 0; i < cantonTableModel.getRowCount(); i++) {
            String name = (String) cantonTableModel.getValueAt(i, 2); // columna "Nombre"
            if (cantonName.equals(name)) {
                return (String) cantonTableModel.getValueAt(i, 1); // columna "Provincia"
            }
        }
        return null;
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButtonCantonDelete;
    private javax.swing.JButton jButtonCantonSave;
    private javax.swing.JButton jButtonCantonUpdate;
    private javax.swing.JButton jButtonCountryDelete;
    private javax.swing.JButton jButtonCountrySave;
    private javax.swing.JButton jButtonCountryUpdate;
    private javax.swing.JButton jButtonDistrictDelete;
    private javax.swing.JButton jButtonDistrictSave;
    private javax.swing.JButton jButtonDistrictUpdate;
    private javax.swing.JButton jButtonProvinceDelete;
    private javax.swing.JButton jButtonProvinceSave;
    private javax.swing.JButton jButtonProvinceUpdate;
    private javax.swing.JLabel jLabelCantonName;
    private javax.swing.JLabel jLabelCountryName;
    private javax.swing.JLabel jLabelDistrictName;
    private javax.swing.JLabel jLabelProvinceName;
    private javax.swing.JPanel jPanelCantons;
    private javax.swing.JPanel jPanelCountries;
    private javax.swing.JPanel jPanelDistricts;
    private javax.swing.JPanel jPanelProvinces;
    private javax.swing.JScrollPane jScrollPaneCantons;
    private javax.swing.JScrollPane jScrollPaneCountries;
    private javax.swing.JScrollPane jScrollPaneDistricts;
    private javax.swing.JScrollPane jScrollPaneProvinces;
    private javax.swing.JTabbedPane jTabbedPane1;
    private javax.swing.JTable jTableCantons;
    private javax.swing.JTable jTableCountries;
    private javax.swing.JTable jTableDistricts;
    private javax.swing.JTable jTableProvinces;
    private javax.swing.JTextField jTextFieldCantonName;
    private javax.swing.JTextField jTextFieldCountryName;
    private javax.swing.JTextField jTextFieldDistrictName;
    private javax.swing.JTextField jTextFieldProvinceName;
    // End of variables declaration//GEN-END:variables
} 