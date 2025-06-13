/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.PassengerTripDisplay;

import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.CallableStatement;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.SQLException;
/**
 *
 * @author hidal
 */
public class PassengerTripDAO {
    public List<PassengerTripDisplay> getBookedTrips(long passengerId, Connection conn) throws SQLException {
        List<PassengerTripDisplay> list = new ArrayList<>();

        // If you’re not already `USE carpooling_pu`, qualify it:
        String call = "{ CALL carpooling_pu.get_booked_trips(?) }";

        try (CallableStatement stmt = conn.prepareCall(call)) {
            stmt.setLong(1, passengerId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    long   id     = rs.getLong("trip_id");           // <<< new!
                    Date   date   = rs.getDate("programming_date");
                    String start  = rs.getString("start_point");
                    String end    = rs.getString("destination_point");
                    String plate  = rs.getString("plate");
                    String status = rs.getString("status");

                    // pass the ID into the constructor
                    list.add(new PassengerTripDisplay(
                        id,
                        date,
                        start,
                        end,
                        plate,
                        status
                    ));
                }
            }
        }

        return list;
    }
}
