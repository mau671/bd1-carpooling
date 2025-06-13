package com.tec.carpooling.data.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for Email operations using MySQL stored procedures
 */
public class EmailDAO {

    /**
     * Gets all email addresses for a person with their domains
     * 
     * @param personId The person ID
     * @param conn Database connection
     * @return List of complete email addresses (name@domain)
     * @throws SQLException if a database error occurs
     */
    public List<String> getEmailsByPerson(long personId, Connection conn) throws SQLException {
        List<String> emails = new ArrayList<>();
        String sql = "{call carpooling_adm.get_person_emails(?)}";
        
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, personId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String fullEmail = rs.getString("full_email");
                    emails.add(fullEmail);
                }
            }
        }
        
        return emails;
    }
    
    public void deleteEmailByAddress(Connection conn, String emailAddress) throws SQLException {
        String sql = "{call carpooling_pu.DELETE_EMAIL_BY_ADDRESS(?)}";

        try (CallableStatement cs = conn.prepareCall(sql)) {
            cs.setString(1, emailAddress);  // Parámetro: dirección de email

            // Ejecutar el procedimiento
            cs.execute();

            // Opcional: Verificar si se eliminó algún registro
            if (cs.getUpdateCount() == 0) {
                throw new SQLException("No se encontró el email para eliminar");
            }
        }
    }
} 