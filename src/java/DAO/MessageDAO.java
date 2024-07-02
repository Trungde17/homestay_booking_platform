package DAO;

import model.Message;
import model.Conversation;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;

public class MessageDAO {

    public static void saveMessage(Message message) {
        try (Connection connection = DAO.getConnection()) {
            String query = "INSERT INTO messages (owner_id, customer_id, account_id, message, timestamp, sender_name) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, message.getOwnerId());
            preparedStatement.setInt(2, message.getCustomerId());
            preparedStatement.setInt(3, message.getAccount_id());
            preparedStatement.setString(4, message.getMessage());
            preparedStatement.setTimestamp(5, Timestamp.valueOf(message.getTimestamp()));
            preparedStatement.setString(6, message.getSenderName());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static List<Conversation> getConversationsByOwnerId(int ownerId) {
        return getConversations("SELECT * FROM messages WHERE owner_id = ? OR customer_id = ? ORDER BY timestamp", ownerId);
    }

    public static List<Conversation> getConversationsByCustomerId(int customerId) {
        return getConversations("SELECT * FROM messages WHERE customer_id = ? OR owner_id = ? ORDER BY timestamp", customerId);
    }

    private static List<Conversation> getConversations(String query, int id) {
        Map<Integer, Conversation> conversationMap = new HashMap<>();
        try (Connection connection = DAO.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.setInt(2, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int ownerId = resultSet.getInt("owner_id");
                int customerId = resultSet.getInt("customer_id");
                int conversationId = id == ownerId ? customerId : ownerId;
                Conversation conversation = conversationMap.computeIfAbsent(conversationId, k -> new Conversation(ownerId, customerId));
                Message message = new Message();
                message.setId(resultSet.getInt("id"));
                message.setOwnerId(ownerId);
                message.setCustomerId(customerId);
                message.setAccount_id(resultSet.getInt("account_id"));
                message.setMessage(resultSet.getString("message"));
                message.setTimestamp(resultSet.getTimestamp("timestamp").toLocalDateTime());
                message.setSenderName(resultSet.getString("sender_name"));
                conversation.addMessage(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new ArrayList<>(conversationMap.values());
    }
}
