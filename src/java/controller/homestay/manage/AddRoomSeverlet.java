/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.homestay.manage;

import DAO.AccountDAO;
import DAO.BedDAO;
import DAO.RoomDAO;
import DAO.RoomFacilitiesDAO;
import DAO.RoomImgDAO;
import DAO.RoomPriceDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;
import model.Homestay;
import model.Room;
import utilities.CloudinaryConfig1;
import utilities.Int;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "AddRoomSeverlet", urlPatterns = {"/AddRoomSeverlet"})

@MultipartConfig(maxFileSize = 16177215) // 15MB max file size
public class AddRoomSeverlet extends HttpServlet {

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
            out.println("<title>Servlet AddRoomSeverlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddRoomSeverlet at " + request.getContextPath() + "</h1>");
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
        boolean isError = false;

        Homestay homestay = (Homestay) session.getAttribute("homestay");
        int ht_id = homestay.getHt_id();
        String roomName = request.getParameter("room_name");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String Description = request.getParameter("description");
        String size = request.getParameter("size");
        String[] bedsStr = request.getParameterValues("bed");
        int[] beds = Int.convertStringListToIntegerList(bedsStr);
        String[] facilitiesListStr = request.getParameterValues("room_facilities");
        int[] facilitiesList = Int.convertStringListToIntegerList(facilitiesListStr);
        
        int roomId = RoomDAO.count() + 1;

        if (RoomDAO.insertRoomOfHomestay(ht_id, roomId, roomName, capacity) != 0) {
            Map<Integer, Integer> bedsInsert = Int.countIntegers(beds);
            BedDAO.insertRoomBeds(roomId, bedsInsert);
            RoomFacilitiesDAO.insertRoomFacilities(roomId, facilitiesList);
            double priceForOne = Double.parseDouble(request.getParameter("price_for_one"));
            RoomPriceDAO.insertRoomPrice(roomId, 1, priceForOne);
            RoomDAO.changeDescription(roomId, Description);
            RoomDAO.changeSize(roomId, size);
            
            if (capacity > 1) {
                double priceForMore = Double.parseDouble(request.getParameter("price_for_more"));
                RoomPriceDAO.insertRoomPrice(roomId, 2, priceForMore);
            }
              Collection<Part> fileParts = request.getParts(); // Retrieves all file parts
        for (Part filePart : fileParts) {
            if (filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                String fileName = filePart.getSubmittedFileName();
                Map<String, String> mapResult = CloudinaryConfig1.upLoadFile(filePart.getInputStream(), fileName);
                String img_url = mapResult.get("url");
                RoomImgDAO.insertRoomImg(roomId, img_url);
            }
        }
        }
         else {
            isError = true;
        }
        
Room room = RoomDAO.getRoomById(roomId);
        session.setAttribute("room", room);
        
        String ms = "Successful update!";
        request.setAttribute("ms", ms);
        
       
            
        
       
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/owner/noticeAddRoom.jsp");
        rd.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
