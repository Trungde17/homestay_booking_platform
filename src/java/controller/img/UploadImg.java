/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.img;

import DAO.AccountDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.util.Map;
import model.Account;
import utilities.CloudinaryConfig1;

@WebServlet(name = "UploadImg", urlPatterns = {"/uploadimg"})
@MultipartConfig(maxFileSize = 16177215)
public class UploadImg extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UploadImg</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UploadImg at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Part filePart = request.getPart("img_file");
        HttpSession session = request.getSession();
        if (filePart != null) {
            Account account = (Account) session.getAttribute("account");
            String fileName = filePart.getSubmittedFileName();
            Map mapResult = CloudinaryConfig1.upLoadFile(filePart.getInputStream(), fileName);
            if (mapResult != null) {
                String img_url = (String) mapResult.get("url");
                CloudinaryConfig1.deleteCloundinary(account.getAvatar_img());
                AccountDAO.changeAvatar(account.getAccount_id(), img_url); 
                account.setAvatar_img(img_url);
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/account/personal_profile.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
