
package DAO;
import java.sql.*;
import java.util.Date;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import model.Bed;
import model.Img;
import model.Room;
import model.RoomFacilities;
import model.RoomPrice;
public class RoomDAO extends DAO{
    public static ArrayList<Room> getRoomsOfHomestay(int homestay_id){
        try(Connection con=getConnection();
                PreparedStatement stmt=con.prepareStatement("select * from tblRoom where ht_id=?");) {
            
            stmt.setInt(1, homestay_id);
            return createRoomsBaseResultset(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
            
        }
        return null;
    }
    public static Room getRoomById(int room_id){
        try (Connection con=getConnection();
                PreparedStatement stmt=con.prepareStatement("select * from tblRoom where room_id=?");){
            
            stmt.setInt(1, room_id);
            return createRoomsBaseResultset(stmt.executeQuery()).get(0);
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public static Map<Room, Integer>getRoomBookingBasicInfor(int booking_id){
        try (Connection con=getConnection();
                PreparedStatement stmt = con.prepareStatement("select * from tblBooking_detail bd join tblRoom r on bd.room_id=r.room_id where booking_id=?");){
            
            stmt.setInt(1, booking_id);
            ResultSet rs=stmt.executeQuery();
            Map<Room, Integer>rooms=new LinkedHashMap<>();
            while(rs.next()){
                rooms.put(new Room(rs.getInt("room_id"),rs.getString("room_name"), rs.getInt("capacity"), rs.getString("size"), 
                        RoomImgDAO.getRoomImgs(rs.getInt("room_id")), RoomPriceDAO.getRoomPrices(rs.getInt("room_id"))), rs.getInt("number_of_guest"));
            }
            return rooms;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static ArrayList<Room> getAllHomestayRooms(int homestay_id){
        try(Connection con=getConnection();
                PreparedStatement stmt=con.prepareStatement("select * from tblRoom where ht_id=?");) {
            
            stmt.setInt(1, homestay_id);
            return createRoomsBaseResultset(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static int insertRoomOfHomestay(int homestay_id, int room_id, String room_name, int capacity){
        try (Connection con=getConnection();
                PreparedStatement stmt=con.prepareStatement("insert into tblRoom(room_id, room_name, ht_id, capacity)"
                    + "values(?, ?, ?, ?)");){
            
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
    
   // Update Room Information including related data
   public static boolean changeName(int room_id, String name){
        try(Connection con=getConnection();
                PreparedStatement stmt=con.prepareStatement("Update tblRoom set room_name=? where room_id=?");) {
            
            stmt.setString(1, name);
            stmt.setInt(2, room_id);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }
   public static boolean changeStatus(int room_id, boolean status){
        try(Connection con=getConnection();
                PreparedStatement stmt=con.prepareStatement("update tblRoom set room_status= ? where room_id=?");) {
            
            stmt.setBoolean(1, status);
            stmt.setInt(2, room_id);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }
           
    public static boolean changeDescription(int room_id, String description){
        try(Connection con=getConnection();
                PreparedStatement stmt=con.prepareStatement("Update tblRoom set room_description=? where room_id=?");) {
            
            stmt.setString(1, description);
            stmt.setInt(2, room_id);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }
    
    
    public static boolean changeCapaciy(int room_id, int capacity ){
        try (Connection con=getConnection();
                PreparedStatement stmt=con.prepareStatement("Update tblRoom set capacity =? where room_id=?");){
            
            stmt.setInt(1, capacity);
            stmt.setInt(2, room_id);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }
    
    public static boolean changeSize(int room_id, String size){
        try (Connection con=getConnection();
                PreparedStatement stmt=con.prepareStatement("Update tblRoom set size=? where room_id=?");){
            
            stmt.setString(1, size);
            stmt.setInt(2, room_id);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }
    
//    public static boolean changeStatus(boolean room_status){
//        try (Connection con=getConnection()){
//            PreparedStatement stmt=con.prepareStatement("Update tblRoom set room_status= ?");
//            stmt.setBoolean(1, room_status);
//            stmt.executeUpdate();
//            return true;
//        } catch (Exception e) {
//            System.out.println(e);
//        }
//        return false;
//    }
    // Delete Room
    public static boolean deleteRoom(int room_id) {
    try (Connection con = getConnection()) {
       
      

        // Delete room images from tblRoomImg
        PreparedStatement stmtRoomImg = con.prepareStatement("DELETE FROM tblRoomImg WHERE room_id = ?");
        stmtRoomImg.setInt(1, room_id);
        stmtRoomImg.executeUpdate();

        // Delete room facilities from tblRoomFacilities
        PreparedStatement stmtRoomFacilities = con.prepareStatement("DELETE FROM tblFacilitiesOfRoom WHERE room_id = ?");
        stmtRoomFacilities.setInt(1, room_id);
        stmtRoomFacilities.executeUpdate();

        // Delete room prices from tblRoomPrice
        PreparedStatement stmtRoomPrice = con.prepareStatement("DELETE FROM tblRoomPrice WHERE room_id = ?");
        stmtRoomPrice.setInt(1, room_id);
        stmtRoomPrice.executeUpdate();

        // Delete room bookings from tblBooking_detail (if any)
        PreparedStatement stmtBookingDetail = con.prepareStatement("DELETE FROM tblBooking_detail WHERE room_id = ?");
        stmtBookingDetail.setInt(1, room_id);
        stmtBookingDetail.executeUpdate();
        
          PreparedStatement stmtRoom = con.prepareStatement("DELETE FROM tblRoom WHERE room_id = ?");
        stmtRoom.setInt(1, room_id);
        stmtRoom.executeUpdate();

        return true;
    } catch (Exception e) {
        System.out.println(e);
    }
    return false;
}

    
    public static int insertIntoBookingDetail(int booking_id,Map<Room, Integer>rooms){
        int number=0;
        try (Connection con=getConnection();
                PreparedStatement stmt=con.prepareStatement("insert into tblBooking_detail values(?, ?, ?)");){            
            
            stmt.setInt(1, booking_id);
            for (Map.Entry<Room, Integer> entry : rooms.entrySet()) {
                try {
                    stmt.setInt(2, entry.getKey().getRoom_id());
                    stmt.setInt(3, entry.getValue());
                    stmt.executeUpdate();
                } catch (SQLException sQLException) {
                    System.out.println(sQLException);
                }
                number++;
            }
        } catch (Exception e) {
        }
        return number;
    }
    public static int count(){
        
        try (Connection con=getConnection();
                PreparedStatement stmt=con.prepareStatement("select count(*) number from tblRoom");){
            
            ResultSet rs=stmt.executeQuery();
            if(rs.next()){
                return rs.getInt("number");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }
    
    public static ArrayList<Room>getRoomsOverlapOfBooking(int booking_id){
        try (Connection con=getConnection();
                PreparedStatement stmt=con.prepareStatement("EXEC dbo.CheckRoomOverlap @booking_id=?");){
            
            stmt.setInt(1, booking_id);
            ResultSet rs=stmt.executeQuery();
            ArrayList<Room>roomsOverlap=new ArrayList<>();
            while(rs.next()){
                try {
                    roomsOverlap.add(new Room(rs.getInt("room_id"), rs.getString("room_name"), rs.getBoolean("room_status")));
                } catch (SQLException sQLException) {
                    System.out.println(sQLException);
                }
            }
            return roomsOverlap;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public static ArrayList<Room>getAvailableRoomsOfHomestay(int homestay_id, Date checkin_date, Date checkout_date){
        try (Connection con=getConnection();
                PreparedStatement stmt=con.prepareStatement("EXEC GetAvailableRoomsOfHomestay @homestay_id=?, @date_checkin=?, @date_check_out=?");){
            
            stmt.setInt(1, homestay_id);
            stmt.setDate(2, new java.sql.Date(checkin_date.getTime()));
            stmt.setDate(3, new java.sql.Date(checkout_date.getTime()));
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
                Map<Bed, Integer>beds=BedDAO.getBedsOfRoom(id);
                ArrayList<Img>imgs=RoomImgDAO.getRoomImgs(id);
                ArrayList<RoomFacilities>facilities=RoomFacilitiesDAO.getRoomFacilities(id);
                ArrayList<RoomPrice>prices=RoomPriceDAO.getRoomPrices(id);
                boolean status=rs.getBoolean("room_status");
                Room room = new Room(id, room_name, dsr, capacity, size, beds, imgs, facilities, prices, status);
                room.setHt_id(rs.getInt("ht_id"));
                rooms.add(room);
            }
            return rooms;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public static void main(String[] args) {
//         Map<Room, Integer>rooms=getRoomBookingBasicInfor(5);
//         for (Map.Entry<Room, Integer> entry : rooms.entrySet()) {
//            Room key = entry.getKey();
//             System.out.println(key.getRoom_name());            
//        }
//        changeSize(6,"3");
        int testRoomId = 1; // Replace with an actual room_id from your database
    Room room = getRoomById(testRoomId);
    
    if (room != null) {
        System.out.println("Room ID: " + room.getRoom_id());
        System.out.println("Room Name: " + room.getRoom_name());
        System.out.println("Room Description: " + room.getRoom_description());
        System.out.println("Capacity: " + room.getCapacity());
        System.out.println("Size: " + room.getSize());
        // Add other fields as needed
    } else {
        System.out.println("Room not found with ID: " + testRoomId);
    }
}
    }

