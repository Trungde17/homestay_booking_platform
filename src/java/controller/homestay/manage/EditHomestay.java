
package controller.homestay.manage;

import DAO.HomestayDAO;
import DAO.HomestayFacilitiesDAO;
import DAO.HomestayImgDAO;
import DAO.NeighbourhoodDAO;
import DAO.RuleDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import model.Homestay;
import utilities.CloudinaryConfig1;
import utilities.Int;

@WebServlet(name = "EditHomestay", urlPatterns = {"/edithomestay"})
@MultipartConfig(maxFileSize = 16177215)
public class EditHomestay extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditHomestay</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditHomestay at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Homestay homestay = (Homestay)session.getAttribute("homestay");
        int ht_id = homestay.getHt_id();
        String action=request.getParameter("action");
        if(action.equalsIgnoreCase("name")){
            String ht_name=request.getParameter("ht_name");
            if(!ht_name.equals(""))HomestayDAO.changeName(ht_id, ht_name);
        }
        else if(action.equalsIgnoreCase("type")){
            int ht_type_id=Integer.parseInt(request.getParameter("ht_type"));
            HomestayDAO.changeType(ht_id, ht_type_id);
        }
        else if(action.equalsIgnoreCase("description")){
            String ht_description = request.getParameter("ht_description");
            HomestayDAO.changeDescription(ht_id, ht_description);
        }
        else if(action.equalsIgnoreCase("address")){
            String address_detail=request.getParameter("address_detail");
            int district_id=Integer.parseInt(request.getParameter("district_id"));
            HomestayDAO.changeAddressDetail(ht_id, address_detail);
            HomestayDAO.changeDistrict(ht_id, district_id);
        }
        else if(action.equalsIgnoreCase("facilities")){
            String[]facilities_id_str=request.getParameterValues("facilities");
            int[]facilities_id = Int.convertStringListToIntegerList(facilities_id_str);
            if(facilities_id!=null&&facilities_id.length>0){
                HomestayFacilitiesDAO.delete(ht_id);
                HomestayFacilitiesDAO.insertIntoHomestayFacilities(ht_id, facilities_id);
            }
        }
        else if(action.equalsIgnoreCase("neighbourhoods")){
            String[]neighbourhood_id_str=request.getParameterValues("neighbourhoods");
            int[]neighbourhood_id=Int.convertStringListToIntegerList(neighbourhood_id_str);
            if(neighbourhood_id!=null && neighbourhood_id.length>0){
                NeighbourhoodDAO.delete(ht_id);
                NeighbourhoodDAO.insertNeighbourhoodOfHomestay(ht_id, neighbourhood_id);
            }
        }
        else if(action.equalsIgnoreCase("rules")){
            String rule_text=request.getParameter("ht_rules");
            HomestayDAO.changeRule(rule_text);
            String[]common_rules_str=request.getParameterValues("rule_common");
            int[]common_rules=Int.convertStringListToIntegerList(common_rules_str);
            if(common_rules!=null&&common_rules.length>0){
                RuleDAO.delete(ht_id);
                RuleDAO.insertHomestayRules(ht_id, common_rules);
            }
        }
        else if(action.equalsIgnoreCase("status")){
            int status = request.getParameter("ht_status") != null ? 1 : 0;
            HomestayDAO.changeStatus(ht_id, status);
        }
        else if(action.equalsIgnoreCase("img")){
            String img_id_str = request.getParameter("img_id");
            int img_id=Integer.parseInt(img_id_str);
            Part img_file=request.getPart("img_file");
            String fileName = img_file.getSubmittedFileName();
            Map mapResult = CloudinaryConfig1.upLoadFile(img_file.getInputStream(), fileName);
            String img_url = (String) mapResult.get("url");
            HomestayImgDAO.changeImg(img_id, img_url);
        }
        homestay=HomestayDAO.getHomestayById(ht_id);
        session.setAttribute("homestay", homestay);
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/homestay/homestay_manage/infor.jsp");
        rd.forward(request, response);
        
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
