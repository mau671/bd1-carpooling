/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Trip;
import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.*;
import java.util.*;
import oracle.jdbc.OracleTypes;

import java.math.BigDecimal;

/**
 *
 * @author hidal
 */
public class TripDAO {
    public long createTrip(long vehicleId, long routeId, BigDecimal price, Long currencyId, Connection conn) throws SQLException {
        String sql = "{ call PU_TRIP_MGMT_PKG.create_trip(?, ?, ?, ?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, vehicleId);
            stmt.setLong(2, routeId);
            stmt.setBigDecimal(3, price);
            if (currencyId != null) {
                stmt.setLong(4, currencyId);
            } else {
                stmt.setNull(4, Types.NUMERIC);
            }
            stmt.registerOutParameter(5, Types.NUMERIC); // OUT parameter for trip ID
            stmt.execute();
            return stmt.getLong(5);
        }
    }
}