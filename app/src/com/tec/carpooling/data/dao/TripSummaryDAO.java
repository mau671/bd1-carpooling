/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.TripSummary;
import com.tec.carpooling.domain.entity.Waypoint;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hidal
 */
public class TripSummaryDAO {

    /**
     * Returns a list of pending trips for a given institution,
     * excluding those created by the current user.
     */
    public List<TripSummary> getAvailableTripsByInstitution(
            long institutionId,
            long currentUserId,
            Connection conn
    ) throws SQLException {
        List<TripSummary> trips = new ArrayList<>();

        String sql =
            "SELECT T.id AS trip_id, R.programming_date, D1.name AS start_point " +
            "FROM carpooling_pu.TRIP T " +
            "JOIN carpooling_pu.ROUTE R ON T.route_id = R.id " +
            "JOIN carpooling_pu.STATUSXTRIP SX ON SX.trip_id = T.id " +
            "JOIN carpooling_adm.STATUS S ON S.id = SX.status_id " +
            "JOIN carpooling_pu.VEHICLEXROUTE VR ON VR.route_id = R.id " +
            "JOIN carpooling_pu.VEHICLE VEH ON VEH.id = VR.vehicle_id " +
            "JOIN carpooling_pu.DRIVERXVEHICLE DV ON DV.vehicle_id = VEH.id " +
            "JOIN carpooling_pu.DRIVER D ON D.person_id = DV.driver_id " +
            "JOIN carpooling_adm.PERSON P ON P.id = D.person_id " +
            "JOIN carpooling_pu.INSTITUTION_PERSON PI ON PI.person_id = P.id " +
            "JOIN ( " +
            "    SELECT route_id, district_id FROM ( " +
            "        SELECT route_id, district_id, ROW_NUMBER() OVER (PARTITION BY route_id ORDER BY id) rn " +
            "        FROM carpooling_pu.WAYPOINT WHERE district_id IS NOT NULL " +
            "    ) sub WHERE rn = 1 " +
            ") WP1 ON WP1.route_id = R.id " +
            "JOIN carpooling_adm.DISTRICT D1 ON D1.id = WP1.district_id " +
            "WHERE S.name = 'Pending' " +
            "  AND PI.institution_id = ? " +
            "  AND P.id != ? " +
            "ORDER BY R.programming_date";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, institutionId);
            stmt.setLong(2, currentUserId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    long tripId = rs.getLong("trip_id");
                    Date tripDate = rs.getDate("programming_date");
                    String startPoint = rs.getString("start_point");

                    trips.add(new TripSummary(tripId, tripDate, startPoint));
                }
            }
        }

        return trips;
    }

    /**
     * Returns all waypoints (pickup stops) for a given trip.
     */
    public List<Waypoint> getWaypointsByTripId(
            long tripId,
            Connection conn
    ) throws SQLException {
        List<Waypoint> stops = new ArrayList<>();

        String sql =
            "SELECT WP.id, WP.latitude, WP.longitude, D.id AS district_id " +
            "FROM carpooling_pu.WAYPOINT WP " +
            "JOIN carpooling_pu.TRIP T ON T.route_id = WP.route_id " +
            "LEFT JOIN carpooling_adm.DISTRICT D ON D.id = WP.district_id " +
            "WHERE T.id = ? " +
            "ORDER BY WP.id";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, tripId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    long id = rs.getLong("id");
                    Long districtId = rs.getObject("district_id") != null
                            ? rs.getLong("district_id")
                            : null;
                    Double lat = rs.getObject("latitude") != null
                            ? rs.getDouble("latitude")
                            : null;
                    Double lon = rs.getObject("longitude") != null
                            ? rs.getDouble("longitude")
                            : null;

                    stops.add(new Waypoint(id, districtId, lat, lon));
                }
            }
        }

        return stops;
    }

}

