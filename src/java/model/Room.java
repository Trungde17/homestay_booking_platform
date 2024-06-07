
package model;

import java.util.ArrayList;
import java.util.Map;


public class Room {
    private int room_id;
    private String room_name;
    private String room_description;
    private int capacity;
    private String size;
    private Map<Bed, Integer>beds;
    private ArrayList<Img>img;
    private ArrayList<RoomFacilities>facilities;
    private ArrayList<RoomPrice>prices;
    private boolean status;

    public Room() {
    }

    public Room(int room_id, String room_name, String room_description, int capacity, String size, Map<Bed, Integer>beds, ArrayList<Img> img, ArrayList<RoomFacilities> facilities, ArrayList<RoomPrice>prices, boolean status) {
        this.room_id = room_id;
        this.room_name = room_name;
        this.room_description = room_description;
        this.capacity = capacity;
        this.size = size;
        this.beds = beds;
        this.img = img;
        this.facilities = facilities;
        this.prices = prices;
        this.status = status;
    }
    
    
    public int getRoom_id() {
        return room_id;
    }

    public void setRoom_id(int room_id) {
        this.room_id = room_id;
    }

    public String getRoom_name() {
        return room_name;
    }

    public void setRoom_name(String room_name) {
        this.room_name = room_name;
    }

    public String getRoom_description() {
        return room_description;
    }

    public void setRoom_description(String room_description) {
        this.room_description = room_description;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public Map<Bed, Integer> getBeds() {
        return beds;
    }

    public void setBeds(Map<Bed, Integer> beds) {
        this.beds = beds;
    }


    public ArrayList<Img> getImg() {
        return img;
    }

    public void setImg(ArrayList<Img> img) {
        this.img = img;
    }

    public ArrayList<RoomFacilities> getFacilities() {
        return facilities;
    }

    public void setFacilities(ArrayList<RoomFacilities> facilities) {
        this.facilities = facilities;
    }

    public ArrayList<RoomPrice> getPrices() {
        return prices;
    }

    public void setPrices(ArrayList<RoomPrice> prices) {
        this.prices = prices;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Room other = (Room) obj;
        return this.room_id == other.room_id;
    }
    
    
}
