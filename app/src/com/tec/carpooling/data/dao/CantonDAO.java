/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Canton;
import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.*;
import java.util.*;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author hidal
 */
public class CantonDAO {
    public List<Canton> getCantonsByProvince(long provinceId) throws SQLException {
        List<Canton> cantons = new ArrayList<>();
        String sql = "{CALL carpooling_adm.get_cantons_by_province(?)}";

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.setLong(1, provinceId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    long id = rs.getLong("id");
                    String name = rs.getString("name");
                    cantons.add(new Canton(id, name, provinceId));
                }
            }
        }

        return cantons;
    }
}