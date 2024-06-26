/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.feedback;

import DAO.BookingDAO;
import DAO.FeedbackDAO;
import DAO.HomestayDAO;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.time.LocalDate;
import model.Account;
import model.Feedback;
import model.Homestay;

/**
 *
 * @author FPT
 */
@WebServlet(name = "CreateFeedbackServlet", urlPatterns = {"/feedback/create"})
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
                response.sendRedirect("../access/login.jsp");
            } else {

                int booking_id = BookingDAO.getBookingByHt_idAndAccount_id(ht_id, account.getAccount_id());
                if (booking_id != -1) {

                    fb.setHt_id(ht_id);
                    fb.setCustomer_id(account.getAccount_id());
                    fb.setCustomerName(account.getFirst_name() + " " + account.getLast_name());
                    fb.setCreatedDate(LocalDate.now());
                    fb.setRating(rating);
                    fb.setComments(comments);

                    if (FeedbackDAO.insertFeedback(fb)) {
                        //response.getWriter().write("Feedback submitted successfully.");
                        
                        Homestay homestay = HomestayDAO.getHomestayById(ht_id);
                        session.setAttribute("homestay_view", homestay);
                        
                        response.sendRedirect("../homestay/view_homestay/feedback.jsp?ht_id=" + ht_id + "&msg=Feedback added successfully.");
                    } else {
                        //response.getWriter().write("Error processing feedback.");
                        response.sendRedirect("../homestay/view_homestay/view.jsp?ht_id=" + ht_id + "&error=Fail to add the feedback, please try again.");
                    }
                } else {
                    response.sendRedirect("../homestay/view_homestay/feedback.jsp?ht_id=" + ht_id + "&error=You must book the homestay in order to send feedback.");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("../");

        }
    }

}
