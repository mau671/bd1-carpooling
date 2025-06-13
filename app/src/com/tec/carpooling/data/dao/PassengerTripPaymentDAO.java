/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author hidal
 */
public class PassengerTripPaymentDAO {

    /**
     * Assigns a payment method to a passenger-trip by calling:
     *   CALL carpooling_adm.assign_payment_method(p_passenger_x_trip_id, p_payment_method_id)
     */
    public void assignPaymentMethod(long passengerXTripId,
                                    long paymentMethodId,
                                    Connection conn) throws SQLException {
        String sql = "{ CALL assign_payment_method(?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerXTripId);
            stmt.setLong(2, paymentMethodId);
            stmt.execute();
        }
    }

    /**
     * Updates the payment method on a passenger-trip by calling:
     *   CALL carpooling_adm.update_payment_method(p_passenger_x_trip_id, p_new_payment_method_id)
     */
    public void updatePaymentMethod(long passengerXTripId,
                                    long newPaymentMethodId,
                                    Connection conn) throws SQLException {
        String sql = "{ CALL update_payment_method(?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerXTripId);
            stmt.setLong(2, newPaymentMethodId);
            stmt.execute();
        }
    }

    /**
     * Deletes the payment method from a passenger-trip by calling:
     *   CALL carpooling_adm.delete_payment_method(p_passenger_x_trip_id)
     */
    public void deletePaymentMethod(long passengerXTripId,
                                    Connection conn) throws SQLException {
        String sql = "{ CALL delete_payment_method(?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerXTripId);
            stmt.execute();
        }
    }

}

