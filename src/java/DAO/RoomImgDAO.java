
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
    public static int insertRoomImg(int room_id, String url){
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("insert tblRoomImg(room_id, img_id, img_url) values(?, ?, ?)");
            stmt.setInt(1, room_id);
            stmt.setInt(2, count()+1);
            stmt.setString(3, url);
            stmt.executeUpdate();
            return 1;
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }
    public static int count(){
        int number=0;
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("select COUNT(*) number from tblRoomImg");
            ResultSet rs=stmt.executeQuery();
            if(rs.next())return rs.getInt("number");
        } catch (Exception e) {
            System.out.println(e);
        }
        return number;
    }
    
    public static void main(String[] args) {
        ArrayList<Img>imgs=getRoomImgs(4);
        for(Img img:imgs){
            System.out.println(img.getImg_url());
        }
    }
}
