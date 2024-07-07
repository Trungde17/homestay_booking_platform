package controller.payment;

import model.VnPayConfiguration;
import model.VnPaymentRequestModel;
import services.VnPayService;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.time.LocalDateTime;
import model.Account;
import model.Booking;

/**
 *
 * @author FPT
 */
@WebServlet(name = "AuthorizePayment", urlPatterns = {"/payment/authorize"})
public class AuthorizePayment extends HttpServlet {

    VnPayConfiguration config;
    VnPayService _vnPayService;

    @Override
    public void init() {
        config = new VnPayConfiguration();
        _vnPayService = new VnPayService(config);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            Booking booking = (Booking) session.getAttribute("cart");
            Account account=(Account)session.getAttribute("account");
            
            VnPaymentRequestModel requestModel = new VnPaymentRequestModel();
            requestModel.setAmount((int)booking.getTotalAmount() * 1000);
            requestModel.setCreatedDate(LocalDateTime.now());
            requestModel.setDescription("Booking Payment");
            requestModel.setFullName(account.getFullName());
            requestModel.setOrderId(String.valueOf((int) (Math.random() * 9000) + 1000));

            response.sendRedirect(_vnPayService.createPaymentUrl(request, requestModel));
//            response.sendRedirect("https://facebook.com/pphucc");

        } catch (Exception ex) {
            String error = "An unexpected error occurs while authorizing payment. Please try again" ;

            response.sendRedirect("../booking/booking_result.jsp?error=" + error);
        }
    }
}
