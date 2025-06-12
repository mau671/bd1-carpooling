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
 * DAO for Type Identification information using MySQL stored procedures
 */
public class TypeIdInfoDAO {

    public String getTypeName(long typeId, Connection conn) throws SQLException {
        String typeName = null;
        String sql = "{call carpooling_adm.get_type_identification(?)}";
        
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, typeId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    typeName = rs.getString("name");
                }
            }
        }
        
        return typeName;
    }
}
