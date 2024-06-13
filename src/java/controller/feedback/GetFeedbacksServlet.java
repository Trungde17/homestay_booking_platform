/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.feedback;

import DAO.BookingDAO;
import DAO.FeedbackDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;

/**
 *
 * @author FPT
 */
public class GetFeedbacksServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Feedback> feedbackList = FeedbackDAO.selectAllFeedback();
        int ht_id = Integer.parseInt(request.getParameter("ht_id"));

        List<Feedback> result = new ArrayList<>();

        for (Feedback feedback : feedbackList) {
            int booking_id = feedback.getBooking_id();
            if (BookingDAO.getBookingById(booking_id).getHt_id() == ht_id) {
                result.add(feedback);
            }
        }

        // Convert the result list to JSON
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDate.class, new LocalDateTypeAdapter())
                .create();
        String json = gson.toJson(result);

        // Set response content type to JSON and write the JSON string to the response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}


