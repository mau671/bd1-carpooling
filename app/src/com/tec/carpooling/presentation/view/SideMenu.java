/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import javax.swing.*;
import java.awt.*;
/**
 *
 * @author hidal
 */
public class SideMenu {

    public static JToolBar createToolbar(JFrame parentFrame, String userRole) {
        Color menuBlue = new Color(18, 102, 160);
        JToolBar toolBar = new JToolBar(JToolBar.VERTICAL);
        toolBar.setFloatable(false);
        toolBar.setBackground(menuBlue);
        toolBar.setOpaque(true);

        // Buttons with emojis in labels
        JButton profileButton = createStyledButton("👤 User Profile", menuBlue);
        JButton vehicleInfoButton = createStyledButton("🚗 Registered Vehicles", menuBlue);
        JButton tripButton = createStyledButton("📅 Trips Created", menuBlue);
        JButton searchTripButton = createStyledButton("🔍 Search for Trips", menuBlue);
        JButton tripBookedButton = createStyledButton("🎫 Trips Booked", menuBlue);
        JButton logButton = createStyledButton("📄 Activity Log", menuBlue);
        JButton switchRoleButton = createStyledButton("", menuBlue);
        JButton logoutButton = createStyledButton("🔒 Log Out", menuBlue);

        // Add buttons with spacing
        toolBar.add(profileButton);
        toolBar.add(Box.createVerticalStrut(10));

        if (userRole.equals("Passenger")) {
            toolBar.add(tripBookedButton);
            toolBar.add(Box.createVerticalStrut(10));
            toolBar.add(searchTripButton);
            toolBar.add(Box.createVerticalStrut(10));
            switchRoleButton.setText("🔁 Switch to Driver");
        } else if (userRole.equals("Driver")) {
            toolBar.add(vehicleInfoButton);
            toolBar.add(Box.createVerticalStrut(10));
            toolBar.add(tripButton);
            toolBar.add(Box.createVerticalStrut(10));
            switchRoleButton.setText("🔁 Switch to Passenger");
        }

        toolBar.add(logButton);
        toolBar.add(Box.createVerticalStrut(10));
        toolBar.add(switchRoleButton);
        toolBar.add(Box.createVerticalStrut(10));
        toolBar.add(logoutButton);

        // ActionListeners
        profileButton.addActionListener(e -> {
            UserProfile profile = new UserProfile(userRole);
            profile.setExtendedState(JFrame.MAXIMIZED_BOTH);
            profile.setVisible(true);
            parentFrame.dispose();
        });

        tripBookedButton.addActionListener(e -> {
            TripBooked search = new TripBooked(userRole);
            search.setExtendedState(JFrame.MAXIMIZED_BOTH);
            search.setVisible(true);
            parentFrame.dispose();
        });

        searchTripButton.addActionListener(e -> {
            SearchTrip search = new SearchTrip(userRole);
            search.setExtendedState(JFrame.MAXIMIZED_BOTH);
            search.setVisible(true);
            parentFrame.dispose();
        });

        vehicleInfoButton.addActionListener(e -> {
            RegisteredVehicle vehicle = new RegisteredVehicle(userRole);
            vehicle.setExtendedState(JFrame.MAXIMIZED_BOTH);
            vehicle.setVisible(true);
            parentFrame.dispose();
        });

        tripButton.addActionListener(e -> {
            ViewTrip trips = new ViewTrip(userRole);
            trips.setExtendedState(JFrame.MAXIMIZED_BOTH);
            trips.setVisible(true);
            parentFrame.dispose();
        });

        logButton.addActionListener(e -> {
            UserLog log = new UserLog(userRole);
            log.setExtendedState(JFrame.MAXIMIZED_BOTH);
            log.setVisible(true);
            parentFrame.dispose();
        });

        logoutButton.addActionListener(e -> {
            InitialPage home = new InitialPage();
            home.setExtendedState(JFrame.MAXIMIZED_BOTH);
            home.setVisible(true);
            parentFrame.dispose();
        });

        switchRoleButton.addActionListener(e -> {
            String newRole = userRole.equals("Passenger") ? "Driver" : "Passenger";
            UserProfile profile = new UserProfile(newRole);
            profile.setExtendedState(JFrame.MAXIMIZED_BOTH);
            profile.setVisible(true);
            parentFrame.dispose();
        });

        return toolBar;
    }

    private static JButton createStyledButton(String text, Color bg) {
        JButton button = new JButton(text);
        button.setBackground(bg);
        button.setForeground(Color.WHITE);
        button.setFocusPainted(false);
        button.setBorderPainted(false);
        button.setOpaque(true);
        button.setAlignmentX(Component.CENTER_ALIGNMENT);
        button.setMargin(new Insets(12, 20, 12, 20));
        button.setFont(new Font("Dialog", Font.PLAIN, 14)); // Ensure emoji font support
        return button;
    }
}