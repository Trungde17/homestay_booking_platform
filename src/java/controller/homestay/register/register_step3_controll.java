
package controller.homestay.register;

import DAO.BedDAO;
import DAO.RoomDAO;
import DAO.RoomFacilitiesDAO;
import DAO.RoomPriceDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Map;
import model.Homestay;
import utilities.Int;


@WebServlet(name = "register_step3_controll", urlPatterns = {"/register_step3_controll"})
public class register_step3_controll extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet register_step3_controll</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet register_step3_controll at " + request.getContextPath() + "</h1>");
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
        HttpSession session=request.getSession();
        boolean isError=false;
        String roomName=request.getParameter("room_name");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String[]beds_str=request.getParameterValues("bed");
        int[]beds=Int.convertStringListToIntegerList(beds_str);
        String[]facilities_list_str=request.getParameterValues("room_facilities");
        int[]facilities_list=Int.convertStringListToIntegerList(facilities_list_str);
        Homestay ht = (Homestay)session.getAttribute("homestay_register");
        int room_id=RoomDAO.count()+1;
        if(RoomDAO.insertRoomOfHomestay(ht.getHt_id(), room_id, roomName, capacity)!=0){
            Map<Integer, Integer>beds_insert=Int.countIntegers(beds);
            BedDAO.insertRoomBeds(room_id, beds_insert);
            RoomFacilitiesDAO.insertRoomFacilities(room_id, facilities_list);
            double price_for_one=Double.parseDouble(request.getParameter("price_for_one"));
            RoomPriceDAO.insertRoomPrice(room_id, 1, price_for_one);
            if(capacity>1){
                double price_for_more = Double.parseDouble(request.getParameter("price_for_more"));
                RoomPriceDAO.insertRoomPrice(room_id, 2, price_for_more);
            }
        }
        else isError=true;
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/homestay/homestay_register/step3.jsp");
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
