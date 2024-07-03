/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.homestay.manage;

import DAO.HomestayDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import model.Homestay;


@WebServlet(name = "HomestayInfor", urlPatterns = {"/homestayinfor"})
public class HomestayInforDirect extends HttpServlet {

    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String homestay_id_str=request.getParameter("ht_id");
        int homestay_id = Integer.parseInt(homestay_id_str);
        Homestay homestay=HomestayDAO.getHomestayById(homestay_id);
        HttpSession session = request.getSession();
        session.setAttribute("homestay", homestay);
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/homestay/homestay_manage/infor.jsp");
        rd.forward(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
