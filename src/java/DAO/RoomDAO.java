
package DAO;
import java.sql.*;
import java.util.ArrayList;
import java.util.Map;
import model.Bed;
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
    
    public static ArrayList<Room> getAllHomestayRooms(int homestay_id){
        try(Connection con=getConnection()) {
            PreparedStatement stmt=con.prepareStatement("select * from tblRoom where ht_id=?");
            stmt.setInt(1, homestay_id);
            return createRoomsBaseResultset(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public static int insertRoomOfHomestay(int homestay_id, int room_id, String room_name, int capacity){
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("insert into tblRoom(room_id, room_name, ht_id, capacity)"
                    + "values(?, ?, ?, ?)");
            stmt.setInt(1, room_id);
            stmt.setString(2, room_name);
            stmt.setInt(3, homestay_id);
            stmt.setInt(4, capacity);
            stmt.executeUpdate();
            return 1;
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }
    
    public static int count(){
        
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("select count(*) number from tblRoom");
            ResultSet rs=stmt.executeQuery();
            if(rs.next()){
                return rs.getInt("number");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
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
                Map<Bed, Integer>beds=BedDAO.getBedsOfRoom(id);
                ArrayList<Img>imgs=RoomImgDAO.getRoomImgs(id);
                ArrayList<RoomFacilities>facilities=RoomFacilitiesDAO.getRoomFacilities(id);
                ArrayList<RoomPrice>prices=RoomPriceDAO.getRoomPrices(id);
                boolean status=rs.getBoolean("room_status");
                rooms.add(new Room(id, room_name, room_name, capacity, size, beds, imgs, facilities, prices, status));
            }
            return rooms;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public static void main(String[] args) {
        System.out.println(count());
    }
}
