<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="account" value="${sessionScope.account}"/>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#"><img src="${pageContext.request.contextPath}/img/project_logo.jpg" alt="logo"/></a>
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
                <c:if test="${account!=null}">
                <li class="nav-item">
                    <a class="nav-link" href="#">Your Homestay</a>
                </li>
                </c:if>
                <c:if test="${account==null}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/access/signup.jsp">Sign Up</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/access/login.jsp">Log In</a>
                    </li>
                </c:if>
                <c:if test="${account!=null}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/account/personal_profile.jsp">${account.getFirst_name()}</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>    

