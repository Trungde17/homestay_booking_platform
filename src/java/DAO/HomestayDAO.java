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
import model.Rule;
import java.util.Date;

public class HomestayDAO extends DAO {

    public static Homestay getHomestayById(int homestay_id) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblHomestay where ht_id = ?");
            stmt.setInt(1, homestay_id);
            return createHomestayBaseResultSet(stmt.executeQuery()).get(0);
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
        
    }
    
    public static boolean changeStatus(int homestay_id, int status){
        try(Connection con=getConnection()) {
            PreparedStatement stmt=con.prepareStatement("update tblHomestay set ht_status=? where ht_id=?");
            stmt.setInt(1, status);
            stmt.setInt(2, homestay_id);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }
    public static int countHomesaty() {
        int number = 0;
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select COUNT(*) as ht_number from tblHomestay");
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                number = rs.getInt("ht_number");
            }
            return number;
        } catch (Exception e) {
        }
        return number;
    }

    public static boolean insert(int homestay_id, String homestay_name, int homestay_type_id, String homestay_about, int owner_id, int payment_id) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("insert into tblHomestay(ht_id, ht_name, ht_type_id, describe, owner_id,"
                    + "payment_id, registration_date) "
                    + "values(?, ?, ?, ?, ?, ?, ?)");
            stmt.setInt(1, homestay_id);
            stmt.setString(2, homestay_name);
            stmt.setInt(3, homestay_type_id);
            stmt.setString(4, homestay_about);
            stmt.setInt(5, owner_id);
            stmt.setInt(6, payment_id);
            stmt.setDate(7, new java.sql.Date(new Date().getTime()));
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public static boolean update(int homestay_id, String homestay_rules) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("UPDATE tblHomestay set ht_rules=? where ht_id=?");
            stmt.setString(1, homestay_rules);
            stmt.setInt(2, homestay_id);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }

    public static boolean update(int homestay_id, int district_id, String address_detail) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("UPDATE tblHomestay set district_id=?, address_detail=? where ht_id=?");
            stmt.setInt(1, district_id);
            stmt.setString(2, address_detail);
            stmt.setInt(3, homestay_id);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }

    public static Homestay findRegisteredHomestays(int owner_id) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblHomestay where owner_id=? AND ht_status=?");
            stmt.setInt(1, owner_id);
            stmt.setInt(2, 1);
            ArrayList<Homestay> homestays = createHomestayBaseResultSet(stmt.executeQuery());
            if (!homestays.isEmpty()) {
                return homestays.get(0);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static ArrayList<Homestay> findAllHomestayAwaitingApproval() {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblHomestay where ht_status=?");
            stmt.setInt(1, 2);
            return createHomestayBaseResultSet(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    private static ArrayList<Homestay> createHomestayBaseResultSet(ResultSet rs) {
        try {
            ArrayList<Homestay> result = new ArrayList<>();
            while (rs.next()) {
                int id = rs.getInt("ht_id");
                String name = rs.getString("ht_name");
                Account owner = AccountDAO.getAccountById(rs.getInt("owner_id"));
                HomestayType type = HomestayTypeDAO.getHomestayTypeById(rs.getInt("ht_type_id"));
                String dsr = rs.getString("describe");
                District district = DistrictDAO.getDistrictById(rs.getInt("district_id"));
                String address_detail = rs.getString("address_detail");
                Payment payment = PaymentDAO.getPaymentById(rs.getInt("payment_id"));
                String rules = rs.getString("ht_rules");
                ArrayList<Rule> commonRules = RuleDAO.getHomestayRules(id);
                ArrayList<HomestayImg> imgs = HomestayImgDAO.getHomestayImgs(id);
                ArrayList<HomestayFacilities> facilities = HomestayFacilitiesDAO.getHomestayFacilities(id);
                ArrayList<Neighbourhood> neighbourhoods = NeighbourhoodDAO.getNeighbourhoods(id);
                ArrayList<Room> rooms = RoomDAO.getRoomsOfHomestay(id);
                Date registration_date = rs.getDate("registration_date");
                int status = rs.getInt("ht_status");
                result.add(new Homestay(id, name, owner, type, dsr, district, address_detail, payment, rules, commonRules, imgs,
                        facilities, neighbourhoods, registration_date, rooms, status));
            }
            return result;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
        
    public static void main(String[] args) {
       Homestay homestay=getHomestayById(1);
    }
}
