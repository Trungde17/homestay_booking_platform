<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="DAO.BedDAO"%>
<%@page import="DAO.RoomFacilitiesDAO"%>
<%@page import="DAO.RoomDAO"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Room Booking Form</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestay/register/header.css" /> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestay/register/homestay_register.css" /> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
        <style>
        </style>
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
                    <div class="step">
                        <div class="icon"><i class="fas fa-map-marker-alt"></i></div>
                        <p>Location</p>
                    </div>
                    <div class="step active">
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
            <div class="form-container col-sm-7">               
                <h2>Rooms</h2>
                <c:set var="ht" value="${sessionScope.homestay_register}"/>
                <c:if test="${ht!=null}">
                    <c:set var="room_list" value="${RoomDAO.getAllHomestayRooms(ht.getHt_id())}"/>
                    <c:if test="${room_list!=null && room_list.size()>0}">
                        <h4>Your rooms</h4>              
                        <div class="row mt-3">
                            <c:forEach var="room" items="${room_list}">
                                <div class="col-md-4">
                                    <div class="card mb-3 room-card">
                                        <div class="card-body">
                                            <p class="card-title">${room.getRoom_name()}</p>
                                            <!-- Add more room details as needed -->
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr>
                    </c:if>
                </c:if>              
                <h4>Create new room</h4>
                <hr>
                <form action="${pageContext.request.contextPath}/register_step3_controll" method="POST">
                    <div class="row mb-3">
                        <div class="form-group col-sm-8">
                            <label for="bedroomName" class="font-weight-bold">Bedroom Name*</label>
                            <input name="room_name" type="text" class="form-control" id="bedroomName" placeholder="Eg. Room 1 / Loft Room" required>
                        </div>
                        <div class="form-group col-sm-4">
                            <label for="numGuests" class="font-weight-bold">Number of guests*</label>
                            <select name="capacity" class="form-control" id="numGuests" onchange="togglePriceForTwo()">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>
                        </div>
                    </div>

                    <div>
                        <p class="font-weight-bold">Add beds*</p>
                    </div>                   

                    <div id="bed-container">
                        <c:set var="bed_type_list" value="${BedDAO.getAllBedType()}"/>
                        <div class="form-group row bed-input">
                            <div class="col-sm-6">
                                <select name="bed" class="form-control bed-select">
                                    <c:forEach var="bed_type" items="${bed_type_list}">
                                        <option value="${bed_type.getBed_id()}">${bed_type.getBed_type()}</option>    
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <a href="#" class="btn btn-link" id="add-bed"><small>Add another bed</small></a>
                        <a href="#" class="btn btn-link" id="remove-bed" style="display: none;"><small>Remove bed</small></a>
                    </div>
                    <p class="font-weight-bold">Room Facilities*</p>

                    <c:set var="facilities_list" value="${RoomFacilitiesDAO.getAll()}"/>
                    <div class="row mb-3"> 
                        <c:forEach var="facilities" items="${facilities_list}" varStatus="status">
                            <c:choose>
                                <c:when test="${status.index % 2 == 0}">
                                    <div class="col-md-6">                                        
                                        <div class="form-check">
                                            <input name="room_facilities" class="form-check-input" type="checkbox" id="${facilities.getFacilities_id()}" value="${facilities.getFacilities_id()}">
                                            <label class="form-check-label text-muted" for="${facilities.getFacilities_id()}">${facilities.getFacilities_name()}</label>
                                        </div>                                               
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-md-6">
                                        <div class="form-check">
                                            <input name="room_facilities" class="form-check-input" type="checkbox" id="${facilities.getFacilities_id()}" value="${facilities.getFacilities_id()}">
                                            <label class="form-check-label text-muted" for="${facilities.getFacilities_id()}">${facilities.getFacilities_name()}</label>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                    </div>
                    <p class="font-weight-bold">Room Prices*</p>
                    <div class="form-group row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="nightlyPrice1"><small>Price for 1 Person(1 night)</small></label>
                                <input name="price_for_one" type="number" class="form-control" id="nightlyPrice1" placeholder="VND" min="1" required>
                            </div>               
                        </div>
                        <div class="col-sm-6" id="priceForTwo" style="display: none;">
                            <div class="form-group">
                                <label for="nightlyPrice2"><small>Price for 2 (or more) People(1 night)</small></label>
                                <input name="price_for_more" type="number" class="form-control" id="nightlyPrice2" placeholder="VND" min="1" required>
                            </div>              
                        </div>
                    </div>
                    <button type="submit" class="btn btn-save">Save Room</button>
                </form>
                <a href="${pageContext.request.contextPath}/homestay/homestay_register/step4.jsp" class="btn btn-primary btn-lg btn-continue mt-5 mb-5">Continue</a>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                                function togglePriceForTwo() {
                                    var numGuests = document.getElementById("numGuests").value;
                                    var priceForTwo = document.getElementById("priceForTwo");
                                    if (numGuests > 1) {
                                        priceForTwo.style.display = "block";
                                    } else {
                                        priceForTwo.style.display = "none";
                                    }
                                }

                                function updateButtons() {
                                    var bedCount = $('#bed-container .bed-input').length;
                                    if (bedCount > 1) {
                                        $('#remove-bed').show();
                                    } else {
                                        $('#remove-bed').hide();
                                    }

                                    if (bedCount >= 2) {
                                        $('#add-bed').hide();
                                    } else {
                                        $('#add-bed').show();
                                    }
                                }

                                $(document).ready(function () {
                                    updateButtons(); // Initial call to set button visibility

                                    $('#add-bed').click(function (e) {
                                        e.preventDefault();
                                        var bedInput = `
                    <div class="form-group row bed-input">
                        <div class="col-sm-6">
                            <select name="bed" class="form-control bed-select">
            <c:forEach var="bed_type" items="${bed_type_list}">
                                    <option value="${bed_type.getBed_id()}">${bed_type.getBed_type()}</option>    
            </c:forEach>
                            </select>
                        </div>
                    </div>`;
                                        $('#bed-container').append(bedInput);
                                        updateButtons(); // Update button visibility
                                    });

                                    $('#remove-bed').click(function (e) {
                                        e.preventDefault();
                                        $('#bed-container .bed-input:last').remove();
                                        updateButtons(); // Update button visibility after removing
                                    });
                                });
        </script>
    </body>
</html>
