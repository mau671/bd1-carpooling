/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Route;
import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.*;
import java.util.*;
import oracle.jdbc.OracleTypes;

import java.sql.Timestamp;
import java.sql.Date;

/**
 *
 * @author hidal
 */
public class RouteDAO {
    public long createRoute(Timestamp startTime, Timestamp endTime, Date programmingDate, Connection conn) throws SQLException {
        String sql = "{ call PU_ROUTE_MGMT_PKG.create_route(?, ?, ?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setTimestamp(1, startTime);
            stmt.setTimestamp(2, endTime);
            stmt.setDate(3, programmingDate);
            stmt.registerOutParameter(4, Types.BIGINT);
            stmt.execute();
            return stmt.getLong(4);
        }
    }
}
