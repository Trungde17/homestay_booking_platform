package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.HomestayFacilities;

public class HomestayFacilitiesDAO extends DAO {

    public static ArrayList<HomestayFacilities> getHomestayFacilities(int homestay_id) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblHomestayFacilities as hf join tblFacilitiesOfHomestay as fh "
                    + "on hf.facility_id=fh.facility_id where ht_id=?");
            stmt.setInt(1, homestay_id);
            return createHomestayFacilitiesBaseResultset(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static int insertIntoHomestayFacilities(int homestay_id, int[] facilities_list) {
        int number=0;
        try (Connection con = getConnection()) {
            if (facilities_list != null) {
                PreparedStatement stmt = con.prepareStatement("insert into tblFacilitiesOfHomestay(ht_id, facility_id) values(?, ?)");
                stmt.setInt(1, homestay_id);
                for(int facilities_id:facilities_list){
                    stmt.setInt(2, facilities_id);
                    stmt.executeUpdate();
                    number++;
                }
            }
        } catch (Exception e) {
        }
        return number;
    }
       
    public static ArrayList<HomestayFacilities> getAll() {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblHomestayFacilities");
            return createHomestayFacilitiesBaseResultset(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    private static ArrayList<HomestayFacilities> createHomestayFacilitiesBaseResultset(ResultSet rs) {
        try {
            ArrayList<HomestayFacilities> result = new ArrayList<>();
            while (rs.next()) {
                result.add(new HomestayFacilities(rs.getInt("facility_id"), rs.getString("facility_name")));
            }
            return result;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        int[]list=new int[]{1, 2, 3, 4, 5};
        System.out.println(insertIntoHomestayFacilities(1, list));
    }
    
}
