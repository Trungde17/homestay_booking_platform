package model;

import java.util.ArrayList;
import java.util.Map;

public class Room {

    private int room_id;
    private String room_name;
    private String room_description;
    private int capacity;
    private String size;
    private Map<Bed, Integer> beds;
    private ArrayList<Img> img;
    private ArrayList<RoomFacilities> facilities;
    private ArrayList<RoomPrice> prices;
    private boolean status;

    public Room() {
    }
    
    public Room(int room_id, String room_name){
        this.room_id=room_id;
        this.room_name=room_name;
    }
    public Room(int room_id, String room_name, boolean status) {
        this.room_id = room_id;
        this.room_name = room_name;
        this.status = status;
    }

    
    
    public Room(String room_name, int capacity, String size, ArrayList<Img> img, ArrayList<RoomPrice> prices) {
        this.room_name = room_name;
        this.capacity = capacity;
        this.size = size;
        this.img = img;
        this.prices = prices;
        this.status = status;
    }
    
    
    public Room(int room_id, String room_name, String room_description, int capacity, String size, Map<Bed, Integer> beds, ArrayList<Img> img, ArrayList<RoomFacilities> facilities, ArrayList<RoomPrice> prices, boolean status) {
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
    public String getPricesString(){
        String prices_str="";
        if(prices!=null && prices.size()>0){
            int i=0;
            for(; i < prices.size()-1; i++){
                prices_str+= prices.get(i).getPrice_name()+": "+prices.get(i).getAmount()+"vnd, ";
            }
            prices_str+=prices.get(i).getPrice_name()+": "+prices.get(i).getAmount()+"vnd.";
        }
        return prices_str;
    }
    public String getBedNameString() {
        String result = "";
        if (beds != null && beds.size() > 0) {
            int i = 0;
            for (Map.Entry<Bed, Integer> entry : beds.entrySet()) {
                if (i < beds.size() - 1) {
                    result += entry.getValue() + " " + entry.getKey().getBed_type() + ", ";
                    i++;
                }
            }
            if (i == 0) {
                Map.Entry<Bed, Integer> firstEntry = beds.entrySet().iterator().next();
                result += firstEntry.getValue() + " " + firstEntry.getKey().getBed_type() + ".";
            }
        }
        return result;
    }
    
    public String getRoomFacilitiesString(){
        String result="";
        if (facilities != null && facilities.size()>0) {
            int i =0;
            while(i < facilities.size()-1){
                result+=facilities.get(i).getFacilities_name()+", ";
                i++;
            }
            result += facilities.get(i).getFacilities_name()+".";
        }
        return result;
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
