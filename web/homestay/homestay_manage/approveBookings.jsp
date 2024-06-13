<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking Review</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/manage/menu.css" /> 
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/main.css" />
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/manage/booking_approve.css" />
    </head>
    <body>
        <%@include file="menu.jsp" %>
        <div class="container">
            <h1 class="my-4 text-center">Approve Bookings</h1>
            <table class="table table-bordered table-hover booking-list">
                <thead class="thead-dark">
                    <tr>
                        <th>STT</th>
                        <th>Guest</th>
                        <th>Date Check-In</th>
                        <th>Date Check-Out</th>
                        <th>Date Booked</th>
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

            <form id="booking-action-form" method="post" action="${pageContext.request.contextPath}/approvebooking">
                <input type="hidden" name="booking_id" id="booking-id">
                <input type="hidden" name="homestay_id" value="${homestay_summary.getHomestay_id()}">
                <div class="action-buttons">
                    <button type="submit" name="action" value="approve" class="btn btn-success">Approve</button>
                    <button type="submit" name="action" value="reject" class="btn btn-danger">Reject</button>
                </div>
            </form>
        </div>

        <script>
            var bookings = [];
            <c:forEach var="booking" items="${bookings}" varStatus="status">
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
                    guest_number: "${booking.guest_number}",
                    rooms: [
                <c:forEach var="room" items="${booking.rooms}" varStatus="roomStatus">
                    {
                    room_name: "${room.room_name}",
                            capacity: "${room.capacity}",
                            img: [
                    <c:forEach var="img" items="${room.img}" varStatus="imgStatus">
                            "${img.img_url}"<c:if test="${!imgStatus.last}">,</c:if>
                    </c:forEach>
                            ]
                    }<c:if test="${!roomStatus.last}">,</c:if>
                </c:forEach>
                    ]
            });
            </c:forEach>

            function showBookingDetail(index) {
            var booking = bookings[index];
            console.log(booking); // Kiểm tra dữ liệu booking
            document.getElementById('guest-avatar').src = booking.guest.avatar_img;
            document.getElementById('guest-fullname').innerText = booking.guest.fullName;
            document.getElementById('guest-age').innerText = booking.guest.age;
            document.getElementById('guest-phone').innerText = booking.guest.phone;
            document.getElementById('guest-address').innerText = booking.guest.address;
            document.getElementById('number-of-guests').innerText = booking.guest_number;
            document.getElementById('date-checkin').innerText = booking.check_in;
            document.getElementById('date-checkout').innerText = booking.check_out;
            document.getElementById('date-booked').innerText = booking.date_booked;
            var bookingIdInput = document.getElementById('booking-id');
            bookingIdInput.value = booking.booking_id;
            var roomInfoDiv = document.getElementById('room-info');
            roomInfoDiv.innerHTML = ''; // Clear existing room info

            booking.rooms.forEach(function(room) {
            console.log(room); // Kiểm tra dữ liệu room

            var roomCard = document.createElement('div');
            roomCard.classList.add('card', 'mb-3');
            var rowDiv = document.createElement('div');
            rowDiv.classList.add('row', 'no-gutters');
            var colImgDiv = document.createElement('div');
            colImgDiv.classList.add('col-md-4');
            var img = document.createElement('img');
            img.classList.add('card-img');
            img.src = room.img.length > 0 ? room.img[0] : '';
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
            cardBodyDiv.appendChild(roomName);
            cardBodyDiv.appendChild(capacity);
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
