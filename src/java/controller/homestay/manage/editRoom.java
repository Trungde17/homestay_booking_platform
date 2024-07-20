/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.homestay.manage;

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
import java.util.HashMap;
import java.util.Map;
import model.Room;
import utilities.CloudinaryConfig1;
import utilities.Int;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "editRoom", urlPatterns = {"/editRoom"})
@MultipartConfig(maxFileSize = 16177215)
public class editRoom extends HttpServlet {

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
            out.println("<title>Servlet UpdateRooms</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateRooms at " + request.getContextPath() + "</h1>");
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
        Room room = (Room) session.getAttribute("room");
        int room_id = room.getRoom_id();
        String action = request.getParameter("action");
        if (action.equalsIgnoreCase("name")) {
            String room_name = request.getParameter("room_name");
            if (!room_name.equals("")) {
                RoomDAO.changeName(room_id, room_name);
            }
        } else if (action.equalsIgnoreCase("description")) {
            String room_description = request.getParameter("room_description");
            RoomDAO.changeDescription(room_id, room_description);
        } else if (action.equalsIgnoreCase("capacity")) {
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            RoomDAO.changeCapaciy(room_id, capacity);

        } else if (action.equalsIgnoreCase("size")) {
            String size = request.getParameter("size");
            RoomDAO.changeSize(room_id, size);

        } else if (action.equalsIgnoreCase("facilities")) {
            String[] facilities_id_str = request.getParameterValues("facilities");
            int[] facilities_id = Int.convertStringListToIntegerList(facilities_id_str);
            if (facilities_id != null && facilities_id.length > 0) {
                RoomFacilitiesDAO.delete(room_id);
                RoomFacilitiesDAO.insertRoomFacilities(room_id, facilities_id);
            }
        } else if (action.equalsIgnoreCase("status")) {
            String roomStatusParam = request.getParameter("room_status");
            boolean status = "on".equals(roomStatusParam);  // Assuming the checkbox returns "on" when checked
            RoomDAO.changeStatus(room_id, status);
        }
        if (action.equalsIgnoreCase("prices")) {
            String[] priceIds = request.getParameterValues("price_id");
            String[] amounts = request.getParameterValues("amount");

            if (priceIds != null && amounts != null && priceIds.length == amounts.length) {
                for (int i = 0; i < priceIds.length; i++) {
                    try {
                        int priceId = Integer.parseInt(priceIds[i]);
                        double amount = Double.parseDouble(amounts[i]);
                        RoomPriceDAO.changeAmount(room_id, priceId, amount);
                    } catch (NumberFormatException e) {
                        System.out.println( e.toString());
                    }
                }
            } else {
                System.out.println("Price IDs and amounts do not match or are null.");
            }
        } else if (action.equalsIgnoreCase("img")) {
            String img_id_str = request.getParameter("img_id");
            int img_id = Integer.parseInt(img_id_str);
            Part img_file = request.getPart("img_file");
            String fileName = img_file.getSubmittedFileName();
            Map mapResult = CloudinaryConfig1.upLoadFile(img_file.getInputStream(), fileName);
            String img_url = (String) mapResult.get("url");
            RoomImgDAO.changeImg(img_id, img_url);
        } else if (action.equalsIgnoreCase("beds")) {
            updateBeds(request, room_id);
        }
        room = RoomDAO.getRoomById(room_id);
        session.setAttribute("room", room);
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/homestay/homestay_manage/updateRoom.jsp");
        rd.forward(request, response);

    }

    private void updateBeds(HttpServletRequest request, int room_id) throws IOException, ServletException {
        String[] beds_id = request.getParameterValues("bed_id");
        String[] quantities = request.getParameterValues("quantity");

        if (beds_id != null && quantities != null) {
            Map<Integer, Integer> beds = new HashMap<>();
            for (int i = 0; i < beds_id.length; i++) {
                int bed_id = Integer.parseInt(beds_id[i]);
                int quantity = Integer.parseInt(quantities[i]);
                beds.put(bed_id, quantity);
            }

            // Update the database with the collected data
//        BedDAO.delete(room_id);
            BedDAO.updateRoomBeds(room_id, beds);
        }
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
