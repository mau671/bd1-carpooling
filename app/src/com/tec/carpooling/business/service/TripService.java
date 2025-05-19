/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.business.service;

import com.tec.carpooling.data.dao.RouteDAO;
import com.tec.carpooling.data.dao.VehicleRouteDAO;
import com.tec.carpooling.data.dao.ChosenCapacityDAO;
import com.tec.carpooling.data.dao.TripDAO;
import com.tec.carpooling.data.dao.WaypointDAO;
import com.tec.carpooling.domain.entity.Route;
import com.tec.carpooling.domain.entity.VehicleRoute;
import com.tec.carpooling.domain.entity.ChosenCapacity;
import com.tec.carpooling.domain.entity.Trip;
import com.tec.carpooling.domain.entity.Waypoint;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Date;
import java.util.List;
import java.sql.CallableStatement;

import org.openstreetmap.gui.jmapviewer.Coordinate;

/**
 *
 * @author hidal
 */
public class TripService {

    private final RouteDAO routeDAO = new RouteDAO();
    private final VehicleRouteDAO vehicleRouteDAO = new VehicleRouteDAO();
    private final ChosenCapacityDAO chosenCapacityDAO = new ChosenCapacityDAO();
    private final TripDAO tripDAO = new TripDAO();
    private final WaypointDAO waypointDAO = new WaypointDAO();

    public void createFullTripWithWaypoints(
            Timestamp startTime,
            Timestamp endTime,
            Date programmingDate,
            long vehicleId,
            int chosenCapacity,
            BigDecimal pricePerPassenger,
            Long currencyId,
            long startDistrictId,
            long endDistrictId,
            List<Coordinate> stops,
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
            long tripId = tripDAO.createTrip(vehicleId, routeId, pricePerPassenger, currencyId, conn);
            String sql = "{ call PU_TRIP_STATUS_PKG.assign_initial_status(?) }";
            try (CallableStatement stmt = conn.prepareCall(sql)) {
                stmt.setLong(1, tripId);
                stmt.execute();
            }
            
            // 5. Add Waypoints: Start and End Districts
            waypointDAO.createWaypointWithDistrict(routeId, startDistrictId, conn);
            waypointDAO.createWaypointWithDistrict(routeId, endDistrictId, conn);

            // 6. Add Coordinate Stops
            for (Coordinate coord : stops) {
                waypointDAO.createWaypointWithCoords(routeId, coord.getLat(), coord.getLon(), conn);
            }

            conn.commit();
        } catch (SQLException ex) {
            conn.rollback();
            throw ex;
        } finally {
            conn.setAutoCommit(true);
        }
    }
} 
