
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
      public static boolean delete(int room_id){
        try(Connection con=getConnection()) {
            PreparedStatement stmt=con.prepareStatement("delete tblRoomBed  where room_id=?");
            stmt.setInt(1, room_id);
            stmt.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
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
   public static int updateRoomBeds(int room_id, Map<Integer, Integer> beds) {
    int number = 0;
    try (Connection con = getConnection()) {
        

        // Prepare statements for update and insert
        PreparedStatement updateStmt = con.prepareStatement(
            "UPDATE tblRoomBed SET bed_number = ? WHERE room_id = ? AND bed_type_id = ?"
        );
        PreparedStatement insertStmt = con.prepareStatement(
            "INSERT INTO tblRoomBed (bed_type_id, room_id, bed_number) VALUES (?, ?, ?)"
        );

        // Loop through the beds map and either update or insert each entry
        for (Map.Entry<Integer, Integer> entry : beds.entrySet()) {
            int bed_type_id = entry.getKey();
            int bed_number = entry.getValue();

            // Try to update existing bed
            updateStmt.setInt(1, bed_number);
            updateStmt.setInt(2, room_id);
            updateStmt.setInt(3, bed_type_id);
            int rowsAffected = updateStmt.executeUpdate();

            // If no rows were updated, insert new bed
            if (rowsAffected == 0) {
                insertStmt.setInt(1, bed_type_id);
                insertStmt.setInt(2, room_id);
                insertStmt.setInt(3, bed_number);
                insertStmt.executeUpdate();
            }
            number++;
        }

        con.commit(); // commit transaction
    } catch (Exception e) {
        System.out.println(e);
       
        
    }
    return number;
}

    public static void main(String[] args) {
         int roomId = 1;

        // Create a map of bed_type_id and their corresponding quantities
        Map<Integer, Integer> bedsToUpdate = new LinkedHashMap<>();
        bedsToUpdate.put(1, 2); // bed_type_id 1 with quantity 2
        bedsToUpdate.put(2, 3); // bed_type_id 2 with quantity 3

        // Update the room beds
        int numberOfUpdates = updateRoomBeds(roomId, bedsToUpdate);
        System.out.println("Number of updates: " + numberOfUpdates);

        // Fetch and print the updated beds of the room
        Map<Bed, Integer> updatedBeds = getBedsOfRoom(roomId);
        if (updatedBeds != null) {
            for (Map.Entry<Bed, Integer> entry : updatedBeds.entrySet()) {
                System.out.println(entry.getKey().getBed_type() + ": " + entry.getValue());
            }
        } else {
            System.out.println("No beds found for the given room.");
        }
    
       Map<Bed, Integer> beds = getBedsOfRoom(1);
        if (beds != null) {
            for (Map.Entry<Bed, Integer> entry : beds.entrySet()) {
                System.out.println(entry.getKey().getBed_type() + ": " + entry.getValue());
            }
        } else {
            System.out.println("No beds found for the given room.");
        }
    }
}
