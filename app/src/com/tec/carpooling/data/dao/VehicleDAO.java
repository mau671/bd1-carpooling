/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.VehicleInfo;
import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;
/**
 *
 * @author hidal
 */
public class VehicleDAO {

    public List<VehicleInfo> getVehiclesByDriver(long driverId) throws SQLException {
        List<VehicleInfo> vehicles = new ArrayList<>();

        Connection conn = DatabaseConnection.getConnection();
        CallableStatement stmt = conn.prepareCall("{CALL get_vehicles_by_driver(?)}");
        stmt.setLong(1, driverId);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            long id = rs.getLong("vehicle_id");
            String plate = rs.getString("plate_number");
            int capacity = rs.getInt("max_capacity");
            int trips = rs.getInt("trip_count");
            vehicles.add(new VehicleInfo(id, plate, capacity, trips));
        }

        return vehicles;
    }
}
