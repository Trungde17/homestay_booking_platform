/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.registerOwner;

import DAO.HostImageDAO;
import DAO.RegisterOwnerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Map;
import model.Account;
import model.HostUpgradeRequest;
import model.ImageHost;
import utilities.CloudinaryConfig1;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "upgradeToHost", urlPatterns = {"/upgradeToHost"})
  @MultipartConfig(fileSizeThreshold = 1024 * 1024,
                 maxFileSize = 1024 * 1024 * 5, 
                 maxRequestSize = 1024 * 1024 * 5 * 5)
public class upgradeToHost extends HttpServlet {

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
            out.println("<title>Servlet upgradeToHost</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet upgradeToHost at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("upgradeToHost.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        HostUpgradeRequest upgradeRequest = new HostUpgradeRequest();
        upgradeRequest.setAccountId(currentUser.getAccount_id());
        upgradeRequest.setIdNumber(request.getParameter("idNumber"));
        upgradeRequest.setBankAccount(request.getParameter("bankAccount"));
        upgradeRequest.setBankName(request.getParameter("bankName"));
        upgradeRequest.setAccountHolder(request.getParameter("accountHolder"));
        upgradeRequest.setPhoneNumber(request.getParameter("phoneNumber"));
        upgradeRequest.setPermanentAddress(request.getParameter("permanentAddress"));
        ArrayList<ImageHost> idImages = new ArrayList<>();
        ArrayList<ImageHost> ownershipDocImages = new ArrayList<>();

            
        try {
            for (Part filePart : request.getParts()) {
                if (filePart.getName().equals("idImages") && filePart.getSize() > 0) {
                    String imageUrl = uploadToCloudinary(filePart);
                    if (imageUrl != null) {
                        HostImageDAO.insertHostImg(0, imageUrl, 1);
                         // Assuming role 1 for image personal
                    }
                } else if (filePart.getName().equals("ownershipDoc") && filePart.getSize() > 0) {
                    String imageUrl = uploadToCloudinary(filePart);
                    if (imageUrl != null) {
                         HostImageDAO.insertHostImg(0, imageUrl, 1);
//                        ownershipDocImages.add(new ImageHost(2, 0, imageUrl)); // Assuming role 2 for ownership documents
                    }
                }
            }
        } catch (IOException e) {
            
            request.setAttribute("error", "Lỗi khi tải lên tệp. Vui lòng thử lại.");
            request.getRequestDispatcher("upgradeToHost.jsp").forward(request, response);
            return;
        }

        upgradeRequest.setIdImagePath(idImages);
        upgradeRequest.setOwnershipDocPath(ownershipDocImages);

        boolean requestSubmitted = RegisterOwnerDAO.submitUpgradeRequest(upgradeRequest);

        if (requestSubmitted) {
            session.setAttribute("message", "Yêu cầu nâng cấp tài khoản đã được gửi. Vui lòng chờ admin xác minh.");
            response.sendRedirect("user-dashboard.jsp");
        } else {
            request.setAttribute("error", "Không thể gửi yêu cầu nâng cấp. Vui lòng thử lại.");
            request.getRequestDispatcher("upgradeToHost.jsp").forward(request, response);
        }
    }
     private String uploadToCloudinary(Part filePart) throws IOException {
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        Map uploadResult = CloudinaryConfig1.upLoadFile(filePart.getInputStream(), fileName);
        if (uploadResult != null) {
            return (String) uploadResult.get("url");
        }
        return null;
    }
}

    
   