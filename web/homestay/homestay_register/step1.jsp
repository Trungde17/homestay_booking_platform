<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="DAO.HomestayTypeDAO"%>
<%@page import="DAO.HomestayFacilitiesDAO"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Homestay register</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/register/homestay_register.css" />  
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/register/header.css" /> 
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/main.css" />
    </head>
    <body>
        <%@include file="header.jsp"%>
        <div class="container">
            <div class="listing-setup mx-auto">
                <div class="header">My Homestay</div>
                <div class="progress-indicator">
                    <div class="step active">
                        <div class="icon"><i class="fas fa-home"></i></div>
                        <p>Home</p>
                    </div>
                    <div class="step">
                        <div class="icon"><i class="fas fa-map-marker-alt"></i></div>
                        <p>Location</p>
                    </div>
                    <div class="step">
                        <div class="icon"><i class="fas fa-bed"></i></div>
                        <p>Rooms</p>
                    </div>
                    <div class="step">
                        <div class="icon"><i class="fas fa-book"></i></div>
                        <p>Rules</p>
                    </div>
                    <div class="step">
                        <div class="icon"><i class="fas fa-user"></i></div>
                        <p>Host</p>
                    </div>
                    <div class="step">
                        <div class="icon"><i class="fas fa-images"></i></div>
                        <p>Photos</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-8">
                    <div class="listing-setup mx-auto">
                        <form action="${pageContext.request.contextPath}/register_step1_controll" method="POST">
                            
                            <c:set var="ht_type_list" value="${HomestayTypeDAO.getAll()}"/>
                            <div class="form-group mt-3">
                                <label for="homeType">Home Type *</label>
                                <select name="homestay_type" class="form-control" id="homeType">             
                                    <c:forEach var="ht_type" items="${ht_type_list}">
                                        <option value="${ht_type.getHomestay_type_id()}">${ht_type.getHomestay_type_name()}</option>      
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="homestay_name">Your Homestay Name*</label>
                                <input name="homestay_name" type="text" class="form-control" id="homestay_name" placeholder="Homestay name!" maxlength="30" required>
                                <small class="form-text text-muted">Maximum 30 characters (30 remaining)</small>
                            </div>
                            <div class="form-group">
                                <label>House Facilities</label>
                                <c:set var="facilities_list" value="${HomestayFacilitiesDAO.getAll()}"/>
                                <div class="row"> 
                                    <c:forEach var="facilities" items="${facilities_list}" varStatus="status">
                                        <c:choose>
                                            <c:when test="${status.index % 2 == 0}">
                                                <div class="col-md-6">                                        
                                                    <div class="form-check">
                                                        <input name="facilities" class="form-check-input" type="checkbox" id="${facilities.getFacilities_id()}" name="facility" value="${facilities.getFacilities_id()}">
                                                        <label class="form-check-label text-muted" for="${facilities.getFacilities_id()}">${facilities.getFacilities_name()}</label>
                                                    </div>                                               
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="col-md-6">
                                                    <div class="form-check">
                                                        <input name="facilities" class="form-check-input" type="checkbox" id="${facilities.getFacilities_id()}" name="facility" value="${facilities.getFacilities_id()}">
                                                        <label class="form-check-label text-muted" for="${facilities.getFacilities_id()}">${facilities.getFacilities_name()}</label>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>

                                </div>
                            </div>
                            <div class="form-group">
                                <label for="aboutHomestay">About the Homestay *</label>
                                <textarea name="homestay_about" class="form-control" id="aboutHomestay" rows="4" placeholder="Tell us about your homestay" minlength="100" required></textarea>
                                <small class="form-text text-muted">Minimum 100 characters (100 remaining)</small>
                            </div>
                            <div class="row">
                                <c:set var="account" value="${sessionScope.account}"/>
                                <div class="col-md-8">
                                    <label for="payment-number" class="font-weight-bold">Payment number *</label>

                                    <select name="payment" class="form-control" id="payment-number"> 
                                        <c:forEach var="payment_number" items="${account.getPayments()}">
                                            <option value="${payment_number.getPayment_id()}">${payment_number.getPayment_number()}</option>  
                                        </c:forEach>
                                    </select>

                                </div>
                            </div>
                                <c:set var="error" value="${requestScope.fail_request}"/>
                                <p class="error"> ${error}</p>
                            <button type="submit" class="btn btn-primary btn-block mt-5">Continue</button>

                        </form>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="sidebar">
                        <div class="info-box">
                            <h6>HOSTED HOMESTAY EXPERIENCE</h6>
                            <p>A host lives in every homestay listed on Homestay.com ? none of our homestays are vacant properties. We understand that you can't be there all the time, but just to welcome and orientate your guests.</p>
                        </div>
                        <div class="info-box">
                            <h6>TIPS FOR A GREAT DESCRIPTION</h6>
                            <ul class="tips-list">
                                <li>Is your home in the town, city centre, suburbs or countryside?</li>
                                <li>Who else lives at home with you?</li>
                                <li>What type of bedroom(s) are available to guests?</li>
                                <li>What kind of lounge/living/outdoor areas are there?</li>
                                <li>Have you or your family any special interests?</li>
                                <li>Are any other languages spoken at home?</li>
                            </ul>
                        </div>
                        <div class="mt-3">
                            <p>QUESTION? GET IN TOUCH:</p>
                            <p>Email us at <a href="mailto:hostsupport@homestay.com">hostsupport@homestay.com</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
