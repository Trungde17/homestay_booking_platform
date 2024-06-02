
package DAO;
import java.sql.*;
import java.util.ArrayList;
import model.Img;
import model.Room;
import model.RoomFacilities;
import model.RoomPrice;
public class RoomDAO extends DAO{
    public static ArrayList<Room> getRoomsOfHomestay(int homestay_id){
        try(Connection con=getConnection()) {
            PreparedStatement stmt=con.prepareStatement("select * from tblRoom where ht_id=?");
            stmt.setInt(1, homestay_id);
            return createRoomsBaseResultset(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
            
        }
        return null;
    }
    private static ArrayList<Room>createRoomsBaseResultset(ResultSet rs){
        try {
            ArrayList<Room>rooms=new ArrayList<>();
            while(rs.next()){
                int id = rs.getInt("room_id");
                String room_name=rs.getString("room_name");
                String dsr=rs.getString("room_description");
                int capacity=rs.getInt("capacity");
                String size=rs.getString("size");
                String bed_type=rs.getString("bed_type");
                ArrayList<Img>imgs=RoomImgDAO.getRoomImgs(id);
                ArrayList<RoomFacilities>facilities=RoomFacilitiesDAO.getRoomFacilities(id);
                ArrayList<RoomPrice>prices=RoomPriceDAO.getRoomPrices(id);
                boolean status=rs.getBoolean("room_status");
                rooms.add(new Room(id, room_name, room_name, capacity, size, bed_type, imgs, facilities, prices, status));
            }
            return rooms;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
}
