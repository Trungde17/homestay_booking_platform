
package DAO;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import model.Bed;


public class BedDAO extends DAO{
    public static ArrayList<Bed>getAllBedType(){
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("select * from tblBedType");
            ResultSet rs=stmt.executeQuery();
            ArrayList<Bed>beds=new ArrayList<>();
            while(rs.next()){
                beds.add(new Bed(rs.getInt("bed_type_id"), rs.getString("bed_type_name")));
            }
            return beds;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static int insertRoomBeds(int room_id, Map<Integer, Integer>beds){
        int number=0;
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("insert into tblRoomBed values(?, ?, ?)");
            stmt.setInt(2, room_id);
            for (Map.Entry<Integer, Integer> entry : beds.entrySet()) {
                stmt.setInt(1, entry.getKey());
                stmt.setInt(3, entry.getValue());
                stmt.executeUpdate();
                number++;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return number;
    }
    
    public static Map<Bed, Integer> getBedsOfRoom(int room_id){
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("select * from tblRoomBed r join tblBedType bt "
                    + "on r.bed_type_id=bt.bed_type_id where room_id=?");
            stmt.setInt(1, room_id);
            ResultSet rs = stmt.executeQuery();
            Map<Bed, Integer> beds=new LinkedHashMap<>();
            while(rs.next()){
                beds.put(new Bed(rs.getInt("bed_type_id"), rs.getString("bed_type_name")), rs.getInt("bed_number"));
            }
            return beds;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public static void main(String[] args) {
        ArrayList<Bed>beds=getAllBedType();
        for(Bed bed:beds){
            System.out.println(bed.getBed_type());
        }
    }
}
