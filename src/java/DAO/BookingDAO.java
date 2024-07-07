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
    
    public static ArrayList<Booking>getPaidBookingsOfHomestay(int homestay_id) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt=con.prepareStatement("EXEC GetDistinctBookings @BookingStatus=1, @HtId = ?");
            stmt.setInt(1, homestay_id);
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

    public static double calculateMonthlyRevenue(int year, int month, int homestayId) {
        double monthlyRevenue = 0.0;
        String sql = "SELECT SUM(rp.amount_per_night * DATEDIFF(day, b.date_checkin, b.date_checkout)) AS MonthlyRevenue " +
                     "FROM tblBooking b " +
                     "JOIN tblBooking_detail bd ON b.booking_id = bd.booking_id " +
                     "JOIN tblRoom r ON bd.room_id = r.room_id " +
                     "JOIN tblHomestay h ON r.ht_id = h.ht_id " +
                     "JOIN tblRoomPrice rp ON r.room_id = rp.room_id " +
                     "WHERE YEAR(b.date_booked) = ? " +
                     "AND MONTH(b.date_booked) = ? " +
                     "AND h.ht_id = ? " +
                     "AND ((bd.number_of_guest = 1 AND rp.price_id = 1) " +
                     "OR (bd.number_of_guest > 1 AND rp.price_id = 2))";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            ps.setInt(3, homestayId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    monthlyRevenue = rs.getDouble("MonthlyRevenue");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return monthlyRevenue;
    }
    public static int count(int year, int month, int homestayId) {
        int bookingCount = 0;
        String sql = "SELECT COUNT(*) AS BookingCount " +
                     "FROM tblBooking b " +
                     "JOIN tblBooking_detail bd ON b.booking_id = bd.booking_id " +
                     "JOIN tblRoom r ON bd.room_id = r.room_id " +
                     "JOIN tblHomestay h ON r.ht_id = h.ht_id " +
                     "WHERE YEAR(b.date_booked) = ? " +
                     "AND MONTH(b.date_booked) = ? " +
                     "AND h.ht_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            ps.setInt(3, homestayId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    bookingCount = rs.getInt("BookingCount");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookingCount;
    }
    public static ArrayList<Booking>getCurrentStayBookings(int homestay_id){
        String sql = "SELECT b.booking_id, b.customer_id, b.date_booked, b.date_checkin, b.date_checkout, b.paid_amount, b.outstanding_amount, b.booking_status " +
                     "FROM tblBooking b " +
                     "JOIN tblBooking_detail bd ON b.booking_id = bd.booking_id " +
                     "JOIN tblRoom r ON bd.room_id = r.room_id " +
                     "JOIN tblHomestay h ON r.ht_id = h.ht_id " +
                     "WHERE h.ht_id = ? " +
                     "AND GETDATE() BETWEEN b.date_checkin AND b.date_checkout " +
                     "AND b.booking_status = 1";
        try (Connection con=getConnection()){         
            PreparedStatement stmt=con.prepareStatement(sql);
            stmt.setInt(1, homestay_id);
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
    
    public static ArrayList<Booking>getCheckedOutBookings(int homestay_id){
        String sql = "SELECT b.booking_id, b.customer_id, b.date_booked, b.date_checkin, b.date_checkout, b.paid_amount, b.outstanding_amount, b.booking_status " +
                     "FROM tblBooking b " +
                     "JOIN tblBooking_detail bd ON b.booking_id = bd.booking_id " +
                     "JOIN tblRoom r ON bd.room_id = r.room_id " +
                     "JOIN tblHomestay h ON r.ht_id = h.ht_id " +
                     "WHERE h.ht_id = ? " +
                     "AND GETDATE() > b.date_checkout " +
                     "AND b.booking_status = 1";
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement(sql);
            stmt.setInt(1, homestay_id);
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
    
    public static ArrayList<Booking>getCancelledBookings(int homestay_id){
        String sql = "SELECT b.booking_id, b.customer_id, b.date_booked, b.date_checkin, b.date_checkout, b.paid_amount, b.outstanding_amount, b.booking_status " +
                     "FROM tblBooking b " +
                     "JOIN tblBooking_detail bd ON b.booking_id = bd.booking_id " +
                     "JOIN tblRoom r ON bd.room_id = r.room_id " +
                     "JOIN tblHomestay h ON r.ht_id = h.ht_id " +
                     "WHERE h.ht_id = ? " +
                     "AND b.booking_status = 0";
        
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement(sql);
            stmt.setInt(1, homestay_id);
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
    public static List<Booking> getBookingsByDateRange(Date startDate, Date endDate) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM tblBooking WHERE date_booked BETWEEN ? AND ?";

        try (Connection con = getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setDate(1, new java.sql.Date(startDate.getTime()));
            stmt.setDate(2, new java.sql.Date(endDate.getTime()));
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBooking_id(rs.getInt("booking_id"));
                // Assuming Account class has appropriate constructor or setters
                booking.setGuest(AccountDAO.getBasicInforOfAccount(rs.getInt("customer_id")));
                booking.setDate_booked(rs.getDate("date_booked"));
                booking.setCheck_in(rs.getDate("date_checkin"));
                booking.setCheck_out(rs.getDate("date_checkout"));
                booking.setPaid_amount(rs.getDouble("paid_amount"));
                booking.setOutstanding_amount(rs.getDouble("outstanding_amount"));
                booking.setBooking_status(rs.getInt("booking_status"));
                // Add other fields as necessary
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }

    // Method to get all bookings
    public static List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM tblBooking";

        try (Connection con = getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBooking_id(rs.getInt("booking_id"));
                // Assuming Account class has appropriate constructor or setters
                booking.setGuest(AccountDAO.getBasicInforOfAccount(rs.getInt("customer_id")));
                booking.setDate_booked(rs.getDate("date_booked"));
                booking.setCheck_in(rs.getDate("date_checkin"));
                booking.setCheck_out(rs.getDate("date_checkout"));
                booking.setPaid_amount(rs.getDouble("paid_amount"));
                booking.setOutstanding_amount(rs.getDouble("outstanding_amount"));
                booking.setBooking_status(rs.getInt("booking_status"));
                // Add other fields as necessary
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }
    public static void main(String[] args) {
        System.out.println(calculateMonthlyRevenue(2024, 6, 1));
        System.out.println(count(2024, 7, 1));
        ArrayList<Booking>bookings=getCurrentStayBookings(1);
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
