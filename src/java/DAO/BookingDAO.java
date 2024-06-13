/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import static DAO.DAO.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Booking;

public class BookingDAO extends DAO {

    public static Booking getBookingByHt_idAndAccount_id(int ht_id, int account_id) {
        try ( Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblBooking where ht_id = ? and customer_id = ?");
            stmt.setInt(1, ht_id);
            stmt.setInt(2, account_id);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBooking_id(rs.getInt("booking_id"));
                booking.setHt_id(rs.getInt("ht_id"));
                return booking;
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static Booking getBookingById(int booking_id) {
        try ( Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblBooking where booking_id = ?");
            stmt.setInt(1, booking_id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBooking_id(rs.getInt("booking_id"));
                booking.setHt_id(rs.getInt("ht_id"));
                return booking;
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
}
