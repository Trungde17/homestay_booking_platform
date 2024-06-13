
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
    public static ArrayList<RoomFacilities>getAll(){
        try (Connection con=getConnection()){
            PreparedStatement stmt = con.prepareStatement("select * from tblRoomFacilities");
            return createRoomFacilitiesBaseResultset(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static int insertRoomFacilities(int room_id, int[]facilities_list){
        int number=0;
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("insert into tblFacilitiesOfRoom(room_id, facility_id)"
                    + "values(?, ?)");
            stmt.setInt(1, room_id);
            for(int id : facilities_list){
                stmt.setInt(2, id);
                stmt.executeUpdate();
                number++;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return number;
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
    public static void main(String[] args) {
        ArrayList<RoomFacilities>list=getAll();
        for(RoomFacilities r:list){
            System.out.println(r.getFacilities_name());
        }
    }
}
