/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.PassengerTripDisplay;

import java.sql.ResultSet;
import java.sql.PreparedStatement;
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

    String sql = """
        SELECT
            R.programming_date,
            D1.name AS start_point,
            D2.name AS end_point,
            VEH.plate,
            S.name AS status
        FROM PU.PASSENGERXTRIP PX
        JOIN PU.TRIP T ON PX.trip_id = T.id
        JOIN PU.ROUTE R ON T.route_id = R.id
        JOIN PU.VEHICLEXROUTE VR ON VR.route_id = R.id
        JOIN PU.VEHICLE VEH ON VEH.id = VR.vehicle_id
        JOIN PU.STATUSXTRIP SX ON SX.trip_id = T.id
        JOIN ADM.STATUS S ON S.id = SX.status_id

        -- START POINT
        JOIN (
            SELECT route_id, district_id FROM (
                SELECT route_id, district_id,
                       ROW_NUMBER() OVER (PARTITION BY route_id ORDER BY id) rn
                FROM PU.WAYPOINT
                WHERE district_id IS NOT NULL
            ) WHERE rn = 1
        ) WP1 ON WP1.route_id = R.id
        JOIN ADM.DISTRICT D1 ON D1.id = WP1.district_id

        -- END POINT
        JOIN (
            SELECT route_id, district_id FROM (
                SELECT route_id, district_id,
                       ROW_NUMBER() OVER (PARTITION BY route_id ORDER BY id DESC) rn
                FROM PU.WAYPOINT
                WHERE district_id IS NOT NULL
            ) WHERE rn = 1
        ) WP2 ON WP2.route_id = R.id
        JOIN ADM.DISTRICT D2 ON D2.id = WP2.district_id

        WHERE PX.passenger_id = ?
    """;

    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setLong(1, passengerId);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Date date = rs.getDate("programming_date");
                String start = rs.getString("start_point");
                String end = rs.getString("end_point");
                String plate = rs.getString("plate");
                String status = rs.getString("status");

                list.add(new PassengerTripDisplay(date, start, end, plate, status));
            }
        }
    }

    return list;
}
}
