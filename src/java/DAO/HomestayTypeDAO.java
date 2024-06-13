
package DAO;

import model.HomestayType;
import java.sql.*;
import java.util.ArrayList;
/**
 *
 * @author PC
 */
public class HomestayTypeDAO extends DAO{
    public static HomestayType getHomestayTypeById(int id){
        try(Connection con = getConnection()) {
            PreparedStatement stmt=con.prepareStatement("select * from tblHomestayType where ht_type_id=?");
            stmt.setInt(1, id);
            return createHomestayTypeBaseResultSet(stmt.executeQuery()).get(0);
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static ArrayList<HomestayType>getAll(){
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("select * from tblHomestayType");
            return createHomestayTypeBaseResultSet(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    private static ArrayList<HomestayType>createHomestayTypeBaseResultSet(ResultSet rs){
        try (Connection con = getConnection()){
            ArrayList<HomestayType>result = new ArrayList<>();
            while(rs.next()){
                result.add(new HomestayType(rs.getInt("ht_type_id"), rs.getString("ht_type_name")));
            }
            return result;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public static void main(String[] args) {
        ArrayList<HomestayType>arr=getAll();
        arr.forEach(i -> System.out.println(i.getHomestay_type_name()));
    }
}
