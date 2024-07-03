/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.homestay.manage;

import DAO.BookingDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import model.Homestay;
import utilities.CurrencyUtils;

/**
 *
 * @author PC
 */
@WebServlet(name = "ViewRevenue", urlPatterns = {"/viewrevenue"})
public class ViewRevenue extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewRevenue</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewRevenue at " + request.getContextPath() + "</h1>");
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
        int year = Integer.parseInt(request.getParameter("year"));
        int month = Integer.parseInt(request.getParameter("month"));
        Homestay homestay = (Homestay)session.getAttribute("homestay");
        String revenue = CurrencyUtils.formatCurrency(BookingDAO.calculateMonthlyRevenue(year, month, homestay.getHt_id())*1000);
        int booking_month_number=BookingDAO.count(year, month, homestay.getHt_id());
        request.setAttribute("revenue", revenue);
        request.setAttribute("booking_month_number", booking_month_number);
        request.setAttribute("year", year);
        request.setAttribute("month", month);
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/homestay/homestay_manage/revenue.jsp");
        rd.forward(request, response);
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
