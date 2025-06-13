
package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Person;
import java.sql.Connection;
import java.sql.SQLException;

public interface PersonUpdateDAO {
    void updatePerson(Person person, Connection conn) throws SQLException;
}
