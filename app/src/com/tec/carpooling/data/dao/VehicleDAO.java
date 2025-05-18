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
        CallableStatement stmt = conn.prepareCall("{ ? = call PU_VEHICLE_DRIVER_PKG.get_vehicles_by_driver(?) }");
        stmt.registerOutParameter(1, OracleTypes.CURSOR);
        stmt.setLong(2, driverId);
        stmt.execute();

        ResultSet rs = (ResultSet) stmt.getObject(1);
        while (rs.next()) {
            String plate = rs.getString("plate_number");
            int capacity = rs.getInt("max_capacity");
            int trips = rs.getInt("trip_count"); // always 0 for now
            vehicles.add(new VehicleInfo(plate, capacity, trips));
        }

        return vehicles;
    }
}
