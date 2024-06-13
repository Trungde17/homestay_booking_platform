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
public class CreateFeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Feedback fb = new Feedback();

        try {
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comments = request.getParameter("comments");
 
            
            int ht_id = Integer.parseInt(request.getParameter("ht_id"));
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                response.sendRedirect("../../access/login.jsp");
            }
            Booking booking = BookingDAO.getBookingByHt_idAndAccount_id(ht_id, account.getAccount_id());
            if (booking != null) {

                fb.setBooking_id(booking.getBooking_id());
                fb.setCustomerName(account.getFirst_name() + " " + account.getLast_name());
                fb.setCreatedDate(LocalDate.now());
                fb.setRating(rating);
                fb.setComments(comments);

                if (FeedbackDAO.insertFeedback(fb)) {
                    //response.getWriter().write("Feedback submitted successfully.");
                    response.sendRedirect("../homestay/view.jsp?ht_id=" + ht_id + "&msg=Feedback added successfully.");
                } else {
                    //response.getWriter().write("Error processing feedback.");
                    response.sendRedirect("../homestay/view.jsp?ht_id=" + ht_id + "&error=Fail to add the feedback, please try again.");
                }
            } else {
                response.sendRedirect("../homestay/view.jsp?ht_id=" + ht_id + "&error=You must book the homestay in order to send feedback.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("../../");

        }
    }

}
