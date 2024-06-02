package model;

public class RoomPrice {
    private int price_id;
    private String price_type;
    private double amount_per_night;
    public RoomPrice() {
    }

    
    public RoomPrice(int price_id, String price_type, double amount_per_night) {
        this.price_id = price_id;
        this.price_type = price_type;
        this.amount_per_night=amount_per_night;
    }

    public int getPrice_id() {
        return price_id;
    }

    public void setPrice_id(int price_id) {
        this.price_id = price_id;
    }

    public String getPrice_name() {
        return price_type;
    }

    public void setPrice_name(String price_type) {
        this.price_type = price_type;
    }

    public double getAmount() {
        return amount_per_night;
    }

    public void setAmount(double amount_per_night) {
        this.amount_per_night = amount_per_night;
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
        final RoomPrice other = (RoomPrice) obj;
        return this.price_id == other.price_id;
    }
    
    
}
