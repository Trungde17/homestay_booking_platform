package controller;

import java.io.IOException;
import DAO.HomestayProfile;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Homestay;

@WebServlet("/HomestayDetails")
public class HomestayDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String homestayIdParam = request.getParameter("homestayId");
        if (homestayIdParam != null) {
            int homestayId = Integer.parseInt(homestayIdParam);
            System.out.println("Received homestay ID: " + homestayId); // Log the received homestay ID
            HomestayProfile homestayProfile = new HomestayProfile();
            Homestay homestay = homestayProfile.getHomestayById(homestayId);
            if (homestay != null) {
                System.out.println("Homestay found: " + homestay.getHt_name()); // Log homestay details if found
            } else {
                System.out.println("No homestay found with ID: " + homestayId); // Log if no homestay is found
            }
            request.setAttribute("homestay", homestay);
        } else {
            System.out.println("No homestay ID provided."); // Log if no homestay ID is provided
        }
        request.getRequestDispatcher("/booking/block.jsp").forward(request, response);
    }
}
