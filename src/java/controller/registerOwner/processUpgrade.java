/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.registerOwner;

import DAO.AccountDAO;
import DAO.RegisterOwnerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import model.Account;
import model.HostUpgradeRequest;
import utilities.EmailWork;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "processUpgrade", urlPatterns = {"/processUpgrade"})
public class processUpgrade extends HttpServlet {
     private final EmailWork emailWork = new EmailWork();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet processUpgrade</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet processUpgrade at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         int requestId = Integer.parseInt(request.getParameter("requestId"));
        String action = request.getParameter("action");
        //1 mean aprrove
        if ("1".equals(action)) {
            if (RegisterOwnerDAO.updateRequestStatus(requestId, 1)) {
                HostUpgradeRequest upgradeRequest = RegisterOwnerDAO.getRequestById(requestId);
                Account user = AccountDAO.getAccountById(upgradeRequest.getAccountId());
                //update role to host
                AccountDAO.updateUserRole(user.getAccount_id(), "2");
                //send mail to notice 
                sendApprovalEmail(user.getEmail(), user.getFirst_name());
            }
        }//3 mean reject
        else if ("3".equals(action)) {
            RegisterOwnerDAO.updateRequestStatus(requestId, 3);
             HostUpgradeRequest upgradeRequest = RegisterOwnerDAO.getRequestById(requestId);
                Account user = AccountDAO.getAccountById(upgradeRequest.getAccountId());
               
             sendRejectEmail(user.getEmail(), user.getFirst_name());
        }
        
        response.sendRedirect("admin-dashboard.jsp");// tự sửa phần ni nhé 
    }

    private void sendApprovalEmail(String email, String first_name) {
        String subject = "Chúc mừng! Bạn đã trở thành Host";
        String message = "Xin chào " + first_name + ",\n\n"
                       + "Chúng tôi vui mừng thông báo rằng yêu cầu trở thành Host của bạn đã được chấp nhận. "
                       + "Bạn hiện có thể đăng ký homestay và bắt đầu đón tiếp khách.\n\n"
                       + "Trân trọng,\nĐội ngũ hỗ trợ";      
        emailWork.sendEmail(email, subject, message);
    }

    private void sendRejectEmail(String email, String first_name) {
        String subject = "Xin lỗi , yêu cầu của bạn đã không được chấp thuận ";
        String message = "Xin chào " + first_name + ",\n\n"
                       + "Chúng tôi xin thông báo rằng yêu cầu trở thành Host của bạn đã không được chấp thuận  "
                       + "Bạn vui lòng kiểm tra lại thông tin trước khi đăng kí lại.\n\n"
                       + "Trân trọng,\nĐội ngũ hỗ trợ";
        emailWork.sendEmail(email, subject, message);
    }
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
