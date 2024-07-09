//package favourite;
//
//import DAO.HomestayDAO;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import model.Account;
//
//@WebServlet("/AddFavouriteServlet")
//public class AddFavouriteServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        Account account = (Account) request.getSession().getAttribute("account");
//        if (account == null) {
//            response.sendRedirect(request.getContextPath() + "/access/login.jsp");
//            return;
//        }
//
//        int accountId = account.getAccount_id();
//        int homestayId = Integer.parseInt(request.getParameter("homestayId"));
//
//        try {
//            HomestayDAO.addFavourite(accountId, homestayId);
//            response.sendRedirect(request.getContextPath() + "/favourite/add_favourite");
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect(request.getContextPath() + "/error.jsp");
//        }
//    }
//}
