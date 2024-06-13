package controller.search;

import DAO.SearchHomestay;
import model.Homestay;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = {"/searchServlet"})
public class searchServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Search Results</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Homestay Search Results</h1>");
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
        request.setCharacterEncoding("UTF-8");
        String district = request.getParameter("district");
        String checkInString = request.getParameter("checkIn");
        String checkOutString = request.getParameter("checkOut");
        int numberOfPersons = Integer.parseInt(request.getParameter("guests"));


        // Parse date strings into Date objects
        Date checkIn = parseDateString(checkInString);
        Date checkOut = parseDateString(checkOutString);

        if (checkIn == null || checkOut == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
List<Homestay> homestays = SearchHomestay.searchHomestay(district, checkIn, checkOut,numberOfPersons);


request.setAttribute("homestays", homestays);
request.setAttribute("districtName", district);
request.setAttribute("checkin", checkInString);
request.setAttribute("checkout", checkOutString);
request.setAttribute("guests", numberOfPersons);
request.getRequestDispatcher("/homestaySearch/homestaySearch.jsp").forward(request, response);


    }

    @Override
    public String getServletInfo() {
        return "Servlet for searching homestays";
    }

    // Method to parse date string to Date object
    private Date parseDateString(String dateString) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return dateFormat.parse(dateString);
        } catch (ParseException e) {
            // Log the error for debugging
            e.printStackTrace();
            return null;
        }
    }
}
