package controller.search;

import DAO.HomestayDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Homestay;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/searchByNameServlet")
public class SearchByNameServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String homestayName = request.getParameter("homestayName");
        ArrayList<Homestay> homestays = HomestayDAO.searchHomestayByName(homestayName);
        
        if (homestays.isEmpty()) {
            request.setAttribute("errorMessage", "No homestay found with the name: " + homestayName);
        } else {
            request.setAttribute("homestays", homestays);
        }
        
        request.getRequestDispatcher("/homestaySearch/homestaySearch.jsp").forward(request, response);
    }
}
