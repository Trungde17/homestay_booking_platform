/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class VnPaymentResponseModel {

    public boolean Success;
    public String PaymentMethod;
    public String OrderDescription;
    public String OrderId;
    public String PaymentId;
    public String TransactionId;
    public String Token;
    public String VnPayResponseCode;

    public VnPaymentResponseModel() {
    }

    
    public VnPaymentResponseModel(boolean b) {
        Success = b;
    }

    public VnPaymentResponseModel(boolean Success, String PaymentMethod, String OrderDescription, String OrderId, String TransactionId, String Token, String VnPayResponseCode) {
        this.Success = Success;
        this.PaymentMethod = PaymentMethod;
        this.OrderDescription = OrderDescription;
        this.OrderId = OrderId;
        this.TransactionId = TransactionId;
        this.Token = Token;
        this.VnPayResponseCode = VnPayResponseCode;
    }

    

    public boolean isSuccess() {
        return Success;
    }

    public void setSuccess(boolean Success) {
        this.Success = Success;
    }

    public String getPaymentMethod() {
        return PaymentMethod;
    }

    public void setPaymentMethod(String PaymentMethod) {
        this.PaymentMethod = PaymentMethod;
    }

    public String getOrderDescription() {
        return OrderDescription;
    }

    public void setOrderDescription(String OrderDescription) {
        this.OrderDescription = OrderDescription;
    }

    public String getOrderId() {
        return OrderId;
    }

    public void setOrderId(String OrderId) {
        this.OrderId = OrderId;
    }

    public String getPaymentId() {
        return PaymentId;
    }

    public void setPaymentId(String PaymentId) {
        this.PaymentId = PaymentId;
    }

    public String getTransactionId() {
        return TransactionId;
    }

    public void setTransactionId(String TransactionId) {
        this.TransactionId = TransactionId;
    }

    public String getToken() {
        return Token;
    }

    public void setToken(String Token) {
        this.Token = Token;
    }

    public String getVnPayResponseCode() {
        return VnPayResponseCode;
    }

    public void setVnPayResponseCode(String VnPayResponseCode) {
        this.VnPayResponseCode = VnPayResponseCode;
    }

}
