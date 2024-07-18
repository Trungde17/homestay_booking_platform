package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.RoomFacilities;

public class RoomFacilitiesDAO extends DAO {
    
    public static ArrayList<RoomFacilities> getRoomFacilities(int room_id) {
        String sql = "select * from tblRoomFacilities as rf join tblFacilitiesOfRoom as fr "
                   + "on rf.facility_id=fr.facility_id where room_id=?";
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, room_id);
            try (ResultSet rs = stmt.executeQuery()) {
                return createRoomFacilitiesBaseResultset(rs);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static ArrayList<RoomFacilities> getAll() {
        String sql = "select * from tblRoomFacilities";
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            return createRoomFacilitiesBaseResultset(rs);
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static int insertRoomFacilities(int room_id, int[] facilities_list) {
        int number = 0;
        String sql = "insert into tblFacilitiesOfRoom(room_id, facility_id) values(?, ?)";
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, room_id);
            for (int id : facilities_list) {
                stmt.setInt(2, id);
                stmt.executeUpdate();
                number++;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return number;
    }
    
    private static ArrayList<RoomFacilities> createRoomFacilitiesBaseResultset(ResultSet rs) {
        try {
            ArrayList<RoomFacilities> result = new ArrayList<>();
            while (rs.next()) {
                result.add(new RoomFacilities(rs.getInt("facility_id"), rs.getString("facility_name")));
            }
            return result;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static boolean delete(int room_id) {
        String sql = "delete from tblFacilitiesOfRoom where room_id=?";
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, room_id);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }

    public static void main(String[] args) {
        ArrayList<RoomFacilities> list = getRoomFacilities(1);
        for (RoomFacilities r : list) {
            System.out.println(r.getFacilities_name());
        }
    }
}
