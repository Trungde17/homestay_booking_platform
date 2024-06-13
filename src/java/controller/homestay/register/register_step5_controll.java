package controller.homestay.register;

import DAO.HomestayDAO;
import DAO.HomestayImgDAO;
import DAO.RoomDAO;
import DAO.RoomImgDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;
import model.Homestay;
import model.Room;
import utilities.CloudinaryConfig1;

@WebServlet(name = "register_step5_controll", urlPatterns = {"/register_step5_controll"})
@MultipartConfig(maxFileSize = 16177215)
public class register_step5_controll extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet register_step5_controll</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet register_step5_controll at " + request.getContextPath() + "</h1>");
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
        boolean isError = false;
        String url="/index.jsp";
        HttpSession session = request.getSession();
        Homestay ht = (Homestay) session.getAttribute("homestay_register");
        ArrayList<Room> rooms = RoomDAO.getRoomsOfHomestay(ht.getHt_id());
        Collection<Part> fileParts = request.getParts();
        try {
            for (Part part : fileParts) {
                if (part.getName().equals("homestay_img")) {
                    String fileName = part.getSubmittedFileName();
                    Map mapResult = CloudinaryConfig1.upLoadFile(part.getInputStream(), fileName);
                    String img_url = (String) mapResult.get("url");
                    HomestayImgDAO.InsertHomestayImg(ht.getHt_id(), img_url);
                }

            }
            for (Room room : rooms) {
                Part room_img_part = request.getPart(room.getRoom_id()+"");
                String fileName = room_img_part.getSubmittedFileName();
                Map mapResult = CloudinaryConfig1.upLoadFile(room_img_part.getInputStream(), fileName);
                String img_url = (String) mapResult.get("url");
                RoomImgDAO.insertRoomImg(room.getRoom_id(), img_url);
            }
            HomestayDAO.changeStatus(ht.getHt_id(), 2);
        } catch (Exception e) {
            System.out.println(e);
            isError = true;
        }
        if(isError){
            url="/homestay/homestay_register/step5.jsp";
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
