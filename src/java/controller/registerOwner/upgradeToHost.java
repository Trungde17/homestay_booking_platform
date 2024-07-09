package controller.registerOwner;

import DAO.HostImageDAO;
import DAO.RegisterOwnerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Map;
import model.Account;
import model.HostUpgradeRequest;
import model.ImageHost;
import utilities.CloudinaryConfig1;

@WebServlet(name = "upgradeToHost", urlPatterns = {"/upgradeToHost"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
                 maxFileSize = 1024 * 1024 * 5, 
                 maxRequestSize = 1024 * 1024 * 5 * 5)
public class upgradeToHost extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");

        if (currentUser == null) {
            response.sendRedirect("./access/login.jsp");
            return;
        }

        if (isUpgradeRequestPending(currentUser)) {
            request.setAttribute("message", "Tài khoản bạn đang được xác minh, vui lòng chờ.");
            request.getRequestDispatcher("/account/upgradeToHost.jsp").forward(request, response);
            return;
        }

        HostUpgradeRequest upgradeRequest = new HostUpgradeRequest();
        upgradeRequest.setAccountId(currentUser.getAccount_id());
        upgradeRequest.setIdNumber(request.getParameter("idNumber"));
        upgradeRequest.setBankAccount(request.getParameter("bankAccount"));
        upgradeRequest.setBankName(request.getParameter("bankName"));
        upgradeRequest.setAccountHolder(request.getParameter("accountHolder"));
        ArrayList<ImageHost> idImages = new ArrayList<>();
        ArrayList<ImageHost> ownershipDocImages = new ArrayList<>();

        try {
            for (Part filePart : request.getParts()) {
                if (filePart.getName().equals("idImages") && filePart.getSize() > 0) {
                    String imageUrl = uploadToCloudinary(filePart);
                    if (imageUrl != null) {
                        HostImageDAO.insertHostImg(0, imageUrl, 1);
                        idImages.add(new ImageHost(0, 1, imageUrl));
                    }
                } else if (filePart.getName().equals("ownershipDocs") && filePart.getSize() > 0) {
                    String imageUrl = uploadToCloudinary(filePart);
                    if (imageUrl != null) {
                        HostImageDAO.insertHostImg(0, imageUrl, 2);
                        ownershipDocImages.add(new ImageHost(0, 2, imageUrl));
                    }
                }
            }
        } catch (IOException e) {
            request.setAttribute("error", "Lỗi khi tải lên tệp. Vui lòng thử lại.");
            request.getRequestDispatcher("/account/upgradeToHost.jsp").forward(request, response);
            return;
        }
        
        upgradeRequest.setIdImagePath(idImages);
        upgradeRequest.setOwnershipDocPath(ownershipDocImages);

        boolean requestSubmitted = RegisterOwnerDAO.submitUpgradeRequest(upgradeRequest);

        if (requestSubmitted) {
            request.setAttribute("message", "Tài khoản bạn đã được gửi, vui lòng chờ admin xác minh.");
        } else {
            request.setAttribute("error", "Không thể gửi yêu cầu nâng cấp. Vui lòng thử lại.");
        }

        request.getRequestDispatcher("/account/upgradeToHost.jsp").forward(request, response);
    }

    private String uploadToCloudinary(Part filePart) throws IOException {
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        Map uploadResult = CloudinaryConfig1.upLoadFile(filePart.getInputStream(), fileName);
        if (uploadResult != null) {
            return (String) uploadResult.get("url");
        }
        return null;
    }

    private boolean isUpgradeRequestPending(Account currentUser) {
        try {
            return RegisterOwnerDAO.isUpgradeRequestPending(currentUser.getAccount_id());
        } catch (Exception e) {
            System.err.println(e.getMessage());
            return false; 
        }
    }
    private int getOwnerStatusForUser(int accountId) {
        
        return RegisterOwnerDAO.getOwnerStatus(accountId);
    }
}