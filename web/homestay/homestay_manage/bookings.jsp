<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="DAO.BookingDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Homestay Booking Management</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/manage/menu.css" />
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/manage/booking_approve.css" />
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block sidebar">
                    <jsp:include page="menu.jsp" />
                </nav>
                <c:set var="ht" value="${sessionScope.homestay}"/>
                <c:set var="action" value="${param.page}"/>
                <c:if test="${action == 'paid'}">
                    <c:set var="bookings" value="${BookingDAO.getPaidBookingsOfHomestay(homestay.ht_id)}"/>
                </c:if>
                <c:if test="${action == 'current_stay'}">
                    <c:set var="bookings" value="${BookingDAO.getCurrentStayBookings(homestay.ht_id)}"/>
                </c:if>
                <c:if test="${action == 'completed'}">
                    <c:set var="bookings" value="${BookingDAO.getCheckedOutBookings(homestay.ht_id)}"/>
                </c:if>
                <c:if test="${action == 'canceled'}">
                    <c:set var="bookings" value="${BookingDAO.getCancelledBookings(homestay.ht_id)}"/>
                </c:if>
                <main role="main" class="col-md-9 ml-sm-auto col-lg-10 content">
                    <h2 class="my-4">Bookings</h2>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">STT</th>
                                    <th scope="col">Guest</th>
                                    <th scope="col">Date Check-In</th>
                                    <th scope="col">Date Check-Out</th>
                                    <th scope="col">Date Booked</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="booking" items="${bookings}" varStatus="status">
                                    <tr onclick="showBookingDetail(${status.index})">
                                        <td>${status.index + 1}</td>
                                        <td>${booking.guest.fullName}</td>
                                        <td>${booking.check_in}</td>
                                        <td>${booking.check_out}</td>
                                        <td>${booking.date_booked}</td>                          
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </main>
            </div>
        </div>
        <div class="modal-overlay" id="modal-overlay"></div>

        <div class="booking-detail" id="booking-detail">
            <span class="close-btn" onclick="closeBookingDetail()">&times;</span>
            <h2 class="modal-title">Booking Detail</h2>
            <div class="guest-info">
                <img id="guest-avatar" src="" alt="Avatar">
                <div>
                    <p><strong>Full Name:</strong> <span id="guest-fullname"></span></p>
                    <p><strong>Age:</strong> <span id="guest-age"></span></p>
                    <p><strong>Phone Number:</strong> <span id="guest-phone"></span></p>
                    <p><strong>Address:</strong> <span id="guest-address"></span></p>
                </div>
            </div>
            <p><strong>Number of Guests:</strong> <span id="number-of-guests"></span></p>
            <p><strong>Date Check-In:</strong> <span id="date-checkin"></span></p>
            <p><strong>Date Check-Out:</strong> <span id="date-checkout"></span></p>
            <p><strong>Date Booked:</strong> <span id="date-booked"></span></p>

            <h3 class="text-center">Room Information</h3>
            <div class="room-info" id="room-info">
                <!-- Room details will be injected here by JavaScript -->
            </div>

        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                var bookings = [];
            <c:forEach var="booking" items="${bookings}">
                bookings.push({
                booking_id: "${booking.booking_id}",
                        guest: {
                        fullName: "${booking.guest.fullName}",
                                avatar_img: "${booking.guest.avatar_img}",
                                age: "${booking.guest.age}",
                                phone: "${booking.guest.phone}",
                                address: "${booking.guest.address}"
                        },
                        check_in: "${booking.check_in}",
                        check_out: "${booking.check_out}",
                        date_booked: "${booking.date_booked}",
                        guest_number: "${booking.guestNumber}",
                        rooms: [
                <c:forEach var="entry" items="${booking.rooms.entrySet()}" varStatus="roomStatus">
                        {
                        room_name: "${entry.key.room_name}",
                                capacity: "${entry.key.capacity}",
                                img_js: "${entry.key.img[0].img_url}",
                                numberGuestOfRoom: "${entry.value}"
                        }<c:if test="${!roomStatus.last}">,</c:if>
                </c:forEach>
                        ]
                });
            </c:forEach>

                function showBookingDetail(index) {
                var booking = bookings[index];
                console.log(booking); // Check booking data
                document.getElementById('guest-avatar').src = booking.guest.avatar_img;
                document.getElementById('guest-fullname').innerText = booking.guest.fullName;
                document.getElementById('guest-age').innerText = booking.guest.age;
                document.getElementById('guest-phone').innerText = booking.guest.phone;
                document.getElementById('guest-address').innerText = booking.guest.address;
                document.getElementById('number-of-guests').innerText = booking.guest_number;
                document.getElementById('date-checkin').innerText = booking.check_in;
                document.getElementById('date-checkout').innerText = booking.check_out;
                document.getElementById('date-booked').innerText = booking.date_booked;
                var roomInfoDiv = document.getElementById('room-info');
                roomInfoDiv.innerHTML = ''; // Clear existing room info

                booking.rooms.forEach(function(room) {
                console.log(room); // Check room data

                var roomCard = document.createElement('div');
                roomCard.classList.add('card', 'mb-3');
                var rowDiv = document.createElement('div');
                rowDiv.classList.add('row', 'no-gutters');
                var colImgDiv = document.createElement('div');
                colImgDiv.classList.add('col-md-4');
                var img = document.createElement('img');
                img.classList.add('card-img');
                img.src = room.img_js;
                img.alt = 'Room Image';
                colImgDiv.appendChild(img);
                var colContentDiv = document.createElement('div');
                colContentDiv.classList.add('col-md-8');
                var cardBodyDiv = document.createElement('div');
                cardBodyDiv.classList.add('card-body');
                var roomName = document.createElement('h5');
                roomName.classList.add('card-title');
                roomName.innerText = room.room_name;
                var capacity = document.createElement('p');
                capacity.classList.add('card-text');
                capacity.innerHTML = '<strong>Capacity:</strong> ' + room.capacity + ' people';
                var numberGuestOfRoom = document.createElement('p');
                numberGuestOfRoom.classList.add('card-text');
                numberGuestOfRoom.innerHTML = '<strong>Number of guest:</strong> ' + room.numberGuestOfRoom + ' people';
                cardBodyDiv.appendChild(roomName);
                cardBodyDiv.appendChild(capacity);
                cardBodyDiv.appendChild(numberGuestOfRoom);
                colContentDiv.appendChild(cardBodyDiv);
                rowDiv.appendChild(colImgDiv);
                rowDiv.appendChild(colContentDiv);
                roomCard.appendChild(rowDiv);
                roomInfoDiv.appendChild(roomCard);
                });
                var bookingDetail = document.getElementById('booking-detail');
                var modalOverlay = document.getElementById('modal-overlay');
                bookingDetail.classList.add('show');
                modalOverlay.style.display = 'block';
                }

                function closeBookingDetail() {
                var bookingDetail = document.getElementById('booking-detail');
                var modalOverlay = document.getElementById('modal-overlay');
                bookingDetail.classList.remove('show');
                modalOverlay.style.display = 'none';
                }
        </script>
    </body>
</html>
