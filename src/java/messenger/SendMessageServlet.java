package messenger;

import DAO.MessageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Message;
import model.Account;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/sendMessage")
public class SendMessageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ownerIdStr = request.getParameter("owner_id");
        String customerIdStr = request.getParameter("customer_id");
        String messageText = request.getParameter("message");

        if (ownerIdStr == null || ownerIdStr.isEmpty() || customerIdStr == null || customerIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Owner ID and Customer ID must not be empty.");
            return;
        }

        int ownerId;
        int customerId;
        try {
            ownerId = Integer.parseInt(ownerIdStr);
            customerId = Integer.parseInt(customerIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Owner ID or Customer ID.");
            return;
        }

        Account senderAccount = (Account) request.getSession().getAttribute("account");
        if (senderAccount == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User must be logged in.");
            return;
        }

        String senderName = senderAccount.getRole_account() == 2 ? "Owner" : "Customer";
        Message message = new Message(ownerId, customerId, messageText, LocalDateTime.now(), senderName);

        MessageDAO.saveMessage(message);
        response.sendRedirect(request.getContextPath() + "/viewMessages.jsp");
    }
}
