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

    public void assignPaymentMethod(long passengerXTripId, long paymentMethodId, Connection conn) throws SQLException {
        String sql = "{ call PU_PASSENGERXTRIPXPAYMENT_PKG.assign_payment_method(?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerXTripId);
            stmt.setLong(2, paymentMethodId);
            stmt.execute();
        }
    }

    public void updatePaymentMethod(long passengerXTripId, long newPaymentMethodId, Connection conn) throws SQLException {
        String sql = "{ call PU_PASSENGERXTRIPXPAYMENT_PKG.update_payment_method(?, ?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerXTripId);
            stmt.setLong(2, newPaymentMethodId);
            stmt.execute();
        }
    }

    public void deletePaymentMethod(long passengerXTripId, Connection conn) throws SQLException {
        String sql = "{ call PU_PASSENGERXTRIPXPAYMENT_PKG.delete_payment_method(?) }";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, passengerXTripId);
            stmt.execute();
        }
    }
}
