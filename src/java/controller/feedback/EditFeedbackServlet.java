/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.feedback;

import DAO.FeedbackDAO;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.time.LocalDate;
import model.Account;
import model.Feedback;

/**
 *
 * @author FPT
 */
@WebServlet(name = "EditFeedbackServlet", urlPatterns = {"/feedback/edit"})
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
                response.sendRedirect("../access/login.jsp");
            } else {

                Feedback fb = FeedbackDAO.selectFeedback(id);

                if (fb.getCustomer_id() != account.getAccount_id()) {
                    response.sendRedirect("../homestay/view_homestay/feedback.jsp?ht_id=" + fb.getHt_id() + "&error=You are not allowed to edit this feedback.");
                } else {

                    fb.setRating(rating);
                    fb.setComments(comments);
                    fb.setCreatedDate(LocalDate.now());

                    FeedbackDAO.updateFeedback(fb);

                    response.sendRedirect("../homestay/view_homestay/feedback.jsp?ht_id=" + fb.getHt_id() + "&msg=Feedback updated successfully.");
                }
            }
        } catch (Exception e) {
            response.sendRedirect("../");
        }
    }

}
