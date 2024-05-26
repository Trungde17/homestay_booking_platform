/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.password;

import DAO.AccountDAO;
import jakarta.servlet.RequestDispatcher;
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
        String old_pass = request.getParameter("old_pass");
        String new_pass = request.getParameter("new_pass");
        String new_pass_confi = request.getParameter("new_pass_confi");
        boolean isError = false;
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account.getPassword().equals(old_pass)) {
            if (new_pass.equals(new_pass_confi)) {
                if (!AccountDAO.changePassword(account.getEmail(), new_pass)) {
                    request.setAttribute("request_error", "Request fail!");
                    isError = true;
                }
            } else {
                request.setAttribute("new_pass_confi_error", "Passwords do not match!");
                isError = true;
            }
        } else {
            request.setAttribute("old_pass_error", "The old password is incorrect!");
            isError = true;
        }
        if (isError) {
            request.setAttribute("old_pass", old_pass);
            request.setAttribute("new_pass", new_pass);
            request.setAttribute("new_pass_confi", new_pass_confi);
        }
         
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/account/personal_profile.jsp?tab=change-pass");
        rd.forward(request, response);
    }

}
