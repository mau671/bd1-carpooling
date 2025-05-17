package com.tec.carpooling;

import com.formdev.flatlaf.FlatLightLaf;
import com.formdev.flatlaf.fonts.roboto.FlatRobotoFont;
import com.tec.carpooling.presentation.view.InitialPage;
import com.tec.carpooling.presentation.view.admin.AdminFrame;

import javax.swing.JFrame;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;
import java.awt.Font;

/**
 * Main class containing the entry point for the Carpooling application.
 * Configures FlatLaf Look and Feel with Roboto font.
 */
public class MainApp {

    private static final int DEFAULT_FONT_SIZE = 13;

    /**
     * Main application entry point.
     * @param args command line arguments (not used)
     */
    public static void main(String[] args) {
        setupLookAndFeelAndFont();
        initializeApplication();
        launchUserInterface();
    }

    /**
     * Configures the FlatLaf Look and Feel and sets Roboto as the default font.
     */
    private static void setupLookAndFeelAndFont() {
        try {
            FlatRobotoFont.install();
            UIManager.setLookAndFeel(new FlatLightLaf());
            UIManager.put("defaultFont", new Font(FlatRobotoFont.FAMILY, Font.PLAIN, DEFAULT_FONT_SIZE));
            System.out.println("FlatLaf Look and Feel with Roboto font initialized successfully.");
        } catch (Exception ex) {
            System.err.println("Failed to initialize FlatLaf Look and Feel: " + ex.getMessage());
        }
    }

    /**
     * Performs necessary application initializations.
     */
    private static void initializeApplication() {
        System.out.println("Starting Carpooling Application...");
    }

    /**
     * Launches the main user interface of the application.
     * Creates and configures the HomePage window on the Event Dispatch Thread.
     */
    private static void launchUserInterface() {
        SwingUtilities.invokeLater(() -> {
            /*AdminFrame homePageFrame = new AdminFrame();
            homePageFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            // Set the size of the frame to the preferred size
            homePageFrame.setSize(800, 600); // Set to a default size
            homePageFrame.setResizable(true); // Allow resizing
            // Set the frame to be centered on the screen
            homePageFrame.setLocationRelativeTo(null);
            homePageFrame.setTitle("Carpooling TEC"); // Change to obtain the name from database
            homePageFrame.pack();
            homePageFrame.setVisible(true);*/
            
            InitialPage homePageFrame = new InitialPage();
            homePageFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            homePageFrame.setExtendedState(JFrame.MAXIMIZED_BOTH); // Start maximized
            homePageFrame.setResizable(true);
            homePageFrame.setLocationRelativeTo(null);
            homePageFrame.setTitle("Carpooling TEC");
            homePageFrame.setVisible(true);
        });
    }
}
