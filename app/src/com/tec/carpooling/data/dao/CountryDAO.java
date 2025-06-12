/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Country;
import com.tec.carpooling.data.connection.DatabaseConnection;

import java.sql.*;
import java.util.*;
import oracle.jdbc.OracleTypes;


/**
 *
 * @author hidal
 */
public class CountryDAO {
    public List<Country> getAllCountries() throws SQLException {
        List<Country> countries = new ArrayList<>();
        String sql = "{CALL carpooling_adm.get_all_countries()}";

        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement stmt = conn.prepareCall(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                long id = rs.getLong("id");
                String name = rs.getString("name");
                countries.add(new Country(id, name));
            }
        }

        return countries;
    }
}
