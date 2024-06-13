/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import DAO.HomestayDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Account;
import model.Homestay;

/**
 *
 * @author PC
 */
@WebServlet(name = "HomestayApprove", urlPatterns = {"/homestayapprove"})
public class HomestayApprove extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomestayApprove</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomestayApprove at " + request.getContextPath() + "</h1>");
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
        Account admin = (Account) session.getAttribute("account");
        String action = request.getParameter("action");
        int ht_id = Integer.parseInt(request.getParameter("homestayId"));
        if (action.equalsIgnoreCase("approve")) {
            HomestayDAO.changeStatus(ht_id, 3);
        } else if (action.equalsIgnoreCase("reject")) {
            HomestayDAO.changeStatus(ht_id, 0);
        }
        ArrayList<Homestay> homestayList = HomestayDAO.findAllHomestayAwaitingApproval();
        session.setAttribute("homestays_approve", homestayList);

        RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin/ht_register_approve/list_request.jsp");
        rd.forward(request, response);
    }

    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
