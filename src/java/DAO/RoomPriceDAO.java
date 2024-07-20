package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.RoomPrice;

public class RoomPriceDAO extends DAO {
    public static ArrayList<RoomPrice>getPrices(){
       try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("select * from tblPrice");
           
             return createRoomPricesBaseResultset(stmt.executeQuery());
  } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
        
    
    public static ArrayList<RoomPrice>getRoomPrices(int room_id){
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("select * from tblPrice as p join tblRoomPrice as rp "
                    + "on p.price_id=rp.price_id where room_id=?");
            stmt.setInt(1, room_id);
            try (ResultSet rs = stmt.executeQuery()) {
                return createRoomPricesBaseResultset(rs);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static int insertRoomPrice(int room_id, int price_id, double amount) {
        String sql = "insert into tblRoomPrice values(?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, price_id);
            stmt.setInt(2, room_id);
            stmt.setDouble(3, amount);
            stmt.executeUpdate();
            return 1;           
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }
    public static int changeAmount(int room_id, int price_id, double newAmount) {
        String sql = "UPDATE tblRoomPrice SET amount_per_night = ? WHERE room_id = ? AND price_id = ?";
        
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setDouble(1, newAmount);
            stmt.setInt(2, room_id);
            stmt.setInt(3, price_id);
            
            return stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
   
    public static ArrayList<RoomPrice>createRoomPricesBaseResultset( ResultSet rs){
        try {
            ArrayList<RoomPrice> result = new ArrayList<>();
            while (rs.next()) {
                result.add(new RoomPrice(rs.getInt("price_id"), rs.getString("price_type"), rs.getDouble("amount_per_night")));
            }
            return result;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public static void main(String[] args) {
        int roomId = 1;
        int priceId = 1;
        double newAmount = 200.0;
        
        // Change the amount for the specified room and price ID
        int result = changeAmount(roomId, priceId, newAmount);
        
        // Check the result of the update operation
        if (result > 0) {
            System.out.println("Amount updated successfully.");
        } else {
            System.out.println("Failed to update amount.");
        }
           ArrayList<RoomPrice> roomPrices = getRoomPrices(1);
        if (roomPrices != null && !roomPrices.isEmpty()) {
            for (RoomPrice rp : roomPrices) {
                System.out.println("Price ID: " + rp.getPrice_id() + ", Price Type: " + rp.getPrice_name() + ", Amount per Night: " + rp.getAmount());
            }
        } else {
            System.out.println("No prices found for the given room.");
        }
    }
}
