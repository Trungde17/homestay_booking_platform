package controller.homestay.manage;

import DAO.ScheduleDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/ScheduleServlet")
public class ScheduleServlet extends HttpServlet {

    private ScheduleDAO scheduleDAO;

    @Override
    public void init() throws ServletException {
        scheduleDAO = new ScheduleDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int roomId = Integer.parseInt(request.getParameter("room_id"));
        try {
            List<Map<String, Object>> schedules = scheduleDAO.getSchedules(roomId);
            ObjectMapper mapper = new ObjectMapper();
            String json = mapper.writeValueAsString(schedules);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ObjectMapper mapper = new ObjectMapper();
        Map<String, String> data = mapper.readValue(request.getInputStream(), Map.class);

        int roomId = Integer.parseInt(data.get("room_id"));
        String startDate = data.get("start_date");
        String endDate = data.get("end_date");
        String action = data.get("action");

        try {
            scheduleDAO.handleSchedule(roomId, startDate, endDate, action);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
