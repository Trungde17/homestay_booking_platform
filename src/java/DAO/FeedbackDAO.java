package DAO;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;

public class FeedbackDAO extends DAO {

    private static final String INSERT_FEEDBACK_SQL = "INSERT INTO tblFeedback (booking_id, customerName, comments, rating, createdDate) VALUES (?, ?, ?, ?, ?);";
    private static final String SELECT_FEEDBACK_BY_ID = "SELECT id, booking_id, customerName, comments, rating, createdDate FROM tblFeedback WHERE id = ?";
    private static final String SELECT_ALL_FEEDBACK = "SELECT * FROM tblFeedback";
    private static final String DELETE_FEEDBACK_SQL = "DELETE FROM tblFeedback WHERE id = ?;";
    private static final String UPDATE_FEEDBACK_SQL = "UPDATE tblFeedback SET booking_id = ?, customerName = ?, comments = ?, rating = ?, createdDate = ? WHERE id = ?;";

    public FeedbackDAO() {
    }

    public static boolean insertFeedback(Feedback feedback) throws SQLException {
        boolean success = false;
        try ( Connection connection = getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(INSERT_FEEDBACK_SQL)) {
            preparedStatement.setInt(1, feedback.getBooking_id());
            preparedStatement.setString(2, feedback.getCustomerName());
            preparedStatement.setString(3, feedback.getComments());
            preparedStatement.setInt(4, feedback.getRating());
            preparedStatement.setDate(5, Date.valueOf(feedback.getCreatedDate()));
            preparedStatement.executeUpdate();
            success = true;
        } catch (SQLException e) {
            success = false;
            printSQLException(e);

        }
        return success;
    }

    public static Feedback selectFeedback(int id) throws SQLException {
        Feedback feedback = null;
        try ( Connection connection = getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(SELECT_FEEDBACK_BY_ID);) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int booking_id = rs.getInt("booking_id");
                String customerName = rs.getString("customerName");
                String comments = rs.getString("comments");
                int rating = rs.getInt("rating");
                LocalDate createdDate = rs.getDate("createdDate").toLocalDate();
                feedback = new Feedback(id, booking_id, customerName, comments, rating, createdDate);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return feedback;
    }

    public static List<Feedback> selectAllFeedback() {
        List<Feedback> feedbackList = new ArrayList<>();
        try ( Connection connection = getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_FEEDBACK);) {
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                int booking_id = rs.getInt("booking_id");
                String customerName = rs.getString("customerName");
                String comments = rs.getString("comments");
                int rating = rs.getInt("rating");
                LocalDate createdDate = rs.getDate("createdDate").toLocalDate();
                feedbackList.add(new Feedback(id, booking_id, customerName, comments, rating, createdDate));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return feedbackList;
    }

    public static boolean deleteFeedback(int id) throws SQLException {
        boolean rowDeleted;
        try ( Connection connection = getConnection();  PreparedStatement statement = connection.prepareStatement(DELETE_FEEDBACK_SQL);) {
            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public static boolean updateFeedback(Feedback feedback) throws SQLException {
        boolean rowUpdated;
        try ( Connection connection = getConnection();  PreparedStatement statement = connection.prepareStatement(UPDATE_FEEDBACK_SQL);) {
            statement.setInt(1, feedback.getBooking_id());
            statement.setString(2, feedback.getCustomerName());
            statement.setString(3, feedback.getComments());
            statement.setInt(4, feedback.getRating());
            statement.setDate(5, java.sql.Date.valueOf(feedback.getCreatedDate()));
            statement.setInt(6, feedback.getId());
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    private static void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException sQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + sQLException.getSQLState());
                System.err.println("Error Code: " + sQLException.getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
