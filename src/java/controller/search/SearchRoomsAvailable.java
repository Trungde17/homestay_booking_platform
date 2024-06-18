/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.search;

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
import java.util.ArrayList;
import java.util.Date;
import model.Room;

@WebServlet(name = "SearchRoomsAvailable", urlPatterns = {"/searchroomsavailable"})
public class SearchRoomsAvailable extends HttpServlet {

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
            out.println("<title>Servlet SearchRoomsAvailable</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchRoomsAvailable at " + request.getContextPath() + "</h1>");
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
        String checkin_str=request.getParameter("checkin_date");
        String checkout_str=request.getParameter("checkout_date"); 
        HttpSession session=request.getSession();
        try {
            String ht_id_str=request.getParameter("homestay_id");
            int ht_id=Integer.parseInt(ht_id_str);
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date checkinDate = dateFormat.parse(checkin_str);
            Date checkoutDate = dateFormat.parse(checkout_str);
            ArrayList<Room>rooms= RoomDAO.getAvailableRoomsOfHomestay(ht_id, checkinDate, checkoutDate);
            session.setAttribute("available_rooms", rooms);

        } catch (Exception e) {
            e.printStackTrace();
        }
        session.setAttribute("checkinDate", checkin_str);
        session.setAttribute("checkoutDate", checkout_str);
        request.setAttribute("scrollToRooms", true);
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/homestay/view_homestay/homestay_block.jsp");
        rd.forward(request, response);

    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
