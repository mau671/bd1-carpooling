/*
 * File: Home.java
 * This file contains the home view, with a background image and two buttons for login and sign up
 * @author: Mauricio González Prendas
 */
package View;

import Formatter.Component_Formatter;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.io.File;
import java.net.URL;
import javax.swing.ImageIcon;
import javax.swing.JLabel;

public class Home extends javax.swing.JPanel {

    /**
     * Creates new form Home
     */
    
    public Home() {
        initComponents();
        Component_Formatter.format_button(jButtonLogIn, new Color(102, 51, 255), new Color(102, 0, 255), Color.WHITE);
        Component_Formatter.format_button(jButtonSignUp, new Color(102, 51, 255), new Color(34, 197, 94), Color.WHITE);
        Component_Formatter.format_button(jButtonAboutUs, new Color(102, 51, 255), new Color(102, 0, 255), Color.WHITE);
    }
    
    /** NOTA!!!!: CAMBIAR ESTO PARA CARGAR LA IMAGEN DESDE LA BASE DE DATOS
     * Este método carga la imagen desde la ruta dada, la escala (sin alterar su relación de aspecto)  
     * para que quepa en el tamaño máximo asignado al JLabel y la asigna.  
     * De esta manera se renderiza la imagen con sus dimensiones correctas sin estirarla y sin salirse de la ventana.
     * @param imagePath la ruta de la imagen
     * @param jLabelImage el JLabel en el que se mostrará la imagen
     */
    public void setImage(String imagePath, JLabel jLabelImage) {
        URL url = getClass().getResource(imagePath);
        if(url == null){
            System.err.println("No se encontró la imagen en: " + imagePath);
            return;
        }
        ImageIcon icon = new ImageIcon(url);
        int imageWidth = icon.getIconWidth();
        int imageHeight = icon.getIconHeight();
        
        // Obtener el tamaño máximo para la imagen. Se utiliza el tamaño actual del label,
        // pero si es 0 (no se ha mostrado aún), se utiliza su tamaño preferido.
        Dimension maxDim = jLabelImage.getSize();
        if (maxDim.width == 0 || maxDim.height == 0) {
            maxDim = jLabelImage.getPreferredSize();
        }
        
        double scale = 1.0;
        // Si la imagen es más grande que el espacio máximo permitido, se calcula el factor de escala
        if(imageWidth > maxDim.width || imageHeight > maxDim.height){
            scale = Math.min((double) maxDim.width / imageWidth, (double) maxDim.height / imageHeight);
        }
        
        int newWidth = (int) (imageWidth * scale);
        int newHeight = (int) (imageHeight * scale);
        
        // Si la imagen es mayor al espacio, se escala. Si no, se mantiene el tamaño original.
        ImageIcon scaledIcon;
        if(scale < 1.0){
            scaledIcon = new ImageIcon(icon.getImage().getScaledInstance(newWidth, newHeight, java.awt.Image.SCALE_SMOOTH));
        } else {
            scaledIcon = icon;
        }
        
        jLabelImage.setIcon(scaledIcon);
        jLabelImage.setText("");
        jLabelImage.setPreferredSize(new Dimension(newWidth, newHeight));
        jLabelImage.setSize(newWidth, newHeight);
    }


    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jButtonAboutUs = new javax.swing.JButton();
        jButtonLogIn = new javax.swing.JButton();
        jButtonSignUp = new javax.swing.JButton();
        jLabelHomeImage = new javax.swing.JLabel();

        jButtonAboutUs.setText("Acerca de");

        jButtonLogIn.setBackground(new java.awt.Color(255, 255, 255));
        jButtonLogIn.setForeground(new java.awt.Color(0, 0, 0));
        jButtonLogIn.setText("Iniciar sesión");

        jButtonSignUp.setBackground(new java.awt.Color(34, 197, 94));
        jButtonSignUp.setForeground(new java.awt.Color(255, 255, 255));
        jButtonSignUp.setText("Registrarse");

        jLabelHomeImage.setText("jLabel1");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(279, Short.MAX_VALUE)
                .addComponent(jButtonLogIn, javax.swing.GroupLayout.PREFERRED_SIZE, 150, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(29, 29, 29)
                .addComponent(jButtonSignUp, javax.swing.GroupLayout.PREFERRED_SIZE, 150, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(278, 278, 278))
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(226, 226, 226)
                        .addComponent(jLabelHomeImage, javax.swing.GroupLayout.PREFERRED_SIZE, 431, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(384, 384, 384)
                        .addComponent(jButtonAboutUs, javax.swing.GroupLayout.PREFERRED_SIZE, 101, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(59, Short.MAX_VALUE)
                .addComponent(jLabelHomeImage, javax.swing.GroupLayout.PREFERRED_SIZE, 251, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(32, 32, 32)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jButtonLogIn, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButtonSignUp, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addComponent(jButtonAboutUs, javax.swing.GroupLayout.PREFERRED_SIZE, 35, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(55, 55, 55))
        );
    }// </editor-fold>//GEN-END:initComponents


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButtonAboutUs;
    private javax.swing.JButton jButtonLogIn;
    private javax.swing.JButton jButtonSignUp;
    private javax.swing.JLabel jLabelHomeImage;
    // End of variables declaration//GEN-END:variables
}
