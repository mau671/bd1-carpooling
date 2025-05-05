package com.tec.carpooling.presentation.formatter;

import java.awt.Color;
import java.awt.Cursor;
import java.awt.Font;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JTextField;

public class Component_Formatter {
    
    /**
     * Este método recibe un campo de texto y le aplica un formato deseado, en el formato
     * puede modificar características como el tipo y tamaño de letra, bordes, colores, etc.
     * @param text_field
     * @param char_limit límite de caracteres que soporta el campo de texto. Esta característica es útil
     *                   para evitar que el usuario ingrese texto sin límite, y así no tener que validar esto
     *                   al momento de insertar datos en la base de datos. 
     */
    public static void format_text_field(JTextField text_field, int char_limit){
        text_field.setFont(new Font("Yu Gothic UI Semilight", 0, 12));
        text_field.setBorder(null);
        // La clase LimitDocumentFilter se utiliza para implementar el límite de caracteres
        text_field.setDocument(new LimitDocumentFilter(char_limit));
    }
    
    /**
     * Este método recibe un label y le aplica un formato deseado.
     * @param label
     */
    public static void format_label(JLabel label){
        label.setFont(new Font("Yu Gothic UI Semilight", 0, 14));
    }
    
    /**
     * This method receives a button and applies a desired format.
     * @param button
     * @param entered_color the color the button will have when the mouse hovers over it
     * @param exited_color the color the button will have when inactive
     * @param text_color the default color of the text displayed on the button
     * @param hover_text_color the color of text when mouse hovers over the button
     */
    public static void format_button(JButton button, Color entered_color, Color exited_color, Color text_color, Color hover_text_color) {
        button.setBackground(exited_color);
        button.setForeground(text_color);
        button.setFont(new Font("Yu Gothic UI Semilight", 1, 14));
        //button.setBorder(null);
        button.setCursor(new Cursor(Cursor.HAND_CURSOR));
        button.setFocusPainted(false);
        button.setFocusable(false);

        // Adds a listener to the button when the mouse hovers over it.
        // When the event is triggered, the button changes background and text color.
        button.addMouseListener(new java.awt.event.MouseAdapter() {
            @Override
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                button.setBackground(entered_color);
                button.setForeground(hover_text_color);             
            }
        });
        
        // Listener to change the button background and text color when the mouse is no longer over it.
        button.addMouseListener(new java.awt.event.MouseAdapter() {
            @Override
            public void mouseExited(java.awt.event.MouseEvent evt) {
                button.setBackground(exited_color);
                button.setForeground(text_color);             
            }
        });
    }
}