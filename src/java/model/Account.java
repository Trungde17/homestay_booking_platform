/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author PC
 */
public class Account {

    private int account_id;
    private String email;
    private String password;
    private String first_name;
    private String last_name;
    private String gender;
    private String phone;
    private String address;
    private String avatar_img;
    private String payment_account;
    private int role_account;
    private Date registration_date;

    public Account() {
        // TODO Auto-generated constructor stub
    }

    public Account(int account_id, String email, String password, String first_name, String last_name, int role_account,
            Date registration_date) {
        this.account_id = account_id;
        this.email = email;
        this.password = password;
        this.first_name = first_name;
        this.last_name = last_name;
        this.role_account = role_account;
        this.registration_date = registration_date;
    }

    public Account(int account_id, String email, String password, String first_name, String last_name, String gender,
            String phone, String address, String avatar_img, String payment_account, int role_account,
            Date registration_date) {
        this.account_id = account_id;
        this.email = email;
        this.password = password;
        this.first_name = first_name;
        this.last_name = last_name;
        this.gender = gender;
        this.phone = phone;
        this.address = address;
        this.avatar_img = avatar_img;
        this.payment_account = payment_account;
        this.role_account = role_account;
        this.registration_date = registration_date;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPayment_account() {
        return payment_account;
    }

    public void setPayment_account(String payment_account) {
        this.payment_account = payment_account;
    }

    public int getRole_account() {
        return role_account;
    }

    public void setRole_account(int role_account) {
        this.role_account = role_account;
    }

    public Date getRegistration_date() {
        return registration_date;
    }

    public void setRegistration_date(Date registration_date) {
        this.registration_date = registration_date;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAvatar_img() {
        return avatar_img;
    }

    public void setAvatar_img(String avatar_img) {
        this.avatar_img = avatar_img;
    }

    @Override
    public String toString() {
        return "Account [account_id=" + account_id + ", email=" + email + ", password=" + password + ", first_name="
                + first_name + ", last_name=" + last_name + ", gender=" + gender + ", phone=" + phone + ", address="
                + address + ", avatar_img=" + avatar_img + ", payment_account=" + payment_account + ", role_account="
                + role_account + ", registration_date=" + registration_date + "]";
    }
}
