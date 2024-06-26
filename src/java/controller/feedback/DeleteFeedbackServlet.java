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
import java.sql.SQLException;
import model.Account;
import model.Feedback;

/**
 *
 * @author FPT
 */
@WebServlet(name = "DeleteFeedbackServlet", urlPatterns = {"/feedback/delete"})
public class DeleteFeedbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            int id = Integer.parseInt(request.getParameter("id"));

            Account account = (Account) request.getSession().getAttribute("account");
            if (account == null) {
                response.sendRedirect("../access/login.jsp");
            } else {

                Feedback fb = FeedbackDAO.selectFeedback(id);

                if (fb.getCustomer_id() != account.getAccount_id()) {
                    response.sendRedirect("../homestay/view_homestay/feedback.jsp?ht_id=" +fb.getHt_id()+ "&error=You are not allowed to delete this feedback.");
                } else {

                    FeedbackDAO.deleteFeedback(id);

                    response.sendRedirect("../homestay/view_homestay/feedback.jsp?ht_id=" + fb.getHt_id() + "&msg=Feedback delete successfully.");
                }
            }

        } catch (SQLException e) {

        }

    }
}
