package com.tec.carpooling;

import com.tec.carpooling.presentation.view.HomePage;
import javax.swing.JFrame;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;

/**
 * Main class containing the entry point for the Carpooling application.
 */
public class MainApp {

    /**
     * Main application entry point.
     * @param args command line arguments
     */
    public static void main(String[] args) {
        setupLookAndFeel();
        initializeApplication();
        launchUserInterface();
    }

    /**
     * Configures the graphical user interface Look and Feel.
     * Tries to use Nimbus, and falls back to the system L&F if unavailable.
     */
    private static void setupLookAndFeel() {
        try {
            boolean nimbusFound = false;
            for (UIManager.LookAndFeelInfo info : UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    UIManager.setLookAndFeel(info.getClassName());
                    nimbusFound = true;
                    break; // Nimbus found, no need to continue
                }
            }
            // If Nimbus not found, use system default
            if (!nimbusFound) {
                 UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
            }
        } catch (Exception ex) {
            // Print a more informative error message
            System.err.println("Failed to initialize Look and Feel: " + ex.getMessage());
            // Optionally print stack trace for debugging
            // ex.printStackTrace();
        }
    }

    /**
     * Performs necessary application initializations.
     */
    private static void initializeApplication() {
        System.out.println("Starting Carpooling TEC...");
        // Add any other necessary initialization here
    }

    /**
     * Launches the main user interface of the application.
     * Now loads HomePage directly.
     */
    private static void launchUserInterface() {
        // Ensures GUI creation happens on the Event Dispatch Thread (EDT)
        SwingUtilities.invokeLater(() -> {
            // Create and directly display the HomePage window
            // Assuming HomePage extends JFrame or is a JFrame
            HomePage homePageFrame = new HomePage();

            // Set essential properties for the main window
            homePageFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); // Ensures application terminates when window is closed
            homePageFrame.setTitle("Carpooling TEC"); // Set a meaningful title
            // homePageFrame.pack(); // Adjust size to fit components (use if needed)
            homePageFrame.setLocationRelativeTo(null); // Center window on screen
            homePageFrame.setVisible(true); // Make window visible
        });
    }
}
