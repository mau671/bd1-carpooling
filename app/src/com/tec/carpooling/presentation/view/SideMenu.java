/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import com.tec.carpooling.domain.entity.User;
import com.tec.carpooling.business.service.UserTypeService;
import com.tec.carpooling.business.service.impl.UserTypeServiceImpl;

import javax.swing.*;
import java.awt.*;
import java.sql.SQLException;
/**
 *
 * @author hidal
 */
public class SideMenu {

    public static JToolBar createToolbar(JFrame parentFrame, String userRole, User user) {
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
        toolBar.add(switchRoleButton);
        toolBar.add(Box.createVerticalStrut(10));
        toolBar.add(logoutButton);
        

        // ActionListeners
        profileButton.addActionListener(e -> {
            UserProfile profile = new UserProfile(userRole, user);
            profile.setExtendedState(JFrame.MAXIMIZED_BOTH);
            profile.setVisible(true);
            parentFrame.dispose();
        });

        tripBookedButton.addActionListener(e -> {
            TripBooked search = new TripBooked(userRole, user);
            search.setExtendedState(JFrame.MAXIMIZED_BOTH);
            search.setVisible(true);
            parentFrame.dispose();
        });

        searchTripButton.addActionListener(e -> {
            SearchTrip search = new SearchTrip(userRole, user);
            search.setExtendedState(JFrame.MAXIMIZED_BOTH);
            search.setVisible(true);
            parentFrame.dispose();
        });

        vehicleInfoButton.addActionListener(e -> {
            RegisteredVehicle vehicle = new RegisteredVehicle(userRole, user);
            vehicle.setExtendedState(JFrame.MAXIMIZED_BOTH);
            vehicle.setVisible(true);
            parentFrame.dispose();
        });

        tripButton.addActionListener(e -> {
            ViewTrip trips = new ViewTrip(userRole, user);
            trips.setExtendedState(JFrame.MAXIMIZED_BOTH);
            trips.setVisible(true);
            parentFrame.dispose();
        });

        logoutButton.addActionListener(e -> {
            int confirm = JOptionPane.showConfirmDialog(null,
            "Are you sure you want to log out?", "Log Out",
            JOptionPane.YES_NO_OPTION);
            
            if (confirm == JOptionPane.YES_OPTION) {
                // Go back to the login screen
                InitialPage home = new InitialPage();
                home.setExtendedState(JFrame.MAXIMIZED_BOTH);
                home.setVisible(true);
                parentFrame.dispose();
            }
        });
        
        final UserTypeService userTypeService = new UserTypeServiceImpl();

        switchRoleButton.addActionListener(e -> {
            // if we’re currently a Driver, we switch to Passenger; else vice-versa
            boolean switchingToPassenger = userRole.equals("Driver");

            try {
                boolean isAdmin     = userTypeService.isAdmin(user.getId());
                boolean isDriver    = userTypeService.isDriver(user.getId());
                boolean isPassenger = userTypeService.isPassenger(user.getId());

                if (switchingToPassenger) {
                    // —— Passenger selection logic —— 
                    if (isAdmin) {
                        JOptionPane.showMessageDialog(parentFrame,
                            "Administrators cannot register as passengers.",
                            "Access Restricted",
                            JOptionPane.WARNING_MESSAGE);
                        return;
                    }

                    if (isPassenger) {
                        // already a passenger—nothing to do
                    }
                    else if (isDriver) {
                        int resp = JOptionPane.showConfirmDialog(parentFrame,
                            "You are already a driver. Would you also like to register as a passenger?",
                            "Register as Passenger",
                            JOptionPane.YES_NO_OPTION,
                            JOptionPane.QUESTION_MESSAGE);
                        if (resp == JOptionPane.YES_OPTION) {
                            userTypeService.registerAsPassenger(user.getId());
                        } else {
                            return;
                        }
                    }
                    else {
                        // new passenger
                        userTypeService.registerAsPassenger(user.getId());
                    }

                    // open passenger profile
                    UserProfile prof = new UserProfile("Passenger", user);
                    prof.setExtendedState(JFrame.MAXIMIZED_BOTH);
                    prof.setVisible(true);
                    parentFrame.dispose();
                }
                else {
                    // —— Driver selection logic —— 
                    if (isAdmin) {
                        JOptionPane.showMessageDialog(parentFrame,
                            "Administrators cannot register as drivers.",
                            "Access Restricted",
                            JOptionPane.WARNING_MESSAGE);
                        return;
                    }

                    if (isDriver) {
                        // already a driver—nothing to do
                    }
                    else if (isPassenger) {
                        int resp = JOptionPane.showConfirmDialog(parentFrame,
                            "You are already a passenger. Would you also like to register as a driver?",
                            "Register as Driver",
                            JOptionPane.YES_NO_OPTION,
                            JOptionPane.QUESTION_MESSAGE);
                        if (resp == JOptionPane.YES_OPTION) {
                            userTypeService.registerAsDriver(user.getId());
                        } else {
                            return;
                        }
                    }
                    else {
                        // new driver
                        userTypeService.registerAsDriver(user.getId());
                    }

                    // open driver profile
                    UserProfile prof = new UserProfile("Driver", user);
                    prof.setExtendedState(JFrame.MAXIMIZED_BOTH);
                    prof.setVisible(true);
                    parentFrame.dispose();
                }

            } catch (SQLException ex) {
                JOptionPane.showMessageDialog(parentFrame,
                    "Error changing role: " + ex.getMessage(),
                    "Error",
                    JOptionPane.ERROR_MESSAGE);
            }
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
