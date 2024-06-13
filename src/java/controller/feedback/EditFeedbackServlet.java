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
import java.time.LocalDate;
import model.Account;
import model.Booking;
import model.Feedback;

/**
 *
 * @author FPT
 */
public class EditFeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comments = request.getParameter("comments");
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                response.sendRedirect("../../access/login.jsp");
            } else {

                Feedback fb = FeedbackDAO.selectFeedback(id);
                Booking booking = BookingDAO.getBookingById(fb.getBooking_id());

                Booking bookingToCheck = BookingDAO.getBookingByHt_idAndAccount_id(booking.getHt_id(), account.getAccount_id());

                if (bookingToCheck == null || (bookingToCheck.getBooking_id() != booking.getBooking_id())) {
                    response.sendRedirect("../homestay/view.jsp?ht_id=" + booking.getHt_id() + "&error=You are not allowed to edit this feedback.");
                } else {

                    fb.setRating(rating);
                    fb.setComments(comments);
                    fb.setCreatedDate(LocalDate.now());

                    FeedbackDAO.updateFeedback(fb);

                    response.sendRedirect("../homestay/view.jsp?ht_id=" + booking.getHt_id() + "&msg=Feedback updated successfully.");
                }
            }
        } catch (Exception e) {
            response.sendRedirect("../../");
        }
    }

}
