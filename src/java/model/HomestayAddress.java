
package model;

public class HomestayAddress {
    private int address_id;
    private String address_detai;
    private District district;

    public HomestayAddress() {
    }

    public HomestayAddress(int address_id, String address_detai, District district) {
        this.address_id = address_id;
        this.address_detai = address_detai;
        this.district = district;
    }

    public int getAddress_id() {
        return address_id;
    }

    public void setAddress_id(int address_id) {
        this.address_id = address_id;
    }

    public String getAddress_detai() {
        return address_detai;
    }

    public void setAddress_detai(String address_detai) {
        this.address_detai = address_detai;
    }

    public District getDistrict() {
        return district;
    }

    public void setDistrict(District district) {
        this.district = district;
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
        final HomestayAddress other = (HomestayAddress) obj;
        return this.address_id == other.address_id;
    }
    
    
}
