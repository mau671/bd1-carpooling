/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.ChosenCapacity;
import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.*;
import java.util.*;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author hidal
 */
public class ChosenCapacityDAO {
    public long saveChosenCapacity(long vehicleRouteId, int chosenNumber, Connection conn) throws SQLException {
        String sql = "{CALL carpooling_adm.create_chosen_capacity(?, ?, ?)}";

        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, vehicleRouteId);
            stmt.setInt(2, chosenNumber);
            stmt.registerOutParameter(3, Types.BIGINT); // or Types.INTEGER

            stmt.execute();

            return stmt.getLong(3); // return new ID
        }
    }
}
