
package controller.password;

import DAO.AccountDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author PC
 */
@WebServlet(name = "ResetPassword", urlPatterns = {"/resetpassword"})
public class ResetPassword extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ResetPassword</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPassword at " + request.getContextPath() + "</h1>");
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
        String pass=request.getParameter("pass");
        String pass_conf=request.getParameter("pass_conf");
        String url="/index.jsp";
        boolean isError=false;
        if(pass.equals(pass_conf)){
            String email=(String)request.getSession().getAttribute("email");
            if(AccountDAO.changePassword(email, pass)){
                Account account=AccountDAO.getAccountByEmail(email);
                request.getSession().setAttribute("account", account);
            }
            else{
                isError=true;
                request.setAttribute("resetPasswordFail", "Reset password fail!");
            }
        }else{
            isError=true;
            request.setAttribute("pass_conf_error", "Passwords do not match!");         
        }     
        if(isError){
            request.setAttribute("pass", pass);
            request.setAttribute("pass_conf", pass_conf);
            url="/access/password/resetPassword.jsp";
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
