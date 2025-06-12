/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.District;
import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.*;
import java.util.*;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author hidal
 */
public class DistrictDAO {
    public List<District> getDistrictsByCanton(long cantonId) throws SQLException {
        List<District> districts = new ArrayList<>();
        String sql = "{CALL carpooling_adm.get_districts_by_canton(?)}";

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.setLong(1, cantonId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    long id = rs.getLong("id");
                    String name = rs.getString("name");
                    districts.add(new District(id, name, cantonId));
                }
            }
        }

        return districts;
    }
}
