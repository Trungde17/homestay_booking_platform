/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.homestay.register;

import DAO.HomestayDAO;
import DAO.RuleDAO;
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
@WebServlet(name = "register_step4_controller", urlPatterns = {"/register_step4_controller"})
public class register_step4_controller extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet register_step4_controller</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet register_step4_controller at " + request.getContextPath() + "</h1>");
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
        String url="/homestay/homestay_register/step5.jsp";
        boolean isError=false;
        String ht_rules = request.getParameter("ht_rules");
        String[]common_rules_str=request.getParameterValues("common_rules");
        int[]common_rules=Int.convertStringListToIntegerList(common_rules_str);
        HttpSession session=request.getSession();
        if(common_rules!=null && common_rules.length>0){
            Homestay ht = (Homestay)session.getAttribute("homestay_register");
            if(HomestayDAO.update(ht.getHt_id(), ht_rules)){
                RuleDAO.insertHomestayRules(ht.getHt_id(), common_rules);
            }
            else isError= true;
        }
        else isError=true;
        if(isError){
            url="/homestay/homestay_register/step4.jsp";
            request.setAttribute("fail_request", "Fail request!");
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
