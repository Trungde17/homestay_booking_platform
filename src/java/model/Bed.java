
package model;

public class Bed {
    private int bed_id;
    private String bed_type;

    public Bed() {
    }

    public Bed(int bed_id, String bed_type) {
        this.bed_id = bed_id;
        this.bed_type = bed_type;
    }

    public int getBed_id() {
        return bed_id;
    }

    public void setBed_id(int bed_id) {
        this.bed_id = bed_id;
    }

    public String getBed_type() {
        return bed_type;
    }

    public void setBed_type(String bed_type) {
        this.bed_type = bed_type;
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
        final Bed other = (Bed) obj;
        return this.bed_id == other.bed_id;
    }
    
    
}
