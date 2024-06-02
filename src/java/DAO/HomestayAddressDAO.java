package DAO;
import java.sql.*;
import java.util.ArrayList;
import model.HomestayAddress;
public class HomestayAddressDAO extends DAO{
    public static HomestayAddress getAddressById(int id){
        try(Connection con=getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblHomestayAddress where address_id=?");
            stmt.setInt(1, id);
            return createHomestayAddressBaseResultSet(stmt.executeQuery()).get(0);
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    private static ArrayList<HomestayAddress>createHomestayAddressBaseResultSet(ResultSet rs){
        try {
            ArrayList<HomestayAddress> result=new ArrayList<HomestayAddress>();
            while(rs.next()){
                result.add(new HomestayAddress(rs.getInt("address_id"), rs.getString("address_detail"), DistrictDAO.getDistrictById(rs.getInt("district_id"))));
            }
            return result;
        } catch (Exception e) {
        }
        return null;
    }
    public static void main(String[] args) {
        HomestayAddress add = getAddressById(1);
        System.out.println(add.getAddress_detai()+"/"+add.getDistrict().getDistrict_name());
    }
}
