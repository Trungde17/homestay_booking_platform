package controller.homestay.manage;

import com.google.gson.Gson;
import DAO.RevenueDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Revenue;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import model.Homestay;

@WebServlet("/GetRevenueData")
public class GetRevenueData extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        HttpSession session = request.getSession();
        Homestay homestay = (Homestay) session.getAttribute("homestay");
        ArrayList<Revenue> revenueList = new ArrayList<>();
        revenueList = RevenueDAO.getRevenueData(year, month, homestay.getHt_id());
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        String jsonData = gson.toJson(revenueList);
        out.write(jsonData);
        out.flush();
    }
}
