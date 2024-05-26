/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.password;

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
import utilities.EmailWork;

/**
 *
 * @author PC
 */
@WebServlet(name = "checkEmailForgotPass", urlPatterns = {"/checkemailforgotpass"})
public class checkEmailForgotPass extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet checkEmailForgotPass</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet checkEmailForgotPass at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String url = "/access/password/enterOtpCode.jsp";
        boolean isError = false;
        if (!AccountDAO.checkEmail(email)) {
            request.setAttribute("email_error", "This email is not registered!");
            isError = true;
        } else {
            request.setAttribute("email", email);
            String otp_code = new EmailWork().sendOtpToEmail(email);
            if (otp_code.equals("")) {
                isError = true;
                request.setAttribute("fail_request", "Request failed!");
            } else {
                session.setAttribute("url_to_otp", "/access/password/forgotPassword.jsp");
                session.setAttribute("email", email);
                session.setAttribute("otp_code_mail", otp_code);
                session.setAttribute("isSignupOtp", "true");
            }

        }
        if (isError) {
            url = "/access/password/forgotPassword.jsp";
        }       
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
