/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import java.sql.*;
import com.tec.carpooling.domain.entity.Person;

/**
 * DAO for Person operations using MySQL stored procedures
 */
public class PersonDAO {

    public Person getPersonProfile(long personId, Connection conn) throws SQLException {
        Person person = null;

        String sql = "{call carpooling_adm.find_person_by_id(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.setLong(1, personId);
            
            // Execute and get result set
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    person = new Person();
                    person.setId(rs.getLong("id"));
                    person.setFirstName(rs.getString("first_name"));
                    person.setSecondName(rs.getString("second_name"));
                    person.setFirstSurname(rs.getString("first_surname"));
                    person.setSecondSurname(rs.getString("second_surname"));
                    person.setIdentificationNumber(rs.getString("identification_number"));
                    person.setDateOfBirth(rs.getDate("date_of_birth"));
                    
                    // Set IDs using the original field types
                    person.setGenderId(rs.getLong("gender_id"));
                    person.setTypeIdentificationId(rs.getLong("type_identification_id"));
                }
            }
        }

        return person;
    }
}

