package com.tec.carpooling.presentation.view.admin;

import com.tec.carpooling.data.connection.DatabaseConnection;
import java.awt.BorderLayout;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Types;
import javax.swing.JPanel;
import javax.swing.JComboBox;
import javax.swing.JButton;
import javax.swing.JOptionPane;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;

/**
 * StatisticsPanel - muestra gráficas basadas en los procedimientos de 07_Statistics.sql
 */
public class StatisticsPanel extends javax.swing.JPanel {
    private Connection connection;
    private JComboBox<String> combo;
    private JButton btn;
    private JPanel chartContainer;

    public StatisticsPanel() {
        initComponents();
        try {
            connection = DatabaseConnection.getConnection();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Error DB: " + e.getMessage());
        }
    }

    private void initComponents() {
        setLayout(new BorderLayout());
        combo = new JComboBox<>(new String[]{
            "Drivers by gender", "Passengers by gender", "Users by age range", "Trips per month"});
        btn = new JButton("Generate");
        btn.addActionListener(e -> generateChart());
        JPanel top = new JPanel();
        top.add(combo);
        top.add(btn);
        add(top, BorderLayout.NORTH);
        chartContainer = new JPanel(new BorderLayout());
        add(chartContainer, BorderLayout.CENTER);
    }

    private void generateChart() {
        int sel = combo.getSelectedIndex();
        switch (sel) {
            case 0: // Drivers by gender
                showPieChart("Drivers by Gender", "get_drivers_by_gender");
                break;
            case 1: // Passengers by gender
                showPieChart("Passengers by Gender", "get_passengers_by_gender");
                break;
            case 2: // Users by age range
                showBarChartAge();
                break;
            case 3: // Trips per month
                showBarChartTrips();
                break;
        }
    }

    private void showPieChart(String title, String procedure) {
        try (CallableStatement cs = connection.prepareCall("{call " + procedure + "(?,?,?)}")) {
            cs.setInt(1, 1); // institution_id hard-coded ejemplo
            cs.setNull(2, Types.DATE);
            cs.setNull(3, Types.DATE);
            ResultSet rs = cs.executeQuery();
            DefaultPieDataset<String> ds = new DefaultPieDataset<>();
            while (rs.next()) {
                ds.setValue(rs.getString(1), rs.getInt(2));
            }
            JFreeChart chart = ChartFactory.createPieChart(title, ds, true, true, false);
            updateChart(chart);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
        }
    }

    private void showBarChartAge() {
        try (CallableStatement cs = connection.prepareCall("{call get_users_by_age_range(?)}")) {
            cs.setNull(1, Types.INTEGER);
            ResultSet rs = cs.executeQuery();
            DefaultCategoryDataset ds = new DefaultCategoryDataset();
            while (rs.next()) {
                String gender = rs.getString(1);
                String range = rs.getString(2);
                int total = rs.getInt(3);
                ds.addValue(total, gender, range);
            }
            JFreeChart chart = ChartFactory.createBarChart("Users by Age Range", "Age Range", "Users", ds);
            updateChart(chart);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
        }
    }

    private void showBarChartTrips() {
        try (CallableStatement cs = connection.prepareCall("{call get_total_trips_per_month()}")) {
            ResultSet rs = cs.executeQuery();
            DefaultCategoryDataset ds = new DefaultCategoryDataset();
            while (rs.next()) {
                String month = rs.getString(1);
                int total = rs.getInt(2);
                ds.addValue(total, "Trips", month);
            }
            JFreeChart chart = ChartFactory.createBarChart("Trips per Month", "Month", "Trips", ds);
            updateChart(chart);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
        }
    }

    private void updateChart(JFreeChart chart) {
        chartContainer.removeAll();
        chartContainer.add(new ChartPanel(chart), BorderLayout.CENTER);
        chartContainer.validate();
    }
} 