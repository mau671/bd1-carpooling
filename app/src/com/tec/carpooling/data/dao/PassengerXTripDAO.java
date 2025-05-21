/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

/**
 *
 * @author hidal
 */
public class PassengerXTripDAO {

    public long bookTrip(long passengerId, long tripId, Connection conn) throws SQLException {
        String sql = "SELECT id FROM PU.PASSENGERXTRIP WHERE passenger_id = ? AND trip_id = ?";
        try (CallableStatement stmt = conn.prepareCall("{ call PU_PASSENGERXTRIP_PKG.book_trip(?, ?) }")) {
            stmt.setLong(1, passengerId);
            stmt.setLong(2, tripId);
            stmt.execute();
        }

        try (PreparedStatement stmt2 = conn.prepareStatement(sql)) {
            stmt2.setLong(1, passengerId);
            stmt2.setLong(2, tripId);
            try (ResultSet rs = stmt2.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong("id");
                } else {
                    throw new SQLException("Failed to retrieve PassengerXTrip ID.");
                }
            }
        }
    }

    public void cancelTrip(long passengerId, long tripId, Connection conn) throws SQLException {
        String sql = "{ call PU_PASSENGERXTRIP_PKG.cancel_trip_booking(?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerId);
            stmt.setLong(2, tripId);
            stmt.execute();
        }
    }
}