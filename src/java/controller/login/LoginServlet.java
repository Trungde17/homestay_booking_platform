package controller.login;

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
import model.GoogleAccount;
import utilities.GoogleLogin;
import utilities.Valid;
import utilities.random;

/**
 *
 * @author PC
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login_servlet"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String code = request.getParameter("code");
        GoogleLogin gg = new GoogleLogin();
        String accessToken = gg.getToken(code);
        System.out.println(accessToken);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "/access/login.jsp";
        boolean isError = false;
        String code = request.getParameter("code");
        GoogleLogin gg = new GoogleLogin();
        String accessToken = gg.getToken(code);
        GoogleAccount gg_account = gg.getUserInfo(accessToken);
        Account account = AccountDAO.getAccountByEmail(gg_account.getEmail());
        if (account == null) {
            account = AccountDAO.signupAccount(gg_account.getEmail(),
                    random.generateRandomPassword(8, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_-+=<>?"),
                    gg_account.getGiven_name(), gg_account.getFamily_name(), 3);
        } else {
            if (!account.isStatus()) {
                request.setAttribute("not_allow", "You are not allowed to login to HealingLand.");
                isError = true;
            }
        }
        if (!isError) {
            url = "/index.jsp";
            HttpSession session = request.getSession();
            session.setAttribute("account", account);
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "/access/login.jsp";
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Account account = null;
        boolean error = false;
        if (Valid.isValidEmailAddress(email)) {
            account = AccountDAO.verifyTheAccount(email, password);
            if (account != null) {
                if (account.getRole_account() == 3 || account.getRole_account() == 2) {
                    url = "/index.jsp";
                } else if (account.getRole_account() == 1) {
                    url = "/admin/index.jsp";
                } else {
                    request.setAttribute("not_allow", "You are not allowed to login to HealingLand.");
                    error = true;
                }
            } else {
                request.setAttribute("incorrect_account", "Incorrect account or password!");
                error = true;
            }
        } else {
            request.setAttribute("email_error", "This is not an email!");
            error = true;
        }
        if (error) {
            request.setAttribute("email", email);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("account", account);
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
