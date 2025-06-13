
package com.tec.carpooling.data.dao.impl;

import com.tec.carpooling.data.dao.PersonUpdateDAO;
import com.tec.carpooling.domain.entity.Person;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class PersonUpdateDAOImpl implements PersonUpdateDAO {
    private static final String UPDATE_PERSON_PROCEDURE = 
        "{call carpooling_adm.update_person(?, ?, ?, ?, ?, ?, ?, ?, ?)}";
    
    @Override
    public void updatePerson(Person person, Connection conn) throws SQLException {
        try (CallableStatement stmt = conn.prepareCall(UPDATE_PERSON_PROCEDURE)) {
            
            // Set input parameters
            stmt.setLong(1, person.getId());
            stmt.setString(2, person.getFirstName());
            stmt.setString(3, person.getSecondName());
            stmt.setString(4, person.getFirstSurname());
            stmt.setString(5, person.getSecondSurname());
            stmt.setLong(6, person.getTypeIdentificationId());
            stmt.setString(7, person.getIdentificationNumber());
             
            java.sql.Date sqlDate = person.getDateOfBirth() != null ? 
                new java.sql.Date(person.getDateOfBirth().getTime()) : null;
            stmt.setDate(8, sqlDate);
            
            stmt.setLong(9, person.getGenderId());
            stmt.execute();
        }
    }
}
