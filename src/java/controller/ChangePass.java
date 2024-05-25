/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import DAO.AccountDAO;
import DAO.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Account;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "ChangePass", urlPatterns = {"/changePassword"})

public class ChangePass extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("account/changePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String u = request.getParameter("email");
        String op = request.getParameter("opass");
        String p = request.getParameter("npass");
        AccountDAO d = new AccountDAO();
        // String email=(String)request.getSession().getAttribute("email");
        Account a = d.checkAcc(u, op);
        if (a == null) {
            String ms1 = "Old password is incorrect!";
            request.setAttribute("ms1", ms1);
            request.getRequestDispatcher("account/changePassword.jsp").forward(request, response);
        } else {
            Account account = new Account(u, p, a.getRole_account(), a.getAccount_id());
            d.changePass(account);
            HttpSession session = request.getSession();
            session.setAttribute("account", account);
            response.sendRedirect("login_servlet");
        }
    }

}
