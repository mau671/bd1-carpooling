/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.MaxCapacity;
import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.OracleTypes;

/**
 *
 * @author hidal
 */
public class MaxCapacityDAO {
    public List<MaxCapacity> getAllCapacities() throws SQLException {
        List<MaxCapacity> capacities = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall("{CALL carpooling_adm.get_all_max_capacity()}");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                long id = rs.getLong("id");
                int number = rs.getInt("capacity_number");
                capacities.add(new MaxCapacity(id, number));
            }
        }

        return capacities;
    }
}
