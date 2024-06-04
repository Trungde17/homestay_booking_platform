
package DAO;
import java.sql.*;
import java.util.ArrayList;
import model.Account;
import model.District;
import model.Homestay;
import model.HomestayFacilities;
import model.HomestayImg;
import model.HomestayType;
import model.Neighbourhood;
import model.Payment;
import model.Room;

public class HomestayDAO extends DAO{
    public static Homestay getHomestayById(int homestay_id){
        try (Connection con = getConnection()){
            PreparedStatement stmt = con.prepareStatement("select * from tblHomestay where ht_id = ?");
            stmt.setInt(1, homestay_id);
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static ArrayList<Homestay>createHomestayBaseResultSet(ResultSet rs){
        try {
            ArrayList<Homestay>result=new ArrayList<>();
            while(rs.next()){
                int id = rs.getInt("ht_id");
                String name = rs.getString("ht_name");
                Account owner=AccountDAO.getAccountById(rs.getInt("owner_id"));
                HomestayType type = HomestayTypeDAO.getHomestayTypeById(rs.getInt("ht_type_id"));
                String dsr = rs.getString("describe");
                District district = DistrictDAO.getDistrictById(rs.getInt("district_id"));
                String address_detail = rs.getString("address_detail");
                Payment payment=PaymentDAO.getPaymentById(rs.getInt("address_id"));
                String rules = rs.getString("ht_rules");
                ArrayList<HomestayImg>imgs=HomestayImgDAO.getHomestayImgs(id);
                ArrayList<HomestayFacilities>facilities=HomestayFacilitiesDAO.getHomestayFacilities(id);
                ArrayList<Neighbourhood>neighbourhoods=NeighbourhoodDAO.getNeighbourhoods(id);
                ArrayList<Room>rooms=RoomDAO.getRoomsOfHomestay(id);
                Date registration_date=rs.getDate("registration_date");
                Account admin=AccountDAO.getAccountById(rs.getInt("admin_id"));
                boolean status = rs.getBoolean("ht_status");
                result.add(new Homestay(id, name, owner, type, dsr, district, address_detail, payment, rules, imgs, 
                        facilities, neighbourhoods, registration_date, rooms, admin, status ));
            }
        } catch (Exception e) {
            System.out.println("");
        }
        return null;
    }
}
