/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.booking;

import DAO.RoomDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Booking;

/**
 *
 * @author PC
 */
@WebServlet(name = "AddCart", urlPatterns = {"/addcart"})
public class AddCart extends HttpServlet {

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
            out.println("<title>Servlet AddCart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCart at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Booking cart = (Booking) session.getAttribute("cart");
        try {
            if (cart == null) {
                cart = new Booking();
                String checkinDate_str = (String) session.getAttribute("checkinDate_str");
                String checkoutDate_str = (String) session.getAttribute("checkoutDate_str");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date checkinDate = dateFormat.parse(checkinDate_str);
                Date checkoutDate = dateFormat.parse(checkoutDate_str);
                cart.setDate_booked(new Date());
                cart.setCheck_in(checkinDate);
                cart.setCheck_out(checkoutDate);
            }
            String room_id_str = request.getParameter("room_id");
            String number_of_get_str = request.getParameter(room_id_str);

            int number_of_get = Integer.parseInt(number_of_get_str);
            int room_id = Integer.parseInt(room_id_str);
            cart.getRooms().put(RoomDAO.getRoomById(room_id), number_of_get);
            session.setAttribute("cart", cart);
        } catch (Exception e) {
            System.out.println(e);
        }
        request.setAttribute("scrollToRooms", true);
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/homestay/view_homestay/homestay_block.jsp");
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
