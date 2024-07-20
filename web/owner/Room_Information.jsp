<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*, model.*, DAO.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha384-+ThDz1Oks0Q62oBwMCEsCtyM2UFqb1BYhq9RZCb46pD2pjJDDlW1ZKtEh4oV8qzB" crossorigin="anonymous"></script>

<html>
    <head>
        <title>Homestay Information</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                line-height: 1.6;
                background-color: #f2f2f2;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 80%;
                margin: 0 auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h1 {
                color: #333;
                text-align: center;
            }
            h2, h3 {
                color: #555;
            }
            ul {
                list-style-type: none;
                padding: 0;
            }
            li {
                margin-bottom: 10px;
            }
            .room-item {
                border: 1px solid #ccc;
                padding: 10px;
                margin-bottom: 20px;
                background-color: #f9f9f9;
            }
            .room-item img {
                width: 100px;
                height: 100px;
                margin-right: 10px;
                border-radius: 5px;
                object-fit: cover;
            }
            .navigation-links {
                margin-top: 20px;
            }
            .navigation-links a {
                margin-right: 15px;
                color: #007BFF;
                text-decoration: none;
            }
            .navigation-links a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Homestay Information</h1>
            <c:set var="homestay" value="${sessionScope.homestay}"/>

            <c:if test="${not empty homestay}">
                <p><strong>Name:</strong> ${homestay.ht_name}</p>
                <p><strong>Owner:</strong> ${homestay.owner.first_name}</p>
                <p><strong>Description:</strong> ${homestay.describe}</p>
                <p><strong>District:</strong> ${homestay.district.district_name}</p>
                <p><strong>Address Detail:</strong> ${homestay.address_detail}</p>
                <p><strong>Registration Date:</strong> ${homestay.registration_date}</p>

                <!-- Room Details -->
                <h2>Rooms</h2>
                <c:if test="${not empty homestay.rooms}">
                    <ul id="roomListContainer">
                        <c:forEach var="room" items="${homestay.rooms}">
                            <li class="room-item">
                                <p><strong>Room ID:</strong> ${room.room_id}</p>
                                <p><strong>Name:</strong> ${room.room_name}</p>
                                <p><strong>Description:</strong> ${room.room_description}</p>
                                <p><strong>Capacity:</strong> ${room.capacity}</p>
                                <p><strong>Size:</strong> ${room.size}</p>

                                <!-- Room Images -->
                                <h3>Images</h3>
                                <c:if test="${not empty room.img}">
                                    <div>
                                        <c:forEach var="img" items="${room.img}">
                                            <img src="${img.img_url}" alt="Room Image"/>
                                        </c:forEach>
                                    </div>
                                </c:if>
                                <c:if test="${empty room.img}">
                                    <p>No images available.</p>
                                </c:if>

                                <!-- Room Facilities -->

                                <c:choose>
                                    <c:when test="${not empty room.facilities}">
                                        <c:set var="roomFacilities" value="${RoomFacilitiesDAO.getRoomFacilities(room.room_id)}"/>
                                        <h4>Facilities</h4>
                                        <div class="row">
                                            <c:forEach var="fa" items="${roomFacilities}" varStatus="status">
                                                <div class="col-md-3">
                                                    <p>${fa.facilities_name}</p>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p>No facilities available.</p>
                                    </c:otherwise>
                                </c:choose>




                                <!-- Room PRICE -->
                                <c:choose>
                                    <c:when test="${not empty room.prices}">
                                        <c:set var="roomPrices" value="${RoomPriceDAO.getRoomPrices(room.room_id)}"/>
                                        <h4>Prices</h4>
                                        <div class="row">
                                            <c:forEach var="price" items="${roomPrices}" varStatus="status">
                                                <div class="col-md-3">
                                                    <p>${price.getPrice_name()} : ${price.getAmount() } vnd</p>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p>No price available.</p>
                                    </c:otherwise>
                                </c:choose>



                                <!-- Room Beds -->
                                <h3>Beds</h3>
                                <c:choose>
                                    <c:when test="${not empty room.beds}">
                                        <c:set var="roomBeds" value="${BedDAO.getBedsOfRoom(room.room_id)}"/>
                                        <div class="row">
                                            <c:forEach var="entry" items="${roomBeds}">
                                                <div class="col-md-3">
                                                    <p>${entry.key.bed_type} : ${entry.value}</p>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p>No beds available.</p>
                                    </c:otherwise>
                                </c:choose>


                                <form action="${pageContext.request.contextPath}/RoomDirect" method="post" style="display: inline;">
                                    <input type="hidden" name="room_id" value="${room.room_id}" />
                                    <input type="submit" value="Update" />
                                </form>
                            </c:forEach>

                        </c:if>
                        <c:if test="${empty homestay.rooms}">
                            <p>No rooms available.</p>
                        </c:if>
                    </c:if>

                    <c:if test="${empty homestay}">
                        <p>No homestay information available.</p>
                    </c:if>

                    <!-- Navigation links -->
                    <div class="navigation-links">
                        <a href="${pageContext.request.contextPath}/homestay/homestay_manage/infor.jsp?ht_id=${homestay.ht_id}">Back to menu</a>

                    </div>
                    </div>
                    <script>
                        $(document).ready(function () {
                            $('form.delete-room-form').submit(function (event) {
                                event.preventDefault(); // Prevent the form from submitting the traditional way

                                var form = $(this);
                                var roomId = form.find('input[name="room_id"]').val();

                                if (confirm('Are you sure you want to delete this room?')) {
                                    // Perform the AJAX request to delete the room
                                    $.ajax({
                                        type: 'POST',
                                        url: form.attr('action'),
                                        data: form.serialize(), // Send the form data
                                        success: function (data) {
                                            // Successfully deleted, update the room list content
                                            $('#roomListContainer').html(data);
                                        },
                                        error: function () {
                                            // Handle error if needed
                                        }
                                    });
                                }
                            });
                        });
                    </script>
                    </body>
                    </html>
