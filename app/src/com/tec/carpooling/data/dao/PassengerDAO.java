/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Passenger;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

/**
 *
 * @author hidal
 */
public class PassengerDAO {
    public Passenger getPassengerByUserId(long userId, Connection conn) throws SQLException {
        String sql = "SELECT person_id FROM PU.PASSENGER WHERE person_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Passenger p = new Passenger();
                    p.setId(rs.getLong("person_id"));
                    return p;
                }
            }
        }
        return null;
    }
}
