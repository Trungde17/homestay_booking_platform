
package controller.booking;

import DAO.BookingDAO;
import DAO.RoomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import model.Account;
import model.Booking;

@WebServlet(name = "ConfirmBooking", urlPatterns = {"/confirmbooking"})
public class ConfirmBooking extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session=request.getSession();
        String action=request.getParameter("action");
        String url="/index.jsp";
        if(action.equalsIgnoreCase("confirm")){
            Account account=(Account)session.getAttribute("account");
            Booking booking=(Booking)session.getAttribute("cart");
            booking.setBooking_id(BookingDAO.count()+1);
            
            if(BookingDAO.insertIntoBooking(booking.getBooking_id(), account.getAccount_id(), booking.getDate_booked(), booking.getCheck_in(), booking.getCheck_out(), booking.getTotalAmount(), 1)==1){
                RoomDAO.insertIntoBookingDetail(booking.getBooking_id(), booking.getRooms());
            }
        }
        else if (action.equalsIgnoreCase("cancel")) {
            url="/homestay/view_homestay/homestay_block.jsp";
        }        
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
