/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.homestay.manage;

import DAO.BookingDAO;
import DAO.RoomDAO;
import DTO.homestay.HomestaySummaryDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import model.Room;

/**
 *
 * @author PC
 */
@WebServlet(name = "ApproveBooking", urlPatterns = {"/approvebooking"})
public class ApproveBooking extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ApproveBooking</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApproveBooking at " + request.getContextPath() + "</h1>");
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
        String action=request.getParameter("action");
        String booking_id_str=request.getParameter("booking_id");
        int hstDto_id=Integer.parseInt(request.getParameter("homestay_id"));
        try {
            int booking_id=Integer.parseInt(booking_id_str);
            if(action.equalsIgnoreCase("approve")){
                ArrayList<Room>roomsOverlap=RoomDAO.getRoomsOverlapOfBooking(booking_id);
                if(roomsOverlap!=null && roomsOverlap.size()>0){
                    request.setAttribute("roomsOverlap", roomsOverlap);
                }
                else{
                    BookingDAO.changeStatusBooking(booking_id, 2);
                    request.setAttribute("roomsOverlap", null);
                }                
            } 
            else if(action.equalsIgnoreCase("reject")){
                BookingDAO.changeStatusBooking(booking_id, 0);
                request.setAttribute("roomsOverlap", null);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        HomestaySummaryDTO hstDto=HomestaySummaryDTO.getHomestaySummaryDTOById(hstDto_id);
        request.setAttribute("homestay_summary", hstDto);
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/homestay/homestay_manage/approveBookings.jsp");
        rd.forward(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
