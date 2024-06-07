<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="DAO.NeighbourhoodDAO"%>
<%@page import="DAO.DistrictDAO"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Location - My Homestay</title>
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
        <%@include file="header.jsp" %>
        <div class="container">
            <div class="listing-setup mx-auto">
                <div class="header">Location</div>
                <div class="progress-indicator">
                    <div class="step">
                        <div class="icon"><i class="fas fa-home"></i></div>
                        <p>Home</p>
                    </div>
                    <div class="step active">
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
                        <form action="${pageContext.request.contextPath}/register_step2_controll" method="POST">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <c:set var="district_list" value="${DistrictDAO.getAll()}"/>
                                    <label for="district">District *</label>
                                    <select name="district" class="form-control" id="district">
                                        <c:forEach var="district" items="${district_list}">
                                            <option value="${district.getDistrict_id()}">${district.getDistrict_name()}</option> 
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group mb-5">
                                <label for="address-detail">Address detail *</label>
                                <input name="address_detail" type="text" class="form-control" id="address-detail" placeholder="Example: 108 Võ Nguyên Giáp, Phước Mỹ" required>
                            </div>
                            <div class="form-group">
                                <label>Neighbourhood</label>
                                <div class="row">
                                    <c:set var="neighbourhood_list" value="${NeighbourhoodDAO.getAll()}"/>
                                    <c:forEach var="neighbourhood" items="${neighbourhood_list}" varStatus="status">
                                        <c:choose>
                                            <c:when test="${status.index % 2 == 0}">
                                                <div class="col-md-4">
                                                    <div class="form-check">
                                                        <input name="neighbourhood" class="form-check-input" type="checkbox" id="${neighbourhood.getNeighbourhood_id()}">
                                                        <label class="form-check-label text-muted" for="${neighbourhood.getNeighbourhood_id()}">${neighbourhood.getNeighbourhood_name()}</label>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="col-md-4">
                                                    <div class="form-check">
                                                        <input name="neighbourhood" class="form-check-input" type="checkbox" id="${neighbourhood.getNeighbourhood_id()}">
                                                        <label class="form-check-label text-muted" for="${neighbourhood.getNeighbourhood_id()}">${neighbourhood.getNeighbourhood_name()}</label>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>  
                                    <c:set var="fail_reuqest" value="${requestScope.fail_request}"/>
                                    <h4 class="error">${fail_request}</h4>
                            <button type="submit" class="btn btn-primary btn-block">Continue</button>
                        </form>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="sidebar">
                        <div class="info-box">
                            <h6>TIPS FOR LOCATION DESCRIPTION</h6>
                            <ul class="tips-list">
                                <li>Is your home in a quiet or lively neighbourhood?</li>
                                <li>Are you near the sea, lakes, mountains or river?</li>
                                <li>Are there any tourist attractions nearby?</li>
                                <li>What kind of shops, cafï¿½s, bars are there?</li>
                                <li>What other local amenities are close by?</li>
                                <li>How is local transport? Bus or train station close by?</li>
                            </ul>
                        </div>
                        <div class="info-box">
                            <h6>Sample: About the Area</h6>
                            <p>Our house is located on the north side of the city in a quiet and safe suburb. We are 3 km from the city centre and only 15 minutes drive from the airport. The bus stop is only 2 minutes walk from the house and there are lots of bus options using this stop.</p>
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
