/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import DAO.AccountDAO;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/**
 *
 * @author FPT
 */
@WebServlet(name = "AccountActionServlet", urlPatterns = {"/AccountActionServlet"})
public class AccountActionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        int status = Integer.parseInt(request.getParameter("status"));
        String page = request.getParameter("page");
        String action = request.getParameter("action");

        AccountDAO accountDAO = new AccountDAO();

        if ("lock".equals(action)) {
            accountDAO.updateAccountStatus(accountId, "inactive"); // Lock the account
        } else if ("unlock".equals(action)) {
            accountDAO.updateAccountStatus(accountId, "active"); // Unlock the account
        }

        response.sendRedirect("./admin/" + page + ".jsp"); // Redirect back to the dashboard
    }
}
