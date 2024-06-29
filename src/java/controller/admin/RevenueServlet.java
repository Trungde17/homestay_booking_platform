/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import java.io.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import services.RevenueService;

@WebServlet(name = "RevenueServlet", urlPatterns = {"/RevenueServlet"})
public class RevenueServlet extends HttpServlet {
    private RevenueService revenueService;

    @Override
    public void init() {
        revenueService = new RevenueService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double todayRevenue = revenueService.getRevenueForDate(new Date());
        double totalRevenue = revenueService.getTotalRevenue();
        Map<String, Double> revenueLast10Days = revenueService.getRevenueForLast10Days();
        
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("todayRevenue", todayRevenue);
        responseData.put("totalRevenue", totalRevenue);
        responseData.put("revenueLast10Days", revenueLast10Days);
        
        String jsonResponse = new Gson().toJson(responseData);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse);
    }
}
