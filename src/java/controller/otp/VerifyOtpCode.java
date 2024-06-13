/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.otp;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
@WebServlet(name = "VerifyOtpCode", urlPatterns = {"/verifyotpcode"})
public class VerifyOtpCode extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VerifyOtpCode</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyOtpCode at " + request.getContextPath() + "</h1>");
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
        String otp_code_enter=request.getParameter("otp_code");
        HttpSession session=request.getSession();
        String otp_code=(String)session.getAttribute("otp_code_mail");
        boolean isError = false;      
        String url_to_otp = (String)session.getAttribute("url_to_otp");
        String url="/access/password/enterOtpCode.jsp";
        if(!otp_code_enter.equals(otp_code)){
            request.setAttribute("otp_code_error", "OTP code is not correct!");
            request.setAttribute("otp_code_enter", otp_code_enter);
            isError = true;
        }
        if(!isError && url_to_otp!=null){
            if(url_to_otp.contains("sigup.jsp")){
                url="/sigupservlet";
            }
            if(url_to_otp.contains("forgotPassword.jsp")){
                url="/access/password/resetPassword.jsp";
                session.setAttribute("isForgotPassOtp", null);
            }
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
        
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
