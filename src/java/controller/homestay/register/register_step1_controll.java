package controller.homestay.register;

import DAO.HomestayDAO;
import DAO.HomestayFacilitiesDAO;
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
import model.Homestay;
import utilities.Int;

@WebServlet(name = "register_step1_controll", urlPatterns = {"/register_step1_controll"})
public class register_step1_controll extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet register_step1_controll</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet register_step1_controll at " + request.getContextPath() + "</h1>");
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
        String url = "/homestay/homestay_register/step2.jsp";
        Boolean isError = false;
        try {
            HttpSession session = request.getSession();
            int ht_type_id = Integer.parseInt(request.getParameter("homestay_type"));
            String homestay_name = request.getParameter("homestay_name");
            String[] facilities_list_str = request.getParameterValues("facilities");
            int[] facilities_list = Int.convertStringListToIntegerList(facilities_list_str);
            if (facilities_list != null && facilities_list.length > 0) {
                Account account = (Account) session.getAttribute("account");
                if (account != null) {
                    String homestay_about = request.getParameter("homestay_about");
                    int payment_id = Integer.parseInt(request.getParameter("payment"));
                    int ht_id = HomestayDAO.countHomesaty() + 1;
                    if (HomestayDAO.insert(ht_id, homestay_name, ht_type_id, homestay_about,account.getAccount_id(), payment_id)) {
                        HomestayFacilitiesDAO.insertIntoHomestayFacilities(ht_id, facilities_list); 
                        Homestay homestay_register=HomestayDAO.getHomestayById(ht_id);
                        session.setAttribute("homestay_register", homestay_register);
                    }
                }
                else isError=true;

            } else {
                isError = true;
            }
        } catch (Exception e) {
            isError = true;
            request.setAttribute("fail_request", "Request_fail");
        }
        if(isError){
            request.setAttribute("step1_error", "Fail request!");
            url="/homestay/homestay_register/step1.jsp";
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
