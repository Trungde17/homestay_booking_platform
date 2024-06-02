
package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.Img;
public class RoomImgDAO extends DAO{
    public static ArrayList<Img>getRoomImgs(int room_id){
        try (Connection con =getConnection()){
            PreparedStatement stmt = con.prepareStatement("select * from tblRoomImg where room_id=?");
            stmt.setInt(1, room_id);
            ResultSet rs=stmt.executeQuery();
            ArrayList<Img>imgs=new ArrayList<>();
            while(rs.next()){
                imgs.add(new Img(rs.getInt("img_id"), rs.getString("img_url")));
            }
            return imgs;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
}
