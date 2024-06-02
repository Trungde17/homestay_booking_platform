
package DAO;
import java.sql.*;
import java.util.ArrayList;
import model.HomestayImg;

public class HomestayImgDAO extends DAO{
    public static ArrayList<HomestayImg>getHomestayImgs(int homestay_id){
        try(Connection con = getConnection()) {
            PreparedStatement stmt=con.prepareStatement("select * from tblHomestayImg where ht_id=?");
            stmt.setInt(1, homestay_id);
            ResultSet rs = stmt.executeQuery();
            ArrayList<HomestayImg>imgs=new ArrayList<>();
            while(rs.next()){
                imgs.add(new HomestayImg(rs.getInt("img_id"), rs.getString("image_url"), rs.getInt("img_role")));
            }
            return imgs;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
}
