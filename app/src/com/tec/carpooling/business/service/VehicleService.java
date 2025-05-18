/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.business.service;

import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.sql.Types;

/**
 *
 * @author hidal
 */
public class VehicleService {
    public long addVehicle(String plate) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        CallableStatement stmt = conn.prepareCall("{ call PU_VEHICLE_MGMT_PKG.create_vehicle(?, ?) }");
        stmt.setString(1, plate);
        stmt.registerOutParameter(2, Types.BIGINT);
        stmt.execute();
        return stmt.getLong(2); // vehicle ID
    }

    public void assignCapacity(long vehicleId, long capacityId) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        CallableStatement stmt = conn.prepareCall("{ call PU_VEHICLECAPACITY_PKG.assign_capacity_to_vehicle(?, ?) }");
        stmt.setLong(1, vehicleId);
        stmt.setLong(2, capacityId);
        stmt.execute();
    }
    
    public void updateCapacity(long vehicleId, long newCapacityId) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        CallableStatement stmt = conn.prepareCall("{ call PU_VEHICLECAPACITY_PKG.update_vehicle_capacity(?, ?) }");
        stmt.setLong(1, vehicleId);
        stmt.setLong(2, newCapacityId);
        stmt.execute();
    }

    public void assignToDriver(long vehicleId, long driverId) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        CallableStatement stmt = conn.prepareCall("{ call PU_VEHICLE_DRIVER_PKG.assign_vehicle_to_driver(?, ?) }");
        stmt.setLong(1, driverId);
        stmt.setLong(2, vehicleId);
        stmt.execute();
    }
    
    public void updatePlate(long vehicleId, String newPlate) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        CallableStatement stmt = conn.prepareCall("{ call PU_VEHICLE_MGMT_PKG.update_vehicle(?, ?) }");
        stmt.setLong(1, vehicleId);
        stmt.setString(2, newPlate);
        stmt.execute();
    }
}
