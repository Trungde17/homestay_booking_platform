package model;


public class HomestayType {
    private int homestay_type_id;
    private String homestay_type_name;

    public HomestayType() {
     
    }

    public HomestayType(int homestay_type_id, String homestay_type_name) {
        this.homestay_type_id = homestay_type_id;
        this.homestay_type_name = homestay_type_name;
    }

    
    public int getHomestay_type_id() {
        return homestay_type_id;
    }

    public void setHomestay_type_id(int homestay_type_id) {
        this.homestay_type_id = homestay_type_id;
    }

    public String getHomestay_type_name() {
        return homestay_type_name;
    }

    public void setHomestay_type_name(String homestay_type_name) {
        this.homestay_type_name = homestay_type_name;
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
        final HomestayType other = (HomestayType) obj;
        return this.homestay_type_id == other.homestay_type_id;
    }
    
    
}
