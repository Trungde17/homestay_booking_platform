/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;

/**
 *
 * @author acer
 */
public class Feedback {

    private int id;
    private int booking_id;
    private String customerName;
    private String comments;
    private LocalDate createdDate;
    private int rating;

    public Feedback(int id, int booking_id, String customerName, String comments, int rating, LocalDate createdDate) {
        this.id = id;
        this.booking_id = booking_id;
        this.customerName = customerName;
        this.comments = comments;
        this.rating = rating;
        this.createdDate = createdDate;
    }

    public Feedback() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBooking_id() {
        return booking_id;
    }

    public void setBooking_id(int booking_id) {
        this.booking_id = booking_id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public LocalDate getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDate createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        return "Feedback{"
                + "id=" + id
                + ", booking_id=" + booking_id
                + ", customerName='" + customerName + '\''
                + ", comments='" + comments + '\''
                + ", rating=" + rating
                + '}';
    }
}
