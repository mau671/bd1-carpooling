/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author dilan
 */
public class ComboItem {
    private String label;
    private int value;

    public ComboItem(String label, int value) {
        this.label = label;
        this.value = value;
    }

    public ComboItem() {
    }

    @Override
    public String toString() {
        return label;
    }

    public int getValue() {
        return value;
    }
    
}
