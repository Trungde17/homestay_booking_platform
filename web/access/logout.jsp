<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">
        <!-- Latest compiled JavaScript -->
        <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/main.css" />     
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/home.css" />
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
              rel='stylesheet'>
    </head>
    <body>
<!-- Navigation Bar -->
   form
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp"><img src="${pageContext.request.contextPath}/img/project_logo.jpg" alt="logo"/></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#">Destinations</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Inspire Me</a>
                </li>                        
                <li class="nav-item">
                    <a class="nav-link" href="#">Help</a>
                </li>          
                   <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/access/signup.jsp">Sign Up</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/access/login.jsp">Log In</a>
                    </li>
               
               
            </ul>
        </div>
    </div>
</nav>    
        <%@include file="/includes/banner.jsp" %>
    </body>
</html>
