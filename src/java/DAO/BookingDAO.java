package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import model.Booking;

public class BookingDAO extends DAO {

    public static ArrayList<Booking>getAllUnapprovedBookingsOfHomestay(int homestay_id) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt=con.prepareStatement("select * from tblBooking where ht_id=? AND booking_status=0");
            stmt.setInt(1, homestay_id);
            ResultSet rs=stmt.executeQuery();
            ArrayList<Booking>bookings=new ArrayList<>();
            while(rs.next()){
                bookings.add(new Booking(rs.getInt("booking_id"), AccountDAO.getBasicInforOfAccount(rs.getInt("customer_id")), 
                        rs.getInt("guest_count"), rs.getDate("date_booked"), rs.getDate("date_checkin"),
                        rs.getDate("date_checkout"), RoomDAO.getRoomBookingBasicInfor(rs.getInt("booking_id")), 
                        rs.getBoolean("booking_status")));
            }
            Collections.sort(bookings, (i, j)->i.getDate_booked().compareTo(j.getDate_booked()));
            return bookings;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public static void main(String[] args) {
        ArrayList<Booking>list=getAllUnapprovedBookingsOfHomestay(2);
        for(Booking b:list){
            System.out.println(b.getRooms().size());
        }
        getAllUnapprovedBookingsOfHomestay(2);
    }
}
