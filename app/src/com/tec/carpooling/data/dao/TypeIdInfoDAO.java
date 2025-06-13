/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.IdType;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
    
    public List<IdType> getAllIdTypes(Connection conn) throws SQLException {
        List<IdType> types = new ArrayList<>();
        
        String sql = "{call carpooling_adm.list_type_identifications()}";
        
        try (CallableStatement stmt = conn.prepareCall(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                IdType type = new IdType();
                type.setId(rs.getLong("id"));
                type.setName(rs.getString("name"));
                types.add(type);
            }
        }
        
        return types;
    }
}
