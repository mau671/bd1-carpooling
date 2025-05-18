/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.business.service;

import com.tec.carpooling.data.dao.RouteDAO;
import com.tec.carpooling.data.dao.VehicleRouteDAO;
import com.tec.carpooling.data.dao.ChosenCapacityDAO;
import com.tec.carpooling.data.dao.TripDAO;
import com.tec.carpooling.domain.entity.Route;
import com.tec.carpooling.domain.entity.VehicleRoute;
import com.tec.carpooling.domain.entity.ChosenCapacity;
import com.tec.carpooling.domain.entity.Trip;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Date;

/**
 *
 * @author hidal
 */
public class TripService {

    private final RouteDAO routeDAO = new RouteDAO();
    private final VehicleRouteDAO vehicleRouteDAO = new VehicleRouteDAO();
    private final ChosenCapacityDAO chosenCapacityDAO = new ChosenCapacityDAO();
    private final TripDAO tripDAO = new TripDAO();

    public void createFullTrip(
            Timestamp startTime,
            Timestamp endTime,
            Date programmingDate,
            long vehicleId,
            int chosenCapacity,
            BigDecimal pricePerPassenger,
            Long currencyId, // nullable if price is 0
            Connection conn
    ) throws SQLException {
        try {
            conn.setAutoCommit(false);

            // 1. Create Route
            long routeId = routeDAO.createRoute(startTime, endTime, programmingDate, conn);

            // 2. Assign Vehicle to Route
            long vehicleRouteId = vehicleRouteDAO.linkVehicleToRoute(vehicleId, routeId, conn);

            // 3. Save Chosen Capacity
            chosenCapacityDAO.saveChosenCapacity(vehicleRouteId, chosenCapacity, conn);

            // 4. Create Trip
            tripDAO.createTrip(vehicleId, routeId, pricePerPassenger, currencyId, conn);

            conn.commit();
        } catch (SQLException ex) {
            conn.rollback();
            throw ex;
        } finally {
            conn.setAutoCommit(true);
        }
    }
}
