package Formatter;

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
     * Este método recibe un botón y le aplica un formato deseado.
     * @param button
     * @param entered_color es el color que tendrá el botón cuando el mouse pase por encima de este.
     * @param exited_color es el color que tendrá el botón esté desactivado.
     */
    public static void format_button(JButton button, Color entered_color, Color exited_color) {
        button.setBackground(exited_color);
        button.setForeground(Color.white);
        button.setFont(new Font("Yu Gothic UI Semilight", 1, 14));
        button.setBorder(null);
        button.setCursor(new Cursor(Cursor.HAND_CURSOR));
        button.setFocusPainted(false);
        button.setFocusable(false);

        // Se agrega un listener al botón cuando el mouse pase por encima de este.
        // Cuando el evento se activa, el botón cambia de color.
        button.addMouseListener(new java.awt.event.MouseAdapter() {
            @Override
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                button.setBackground(entered_color);             
            }
        });
        
        // Listener para que el botón cambie de color cuando el mouse ya no este encima de este.
        button.addMouseListener(new java.awt.event.MouseAdapter() {
            @Override
            public void mouseExited(java.awt.event.MouseEvent evt) {
                button.setBackground(exited_color);             
            }
        });
    }
}