package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ScheduleDAO extends DAO {

    public List<Map<String, Object>> getSchedules(int roomId) throws SQLException {
        List<Map<String, Object>> schedules = new ArrayList<>();
        
        // Get busy schedules
        String queryBusy = "SELECT * FROM RoomSchedule WHERE room_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement psBusy = conn.prepareStatement(queryBusy)) {
            psBusy.setInt(1, roomId);
            try (ResultSet rsBusy = psBusy.executeQuery()) {
                while (rsBusy.next()) {
                    Map<String, Object> schedule = new HashMap<>();
                    schedule.put("title", "Busy");
                    schedule.put("start", rsBusy.getDate("start_date").toString());
                    schedule.put("end", rsBusy.getDate("end_date").toString());
                    schedule.put("color", "red");
                    schedules.add(schedule);
                }
            }
        }

        // Get booking schedules
        String queryBooking = "SELECT b.date_checkin AS start_date, b.date_checkout AS end_date " +
                              "FROM tblBooking b " +
                              "JOIN tblBooking_detail bd ON b.booking_id = bd.booking_id " +
                              "WHERE bd.room_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement psBooking = conn.prepareStatement(queryBooking)) {
            psBooking.setInt(1, roomId);
            try (ResultSet rsBooking = psBooking.executeQuery()) {
                while (rsBooking.next()) {
                    Map<String, Object> schedule = new HashMap<>();
                    schedule.put("title", "Booking");
                    schedule.put("start", rsBooking.getDate("start_date").toString());
                    schedule.put("end", rsBooking.getDate("end_date").toString());
                    schedule.put("color", "blue");
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
        String queryUpdateEndDate = "UPDATE RoomSchedule SET end_date = ? WHERE room_id = ? AND start_date = ?";
        String queryUpdateStartDate = "UPDATE RoomSchedule SET start_date = ? WHERE room_id = ? AND end_date = ?";
        String queryDelete = "DELETE FROM RoomSchedule WHERE room_id = ? AND start_date <= ? AND end_date >= ?";
        String queryInsert = "INSERT INTO RoomSchedule (room_id, start_date, end_date) VALUES (?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement psCheckOverlap = conn.prepareStatement(queryCheckOverlap);
             PreparedStatement psUpdateEndDate = conn.prepareStatement(queryUpdateEndDate);
             PreparedStatement psUpdateStartDate = conn.prepareStatement(queryUpdateStartDate);
             PreparedStatement psDelete = conn.prepareStatement(queryDelete);
             PreparedStatement psInsert = conn.prepareStatement(queryInsert)) {

            psCheckOverlap.setInt(1, roomId);
            psCheckOverlap.setDate(2, endDate);
            psCheckOverlap.setDate(3, startDate);

            List<Date> startDates = new ArrayList<>();
            List<Date> endDates = new ArrayList<>();

            try (ResultSet rs = psCheckOverlap.executeQuery()) {
                while (rs.next()) {
                    startDates.add(rs.getDate("start_date"));
                    endDates.add(rs.getDate("end_date"));
                }
            }

            if (startDates.isEmpty()) {
                psInsert.setInt(1, roomId);
                psInsert.setDate(2, startDate);
                psInsert.setDate(3, endDate);
                psInsert.executeUpdate();
            } else {
                Date newStartDate = startDate;
                Date newEndDate = endDate;

                for (Date s : startDates) {
                    if (s.compareTo(newStartDate) < 0) {
                        newStartDate = s;
                    }
                }
                for (Date e : endDates) {
                    if (e.compareTo(newEndDate) > 0) {
                        newEndDate = e;
                    }
                }

                psDelete.setInt(1, roomId);
                psDelete.setDate(2, newEndDate);
                psDelete.setDate(3, newStartDate);
                psDelete.executeUpdate();

                psInsert.setInt(1, roomId);
                psInsert.setDate(2, newStartDate);
                psInsert.setDate(3, newEndDate);
                psInsert.executeUpdate();
            }
        }
    }

    private void removeBusySchedule(int roomId, Date startDate, Date endDate) throws SQLException {
        String querySelect = "SELECT * FROM RoomSchedule WHERE room_id = ? AND start_date <= ? AND end_date >= ?";
        String queryDelete = "DELETE FROM RoomSchedule WHERE room_id = ? AND start_date <= ? AND end_date >= ?";
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
                        psDelete.setDate(2, existingStartDate);
                        psDelete.setDate(3, existingEndDate);
                        psDelete.executeUpdate();
                    } else if (startDate.compareTo(existingStartDate) > 0 && endDate.compareTo(existingEndDate) < 0) {
                        // Split the busy schedule into two parts
                        psUpdateEndDate.setDate(1, new Date(startDate.getTime() - 86400000)); // -1 day
                        psUpdateEndDate.setInt(2, roomId);
                        psUpdateEndDate.setDate(3, existingStartDate);
                        psUpdateEndDate.setDate(4, startDate);
                        psUpdateEndDate.executeUpdate();

                        psInsert.setInt(1, roomId);
                        psInsert.setDate(2, new Date(endDate.getTime() + 86400000)); // +1 day
                        psInsert.setDate(3, existingEndDate);
                        psInsert.executeUpdate();
                    } else if (startDate.compareTo(existingStartDate) <= 0 && endDate.compareTo(existingEndDate) < 0) {
                        // Update the start date of the busy schedule
                        psUpdateStartDate.setDate(1, new Date(endDate.getTime() + 86400000)); // +1 day
                        psUpdateStartDate.setInt(2, roomId);
                        psUpdateStartDate.setDate(3, existingEndDate);
                        psUpdateStartDate.setDate(4, endDate);
                        psUpdateStartDate.executeUpdate();
                    } else if (startDate.compareTo(existingStartDate) > 0 && endDate.compareTo(existingEndDate) >= 0) {
                        // Update the end date of the busy schedule
                        psUpdateEndDate.setDate(1, new Date(startDate.getTime() - 86400000)); // -1 day
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
