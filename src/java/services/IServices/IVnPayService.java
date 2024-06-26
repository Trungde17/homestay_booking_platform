/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package services.IServices;

import model.VnPaymentRequestModel;
import model.VnPaymentResponseModel;
import jakarta.servlet.http.HttpServletRequest;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Map;

/**
 *
 * @author FPT
 */
public interface IVnPayService {

    String createPaymentUrl(HttpServletRequest request, VnPaymentRequestModel model) throws NoSuchAlgorithmException, InvalidKeyException;

    VnPaymentResponseModel paymentExecute(Map<String, String[]> parameterMap) throws NoSuchAlgorithmException, InvalidKeyException;
}
