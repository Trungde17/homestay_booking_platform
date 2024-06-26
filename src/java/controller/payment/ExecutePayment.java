/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.payment;

import DAO.BookingDAO;
import DAO.RoomDAO;
import model.VnPayConfiguration;
import model.VnPaymentResponseModel;
import services.VnPayService;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Booking;

/**
 *
 * @author FPT
 */
@WebServlet(name = "ExecutePayment", urlPatterns = {"/payment/execute"})
public class ExecutePayment extends HttpServlet {

    VnPayConfiguration config;
    VnPayService _vnPayService;

    @Override
    public void init() {
        config = new VnPayConfiguration();
        _vnPayService = new VnPayService(config);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        VnPaymentResponseModel responseModel;

        HttpSession session = request.getSession();
        try {
            responseModel = _vnPayService.paymentExecute(request.getParameterMap());
            if (responseModel.VnPayResponseCode.equals("00")) {

                Account account = (Account) session.getAttribute("account");
                Booking booking = (Booking) session.getAttribute("cart");
                booking.setBooking_id(BookingDAO.count() + 1);

                if (BookingDAO.insertIntoBooking(booking.getBooking_id(), account.getAccount_id(), booking.getDate_booked(), booking.getCheck_in(), booking.getCheck_out(), booking.getTotalAmount(), 2) == 1) {
                    RoomDAO.insertIntoBookingDetail(booking.getBooking_id(), booking.getRooms());
                }

                String msg = "Payment Success.";
                response.sendRedirect("../booking/booking_result.jsp?msg=" + msg);

            } else if (responseModel.VnPayResponseCode.equals("01")) {
                String error = "Transaction not completed. Please try again";
                response.sendRedirect("../booking/booking_result.jsp?error=" + error);

            } else {
                String error = "An unexpected error occurs while executing payment. Please try again";
                response.sendRedirect("../booking/booking_result.jsp?error=" + error);

            }
            session.removeAttribute("cart");
        } catch (NoSuchAlgorithmException | InvalidKeyException ex) {
            Logger.getLogger(ExecutePayment.class.getName()).log(Level.SEVERE, null, ex);
            String error = "An unexpected error occurs while executing payment. Please try again";
            session.removeAttribute("cart");
            response.sendRedirect("../booking/booking_result.jsp?error=" + error);
        }
    }
}
