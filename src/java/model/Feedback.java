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
    private int ht_id;
    private int customer_id;
    private String customerName;

    private String comments;
    private LocalDate createdDate;
    private int rating;

    public Feedback(int id, int ht_id, String customerName, String comments, int rating, LocalDate createdDate) {
        this.id = id;
        this.ht_id = ht_id;
        this.customerName = customerName;
        this.comments = comments;
        this.rating = rating;
        this.createdDate = createdDate;
    }

    public Feedback(int id, int ht_id, int customer_id, String customerName, String comments, int rating, LocalDate createdDate) {
        this.id = id;
        this.ht_id = ht_id;
        this.customer_id = customer_id;
        this.customerName = customerName;
        this.comments = comments;
        this.createdDate = createdDate;
        this.rating = rating;
    }

    public Feedback() {

    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getHt_id() {
        return ht_id;
    }

    public void setHt_id(int booking_id) {
        this.ht_id = booking_id;
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
                + ", ht_id=" + ht_id
                + ", customerName='" + customerName + '\''
                + ", comments='" + comments + '\''
                + ", rating=" + rating
                + '}';
    }
}
