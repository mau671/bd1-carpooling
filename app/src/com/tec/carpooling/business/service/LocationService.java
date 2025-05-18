/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tec.carpooling.business.service;

import com.tec.carpooling.data.connection.DatabaseConnection;
import com.tec.carpooling.data.dao.CountryDAO;
import com.tec.carpooling.data.dao.ProvinceDAO;
import com.tec.carpooling.data.dao.CantonDAO;
import com.tec.carpooling.data.dao.DistrictDAO;
import com.tec.carpooling.domain.entity.Country;
import com.tec.carpooling.domain.entity.Province;
import com.tec.carpooling.domain.entity.Canton;
import com.tec.carpooling.domain.entity.District;

import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.sql.Types;

import java.util.List;

/**
 *
 * @author hidal
 */
public class LocationService {
    private final CountryDAO countryDAO = new CountryDAO();
    private final ProvinceDAO provinceDAO = new ProvinceDAO();
    private final CantonDAO cantonDAO = new CantonDAO();
    private final DistrictDAO districtDAO = new DistrictDAO();

    public List<Country> getAllCountries() throws SQLException {
        return countryDAO.getAllCountries();
    }

    public List<Province> getProvincesByCountry(long countryId) throws SQLException {
        return provinceDAO.getProvincesByCountry(countryId);
    }

    public List<Canton> getCantonsByProvince(long provinceId) throws SQLException {
        return cantonDAO.getCantonsByProvince(provinceId);
    }

    public List<District> getDistrictsByCanton(long cantonId) throws SQLException {
        return districtDAO.getDistrictsByCanton(cantonId);
    }
}

