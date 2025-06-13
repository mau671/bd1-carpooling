/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.CallableStatement;
import java.sql.Types;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

/**
 *
 * @author hidal
 */
public class PassengerXTripDAO {

    /**
     * Books a trip for a passenger by calling the MySQL procedure:
     *   IN  p_passenger_id
     *   IN  p_trip_id
     *   OUT o_booking_id
     *
     * @return the generated booking ID
     */
    public long bookTrip(long passengerId, long tripId, Connection conn) throws SQLException {
        String sql = "{ CALL carpooling_adm.book_trip(?, ?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerId);
            stmt.setLong(2, tripId);
            stmt.registerOutParameter(3, Types.INTEGER);
            stmt.execute();
            return stmt.getLong(3);
        }
    }

    /**
     * Cancels an existing booking by calling the MySQL procedure:
     *   IN p_passenger_id
     *   IN p_trip_id
     */
    public void cancelTrip(long passengerId, long tripId, Connection conn) throws SQLException {
        String sql = "{ CALL carpooling_adm.cancel_trip_booking(?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerId);
            stmt.setLong(2, tripId);
            stmt.execute();
        }
    }

}