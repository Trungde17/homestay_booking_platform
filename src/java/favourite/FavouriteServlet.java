package favourite;

import DAO.HomestayDAO;
import model.Homestay;
import model.Account;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/favourite/add_favourite")
public class FavouriteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = (Account) request.getSession().getAttribute("account");
        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/access/login.jsp");
            return;
        }

        int accountId = account.getAccount_id();
        List<Homestay> favourites = HomestayDAO.getFavourites(accountId);
        request.setAttribute("favourites", favourites);
        request.getRequestDispatcher("/favourite/add_favourite.jsp").forward(request, response);
    }
}
