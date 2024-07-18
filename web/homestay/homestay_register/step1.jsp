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
                            
                                <c:set var="error" value="${requestScope.fail_request}"/>
                                <p class="error"> ${error}</p>
                            <button type="submit" class="btn btn-primary btn-block mt-5">Continue</button>

                        </form>
                    </div>
                </div>
                
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
