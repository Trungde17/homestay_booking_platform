/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.feedback;

import DAO.BookingDAO;
import DAO.FeedbackDAO;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.SQLException;
import java.time.LocalDate;
import model.Account;
import model.Booking;
import model.Feedback;

/**
 *
 * @author FPT
 */
public class DeleteFeedbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            int id = Integer.parseInt(request.getParameter("id"));

            Account account = (Account) request.getSession().getAttribute("account");
            if (account == null) {
                response.sendRedirect("../../access/login.jsp");
            } else {

                Feedback fb = FeedbackDAO.selectFeedback(id);
                Booking booking = BookingDAO.getBookingById(fb.getBooking_id());

                Booking bookingToCheck = BookingDAO.getBookingByHt_idAndAccount_id(booking.getHt_id(), account.getAccount_id());

                if (bookingToCheck == null || (bookingToCheck.getBooking_id() != booking.getBooking_id())) {
                    response.sendRedirect("../homestay/view.jsp?ht_id=" + booking.getHt_id() + "&error=You are not allowed to delete this feedback.");
                } else {

                    FeedbackDAO.deleteFeedback(id);

                    response.sendRedirect("../homestay/view.jsp?ht_id=" + booking.getHt_id() + "&msg=Feedback delete successfully.");
                }
            }

        } catch (SQLException e) {

        }

    }
}
