/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.homestay;

import DAO.HomestayDAO;
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
import java.util.Map;
import model.Homestay;
import model.Room;

@WebServlet(name = "ViewHomestay", urlPatterns = {"/viewhomestay"})
public class ViewHomestay extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("cart", null);
        int ht_id = Integer.parseInt(request.getParameter("homestayId"));
        Homestay homestay = HomestayDAO.getHomestayById(ht_id);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date checkin = dateFormat.parse((String) session.getAttribute("checkin"));
            Date checkout = dateFormat.parse((String) session.getAttribute("checkout"));
            ArrayList<Room> available_rooms = RoomDAO.getAvailableRoomsOfHomestay(ht_id, checkin, checkout);
            session.setAttribute("available_rooms", available_rooms);
            session.setAttribute("homestay_view", homestay);
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/homestay/view_homestay/homestay_block.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
