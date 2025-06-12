package com.tec.carpooling.data.dao;

import com.tec.carpooling.domain.entity.Photo;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * DAO for Photo operations using MySQL stored procedures
 */
public class PhotoDAO {

    /**
     * Gets the latest photo for a person (profile picture)
     * 
     * @param personId The person ID
     * @param conn Database connection
     * @return Photo entity or null if no photo found
     * @throws SQLException if a database error occurs
     */
    public Photo getLatestPhoto(long personId, Connection conn) throws SQLException {
        Photo photo = null;
        String sql = "{call carpooling_adm.get_latest_photo(?)}";
        
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, personId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    photo = new Photo();
                    photo.setId(rs.getLong("id"));
                    photo.setImage(rs.getBytes("image"));
                    photo.setPersonId(personId);
                }
            }
        }
        
        return photo;
    }

    /**
     * Gets all photos for a person
     * 
     * @param personId The person ID
     * @param conn Database connection
     * @return Array of Photo entities or empty array if no photos found
     * @throws SQLException if a database error occurs
     */
    public Photo[] getAllPhotos(long personId, Connection conn) throws SQLException {
        java.util.List<Photo> photoList = new java.util.ArrayList<>();
        String sql = "{call carpooling_adm.get_photos(?)}";
        
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setLong(1, personId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Photo photo = new Photo();
                    photo.setId(rs.getLong("id"));
                    photo.setImage(rs.getBytes("image"));
                    photo.setPersonId(personId);
                    photoList.add(photo);
                }
            }
        }
        
        return photoList.toArray(new Photo[0]);
    }
} 