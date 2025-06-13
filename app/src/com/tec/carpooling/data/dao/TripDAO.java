/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Trip;
import com.tec.carpooling.domain.entity.TripDisplay;
import com.tec.carpooling.domain.entity.TripDetails;
import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.*;
import java.util.*;
import oracle.jdbc.OracleTypes;

import java.math.BigDecimal;
import java.sql.Date;

/**
 *
 * @author hidal
 */
public class TripDAO {
    public long createTrip(long vehicleId, long routeId, BigDecimal price, Long currencyId, Connection conn) throws SQLException {
        String sql = "{CALL create_trip(?, ?, ?, ?, ?)}";

        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, vehicleId);
            stmt.setLong(2, routeId);
            stmt.setBigDecimal(3, price);

            if (currencyId != null) {
                stmt.setLong(4, currencyId);
            } else {
                stmt.setNull(4, Types.INTEGER);
            }

            stmt.registerOutParameter(5, Types.BIGINT); // trip ID (OUT)
            stmt.execute();
            return stmt.getLong(5);
        }
    }

    public List<TripDisplay> getTripsByDriver(long userId, Connection conn) throws SQLException {
        List<TripDisplay> trips = new ArrayList<>();
        String sql = "{CALL get_trips_by_driver(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    long   id     = rs.getLong("trip_id");
                    Date   date   = rs.getDate("trip_date");
                    String start  = rs.getString("start_point");
                    String end    = rs.getString("destination_point");
                    String plate  = rs.getString("plate");
                    String status = rs.getString("status");
                    trips.add(new TripDisplay(id, date, start, end, plate, status));
                }
            }
        }
        return trips;
    }

    public TripDetails getFullTripDetails(long tripId, Connection conn) throws SQLException {
        String sql =
            "SELECT " +
            "    R.start_time, " +
            "    R.end_time, " +
            "    R.programming_date, " +
            "    T.price_per_passenger, " +
            "    CUR.name AS currency, " +
            "    VEH.plate, " +
            "    MC.capacity_number AS max_capacity, " +
            "    CC.chosen_number, " +
            "    CONCAT(P.first_name, ' ', P.first_surname) AS driver_name, " +
            "    G.name AS gender, " +
            "    TIMESTAMPDIFF(YEAR, P.date_of_birth, CURDATE()) AS age, " +
            "    S.name AS status, " +
            "    WP.latitude, " +
            "    WP.longitude, " +
            "    CONCAT(P1.name, ', ', C1.name, ', ', D1.name) AS start_point, " +
            "    CONCAT(P2.name, ', ', C2.name, ', ', D2.name) AS end_point, " +
            "    P.id AS person_id " +
            "FROM carpooling_pu.TRIP T " +
            "JOIN carpooling_pu.ROUTE R ON T.route_id = R.id " +
            "JOIN carpooling_pu.VEHICLEXROUTE VR ON VR.route_id = R.id " +
            "JOIN carpooling_pu.VEHICLE VEH ON VEH.id = VR.vehicle_id " +
            "JOIN carpooling_pu.MAXCAPACITYXVEHICLE MCV ON MCV.vehicle_id = VEH.id " +
            "JOIN carpooling_adm.MAXCAPACITY MC ON MC.id = MCV.max_capacity_id " +
            "JOIN carpooling_pu.STATUSXTRIP SX ON SX.trip_id = T.id " +
            "JOIN carpooling_adm.STATUS S ON S.id = SX.status_id " +
            "LEFT JOIN carpooling_adm.CHOSENCAPACITY CC ON CC.vehicle_x_route_id = VR.id " +
            "LEFT JOIN carpooling_adm.CURRENCY CUR ON CUR.id = T.id_currency " +
            "JOIN carpooling_pu.DRIVERXVEHICLE DV ON DV.vehicle_id = VEH.id " +
            "JOIN carpooling_pu.DRIVER D ON D.person_id = DV.driver_id " +
            "JOIN carpooling_adm.PERSON P ON P.id = D.person_id " +
            "JOIN carpooling_adm.GENDER G ON G.id = P.gender_id " +
            "LEFT JOIN carpooling_pu.WAYPOINT WP ON WP.route_id = R.id " +
            "JOIN ( " +
            "    SELECT route_id, district_id FROM ( " +
            "        SELECT route_id, district_id, ROW_NUMBER() OVER (PARTITION BY route_id ORDER BY id) AS rn " +
            "        FROM carpooling_pu.WAYPOINT WHERE district_id IS NOT NULL " +
            "    ) AS t WHERE rn = 1 " +
            ") WP1 ON WP1.route_id = R.id " +
            "JOIN carpooling_adm.DISTRICT D1 ON D1.id = WP1.district_id " +
            "JOIN carpooling_adm.CANTON C1 ON C1.id = D1.canton_id " +
            "JOIN carpooling_adm.PROVINCE P1 ON P1.id = C1.province_id " +
            "JOIN ( " +
            "    SELECT route_id, district_id FROM ( " +
            "        SELECT route_id, district_id, ROW_NUMBER() OVER (PARTITION BY route_id ORDER BY id DESC) AS rn " +
            "        FROM carpooling_pu.WAYPOINT WHERE district_id IS NOT NULL " +
            "    ) AS t WHERE rn = 1 " +
            ") WP2 ON WP2.route_id = R.id " +
            "JOIN carpooling_adm.DISTRICT D2 ON D2.id = WP2.district_id " +
            "JOIN carpooling_adm.CANTON C2 ON C2.id = D2.canton_id " +
            "JOIN carpooling_adm.PROVINCE P2 ON P2.id = C2.province_id " +
            "WHERE T.id = ?";

        TripDetails trip = null;
        List<double[]> coords = new ArrayList<>();

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, tripId);

            try (ResultSet rs = stmt.executeQuery()) {
                long personId = -1;
                while (rs.next()) {
                    if (trip == null) {
                        trip = new TripDetails();
                        trip.setStartTime(rs.getTimestamp("start_time"));
                        trip.setEndTime(rs.getTimestamp("end_time"));
                        trip.setTripDate(rs.getDate("programming_date"));
                        trip.setPricePerPassenger(rs.getBigDecimal("price_per_passenger"));
                        trip.setCurrencyName(rs.getString("currency"));
                        trip.setPlate(rs.getString("plate"));
                        trip.setMaxSeats(rs.getInt("max_capacity"));
                        trip.setChosenSeats(rs.getInt("chosen_number"));
                        trip.setDriverName(rs.getString("driver_name"));
                        trip.setGender(rs.getString("gender"));
                        trip.setAge(rs.getInt("age"));
                        trip.setStatus(rs.getString("status"));
                        trip.setStartLocation(rs.getString("start_point"));
                        trip.setEndLocation(rs.getString("end_point"));
                        personId = rs.getLong("person_id");
                    }

                    double lat = rs.getDouble("latitude");
                    double lon = rs.getDouble("longitude");
                    if (!rs.wasNull()) {
                        coords.add(new double[]{lat, lon});
                    }
                }

                if (trip != null) {
                    trip.setCoordinates(coords);

                    // Load phone numbers for the driver
                    List<String> phoneNumbers = new ArrayList<>();
                    String phoneSQL = "SELECT PH.phone_number FROM carpooling_adm.PERSON P " +
                                      "JOIN carpooling_pu.PHONE_PERSON PP ON PP.person_id = P.id " +
                                      "JOIN carpooling_pu.PHONE PH ON PH.id = PP.phone_id " +
                                      "WHERE P.id = ?";
                    try (PreparedStatement phoneStmt = conn.prepareStatement(phoneSQL)) {
                        phoneStmt.setLong(1, personId);
                        try (ResultSet prs = phoneStmt.executeQuery()) {
                            while (prs.next()) {
                                phoneNumbers.add(prs.getString("phone_number"));
                            }
                        }
                    }
                    trip.setDriverPhones(phoneNumbers);
                }
            }
        }

        return trip;
    }
}