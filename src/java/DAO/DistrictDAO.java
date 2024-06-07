
package DAO;

import java.sql.*;
import java.util.ArrayList;
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
    public static ArrayList<District>getAll(){
        try(Connection con=getConnection()) {
            PreparedStatement stmt=con.prepareStatement("select * from tblDnDistrict");
            ResultSet rs = stmt.executeQuery();
            ArrayList<District>district_list=new ArrayList<>();
            while(rs.next()){
                district_list.add(new District(rs.getInt("district_id"), rs.getString("district_name")));
            }
            return district_list;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public static void main(String[] args) {
        ArrayList<District>list=getAll();
        for(District district:list){
            System.out.println(district.getDistrict_name());
        }
    }
}
