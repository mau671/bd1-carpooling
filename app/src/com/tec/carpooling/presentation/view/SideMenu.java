/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.presentation.view;

import javax.swing.JFrame;
import javax.swing.JToolBar;
import javax.swing.JButton;
/**
 *
 * @author hidal
 */
public class SideMenu {
    public static JToolBar createToolbar(JFrame parentFrame, String userRole) {
        JToolBar toolBar = new JToolBar(JToolBar.VERTICAL);

        JButton profileButton = new JButton("User Profile");
        JButton vehicleInfoButton = new JButton("Registered Vehicles");
        JButton scheduleTripButton = new JButton("Schedule a Trip");
        JButton searchTripButton = new JButton("Search for Trips");
        JButton logButton = new JButton("Activity Log");
        JButton switchRoleButton = new JButton();
        JButton logoutButton = new JButton("Log Out");

        toolBar.add(profileButton);

        if (userRole.equals("Passenger")) {
            toolBar.add(searchTripButton);
            toolBar.add(logButton);
            switchRoleButton.setText("Switch to Driver");
        } else if (userRole.equals("Driver")) {
            toolBar.add(vehicleInfoButton);
            toolBar.add(scheduleTripButton);
            toolBar.add(logButton);
            switchRoleButton.setText("Switch to Passenger");
        }

        toolBar.add(switchRoleButton);
        toolBar.add(logoutButton);

        // ActionListeners use parentFrame.dispose()
        profileButton.addActionListener(e -> {
            UserProfile profile = new UserProfile(userRole);
            profile.setExtendedState(JFrame.MAXIMIZED_BOTH);
            profile.setVisible(true);
            
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

        /*scheduleTripButton.addActionListener(e -> {
            new AgendarViaje(userRole).setVisible(true);
            parentFrame.dispose();
        });*/

        /*logButton.addActionListener(e -> {
            new Historial(userRole).setVisible(true);
            parentFrame.dispose();
        });*/

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
}
