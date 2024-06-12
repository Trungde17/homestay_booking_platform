<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="DAO.HomestayProfile" %>
<%@ page import="model.Homestay" %>

<%
    String homestayIdParam = request.getParameter("homestayId");
    Homestay homestay = null;
    if (homestayIdParam != null) {
        int homestayId = Integer.parseInt(homestayIdParam);
        HomestayProfile homestayProfile = new HomestayProfile();
        homestay = homestayProfile.getHomestayById(homestayId);
        request.setAttribute("homestay", homestay);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>HealingLand-Booking</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="images/fav.ico" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css?family=Poppins%7CQuicksand:500,700" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
    <link href="${pageContext.request.contextPath}/css/materialize.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/responsive.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css"/>
    <style>
        .small-image {
            width: 170px; 
            height: auto;
        }
        </style>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#"><img src="${pageContext.request.contextPath}/img/project_logo.jpg" alt="logo"/></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
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
                    <c:if test="${account != null}">
                        <li class="nav-item">
                            <a class="nav-link" href="#">Your Homestay</a>
                        </li>
                    </c:if>
                    <c:if test="${account == null}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/access/signup.jsp">Sign Up</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/access/login.jsp">Log In</a>
                        </li>
                    </c:if>
                    <c:if test="${account != null}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/account/personal_profile.jsp">${account.first_name}</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <section class="mt-5 pt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2>${homestay.ht_name}</h2>
                    <p>${homestay.describe}</p>
                    <h4>Owner: ${homestay.owner.first_name} ${homestay.owner.last_name}</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <h4>Room Facilities</h4>
                    <ul>
                        <c:forEach var="facility" items="${homestay.facilities}">
                            <li>${facility.facilities_name}</li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="col-md-12">
                    <h4>Photo Gallery</h4>
                    <div class="row">
                        <c:forEach var="image" items="${homestay.img}">
                            <div class="col-md-3">
                                <img src="${image.img_url}" class="img-fluid" alt="Homestay Image">
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-md-12">
                    <h4>Related Rooms</h4>
                    <div class="row">
                        <c:forEach var="room" items="${homestay.rooms}">
                            <div class="col-md-4">
                                <h5>${room.room_name}</h5>
                                <p>${room.room_description}</p>
                                <p>Capacity: ${room.capacity}</p>
                                <p>Size: ${room.size}</p>
                                <p>Bed Type: ${room.bed_type}</p>
                                <ul>
                                    <c:forEach var="roomFacility" items="${room.facilities}">
                                        <li>${roomFacility.facilities_name}</li>
                                    </c:forEach>
                                </ul>
                                <ul>
                                    <c:forEach var="price" items="${room.prices}">
                                        <li>${price.price_type}: ${price.amount_per_night}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="hom-footer-section">
        <div class="container">
            <div class="row">
                <div class="foot-com foot-1 col-md-3">
                    <ul class="list-inline">
                        <li class="list-inline-item"><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                        <li class="list-inline-item"><a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
                        <li class="list-inline-item"><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                    </ul>
                </div>
                <div class="foot-com foot-2 col-md-3">
                    <h5>Phone: 038 332 57 41</h5>
                </div>
                <div class="foot-com foot-3 col-md-3">
                    <a class="waves-effect waves-light btn btn-primary" href="homestaySearch.jsp">Search Homestay</a>
                </div>
                <div class="foot-com foot-4 col-md-3">
                    <a href="#"><img src="images/card.png" alt=""/></a>
                </div>
            </div>
        </div>
    </div>

    <footer class="site-footer clearfix">
        <div class="sidebar-container">
            <div class="sidebar-inner">
                <div class="widget-area clearfix">
                    <div class="widget widget_azh_widget">
                        <div>
                            <div class="container">
                                <div class="row">
                                    <div class="col-sm-12 col-md-4 foot-logo">
                                        <img class="small-image" src="../img/project_logo.jpg" alt="logo">
                                        <p class="hasimg">Providing Homestay throughout Da Nang. Fast, comfortable, convenient. Let's book a cheap homestay room.</p>
                                        <p class="hasimg">Highest rated homestay booking service.</p>
                                    </div>
                                    <div class="col-sm-12 col-md-4">
                                        <h4>Support & Help</h4>
                                        <ul class="two-columns">
                                            <li><a href="dashboard.html">Dashboard</a></li>
                                            <li><a href="db-activity.html">DB Activity</a></li>
                                            <li><a href="booking.html">Booking</a></li>
                                            <li><a href="contact-us.html">Contact Us</a></li>
                                            <li><a href="about-us.html">About Us</a></li>
                                            <li><a href="aminities.html">Amenities</a></li>
                                            <li><a href="blog.html">Blog</a></li>
                                            <li><a href="menu1.html">Food Menu</a></li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-12 col-md-4">
                                        <h4>Address</h4>
                                        <p>Da Nang - Viet Nam</p>
                                        <p><span class="foot-phone">Phone: </span><span class="foot-phone">+01 1245 2541</span></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
    <script src="${pageContext.request.contextPath}/js/angular.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/materialize.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.mixitup.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/custom.js"></script>
</body>
</html>


<%--<body data-ng-app="">
    <!--MOBILE MENU-->
    <section>
        <div class="mm">
            <div class="mm-inn">
                <div class="mm-logo">
                    <a href="main.html"><img src="images/logo.png" alt=""></a>
                </div>
                <div class="mm-icon"><span><i class="fa fa-bars show-menu" aria-hidden="true"></i></span></div>
                <div class="mm-menu">
                    <div class="mm-close"><span><i class="fa fa-times hide-menu" aria-hidden="true"></i></span></div>
                    <ul>
                        <!-- List items here -->
                    </ul>
                </div>
            </div>
        </div>
    </section>
  
    <!--HEADER SECTION-->
    <section>
        <%@include file="../includes/header.jsp" %>
        
        <!-- Meet Kitty Section -->
        <div class="meet-kitty">
            <img id="avatar_img" src="../img/avatar/avatar_default.jpg" alt="kitty" class="img-fluid rounded-circle">
            <h5 class="card-title">Van Hau</h5>
            <p>Hosting Guests Since 2011</p>
            <p>
                <span class="text-danger">&#10084;</span>
                <span class="text-danger">&#10084;</span>
                <span class="text-danger">&#10084;</span>
                <span class="text-danger">&#10084;</span>
                <span class="text-danger">&#10084;</span>
            </p>
        </div>
        
        <div class="inn-body-section inn-detail">
            <div class="container">
                <div class="row">
                    <div class="inn-bod">
                        <div class="inn-detail-p1 inn-com">
                            <h2>Master Suite Room</h2>
                            
                            <p>Discover two of South America’s greatest cities, Rio de Janeiro and Buenos Aires, at a leisurely pace...</p>
                            <p>Brazil’s view takes you through clouds of mist and the opportunity to see these 275 falls...</p>
                        </div>
                        <div class="inn-detail-p1 inn-com inn-com-list-point">
                            <div class="detail-title">
                                <h2>Room Facilities</h2>
                                <p>a procedure intended to establish the quality, performance, or reliability of something...</p>
                            </div>
                            
                        </div>
                       
                        <div class="inn-detail-p1 inn-com inn-com-price">
                            <div class="detail-title">
                                <h2>Today Price</h2>
                                <p>a procedure intended to establish the quality, performance, or reliability of something...</p>
                            </div>
                            <h4>Price For 1 Night</h4>
                            <p>a procedure intended to establish the quality, performance, or reliability of something...</p>
                            <span>Non Refundable</span> <span class="inn-room-price">Rs.6,030</span>
                        </div>
                        <div class="inn-detail-p1 inn-com">
                            <div class="detail-title">
                                <h2>Photo Gallery</h2>
                                <p>a procedure intended to establish the quality, performance, or reliability of something...</p>
                            </div>
                            <div class="room-photo-all">
                                <div class="col-md-3 room-photo">
                                    <div class="gall-grid room-photo-gal"> 
                                        <img class="materialboxed" data-caption="A picture of a way with a group of trees in a park" src="images/room/1.jpg" alt="" /> 
                                    </div>
                                </div>
                                <!-- Other photo items here -->
                            </div>
                        </div>
                        <div class="inn-detail-p1 inn-com">
                            <div class="detail-title">
                                <h2>Related Rooms</h2>
                                <p>a procedure intended to establish the quality, performance, or reliability of something...</p>
                            </div>
                            <div class="re-room">
                                <ul>
                                    <li>
                                        <div class="re-room-list">
                                            <div class="col-md-3 re-room-list-1">
                                                <img src="images/room/1.jpg" alt="">
                                            </div>
                                            <div class="col-md-6 re-room-list-2">
                                                <h4>Ultra Deluxe</h4>
                                                <p><b>Amenities: </b>Television, Wi-Fi, Hair dryer, Towels, Dining, Music, GYM and more..</p>
                                                <span><b>Includes</b>: Free Parking, Breakfast, VAT</span>
                                                <span><b>Maximum</b>: 4 Persons</span>
                                            </div>
                                            <div class="col-md-3 re-room-list-3">
                                                <span class="hot-list-p3-1">Price Per Night</span>
                                                <span class="hot-list-p3-2">$940</span>
                                                <a href="contactHost.jsp" class="hot-page2-alp-quot-btn spec-btn-text">Book Now</a>
                                                
                                            </div>
                                        </div>
                                    </li>
                                    <!-- Other related rooms items here -->
                                </ul>
                            </div>
                        </div>
                        <div class="inn-detail-p1 inn-com">
                            <div class="detail-title">
                                <h2>User Reviews</h2>
                                <p>a procedure intended to establish the quality, performance, or reliability of something...</p>
                            </div>
                            <div class="room-rat-inn room-rat-bor">
                                <div class="row">
                                    <div class="col-md-12 room-rat-body">
                                        <div class="room-rat-img">
                                            <img src="images/users/2.png" alt="">
                                            <p>Orange Fab &amp; Weld <span>19th January, 2017</span></p>
                                        </div>
                                        <div class="dir-rat-star">
                                            <i class="fa fa-star" aria-hidden="true"></i>
                                            <i class="fa fa-star" aria-hidden="true"></i>
                                            <i class="fa fa-star" aria-hidden="true"></i>
                                            <i class="fa fa-star" aria-hidden="true"></i>
                                            <i class="fa fa-star-o" aria-hidden="true"></i>
                                        </div>
                                        <p>Michael &amp; his team have been helping us with our equipment finance for the past 5 years...</p>
                                        <ul>
                                            <li><a href="#"><span>Like</span><i class="fa fa-thumbs-o-up"></i></a></li>
                                            <li><a href="#"><span>Dislike</span><i class="fa fa-thumbs-o-down"></i></a></li>
                                            <li><a href="#"><span>Report</span><i class="fa fa-flag-o"></i></a></li>
                                            <li><a href="#"><span>Comments</span><i class="fa fa-commenting-o"></i></a></li>
                                            <li><a href="#"><span>Share Now</span><i class="fa fa-facebook"></i></a></li>
                                            <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                            <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                            <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                                            <li><a href="#"><i class="fa fa-youtube"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!-- Other reviews here -->
                        </div>
                        <div class="inn-detail-p1 inn-com room-soc-share">
                            <div class="detail-title">
                                <h2>Share this Room</h2>
                                <p>a procedure intended to establish the quality, performance, or reliability of something...</p>
                            </div>
                            <ul>
                                <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i> Facebook</a></li>
                                <li><a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i> Google+</a></li>
                                <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i> Twitter</a></li>
                                <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i> LinkedIn</a></li>
                                <li><a href="#"><i class="fa fa-whatsapp" aria-hidden="true"></i> WhatsApp</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer Section -->
        <div class="hom-footer-section">
            <div class="container">
                <div class="row">
                    <div class="foot-com foot-1">
                        <ul>
                            <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                            <li><a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
                            <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                        </ul>
                    </div>
                    <div class="foot-com foot-2">
                        <h5>Phone: (+404) 142 21 23 78</h5>
                    </div>
                    <div class="foot-com foot-3">
                        <a class="waves-effect waves-light" href="booking.html">Room Reservation</a>
                    </div>
                    <div class="foot-com foot-4">
                        <a href="#"><img src="images/card.png" alt=""></a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
 <!-- Footer Section -->
    <div class="hom-footer-section">
        <div class="container">
            <div class="row">
                <div class="foot-com foot-1 col-md-3">
                    <ul class="list-inline">
                        <li class="list-inline-item"><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                        <li class="list-inline-item"><a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
                        <li class="list-inline-item"><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                    </ul>
                </div>
                <div class="foot-com foot-2 col-md-3">
                    <h5>Phone: 038 332 57 41 </h5>
                </div>
                <div class="foot-com foot-3 col-md-3">
                    <a class="waves-effect waves-light btn btn-primary" href="homestaySearch.jsp">Search Homestay</a>
                </div>
                <div class="foot-com foot-4 col-md-3">
                    <a href="#"><img src="images/card.png" alt="" /></a>
                </div>
            </div>
        </div>
    </div>
    <!-- Site Footer -->
    <footer class="site-footer clearfix">
        <div class="sidebar-container">
            <div class="sidebar-inner">
                <div class="widget-area clearfix">
                    <div class="widget widget_azh_widget">
                        <div>
                            <div class="container">
                                <div class="row">
                                    <div class="col-sm-12 col-md-4 foot-logo">
                                       
                                        <img class="small-image" src="../img/project_logo.jpg" alt="logo">  
                                        <p class="hasimg">Providing Homestay throughout Da Nang. Fast, comfortable, convenient. Let's book a cheap homestay room.</p>
                                        <p class="hasimg">Highest rated homestay booking service.</p>
                                    </div>
                                    <div class="col-sm-12 col-md-4">
                                        <h4>Support & Help</h4>
                                        <ul class="two-columns">
                                            <li><a href="dashboard.html">Dashboard</a></li>
                                            <li><a href="db-activity.html">DB Activity</a></li>
                                            <li><a href="booking.html">Booking</a></li>
                                            <li><a href="contact-us.html">Contact Us</a></li>
                                            <li><a href="about-us.html">About Us</a></li>
                                            <li><a href="aminities.html">Amenities</a></li>
                                            <li><a href="blog.html">Blog</a></li>
                                            <li><a href="menu1.html">Food Menu</a></li>
                                        </ul>
                                    </div>                                   
                                    <div class="col-sm-12 col-md-4">
                                        <h4>Address</h4>
                                        <p>Da Nang - Viet Nam</p>
                                        <p><span class="foot-phone">Phone: </span><span class="foot-phone">+01 1245 2541</span></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                       
    <!--ALL SCRIPT FILES-->
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
    <script src="${pageContext.request.contextPath}/js/angular.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/materialize.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.mixitup.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/custom.js"></script>
</body>--%>