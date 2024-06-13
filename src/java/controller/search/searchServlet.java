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
import java.util.Calendar;
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
     
    if(district == null){
         response.sendRedirect("index.jsp");
            return;
        
    }
   
    // If both check-in and check-out are null, proceed with searching by district and guests
    if (checkIn == null && checkOut == null) {
        List<Homestay> homestays = SearchHomestay.searchHomestay(district, null, null, numberOfPersons);
         
        // Forward the search results to the appropriate JSP page
        forwardToSearchResults(request, response, homestays, district, checkInString, checkOutString, numberOfPersons);
        return;
    }
    
    // If check-in is null, set it to the current date
    if (checkIn == null) {
        checkIn = new Date();
    }
    
    // If check-out is null, set it to a default value (e.g., one day after check-in)
    if (checkOut == null) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(checkIn);
        calendar.add(Calendar.DAY_OF_MONTH, 1); // Default: check-out is one day after check-in
        checkOut = calendar.getTime();
    }
    
    // Perform the homestay search based on district, check-in, check-out, and number of guests
    List<Homestay> homestays = SearchHomestay.searchHomestay(district, checkIn, checkOut, numberOfPersons);

    // Forward the search results to the appropriate JSP page
    forwardToSearchResults(request, response, homestays, district, checkInString, checkOutString, numberOfPersons);
}

// Method to forward the search results to the JSP page
private void forwardToSearchResults(HttpServletRequest request, HttpServletResponse response,
                                     List<Homestay> homestays, String district, String checkIn, String checkOut,
                                     int numberOfPersons) throws ServletException, IOException {
    int count;
   if (checkIn == null && checkOut == null) {
       
         count = SearchHomestay.count(district, null, null, numberOfPersons);} else{
   count = SearchHomestay.count(district, parseDateString(checkIn), parseDateString(checkOut), numberOfPersons);}
        int size = 6; // Number of items per page
        int endPage = count / size;
        if (count % size != 0) {
            endPage++;
        }

        // Retrieve the requested page number (default to page 1)
        int page = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) {
                    page = 1;
                } else if (page > endPage) {
                    page = endPage;
                }
            } catch (NumberFormatException e) {
                // Handle invalid page number
                page = 1;
            }
        }

        // Calculate start index for pagination
        int startIndex = (page - 1) * size;
        int endIndex = Math.min(startIndex + size, homestays.size());

        // Subset the homestays list for the current page
        List<Homestay> homestaysForPage = homestays.subList(startIndex, endIndex);

        // Set attributes for forwarding to JSP
        request.setAttribute("homestays", homestaysForPage);
        request.setAttribute("districtName", district);
        request.setAttribute("checkin", checkIn);
        request.setAttribute("checkout", checkOut);
        request.setAttribute("guests", numberOfPersons);
        request.setAttribute("currentPage", page);
        request.setAttribute("endPage", endPage);

        // Forward the request to the JSP
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
