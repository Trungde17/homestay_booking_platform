package model;

import java.time.LocalDateTime;

public class Message {
    private int id;
    private int account_id;
    private int ownerId;
    private int customerId;
    private String message;
    private LocalDateTime timestamp;
    private String senderName;

    public Message(int id, int account_id, int ownerId, int customerId, String message, LocalDateTime timestamp, String senderName) {
        this.id = id;
        this.account_id = account_id;
        this.ownerId = ownerId;
        this.customerId = customerId;
        this.message = message;
        this.timestamp = timestamp;
        this.senderName = senderName;
    }

    public Message( int ownerId, int customerId, String message, LocalDateTime timestamp) {
       
        this.ownerId = ownerId;
        this.customerId = customerId;
        this.message = message;
        this.timestamp = timestamp;
    }

  

   

    public Message() {
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }
    
    
    
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
}
