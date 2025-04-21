/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Connection;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import oracle.jdbc.OracleTypes;
import java.sql.Date;

/**
 *
 * @author hidal
 */
public class ConnectDB {
    public static void insertPhoneType(int id, String name, String creator, Date creation_date, String modifier, Date modification_date) {
        String host = "jdbc:oracle:thin:@localhost:1521:LIGHTNING";
        String uName = "system";
        String uPass = "iBBs9QkOr3";

        try {
            Connection con = DriverManager.getConnection(host, uName, uPass);
            CallableStatement stmt = con.prepareCall("{call pu.InsertPhoneType(?,?,?,?,?,?)}"); // fixed syntax

            stmt.setInt(1, id);
            stmt.setString(2, name);
            stmt.setString(3, creator);
            stmt.setDate(4, creation_date); // assuming DATE type in SQL
            stmt.setString(5, modifier);
            stmt.setDate(6, modification_date); // assuming DATE type in SQL

            stmt.execute();
            stmt.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
