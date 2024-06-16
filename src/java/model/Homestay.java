package model;

import java.util.ArrayList;
import java.util.Date;

public class Homestay {

    private int ht_id;
    private String ht_name;
    private Account owner;
    private HomestayType homestayType;
    private String describe;
    private District district;
    private String address_detail;
    private Payment payment;
    private String homestay_rules;
    private ArrayList<Rule> commonRules;
    private ArrayList<HomestayImg> img;
    private ArrayList<HomestayFacilities> facilities;
    private ArrayList<Neighbourhood> neighbourhoods;
    private Date registration_date;
    private int status;
    private ArrayList<Room> rooms;

    public Homestay() {
    }

  
    public Homestay(String ht_name, Account owner, HomestayType homestayType, String describe, District district, String address_detail, Payment payment, ArrayList<HomestayImg> img, ArrayList<HomestayFacilities> facilities) {
        this.ht_name = ht_name;
        this.owner = owner;
        this.homestayType = homestayType;
        this.describe = describe;
        this.district = district;
        this.address_detail = address_detail;
        this.payment = payment;
        this.img = img;
        this.facilities = facilities;
    }
    

    public Homestay(int ht_id, String ht_name, Account owner, HomestayType homestayType, String describe, 
            District district, String address_detail, Payment payment, String homestay_rules, ArrayList<Rule>commonRules,
            ArrayList<HomestayImg> img, ArrayList<HomestayFacilities> facilities, ArrayList<Neighbourhood> neighbourhoods, 
            Date registration_date, ArrayList<Room>rooms, int status)
    {
        this.ht_id = ht_id;
        this.ht_name = ht_name;
        this.owner = owner;
        this.homestayType = homestayType;
        this.describe = describe;
        this.district = district;
        this.address_detail = address_detail;
        this.payment = payment;
        this.homestay_rules = homestay_rules;
        this.commonRules = commonRules;
        this.img = img;
        this.facilities = facilities;
        this.neighbourhoods = neighbourhoods;
        this.registration_date = registration_date;
        this.status = status;
        this.rooms = rooms;
    }

    public int getHt_id() {
        return ht_id;
    }

    public void setHt_id(int ht_id) {
        this.ht_id = ht_id;
    }

    public String getHt_name() {
        return ht_name;
    }

    public void setHt_name(String ht_name) {
        this.ht_name = ht_name;
    }

    public Account getOwner() {
        return owner;
    }

    public void setOwner(Account owner) {
        this.owner = owner;
    }

    public HomestayType getHomestayType() {
        return homestayType;
    }

    public void setHomestayType(HomestayType homestayType) {
        this.homestayType = homestayType;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public District getDistrict() {
        return district;
    }

    public void setDistrict(District district) {
        this.district = district;
    }

    public String getAddress_detail() {
        return address_detail;
    }

    public void setAddress_detail(String address_detail) {
        this.address_detail = address_detail;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    public String getHomestay_rules() {
        return homestay_rules;
    }

    public void setHomestay_rules(String homestay_rules) {
        this.homestay_rules = homestay_rules;
    }

    public ArrayList<Rule> getCommonRules() {
        return commonRules;
    }

    public void setCommonRules(ArrayList<Rule> commonRules) {
        this.commonRules = commonRules;
    }

    public ArrayList<HomestayImg> getImg() {
        return img;
    }

    public void setImg(ArrayList<HomestayImg> img) {
        this.img = img;
    }

    public ArrayList<HomestayFacilities> getFacilities() {
        return facilities;
    }

    public void setFacilities(ArrayList<HomestayFacilities> facilities) {
        this.facilities = facilities;
    }

    public ArrayList<Neighbourhood> getNeighbourhoods() {
        return neighbourhoods;
    }

    public void setNeighbourhoods(ArrayList<Neighbourhood> neighbourhoods) {
        this.neighbourhoods = neighbourhoods;
    }

    public Date getRegistration_date() {
        return registration_date;
    }

    public void setRegistration_date(Date registration_date) {
        this.registration_date = registration_date;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public ArrayList<Room> getRooms() {
        return rooms;
    }

    public void setRooms(ArrayList<Room> rooms) {
        this.rooms = rooms;
    }

    public String getFacilitiesString() {
        String result = "";
        if (facilities != null && facilities.size() > 0) {
            int i = 0;
            while (i < facilities.size() - 1) {
                result += facilities.get(i).getFacilities_name() + ", ";
                i++;
            }
            result += facilities.get(i).getFacilities_name() + ".";
        }
        return result;
    }

    public String getNeighbourhoodsString() {
        String result = "";
        if (neighbourhoods != null && neighbourhoods.size() > 0) {
            int i = 0;
            while (i < neighbourhoods.size() - 1) {
                result += neighbourhoods.get(i).getNeighbourhood_name() + ", ";
                i++;
            }
            result += neighbourhoods.get(i).getNeighbourhood_name() + ".";
        }
        return result;
    }
    
    public String getFullAddress(){
        return getAddress_detail() + ", " + district.getDistrict_name();
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
        final Homestay other = (Homestay) obj;
        return this.ht_id == other.ht_id;
    }

}
