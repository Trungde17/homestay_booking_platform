package controller.homestay.manage;

import DAO.RoomDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Room;

@WebServlet(name = "RoomDirect", urlPatterns = {"/RoomDirect"})
public class RoomDirect extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        String room_id_infor = request.getParameter("room_id");
            int room_id = Integer.parseInt(room_id_infor);          
            Room room = RoomDAO.getRoomById(room_id);
                HttpSession session = request.getSession();
                session.setAttribute("room", room);
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/homestay/homestay_manage/updateRoom.jsp");
                rd.forward(request, response);
            
       
    }

    @Override
    public String getServletInfo() {
        return "Handles the redirection to the room update page with room details.";
    }
}
