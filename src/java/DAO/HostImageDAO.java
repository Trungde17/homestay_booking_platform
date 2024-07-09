/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import static DAO.DAO.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.HomestayImg;

/**
 *
 * @author ASUS
 */


public class HostImageDAO {
    

    public static ArrayList<HomestayImg> getHostImgs(int hostId) {
        String query = "SELECT * FROM tblHostImg HERE id = ?";
        ArrayList<HomestayImg> imgs = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, hostId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    imgs.add(new HomestayImg(
                            rs.getInt("roles"),
                        rs.getInt("img_id"),
                        rs.getString("img_url")
                        
                    ));
                }
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return imgs;
    }

    public static boolean insertHostImg(int hostId, String url, int imgRole) {
        String query = "INSERT INTO tblHostImg(id, img_url, roles) VALUES (?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, hostId);
            stmt.setString(2, url);
            stmt.setInt(3, imgRole);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
       } catch (Exception e) {
            System.out.println(e.toString());
        }
        return false;
    }

    public static boolean deleteHostImg(int imgId) {
        String query = "DELETE FROM tblHostImg WHERE img_id = ?";
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, imgId);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return false;
    }

    public static int countHostImgs(int hostId) {
        String query = "SELECT COUNT(*) AS number FROM tblHostImg WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, hostId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("number");
                }
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return 0;
    }
    
    public static void main(String[] args) {

        int hostId = 1; // Replace with your host ID if needed
        String imageUrl = "http://example.com/image.png"; // Replace with an actual image URL
        int imgRole = 1; // Replace with the role of the image

        boolean success = insertHostImg(hostId, imageUrl, imgRole);

        if (success) {
            System.out.println("Image inserted successfully.");
        } else {
            System.out.println("Failed to insert image.");
        }
        System.out.println( getHostImgs(1));
    }
}