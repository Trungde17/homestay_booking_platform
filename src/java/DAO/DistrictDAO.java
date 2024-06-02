
package DAO;

import java.sql.*;
import model.District;
public class DistrictDAO extends DAO{
    public static District getDistrictById(int id){
        try(Connection con=getConnection()) {
            PreparedStatement stmt=con.prepareStatement("select*from tblDnDistrict where district_id=?");
            stmt.setInt(1, id);
            ResultSet rs=stmt.executeQuery();
            if(rs.next()){
                return new District(rs.getInt("district_id"), rs.getString("district_name"));
            }
        } catch (Exception e) {
            System.out.println(id);
        }
        return null;
    }
    public static void main(String[] args) {
        System.out.println(getDistrictById(1).getDistrict_name());
    }
}
