<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="index.jsp"><img src="${pageContext.request.contextPath}/img/project_logo.jpg" alt="logo"/></a>
       
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#">CONTACT HOSTS</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">VND</a>
                </li>
                                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="helpDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Help
                    </a>

                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="helpDropdown">
                        <a class="dropdown-item" href="#">General</a>
                        <a class="dropdown-item" href="#">Hosts</a>
                        <a class="dropdown-item" href="#">Guests</a>
                        <a class="dropdown-item" href="#">Messaging</a>
                        <a class="dropdown-item" href="#">Reviews</a>
                        <a class="dropdown-item" href="#">Trust and Safety</a>
                        <a class="dropdown-item" href="#">Invite a Friend</a>
                        <a class="dropdown-item" href="#">Regulatory Compliance</a>
                    </div>
                </li>
                
            </ul>
        </div>
    </div>
</nav>
