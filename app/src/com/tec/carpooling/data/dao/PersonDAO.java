/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import java.sql.*;
import com.tec.carpooling.domain.entity.Person;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author hidal
 */
public class PersonDAO {

    public Person getPersonProfile(long personId, Connection conn) throws SQLException {
        Person person = null;

        String sql = "{ call ADM.ADM_PERSON_PKG.get_person_profile(?, ?, ?, ?, ?, ?, ?, ?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.setLong(1, personId);
            stmt.registerOutParameter(2, Types.VARCHAR); // first_name
            stmt.registerOutParameter(3, Types.VARCHAR); // second_name
            stmt.registerOutParameter(4, Types.VARCHAR); // first_surname
            stmt.registerOutParameter(5, Types.VARCHAR); // second_surname
            stmt.registerOutParameter(6, Types.VARCHAR); // identification_number
            stmt.registerOutParameter(7, Types.DATE);    // date_of_birth
            stmt.registerOutParameter(8, Types.NUMERIC); // gender_id
            stmt.registerOutParameter(9, Types.NUMERIC); // type_identification_id

            stmt.execute();
            
            person = new Person();
            person.setFirstName(stmt.getString(2));
            person.setSecondName(stmt.getString(3));
            person.setFirstSurname(stmt.getString(4));
            person.setSecondSurname(stmt.getString(5));
            person.setIdentificationNumber(stmt.getString(6));
            person.setDateOfBirth(stmt.getDate(7));
            person.setGenderId(stmt.getLong(8));
            person.setTypeIdentificationId(stmt.getLong(9));
        }

        return person;
    }
}

