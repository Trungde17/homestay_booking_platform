package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.HomestayImg;

public class HomestayImgDAO extends DAO {

    public static ArrayList<HomestayImg> getHomestayImgs(int homestay_id) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblHomestayImg where ht_id=?");
            stmt.setInt(1, homestay_id);
            ResultSet rs = stmt.executeQuery();
            ArrayList<HomestayImg> imgs = new ArrayList<>();
            while (rs.next()) {
                imgs.add(new HomestayImg(rs.getInt("img_id"), rs.getString("image_url"), rs.getInt("img_role")));
            }
            return imgs;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static int InsertHomestayImg(int homestay_id, String url) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("insert into tblHomestayImg(ht_id, img_id, image_url) values(?, ?, ?)");
            stmt.setInt(1, homestay_id);
            stmt.setInt(2, count() + 1);
            stmt.setString(3, url);
            stmt.executeUpdate();
            return 1;
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }

    public static int count() {
        int number = 0;
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select COUNT(*) number FROM tblHomestayImg");
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("number");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return number;
    }

    public static void main(String[] args) {
        System.out.println(count());
    }
}
