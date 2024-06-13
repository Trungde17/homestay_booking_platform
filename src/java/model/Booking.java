
package model;

import java.util.ArrayList;
import java.util.Date;

public class Booking {
    private int booking_id;
    private Account guest;
    private Homestay homestay;
    private int guest_number;
    private Date date_booked;
    private Date check_in;
    private Date check_out;
    private double paid_amount;
    private double outstanding_amount;
    private ArrayList<Room>rooms;
    private boolean booking_status;  

    public Booking() {
    }

    public Booking(int booking_id, Account guest, int guest_number, Date date_booked, Date check_in, Date check_out, ArrayList<Room> rooms, boolean booking_status) {
        this.booking_id = booking_id;
        this.guest = guest;
        this.guest_number = guest_number;
        this.date_booked = date_booked;
        this.check_in = check_in;
        this.check_out = check_out;
        this.rooms = rooms;
        this.booking_status = booking_status;
    }
    
    
    public Booking(int booking_id, Account guest, Homestay homestay, int guest_number, Date date_booked, Date check_in, Date check_out, double paid_amount, double outstanding_amount, ArrayList<Room> rooms, boolean booking_status) {
        this.booking_id = booking_id;
        this.guest = guest;
        this.homestay = homestay;
        this.guest_number = guest_number;
        this.date_booked = date_booked;
        this.check_in = check_in;
        this.check_out = check_out;
        this.paid_amount = paid_amount;
        this.outstanding_amount = outstanding_amount;
        this.rooms = rooms;
        this.booking_status = booking_status;
    }
    
    
    public int getBooking_id() {
        return booking_id;
    }

    public void setBooking_id(int booking_id) {
        this.booking_id = booking_id;
    }

    public Account getGuest() {
        return guest;
    }

    public void setGuest(Account guest) {
        this.guest = guest;
    }

    public Homestay getHomestay() {
        return homestay;
    }

    public void setHomestay(Homestay homestay) {
        this.homestay = homestay;
    }

    public int getGuest_number() {
        return guest_number;
    }

    public void setGuest_number(int guest_number) {
        this.guest_number = guest_number;
    }

    public Date getDate_booked() {
        return date_booked;
    }

    public void setDate_booked(Date date_booked) {
        this.date_booked = date_booked;
    }

    public Date getCheck_in() {
        return check_in;
    }

    public void setCheck_in(Date check_in) {
        this.check_in = check_in;
    }

    public Date getCheck_out() {
        return check_out;
    }

    public void setCheck_out(Date check_out) {
        this.check_out = check_out;
    }

    public double getPaid_amount() {
        return paid_amount;
    }

    public void setPaid_amount(double paid_amount) {
        this.paid_amount = paid_amount;
    }

    public double getOutstanding_amount() {
        return outstanding_amount;
    }

    public void setOutstanding_amount(double outstanding_amount) {
        this.outstanding_amount = outstanding_amount;
    }

    public ArrayList<Room> getRooms() {
        return rooms;
    }

    public void setRooms(ArrayList<Room> rooms) {
        this.rooms = rooms;
    }

    public boolean isBooking_status() {
        return booking_status;
    }

    public void setBooking_status(boolean booking_status) {
        this.booking_status = booking_status;
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
        final Booking other = (Booking) obj;
        return this.booking_id == other.booking_id;
    }
    
    
}
