package filter;

import DAO.HomestayDAO;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.Homestay;

@WebFilter(filterName = "ht_approve_list_filter", urlPatterns = {"/admin/ht_register_approve/list_request.jsp"})
public class ht_approve_list_filter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(); // Sử dụng false để không tạo session mới nếu không có
        if (session != null) {
            ArrayList<Homestay> homestayList = HomestayDAO.findAllHomestayAwaitingApproval();
            session.setAttribute("homestays_approve", homestayList);
        }
        chain.doFilter(request, response);
    }

    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code, if necessary
    }

    public void destroy() {
        // Cleanup code, if necessary
    }
}
