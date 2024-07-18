package DAO;

import model.HomestayType;
import java.sql.*;
import java.util.ArrayList;

public class HomestayTypeDAO extends DAO {
    
    public static HomestayType getHomestayTypeById(int id) {
        String sql = "select * from tblHomestayType where ht_type_id=?";
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                ArrayList<HomestayType> homestayTypes = createHomestayTypeBaseResultSet(rs);
                if (!homestayTypes.isEmpty()) {
                    return homestayTypes.get(0);
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static ArrayList<HomestayType> getAll() {
        String sql = "select * from tblHomestayType";
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            return createHomestayTypeBaseResultSet(rs);
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    private static ArrayList<HomestayType> createHomestayTypeBaseResultSet(ResultSet rs) {
        try {
            ArrayList<HomestayType> result = new ArrayList<>();
            while (rs.next()) {
                result.add(new HomestayType(rs.getInt("ht_type_id"), rs.getString("ht_type_name")));
            }
            return result;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static void main(String[] args) {
        ArrayList<HomestayType> arr = getAll();
        arr.forEach(i -> System.out.println(i.getHomestay_type_name()));
    }
}
