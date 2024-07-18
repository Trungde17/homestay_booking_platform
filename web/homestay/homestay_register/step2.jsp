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
                
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
