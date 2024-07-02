/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author ASUS
 */
public class HostUpgradeRequest {
    private int id;
    private int AccountId;
    private String idNumber;
    private String bankAccount;
    private String bankName; 
    private String accountHolder;// ten chu tai khoan
    private String phoneNumber;
    private String permanentAddress;
    private ArrayList<ImageHost> idImagePath;
    private ArrayList<ImageHost> ownershipDocPath;
    private int status;//1 la approve 2 la pending 3 la reject
    private Date requestDate;
    
    //constructor

    public HostUpgradeRequest() {
    }

    public HostUpgradeRequest(int id, int AccountId, String idNumber, String bankAccount, String bankName, String accountHolder, String phoneNumber, String permanentAddress, ArrayList<ImageHost> idImagePath, ArrayList<ImageHost> ownershipDocPath, int status, Date requestDate) {
        this.id = id;
        this.AccountId = AccountId;
        this.idNumber = idNumber;
        this.bankAccount = bankAccount;
        this.bankName = bankName;
        this.accountHolder = accountHolder;
        this.phoneNumber = phoneNumber;
        this.permanentAddress = permanentAddress;
        this.idImagePath = idImagePath;
        this.ownershipDocPath = ownershipDocPath;
        this.status = status;
        this.requestDate = requestDate;
    }

   

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccountId() {
        return AccountId;
    }

    public void setAccountId(int AccountId) {
        this.AccountId = AccountId;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getAccountHolder() {
        return accountHolder;
    }

    public void setAccountHolder(String accountHolder) {
        this.accountHolder = accountHolder;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPermanentAddress() {
        return permanentAddress;
    }

    public void setPermanentAddress(String permanentAddress) {
        this.permanentAddress = permanentAddress;
    }

    public ArrayList<ImageHost> getIdImagePath() {
        return idImagePath;
    }

    public void setIdImagePath(ArrayList<ImageHost> idImagePath) {
        this.idImagePath = idImagePath;
    }

    public ArrayList<ImageHost> getOwnershipDocPath() {
        return ownershipDocPath;
    }

    public void setOwnershipDocPath(ArrayList<ImageHost> ownershipDocPath) {
        this.ownershipDocPath = ownershipDocPath;
    }

  

    
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }

   
    
}
