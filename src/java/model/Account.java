
package model;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Scanner;


public class Account {

    private int account_id;
    private String email;
    private String password;
    private String first_name;
    private String last_name;
    private String gender;
    private Date date_of_birth;
    private String phone;
    private String address;
    private String avatar_img;
    private ArrayList<Payment>payments;
    private int role_account;
    private Date registration_date;

    public Account() {
        // TODO Auto-generated constructor stub
    }

    public Account(String email, String password, String first_name, String last_name) {
        this.email = email;
        this.password = password;
        this.first_name = first_name;
        this.last_name = last_name;
    }

    public Account(int account_id, String email, String first_name, String last_name, String gender, Date date_of_birth, String phone, String address, String avatar_img) {
        this.account_id = account_id;
        this.email = email;
        this.first_name = first_name;
        this.last_name = last_name;
        this.gender = gender;
        this.date_of_birth = date_of_birth;
        this.phone = phone;
        this.address = address;
        this.avatar_img = avatar_img;
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

    public Account(int account_id, String email, String first_name, String last_name, String gender, String phone, String address) {
        this.account_id = account_id;
        this.email = email;
        this.first_name = first_name;
        this.last_name = last_name;
        this.gender = gender;
        this.phone = phone;
        this.address = address;
    }
    
    

    public Account(int account_id, String email, String password, String first_name, String last_name, String gender,
            Date date_of_birth,
            String phone, String address, String avatar_img, ArrayList<Payment> payments, int role_account,
            Date registration_date) {
        this.account_id = account_id;
        this.email = email;
        this.password = password;
        this.first_name = first_name;
        this.last_name = last_name;
        this.gender = gender;
        this.date_of_birth=date_of_birth;
        this.phone = phone;
        this.address = address;
        this.avatar_img = avatar_img;
        this.payments = payments;
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

    public ArrayList<Payment> getPayments() {
        return payments;
    }

    public void setPayment_account(ArrayList<Payment> payments) {
        this.payments = payments;
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

    public Date getDate_of_birth() {
        return date_of_birth;
    }

    public void setDate_of_birth(Date date_of_birth) {
        this.date_of_birth = date_of_birth;
    }
      
    public String getFullName(){
        return first_name + " " + last_name;
    }
     public String getAge() {
        if (date_of_birth != null) {
            // Tạo đối tượng Calendar cho ngày hiện tại
            Calendar calCurrent = Calendar.getInstance();
            calCurrent.setTime(new Date());

            // Tạo đối tượng Calendar cho ngày sinh
            Calendar calBirth = Calendar.getInstance();
            calBirth.setTime(date_of_birth);

            // Lấy năm hiện tại và năm sinh
            int yearCurrent = calCurrent.get(Calendar.YEAR);
            int yearBirth = calBirth.get(Calendar.YEAR);

            // Tính tuổi
            int age = yearCurrent - yearBirth;

            // Kiểm tra nếu tháng hoặc ngày sinh chưa đến trong năm hiện tại, trừ tuổi đi 1
            int monthCurrent = calCurrent.get(Calendar.MONTH);
            int monthBirth = calBirth.get(Calendar.MONTH);
            if (monthCurrent < monthBirth || (monthCurrent == monthBirth && calCurrent.get(Calendar.DAY_OF_MONTH) < calBirth.get(Calendar.DAY_OF_MONTH))) {
                age--;
            }

            return String.valueOf(age);
        }
        return "";
    }
    @Override
    public String toString() {
        return "Account [account_id=" + account_id + ", email=" + email + ", password=" + password + ", first_name="
                + first_name + ", last_name=" + last_name + ", gender=" + gender + ", phone=" + phone + ", address="
                + address + ", avatar_img=" + avatar_img + ", payment_account=" + payments + ", role_account="
                + role_account + ", registration_date=" + registration_date + "]";
    }
    
    public static void main(String[] args) {
    }
}
