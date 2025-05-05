package com.tec.carpooling;

import com.tec.carpooling.presentation.view.HomePage;
import com.tec.carpooling.presentation.view.MainFrame;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;

/**
 * Main class that contains the entry point for the Carpooling application.
 */
public class MainApp {

    /**
     * Main entry point of the application.
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        setupLookAndFeel();
        initializeApplication();
        launchUserInterface();
    }
    
    private static void setupLookAndFeel() {
        try {
            for (UIManager.LookAndFeelInfo info : UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    UIManager.setLookAndFeel(info.getClassName());
                    return;
                }
            }
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception ex) {
            System.err.println("Failed to initialize Look and Feel");
        }
    }
    
    private static void initializeApplication() {
        System.out.println("Starting Carpooling TEC...");
    }
    
    private static void launchUserInterface() {
        SwingUtilities.invokeLater(() -> {
            MainFrame mainFrame = new MainFrame();
            JFrame initialPanel = new HomePage();
            
            // CAMBIAR HomePage para que sea un JPanel
            //mainFrame.render_panel(initialPanel);
            //mainFrame.setVisible(true);
        });
    }
}
