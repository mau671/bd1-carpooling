/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.PaymentMethod;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.OracleTypes;

/**
 *
 * @author hidal
 */
public class PaymentMethodDAO {

    public List<PaymentMethod> getAllPaymentMethods(Connection conn) throws SQLException {
        List<PaymentMethod> list = new ArrayList<>();
        String sql = "{ ? = call ADM_PAYMENTMETHOD_PKG.get_all_payment_methods }";

        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.registerOutParameter(1, OracleTypes.CURSOR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    long id = rs.getLong("id");
                    String name = rs.getString("name");
                    list.add(new PaymentMethod(id, name));
                }
            }
        }
        return list;
    }
}
