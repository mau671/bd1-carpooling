/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Connect;

import java.sql.Connection;
import java.sql.SQLException;
/**
 *
 * @author hidal
 */
public class TestConnection {
    public static void main(String[] args) {
        Connection conn = ConnectDB.getConnection();

        if (conn != null) {
            System.out.println("✅ Connection successful!");
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("❌ Failed to connect to the database.");
        }
    }
}
