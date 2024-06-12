package Booking;

import DAO.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        saveBooking(request, response);
    }

    private void saveBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String guestName = request.getParameter("guestName");
        int homestayId = Integer.parseInt(request.getParameter("homestayId"));
        int guestNumber = Integer.parseInt(request.getParameter("guestNumber"));
        String dateBooked = request.getParameter("dateBooked");
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");

        // Assuming customer_id is fetched based on guestName, for simplicity, assuming it's 1
        int customerId = 1;

        String priceParam = request.getParameter("price");
        String prepaymentParam = request.getParameter("prepayment");
        float price = (float) 0.0;
        float prepayment = (float) 0.0;

        try {
            if (priceParam != null && !priceParam.trim().isEmpty()) {
                price = Float.parseFloat(priceParam);
            }
            if (prepaymentParam != null && !prepaymentParam.trim().isEmpty()) {
                prepayment = Float.parseFloat(prepaymentParam);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid number format for price or prepayment");
            request.getRequestDispatcher("/booking/contactHost.jsp").forward(request, response);
            return;
        }

        double outstandingAmount = price - prepayment;

        Connection conn = DAO.getConnection();
        String sql = "INSERT INTO tblBooking1 (customer_id, ht_id, guest_count, date_booked, date_checkin, date_checkout, paid_amount, outstanding_amount, booking_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, customerId);
            ps.setInt(2, homestayId);
            ps.setInt(3, guestNumber);
            ps.setString(4, dateBooked);
            ps.setString(5, checkIn);
            ps.setString(6, checkOut);
            ps.setDouble(7, prepayment);
            ps.setDouble(8, outstandingAmount);
            ps.setBoolean(9, false); // Assuming false for booking_status

            int result = ps.executeUpdate();

            if (result > 0) {
                request.setAttribute("message", "Success");
            } else {
                request.setAttribute("message", "Failed to save booking.");
            }
            request.getRequestDispatcher("/booking/contactHost.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "SQL Error: " + e.getMessage());
            request.getRequestDispatcher("/booking/contactHost.jsp").forward(request, response);
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private int generateBookingId() {
        // No need to generate a booking ID if using auto-increment in the database
        return 0;
    }
}
