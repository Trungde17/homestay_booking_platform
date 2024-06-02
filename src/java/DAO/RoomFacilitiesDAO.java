
package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.RoomFacilities;
public class RoomFacilitiesDAO extends DAO{
    public static ArrayList<RoomFacilities>getRoomFacilities(int room_id){
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("select * from tblRoomFacilities as rf join tblFacilitiesOfRoom as fr "
                    + "on rf.facility_id=fr.facility_id where room_id=?");
            stmt.setInt(1, room_id);
            return createRoomFacilitiesBaseResultset(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    private static ArrayList<RoomFacilities>createRoomFacilitiesBaseResultset(ResultSet rs){
        try {
            ArrayList<RoomFacilities>result=new ArrayList<>();
            while(rs.next()){
                result.add(new RoomFacilities(rs.getInt("facility_id"), rs.getString("facility_name")));
            }
            return result;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
}
