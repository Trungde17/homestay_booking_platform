/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import model.*;

public class VnPayConfiguration {

    private String version;
    private String command;
    private String tmnCode;
    private String currCode;
    private String locale;
    private String returnUrl;
    private String url;
    private String hashSecret;

    public VnPayConfiguration() {
        this.version = "2.1.0";
        this.command = "pay";
        this.tmnCode = "QFTDPRCF";
        this.currCode = "VND";
        this.locale = "vn";
        this.returnUrl = "http://localhost:8081/healingland/payment/execute";
        this.url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
        this.hashSecret = "Q31Q1C8ISR7X0I7LE15CJU1RCU8DASH1";
    }

    // Getters and Setters
    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getCommand() {
        return command;
    }

    public void setCommand(String command) {
        this.command = command;
    }

    public String getTmnCode() {
        return tmnCode;
    }

    public void setTmnCode(String tmnCode) {
        this.tmnCode = tmnCode;
    }

    public String getCurrCode() {
        return currCode;
    }

    public void setCurrCode(String currCode) {
        this.currCode = currCode;
    }

    public String getLocale() {
        return locale;
    }

    public void setLocale(String locale) {
        this.locale = locale;
    }

    public String getReturnUrl() {
        return returnUrl;
    }

    public void setReturnUrl(String returnUrl) {
        this.returnUrl = returnUrl;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getHashSecret() {
        return hashSecret;
    }

    public void setHashSecret(String hashSecret) {
        this.hashSecret = hashSecret;
    }
}
