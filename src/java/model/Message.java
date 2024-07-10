package model;

import java.time.LocalDateTime;

public class Message {
    private int id;
    private int ownerId;
    private int customerId;
    private String message;
    private LocalDateTime timestamp;
    private String senderName;
    private String senderFullName;  // Thêm trường này

    public Message(int ownerId, int customerId, String message, LocalDateTime timestamp, String senderName, String senderFullName) {
        this.ownerId = ownerId;
        this.customerId = customerId;
        this.message = message;
        this.timestamp = timestamp;
        this.senderName = senderName;
        this.senderFullName = senderFullName;  // Gán giá trị cho trường này
    }

    public Message() {
    }

    // Các getter và setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getSenderFullName() {  // Thêm getter
        return senderFullName;
    }

    public void setSenderFullName(String senderFullName) {  // Thêm setter
        this.senderFullName = senderFullName;
    }
}