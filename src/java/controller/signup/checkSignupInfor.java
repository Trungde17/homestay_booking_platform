/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.signup;

import DAO.AccountDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import utilities.EmailWork;

/**
 *
 * @author PC
 */
@WebServlet(name = "checkSignupInfor", urlPatterns = {"/checksignupinfor"})
public class checkSignupInfor extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet checkSignupInfor</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet checkSignupInfor at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String pass_conf = request.getParameter("pass_conf");
        String url = "/access/password/enterOtpCode.jsp";
        HttpSession session = request.getSession();
        boolean isError = false;
        if (AccountDAO.checkEmail(email)) {
            request.setAttribute("email_error", "This email has been registered!");
            isError = true;
        }

        if (!pass.equals(pass_conf)) {
            request.setAttribute("pass_conf_error", "Confirmation password does not match!");
            isError = true;
        }
        if (!isError) {
            request.setAttribute("email", email);
            String otp_code = new EmailWork().sendOtpToEmail(email);
            if (otp_code.equals("")) {
                isError = true;
                request.setAttribute("fail_request", "Request failed!");
            } else {
                session.setAttribute("otp_code_mail", otp_code);
                session.setAttribute("url_to_otp", "/access/sigup.jsp");
            }
        }
        if (isError) {
            url = "/access/signup.jsp";
            request.setAttribute("pass_conf", pass_conf);            
        }
        Account acc = new Account(email, pass, first_name, last_name);
        session.setAttribute("acc_signup", acc);   
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
