package com.tec.carpooling.presentation.view.admin;

import com.tec.carpooling.data.connection.DatabaseConnection;
import java.awt.BorderLayout;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.swing.JButton;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

public class ReportsPanel extends JPanel {
    private JTable table;
    private DefaultTableModel model;
    private JButton btnRefresh;
    private Connection connection;

    public ReportsPanel() {
        initUI();
        try {
            connection = DatabaseConnection.getConnection();
            loadReports();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "DB error: " + ex.getMessage());
        }
    }

    private void initUI() {
        setLayout(new BorderLayout());
        model = new DefaultTableModel(new Object[]{
            "ID", "Institution", "Report Date", "Trips", "Passengers", "Revenue"}, 0) {
            public boolean isCellEditable(int r,int c){return false;}
        };
        table = new JTable(model);
        add(new JScrollPane(table), BorderLayout.CENTER);
        btnRefresh = new JButton("Refresh");
        btnRefresh.addActionListener(e -> loadReports());
        JPanel top = new JPanel();
        top.add(btnRefresh);
        add(top, BorderLayout.NORTH);
    }

    private void loadReports() {
        model.setRowCount(0);
        try (Statement st = connection.createStatement();
             ResultSet rs = st.executeQuery("SELECT ir.id, i.name, ir.report_date, ir.total_trips, ir.total_passengers, ir.total_revenue " +
                     "FROM carpooling_adm.INSTITUTION_REPORT ir " +
                     "JOIN carpooling_adm.INSTITUTION i ON ir.institution_id = i.id " +
                     "ORDER BY ir.report_date DESC, ir.id DESC")) {
            while (rs.next()) {
                model.addRow(new Object[]{rs.getLong(1), rs.getString(2), rs.getDate(3), rs.getInt(4), rs.getInt(5), rs.getBigDecimal(6)});
            }
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "Error loading reports: " + ex.getMessage());
        }
    }
} 