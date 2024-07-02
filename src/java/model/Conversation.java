package model;

import java.util.ArrayList;
import java.util.List;

public class Conversation {
    private int ownerId;
    private int customerId;
    private List<Message> messages;

    public Conversation(int ownerId, int customerId) {
        this.ownerId = ownerId;
        this.customerId = customerId;
        this.messages = new ArrayList<>();
    }

    public int getOwnerId() {
        return ownerId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public List<Message> getMessages() {
        return messages;
    }

    public void addMessage(Message message) {
        this.messages.add(message);
    }
}
