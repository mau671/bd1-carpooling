package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Institution;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for Institution-Person operations using MySQL stored procedures
 */
public class InstitutionPersonDAO {

    /**
     * Gets all institutions associated with a person
     * 
     * @param personId The person ID
     * @param conn Database connection
     * @return List of Institution entities
     * @throws SQLException if a database error occurs
     */
    public List<Institution> getInstitutionsByPerson(long personId, Connection conn) throws SQLException {
        List<Institution> institutions = new ArrayList<>();
        String sql = "{call carpooling_adm.get_person_institutions(?)}";
        
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, personId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Institution institution = new Institution();
                    institution.setId(rs.getLong("id"));
                    institution.setName(rs.getString("name"));
                    institutions.add(institution);
                }
            }
        }
        
        return institutions;
    }
} 