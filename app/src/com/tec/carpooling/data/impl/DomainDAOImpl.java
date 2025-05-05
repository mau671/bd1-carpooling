package com.tec.carpooling.data.impl;

import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.data.dao.DomainDAO;
import com.tec.carpooling.domain.entity.Domain;
import com.tec.carpooling.exception.DomainManagementException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;

/**
 * Implementation of the DomainDAO interface that handles database operations for Domain entities.
 * This class interacts with Oracle stored procedures in the ADM_DOMAIN_MGMT_PKG package.
 */
public class DomainDAOImpl implements DomainDAO {

    /**
     * Saves a domain to the database.
     *
     * @param domain The domain to be saved
     * @return The saved domain with its generated ID
     * @throws SQLException If a database access error occurs
     * @throws DomainManagementException If a domain business rule is violated
     */
    @Override
    public Domain save(Domain domain) throws SQLException, DomainManagementException {
        String sql = "{call ADM.ADM_DOMAIN_MGMT_PKG.register_domain(?, ?)}";
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {

            cs.setString(1, domain.getName());
            cs.registerOutParameter(2, Types.NUMERIC); // o_domain_id
            cs.execute();
            long generatedId = cs.getLong(2);
            if (generatedId <= 0) {
                throw new SQLException("The register_domain procedure did not return an ID.");
            }
            domain.setId(generatedId);

        } catch (SQLException e) {
            handleDomainException(e, domain.getName(), "register");
        }
        return domain;
    }

    /**
     * Deletes a domain from the database.
     *
     * @param id The ID of the domain to delete
     * @throws SQLException If a database access error occurs
     * @throws DomainManagementException If the domain cannot be deleted due to dependencies
     */
    @Override
    public void delete(long id) throws SQLException, DomainManagementException {
        String sql = "{call ADM.ADM_DOMAIN_MGMT_PKG.delete_domain(?)}";
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {
            cs.setLong(1, id);
            cs.execute();
        } catch (SQLException e) {
            handleDomainException(e, String.valueOf(id), "delete");
        }
    }

    /**
     * Finds a domain by its ID.
     *
     * @param id The ID of the domain to find
     * @return The found domain or null if not found
     * @throws SQLException If a database access error occurs
     */
    @Override
    public Domain findById(long id) throws SQLException {
        // Uses PL/SQL function that returns a cursor
        String sql = "{? = call ADM.ADM_DOMAIN_MGMT_PKG.find_domain_by_id_cursor(?)}";
        Domain domain = null;
        ResultSet rs = null;
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {

            cs.registerOutParameter(1, OracleTypes.CURSOR); // Output cursor parameter
            cs.setLong(2, id);
            cs.execute();
            rs = (ResultSet) cs.getObject(1); // Get the cursor

            if (rs != null && rs.next()) { // Process the single expected record
                domain = mapToDomain(rs);
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in findDomainById:");
            e.printStackTrace();
            throw e;
        } finally {
            // Ensure ResultSet is closed
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            // CallableStatement is closed in try-with-resources
        }
        return domain;
    }

    /**
     * Retrieves all domains from the database.
     *
     * @return A list of all domains
     * @throws SQLException If a database access error occurs
     */
    @Override
    public List<Domain> findAll() throws SQLException {
        String sql = "{? = call ADM.ADM_DOMAIN_MGMT_PKG.find_all_domains_cursor()}";
        List<Domain> domains = new ArrayList<>();
        ResultSet rs = null;
        try (Connection conn = DatabaseConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {

            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);

            while (rs != null && rs.next()) {
                domains.add(mapToDomain(rs));
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in findAllDomains:");
            e.printStackTrace();
            throw e;
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        }
        return domains;
    }

    /**
     * Maps a ResultSet record to a Domain entity.
     *
     * @param rs The ResultSet containing domain data
     * @return A Domain object populated with ResultSet data
     * @throws SQLException If a database access error occurs
     */
    private Domain mapToDomain(ResultSet rs) throws SQLException {
        Domain domain = new Domain();
        domain.setId(rs.getLong("id"));
        domain.setName(rs.getString("name"));
        return domain;
    }

    /**
     * Handles SQL exceptions and translates them to domain-specific exceptions.
     *
     * @param e The SQL exception to handle
     * @param identifier The domain identifier (ID or name) that caused the error
     * @param operation The operation that failed (e.g., "register", "delete")
     * @throws SQLException If the error is not a domain-specific error
     * @throws DomainManagementException If the error is related to domain business rules
     */
    private void handleDomainException(SQLException e, String identifier, String operation) 
            throws SQLException, DomainManagementException {
        int errorCode = e.getErrorCode();
        if (errorCode == 20101 || errorCode == 20111) {
            throw new DomainManagementException("Error " + operation + "ing domain '" + identifier + "': " 
                    + e.getMessage().split("ORA-\\d{5}:\\s*")[1].trim(), e);
        } else if (errorCode == 20102) {
            throw new DomainManagementException("Error " + operation + "ing domain: Domain '" 
                    + identifier + "' already exists.", e);
        } else if (errorCode == 20112) {
            throw new DomainManagementException("Error " + operation + "ing domain: Domain ID '" 
                    + identifier + "' is in use.", e);
        } else {
            System.err.println("Unmapped SQL error when " + operation + "ing domain " + identifier + ":");
            e.printStackTrace();
            throw e;
        }
    }
}