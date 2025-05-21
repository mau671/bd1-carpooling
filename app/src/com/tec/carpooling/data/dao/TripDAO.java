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

    public List<TripDisplay> getTripsByDriver(long userId, Connection conn) throws SQLException {
        List<TripDisplay> trips = new ArrayList<>();
        String sql = "{ ? = call PU_TRIP_MGMT_PKG.get_trips_by_driver(?) }";

        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.registerOutParameter(1, OracleTypes.CURSOR);
            stmt.setLong(2, userId);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                int count = 0;
                while (rs.next()) {
                    count++;
                    Date date = rs.getDate(1);
                    String start = rs.getString(2);
                    String end = rs.getString(3);
                    String plate = rs.getString(4);
                    String status = rs.getString(5);

                    trips.add(new TripDisplay(date, start, end, plate, status));
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
            "    P.first_name || ' ' || P.first_surname AS driver_name, " +
            "    G.name AS gender, " +
            "    TRUNC(MONTHS_BETWEEN(SYSDATE, P.date_of_birth) / 12) AS age, " +
            "    S.name AS status, " +
            "    WP.latitude, " +
            "    WP.longitude, " +
            "    P1.name || ', ' || C1.name || ', ' || D1.name AS start_point, " +
            "    P2.name || ', ' || C2.name || ', ' || D2.name AS end_point, " +
            "    P.id AS person_id " +
            "FROM PU.TRIP T " +
            "JOIN PU.ROUTE R ON T.route_id = R.id " +
            "JOIN PU.VEHICLEXROUTE VR ON VR.route_id = R.id " +
            "JOIN PU.VEHICLE VEH ON VEH.id = VR.vehicle_id " +
            "JOIN PU.MAXCAPACITYXVEHICLE MCV ON MCV.vehicle_id = VEH.id " +
            "JOIN ADM.MAXCAPACITY MC ON MC.id = MCV.max_capacity_id " +
            "JOIN PU.STATUSXTRIP SX ON SX.trip_id = T.id " +
            "JOIN ADM.STATUS S ON S.id = SX.status_id " +
            "LEFT JOIN ADM.CHOSENCAPACITY CC ON CC.vehicle_X_route_id = VR.id " +
            "LEFT JOIN ADM.CURRENCY CUR ON CUR.id = T.id_currency " +
            "JOIN PU.DRIVERXVEHICLE DV ON DV.vehicle_id = VEH.id " +
            "JOIN PU.DRIVER D ON D.person_id = DV.driver_id " +
            "JOIN ADM.PERSON P ON P.id = D.person_id " +
            "JOIN ADM.GENDER G ON G.id = P.gender_id " +
            "LEFT JOIN PU.WAYPOINT WP ON WP.route_id = R.id " +
            "JOIN ( " +
            "    SELECT route_id, district_id FROM ( " +
            "        SELECT route_id, district_id, ROW_NUMBER() OVER (PARTITION BY route_id ORDER BY id) rn FROM PU.WAYPOINT WHERE district_id IS NOT NULL) WHERE rn = 1 " +
            ") WP1 ON WP1.route_id = R.id " +
            "JOIN ADM.DISTRICT D1 ON D1.id = WP1.district_id " +
            "JOIN ADM.CANTON C1 ON C1.id = D1.canton_id " +
            "JOIN ADM.PROVINCE P1 ON P1.id = C1.province_id " +
            "JOIN ( " +
            "    SELECT route_id, district_id FROM ( " +
            "        SELECT route_id, district_id, ROW_NUMBER() OVER (PARTITION BY route_id ORDER BY id DESC) rn FROM PU.WAYPOINT WHERE district_id IS NOT NULL) WHERE rn = 1 " +
            ") WP2 ON WP2.route_id = R.id " +
            "JOIN ADM.DISTRICT D2 ON D2.id = WP2.district_id " +
            "JOIN ADM.CANTON C2 ON C2.id = D2.canton_id " +
            "JOIN ADM.PROVINCE P2 ON P2.id = C2.province_id " +
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
                    String phoneSQL = "SELECT PH.phone_number FROM ADM.PERSON P " +
                                      "JOIN PU.PHONE_PERSON PP ON PP.person_id = P.id " +
                                      "JOIN PU.PHONE PH ON PH.id = PP.phone_id " +
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