/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package services;

import helpers.VnPayLibrary;
import helpers.VnPayLibrary.Util;
import model.VnPayConfiguration;
import model.VnPaymentRequestModel;
import model.VnPaymentResponseModel;
import services.IServices.IVnPayService;
import jakarta.servlet.http.HttpServletRequest;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

public class VnPayService implements IVnPayService {

    private final VnPayConfiguration vnPayConfig;

    public VnPayService(VnPayConfiguration vnPayConfig) {
        this.vnPayConfig = vnPayConfig;
    }

    @Override
    public String createPaymentUrl(HttpServletRequest request, VnPaymentRequestModel model) throws NoSuchAlgorithmException, InvalidKeyException {
        String tick = String.valueOf(System.currentTimeMillis());
        VnPayLibrary vnpay = new VnPayLibrary();
        vnpay.addRequestData("vnp_Version", vnPayConfig.getVersion());
        vnpay.addRequestData("vnp_Command", vnPayConfig.getCommand());
        vnpay.addRequestData("vnp_TmnCode", vnPayConfig.getTmnCode());
        vnpay.addRequestData("vnp_Amount", String.format("%.0f", model.getAmount() * 100));

        vnpay.addRequestData("vnp_CreateDate", model.getCreatedDate().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
        vnpay.addRequestData("vnp_CurrCode", vnPayConfig.getCurrCode());
        vnpay.addRequestData("vnp_IpAddr", Util.getIpAddress(request));
        vnpay.addRequestData("vnp_Locale", vnPayConfig.getLocale());
        vnpay.addRequestData("vnp_OrderInfo", "Thanh toan don hang:" + model.getOrderId());
        vnpay.addRequestData("vnp_OrderType", "other");
        vnpay.addRequestData("vnp_ReturnUrl", vnPayConfig.getReturnUrl());
        vnpay.addRequestData("vnp_TxnRef", tick);

        String paymentUrl = vnpay.createRequestUrl(vnPayConfig.getUrl(), vnPayConfig.getHashSecret());

        return paymentUrl;
    }

    @Override
    public VnPaymentResponseModel paymentExecute(Map<String, String[]> parameterMap) throws NoSuchAlgorithmException, InvalidKeyException {
        VnPayLibrary vnpay = new VnPayLibrary();
        for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue()[0]; // Assuming single value per key
            if (!key.isEmpty() && key.startsWith("vnp_")) {
                vnpay.addResponseData(key, value);
            }
        }

        
        long vnp_orderId = Long.parseLong(vnpay.getResponseData("vnp_TxnRef"));
        long vnp_Amount = Long.parseLong(vnpay.getResponseData("vnp_Amount")) / 100;
        long vnp_TranId = Long.parseLong(vnpay.getResponseData("vnp_TransactionNo"));
        String vnp_TransactionStatus = vnpay.getResponseData("vnp_TransactionStatus");
        String vnp_SecureHash = parameterMap.get("vnp_SecureHash")[0];
        String vnp_ResponseCode = vnpay.getResponseData("vnp_ResponseCode");
        String vnp_OrderInfo = vnpay.getResponseData("vnp_OrderInfo");
        boolean checkSignature = vnpay.validateSignature(vnp_SecureHash, vnPayConfig.getHashSecret());

        if (!checkSignature) {
            return new VnPaymentResponseModel(false);
        }

        return new VnPaymentResponseModel(
                true,
                "VnPay",
                vnp_OrderInfo,
                String.valueOf(vnp_orderId),
                String.valueOf(vnp_TranId),
                vnp_SecureHash,
                vnp_ResponseCode
        );
    }
}
