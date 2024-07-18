package DAO;

import static DAO.DAO.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ScheduleDAO  extends DAO{
    
    public List<Map<String, Object>> getSchedules(int roomId) throws SQLException {
        List<Map<String, Object>> schedules = new ArrayList<>();
        String query = "SELECT * FROM RoomSchedule WHERE room_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> schedule = new HashMap<>();
                    schedule.put("title", "Busy");
                    schedule.put("start", rs.getDate("start_date").toString());
                    schedule.put("end", rs.getDate("end_date").toString());
                    schedules.add(schedule);
                }
            }
        }
        return schedules;
    }

    public void handleSchedule(int roomId, String startDate, String endDate, String action) throws SQLException {
        if (action.equals("add")) {
            addBusySchedule(roomId, Date.valueOf(startDate), Date.valueOf(endDate));
        } else if (action.equals("delete")) {
            removeBusySchedule(roomId, Date.valueOf(startDate), Date.valueOf(endDate));
        }
    }

    private void addBusySchedule(int roomId, Date startDate, Date endDate) throws SQLException {
        String queryCheckOverlap = "SELECT * FROM RoomSchedule WHERE room_id = ? AND (start_date <= ? AND end_date >= ?)";
        String queryUpdateEndDate = "UPDATE RoomSchedule SET end_date = ? WHERE room_id = ? AND start_date = ? AND end_date < ?";
        String queryUpdateStartDate = "UPDATE RoomSchedule SET start_date = ? WHERE room_id = ? AND end_date = ? AND start_date > ?";
        String queryInsert = "INSERT INTO RoomSchedule (room_id, start_date, end_date) VALUES (?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement psCheckOverlap = conn.prepareStatement(queryCheckOverlap);
             PreparedStatement psUpdateEndDate = conn.prepareStatement(queryUpdateEndDate);
             PreparedStatement psUpdateStartDate = conn.prepareStatement(queryUpdateStartDate);
             PreparedStatement psInsert = conn.prepareStatement(queryInsert)) {

            psCheckOverlap.setInt(1, roomId);
            psCheckOverlap.setDate(2, endDate);
            psCheckOverlap.setDate(3, startDate);

            try (ResultSet rs = psCheckOverlap.executeQuery()) {
                if (rs.next()) {
                    // Overlapping schedule found, update the existing schedule
                    psUpdateEndDate.setDate(1, endDate);
                    psUpdateEndDate.setInt(2, roomId);
                    psUpdateEndDate.setDate(3, rs.getDate("start_date"));
                    psUpdateEndDate.setDate(4, endDate);
                    psUpdateEndDate.executeUpdate();

                    psUpdateStartDate.setDate(1, startDate);
                    psUpdateStartDate.setInt(2, roomId);
                    psUpdateStartDate.setDate(3, rs.getDate("end_date"));
                    psUpdateStartDate.setDate(4, startDate);
                    psUpdateStartDate.executeUpdate();
                } else {
                    // No overlapping schedule found, insert new schedule
                    psInsert.setInt(1, roomId);
                    psInsert.setDate(2, startDate);
                    psInsert.setDate(3, endDate);
                    psInsert.executeUpdate();
                }
            }
        }
    }

    private void removeBusySchedule(int roomId, Date startDate, Date endDate) throws SQLException {
        String querySelect = "SELECT * FROM RoomSchedule WHERE room_id = ? AND start_date <= ? AND end_date >= ?";
        String queryDelete = "DELETE FROM RoomSchedule WHERE room_id = ? AND start_date >= ? AND end_date <= ?";
        String queryUpdateStartDate = "UPDATE RoomSchedule SET start_date = ? WHERE room_id = ? AND end_date >= ? AND start_date < ?";
        String queryUpdateEndDate = "UPDATE RoomSchedule SET end_date = ? WHERE room_id = ? AND start_date <= ? AND end_date > ?";
        String queryInsert = "INSERT INTO RoomSchedule (room_id, start_date, end_date) VALUES (?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement psSelect = conn.prepareStatement(querySelect);
             PreparedStatement psDelete = conn.prepareStatement(queryDelete);
             PreparedStatement psUpdateStartDate = conn.prepareStatement(queryUpdateStartDate);
             PreparedStatement psUpdateEndDate = conn.prepareStatement(queryUpdateEndDate);
             PreparedStatement psInsert = conn.prepareStatement(queryInsert)) {

            psSelect.setInt(1, roomId);
            psSelect.setDate(2, endDate);
            psSelect.setDate(3, startDate);

            try (ResultSet rs = psSelect.executeQuery()) {
                while (rs.next()) {
                    Date existingStartDate = rs.getDate("start_date");
                    Date existingEndDate = rs.getDate("end_date");

                    if (startDate.compareTo(existingStartDate) <= 0 && endDate.compareTo(existingEndDate) >= 0) {
                        // Case where the entire busy schedule is removed
                        psDelete.setInt(1, roomId);
                        psDelete.setDate(2, startDate);
                        psDelete.setDate(3, endDate);
                        psDelete.executeUpdate();
                    } else if (startDate.compareTo(existingStartDate) > 0 && endDate.compareTo(existingEndDate) < 0) {
                        // Split the busy schedule into two parts
                        psUpdateEndDate.setDate(1, new Date(startDate.getTime() - 1));
                        psUpdateEndDate.setInt(2, roomId);
                        psUpdateEndDate.setDate(3, existingStartDate);
                        psUpdateEndDate.setDate(4, startDate);
                        psUpdateEndDate.executeUpdate();

                        psInsert.setInt(1, roomId);
                        psInsert.setDate(2, new Date(endDate.getTime() + 1));
                        psInsert.setDate(3, existingEndDate);
                        psInsert.executeUpdate();
                    } else if (startDate.compareTo(existingStartDate) <= 0 && endDate.compareTo(existingEndDate) < 0) {
                        // Update the start date of the busy schedule
                        psUpdateStartDate.setDate(1, new Date(endDate.getTime() + 1));
                        psUpdateStartDate.setInt(2, roomId);
                        psUpdateStartDate.setDate(3, existingEndDate);
                        psUpdateStartDate.setDate(4, endDate);
                        psUpdateStartDate.executeUpdate();
                    } else if (startDate.compareTo(existingStartDate) > 0 && endDate.compareTo(existingEndDate) >= 0) {
                        // Update the end date of the busy schedule
                        psUpdateEndDate.setDate(1, new Date(startDate.getTime() - 1));
                        psUpdateEndDate.setInt(2, roomId);
                        psUpdateEndDate.setDate(3, existingStartDate);
                        psUpdateEndDate.setDate(4, startDate);
                        psUpdateEndDate.executeUpdate();
                    }
                }
            }
        }
    }
}
