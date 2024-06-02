
package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.HomestayFacilities;
public class HomestayFacilitiesDAO extends DAO{
    public static ArrayList<HomestayFacilities>getHomestayFacilities(int homestay_id){
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("select * from tblHomestayFacilities as hf join tblFacilitiesOfHomestay as fh "
                    + "on hf.facility_id=fh.facility_id where ht_id=?");
            stmt.setInt(1, homestay_id);
            return createHomestayFacilitiesBaseResultset(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    private static ArrayList<HomestayFacilities>createHomestayFacilitiesBaseResultset(ResultSet rs){
        try {
            ArrayList<HomestayFacilities>result=new ArrayList<>();
            while(rs.next()){
                result.add(new HomestayFacilities(rs.getInt("facility_id"), rs.getString("facility_name")));
            }
            return result;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
}
