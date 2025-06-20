/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * DAO for Gender information using MySQL stored procedures
 */
public class GenderInfoDAO {

    public String getGenderName(long genderId, Connection conn) throws SQLException {
        String genderName = null;
        String sql = "{call carpooling_adm.get_gender(?)}";
        
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, genderId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    genderName = rs.getString("name");
                }
            }
        }
        
        return genderName;
    }
}
