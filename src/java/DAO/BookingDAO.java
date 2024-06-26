package DAO;

import static DAO.DAO.getConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import model.Booking;
import java.util.Date;
import java.util.List;
import java.util.Map;
import model.Room;

public class BookingDAO extends DAO {

    public static ArrayList<Booking>getAllUnapprovedBookingsOfHomestay(int homestay_id) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt=con.prepareStatement("EXEC GetDistinctBookings @BookingStatus=?, @HtId = ?");
            stmt.setInt(1, 1);
            stmt.setInt(2, homestay_id);
            ResultSet rs=stmt.executeQuery();
            ArrayList<Booking>bookings=new ArrayList<>();
            while(rs.next()){
                bookings.add(new Booking(rs.getInt("booking_id"), AccountDAO.getBasicInforOfAccount(rs.getInt("customer_id")), 
                        rs.getDate("date_booked"), rs.getDate("date_checkin"),
                        rs.getDate("date_checkout"), RoomDAO.getRoomBookingBasicInfor(rs.getInt("booking_id")), 
                        rs.getInt("booking_status")));
            }
            Collections.sort(bookings, (i, j)->i.getDate_booked().compareTo(j.getDate_booked()));
            return bookings;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public static int insertIntoBooking(int booking_id, int customer_id, Date date_booked, Date date_checkin, Date date_checkout, double paid_amount, int booking_status){
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("insert into tblBooking(booking_id, "
                    + "customer_id, date_booked, date_checkin, date_checkout, paid_amount, booking_status) values(?, ?, ?, ?, ?, ?, ?)");
            
            stmt.setInt(1, booking_id);
            stmt.setInt(2, customer_id);
            stmt.setDate(3, new java.sql.Date(date_booked.getTime()));
            stmt.setDate(4, new java.sql.Date(date_checkin.getTime()));
            stmt.setDate(5, new java.sql.Date(date_checkout.getTime()));
            stmt.setDouble(6, paid_amount);
            stmt.setInt(7, booking_status);
            stmt.executeUpdate();
            return 1;
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }
    
    public static int count(){
        try (Connection con=getConnection()){
            int number=0;
            PreparedStatement stmt=con.prepareStatement("select count(*) number from tblBooking");
            ResultSet rs=stmt.executeQuery();
            if(rs.next()){
                number = rs.getInt("number");
            }
            return number;
        } catch (Exception e) {
            System.out.println(e);
        }
        return -1;
    }
    public static boolean changeStatusBooking(int booking_id, int status){
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("update tblBooking set booking_status=? where booking_id=?");
            stmt.setInt(1, status);
            stmt.setInt(2, booking_id);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }
    
    public static int getBookingByHt_idAndAccount_id(int ht_id, int account_id) {
        try ( Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblBooking where customer_id = ?");
            stmt.setInt(1, account_id);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int booking_id = rs.getInt("booking_id");
                if(checkBookingExist(booking_id, ht_id)) return booking_id;
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return -1;
    }
    
    
    public static boolean checkBookingExist(int booking_id, int ht_id_to_check) {

        try ( Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblBooking_detail where booking_id = ?");
            stmt.setInt(1, booking_id);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Room room = RoomDAO.getRoomById(rs.getInt("room_id"));
                int ht_id = room.getHt_id();
                if (ht_id == ht_id_to_check) {
                    return true;
                }
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return false;

    }
    
    public static void main(String[] args) {
        ArrayList<Booking>bookings=getAllUnapprovedBookingsOfHomestay(1);
        for(Booking booking : bookings){
            System.out.println(booking.getBooking_id() + ", "  + booking.getGuest().getFirst_name());
            for (Map.Entry<Room, Integer> entry : booking.getRooms().entrySet()) {
                Room key = entry.getKey();
                Integer value = entry.getValue();
                System.out.println(key.getRoom_name());
            }
        }
    }
}
