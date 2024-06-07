/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.homestay.register;

import DAO.HomestayDAO;
import DAO.NeighbourhoodDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Homestay;
import utilities.Int;

/**
 *
 * @author PC
 */
@WebServlet(name = "Register_step2_controll", urlPatterns = {"/register_step2_controll"})
public class register_step2_controll extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet register_step2_controll</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet register_step2_controll at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
            String disrict_id_str = request.getParameter("district");
            String address_detail=request.getParameter("address_detail");
            String[] neighbourhoods_str = request.getParameterValues("neighbourhood");
            int[] neighbourhoods = Int.convertStringListToIntegerList(neighbourhoods_str);
            boolean isError = false;
            String url = "/homestay/homestay_register/step3.jsp";
        try {                     
            int district_id=Integer.parseInt(disrict_id_str);
            if (neighbourhoods != null && neighbourhoods.length > 0) {
                Homestay ht = (Homestay)session.getAttribute("homestay_register");
                if(HomestayDAO.update(ht.getHt_id(), district_id, address_detail)){
                    NeighbourhoodDAO.insertNeighbourhoodOfHomestay(ht.getHt_id(), neighbourhoods);
                }
                else isError=true;
            } else isError = true;
        } catch (Exception e) {
            isError=true;
        }
        if(isError){
            request.setAttribute("fail_request", "Request is fail!");
            url="/homestay/homestay_register/step2.jsp";
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
