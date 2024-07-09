package filter;

import DAO.RegisterOwnerDAO;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import DAO.RegisterOwnerDAO;

import java.io.IOException;

@WebFilter(filterName = "checkUpdateOwner", urlPatterns = {"./account/upgradeToHost.jsp"}) 
public class checkUpdateOwner implements Filter {

    public checkUpdateOwner() {
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

       
        HttpSession session = httpRequest.getSession(false); 
        if (session != null) {
            Account currentUser = (Account) session.getAttribute("account");

            if (currentUser != null) {
                int ownerStatus = RegisterOwnerDAO.getOwnerStatus(currentUser.getAccount_id());
                if (ownerStatus == 2) {
                    
                    httpResponse.sendRedirect("./account/update.jsp");
                    return;
                }
            }
        }

      
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code, if any
    }
}
