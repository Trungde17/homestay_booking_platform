<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="logo.png" alt="Homestay Logo">
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#">CONTACT HOSTS</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">VND</a>
                </li>
                <li class="nav-item dropdown">
                    <c:set var="account" value="${sessionScope.account}"/>
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        ${account.getFirst_name()}
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="#">Dashboard</a>
                        <a class="dropdown-item" href="#">Inbox</a>
                        <a class="dropdown-item" href="#">Trips</a>
                        <a class="dropdown-item" href="#">Bookings</a>
                        <a class="dropdown-item" href="#">Verify Me</a>
                        <a class="dropdown-item" href="#">Invite Friends</a>
                        <a class="dropdown-item" href="#">List a Room</a>
                        <a class="dropdown-item" href="#">Account</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Logout</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="helpDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        HELP
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
