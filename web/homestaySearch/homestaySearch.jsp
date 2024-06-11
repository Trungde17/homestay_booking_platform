<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="DAO.HomestayDAO"%>
<%@page import="model.Homestay"%>
<%@page import="java.util.List"%>
<c:set var="account" value="${sessionScope.account}"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>HealingLand</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/Search_homestay.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">

    </head>
    <body>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="#"><img src="${pageContext.request.contextPath}/img/project_logo.jpg" alt="logo"/></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="#">Destinations</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Contact Host</a>
                        </li>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav mr-auto">
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
                                <a class="nav-link" href="#">Your Homestay</a>

                            </li>
                            <li class="nav-item dropdown">
                                <c:set var="account" value="${sessionScope.account}"/>
                                <a class="nav-link dropdown-toggle" href="#" id="helpDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/account/personal_profile.jsp">Account</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/access/logout.jsp">Logout</a>
                                </div>
                            </li>      
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <section>
            <div class="container mt-4">
                <form action="${pageContext.request.contextPath}/searchServlet" method="post">
                    <div class="search-bar">
                        <input type="text" class="form-control" value="${districtName}" name="district">

                        <input type="date" class="form-control" value="${checkin}" name="checkIn">

                        <input type="date" class="form-control" value="${checkout}" name="checkOut">

                        <input type="text" class="form-control" value="${guests}" name="guests"> 

                        <div class="col-md-1">
                            <button type="submit" class="btn btn-primary w-100">Search</button>
                        </div>
                    </div>
                </form>
            </div>
        </section>


        <!-- Homestay Listings -->
        <div class="container mt-5">
            <div class="row">
                <c:forEach var="homestay" items="${homestays}">
                    <div class="col-md-4">
                        <div class="card hotel-card">
                            <c:forEach var="image" items="${homestay.getImg()}">
                                <img src="${image.getImg_url()}" class="card-img-top" alt="Homestay Image">
                            </c:forEach>                        
                            <div class="card-body">
                                <h5 class="card-title"><c:out value="${homestay.getHt_name()}" /></h5>
                                <p class="card-text">Owner: <c:out value="${homestay.getOwner().getLast_name()} ${homestay.getOwner().getFirst_name()}" /></p>
                                <p class="card-text">Description: <c:out value="${homestay.getDescribe()}" /></p>
                                <p class="card-text">Address: <c:out value="${homestay.getAddress_detail()} ${homestay.getDistrict().getDistrict_name()}" /></p>                        
                            </div>
                        </div>
                    </div>
                </c:forEach>    
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const today = new Date().toISOString().split('T')[0];
                document.getElementById('checkIn').setAttribute('min', today);
                document.getElementById('checkOut').setAttribute('min', today);
            });
        </script>
    </body>
</html>