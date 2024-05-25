///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package controller;
//
//import DAO.AccountDAO;
//import jakarta.servlet.RequestDispatcher;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
////import utilities.EmailWork;
//
///**
// *
// * @author PC
// */
//@WebServlet(name = "SendOtpEmail", urlPatterns = {"/sendotpemail"})
//public class SendOtpEmail extends HttpServlet {
//
//    
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet SendOtpEmail</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet SendOtpEmail at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//
//    
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String email = request.getParameter("email");
//        String url="/access/password/enterOtpCode.jsp";
//        boolean isError=false;
//        if(!AccountDAO.checkEmail(email)){
//            isError=true;
//            request.setAttribute("email_error", "This email is not registered!");
//        }
//        else{      
//            String otp_code=new EmailWork().sendOtpToEmail(email);
//            if(otp_code.equals("")){
//                isError=true;
//                request.setAttribute("fail_request", "Request failed!");
//            }
//            else{
//                HttpSession session = request.getSession();
//                session.setAttribute("otp_code_mail", otp_code);  
//                session.setAttribute("email", email);
//            }
//        }
//        if(isError){
//            url="/access/password/forgotPassword.jsp";
//            request.setAttribute("email", email);
//        }
//        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
//        rd.forward(request, response);
//    }
//
//    
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
