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
import java.time.LocalDate;
import java.time.LocalTime;

/**
 *
 * @author hidal
 */
public class TripSummaryDAO {

    /**
     * Returns a list of pending trips for a given institution,
     * excluding those created by the current user, and only
     * if there are still available seats (>0).
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
            "  JOIN carpooling_pu.ROUTE R             ON T.route_id = R.id " +
            "  JOIN carpooling_pu.STATUSXTRIP SX      ON SX.trip_id = T.id " +
            "  JOIN carpooling_adm.STATUS S           ON S.id = SX.status_id " +
            "  JOIN carpooling_pu.VEHICLEXROUTE VR    ON VR.route_id = R.id " +
            "  JOIN carpooling_pu.VEHICLE VEH         ON VEH.id = VR.vehicle_id " +
            "  JOIN carpooling_pu.DRIVERXVEHICLE DV   ON DV.vehicle_id = VEH.id " +
            "  JOIN carpooling_pu.DRIVER D            ON D.person_id = DV.driver_id " +
            "  JOIN carpooling_adm.PERSON P           ON P.id = D.person_id " +
            "  JOIN carpooling_pu.INSTITUTION_PERSON PI ON PI.person_id = P.id " +
            "  JOIN carpooling_pu.MAXCAPACITYXVEHICLE mcv ON mcv.vehicle_id = VEH.id " +
            "  JOIN carpooling_adm.MAXCAPACITY mc     ON mc.id = mcv.max_capacity_id " +
            "  LEFT JOIN carpooling_pu.PASSENGERXTRIP px ON px.trip_id = T.id " +
            "  JOIN (                                " +
            "    SELECT route_id, district_id       " +
            "    FROM (                             " +
            "      SELECT route_id, district_id,    " +
            "             ROW_NUMBER() OVER (PARTITION BY route_id ORDER BY id) rn " +
            "      FROM carpooling_pu.WAYPOINT WHERE district_id IS NOT NULL" +
            "    ) sub WHERE rn = 1                 " +
            "  ) WP1 ON WP1.route_id = R.id        " +
            "  JOIN carpooling_adm.DISTRICT D1     ON D1.id = WP1.district_id    " +
            "WHERE S.name = 'Pending'              " +
            "  AND PI.institution_id = ?           " +   // only this institution
            "  AND P.id <> ?                        " +   // not driven by current user
            "  AND NOT EXISTS (                     " +   // not already booked by them
            "      SELECT 1                         " +
            "      FROM carpooling_pu.PASSENGERXTRIP pxt " +
            "      WHERE pxt.trip_id = T.id        " +
            "        AND pxt.passenger_id = ?      " +
            "  )                                    " +
            "GROUP BY T.id, R.programming_date, D1.name, mc.capacity_number " +
            "HAVING (mc.capacity_number - COUNT(px.id)) > 0  " +   // has seats
            "ORDER BY R.programming_date";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, institutionId);
            stmt.setLong(2, currentUserId);
            stmt.setLong(3, currentUserId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    trips.add(new TripSummary(
                        rs.getLong("trip_id"),
                        rs.getDate("programming_date"),
                        rs.getString("start_point")
                    ));
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
    public List<TripSummary> searchAvailableTripsByCriteria(
            long institutionId,
            long currentUserId,
            LocalDate tripDate,
            LocalTime arrivalTime,
            long countryId,
            long provinceId,
            long cantonId,
            long districtId,
            Connection conn
    ) throws SQLException {
        List<TripSummary> trips = new ArrayList<>();

        // 1) Build the base query (added C1/P1/CT joins)
        StringBuilder sql = new StringBuilder()
            .append("SELECT ")
            .append("  T.id                 AS trip_id, ")
            .append("  R.programming_date, ")
            .append("  D1.name              AS start_point ")
            .append("FROM carpooling_pu.TRIP T ")
            .append("JOIN carpooling_pu.ROUTE R        ON T.route_id = R.id ")
            .append("JOIN carpooling_pu.STATUSXTRIP SX ON SX.trip_id = T.id ")
            .append("JOIN carpooling_adm.STATUS S      ON S.id = SX.status_id ")
            .append("JOIN carpooling_pu.VEHICLEXROUTE VR ON VR.route_id = R.id ")
            .append("JOIN carpooling_pu.VEHICLE VEH    ON VEH.id = VR.vehicle_id ")
            .append("JOIN carpooling_pu.DRIVERXVEHICLE DV ON DV.vehicle_id = VEH.id ")
            .append("JOIN carpooling_pu.DRIVER D       ON D.person_id = DV.driver_id ")
            .append("JOIN carpooling_adm.PERSON P      ON P.id = D.person_id ")
            .append("JOIN carpooling_pu.INSTITUTION_PERSON PI ON PI.person_id = P.id ")
            .append("JOIN carpooling_pu.MAXCAPACITYXVEHICLE MCV ON MCV.vehicle_id = VEH.id ")
            .append("JOIN carpooling_adm.MAXCAPACITY MC ON MC.id = MCV.max_capacity_id ")
            .append("LEFT JOIN carpooling_pu.PASSENGERXTRIP px ON px.trip_id = T.id ")
            .append("JOIN ( ")
            .append("  SELECT route_id, district_id FROM ( ")
            .append("    SELECT route_id, district_id, ROW_NUMBER() OVER (")
            .append("         PARTITION BY route_id ORDER BY id) rn ")
            .append("    FROM carpooling_pu.WAYPOINT WHERE district_id IS NOT NULL ")
            .append("  ) sub WHERE rn = 1 ")
            .append(") WP1 ON WP1.route_id = R.id ")
            // join up from district → canton → province → country
            .append("JOIN carpooling_adm.DISTRICT D1 ON D1.id = WP1.district_id ")
            .append("JOIN carpooling_adm.CANTON  C1 ON C1.id = D1.canton_id ")
            .append("JOIN carpooling_adm.PROVINCE P1 ON P1.id = C1.province_id ")
            .append("JOIN carpooling_adm.COUNTRY CT  ON CT.id = P1.country_id ")
            .append("WHERE S.name = 'Pending' ")
            .append("  AND PI.institution_id = ? ")
            .append("  AND P.id <> ? ");

        // 2) Append optional filters
        if (tripDate != null) {
            sql.append(" AND DATE(R.programming_date) = ? ");
        }
        if (arrivalTime != null) {
            sql.append(" AND TIME(R.start_time) >= ? ");
        }
        if (countryId  != 0) {
            sql.append(" AND CT.id = ? ");
        }
        if (provinceId != 0) {
            sql.append(" AND P1.id = ? ");
        }
        if (cantonId   != 0) {
            sql.append(" AND C1.id = ? ");
        }
        if (districtId != 0) {
            sql.append(" AND D1.id = ? ");
        }

        // 3) Group/Having to filter out full trips, then order
        sql.append("GROUP BY T.id, R.programming_date, D1.name, MC.capacity_number ")
           .append("HAVING (MC.capacity_number - COUNT(px.id)) > 0 ")
           .append("ORDER BY R.programming_date, R.start_time");

        // 4) Prepare and bind
        PreparedStatement ps = conn.prepareStatement(sql.toString());
        int idx = 1;
        ps.setLong(idx++, institutionId);
        ps.setLong(idx++, currentUserId);

        if (tripDate != null) {
            ps.setDate(idx++, Date.valueOf(tripDate));
        }
        if (arrivalTime != null) {
            ps.setTime(idx++, Time.valueOf(arrivalTime));
        }
        if (countryId  != 0) {
            ps.setLong(idx++, countryId);
        }
        if (provinceId != 0) {
            ps.setLong(idx++, provinceId);
        }
        if (cantonId   != 0) {
            ps.setLong(idx++, cantonId);
        }
        if (districtId != 0) {
            ps.setLong(idx++, districtId);
        }

        // 5) Execute and collect
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                trips.add(new TripSummary(
                    rs.getLong("trip_id"),
                    rs.getDate("programming_date"),
                    rs.getString("start_point")
                ));
            }
        }

        return trips;
    }
}