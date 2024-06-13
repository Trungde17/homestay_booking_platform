
package model;

public class HomestayFacilities {
    private int facilities_id;
    private String facilities_name;
    
    public HomestayFacilities(int facilities_id, String facilities_name) {
        this.facilities_id = facilities_id;
        this.facilities_name = facilities_name;
    }

    public int getFacilities_id() {
        return facilities_id;
    }

    public void setFacilities_id(int facilities_id) {
        this.facilities_id = facilities_id;
    }

    public String getFacilities_name() {
        return facilities_name;
    }

    public void setFacilities_name(String facilities_name) {
        this.facilities_name = facilities_name;
    }

    @Override
    public int hashCode() {
        int hash = 3;
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
        final HomestayFacilities other = (HomestayFacilities) obj;
        return this.facilities_id == other.facilities_id;
    }
    
    
}
