package controller;

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
import utilities.Valid;

/**
 *
 * @author PC
 */
@WebServlet(name = "SigupServlet", urlPatterns = {"/sigupservlet"})
public class SigupServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SigupServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SigupServlet at " + request.getContextPath() + "</h1>");
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
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String pass_conf = request.getParameter("pass_conf");
        String url = "/index.jsp";
        boolean isError = false;
        if (AccountDAO.checkEmail(email)) {
            request.setAttribute("email_error", "This email has been registered!");
            isError = true;
        }

        if (!pass.equals(pass_conf)) {
            request.setAttribute("pass_conf_error", "Confirmation password does not match!");
            isError = true;
        }
        if (!isError) {
            Account account = AccountDAO.signupAccount(email, pass, first_name, last_name, 3);
            if (account == null) {
                isError = true;
                request.setAttribute("signup_failed", "Registration failed!");
            }
            HttpSession session = request.getSession();
            session.setAttribute("account", account);
        }
        if (isError) {
            request.setAttribute("first_name", first_name);
            request.setAttribute("last_name", last_name);
            request.setAttribute("email", email);
            request.setAttribute("pass", pass);
            request.setAttribute("pass_conf", pass_conf);
            url = "/access/signup.jsp";
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
