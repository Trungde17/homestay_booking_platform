/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import static DAO.DAO.getConnection;
import java.lang.System.Logger;
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
        String query = "SELECT * FROM tblHostImg WHERE id = ?";
        ArrayList<HomestayImg> imgs = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, hostId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    imgs.add(new HomestayImg(
                        rs.getInt("img_id"),
                        rs.getString("image_url"),
                        rs.getInt("img_role")
                    ));
                }
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return imgs;
    }

    public static boolean insertHostImg(int hostId, String url, int imgRole) {
        String query = "INSERT INTO tblHostImg(id, image_url, img_role) VALUES (?, ?, ?)";
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
}