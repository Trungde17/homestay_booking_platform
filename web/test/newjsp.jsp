<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Review</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .booking-list {
            margin-top: 20px;
        }
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }
        .booking-detail {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 90%;
            max-width: 600px;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
            z-index: 2;
            opacity: 0;
            transition: opacity 0.5s ease-in-out;
            border-radius: 15px;
            overflow-y: auto; /* Thêm thanh cuộn dọc */
            max-height: 80vh; /* Giới hạn chiều cao để tránh chiếm hết màn hình */
        }
        .booking-detail.show {
            display: block;
            opacity: 1;
        }
        .guest-info {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .guest-info img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-right: 15px;
        }
        .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
            font-size: 25px;
            color: #dc3545;
        }
        .modal-title {
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
            font-size: 24px;
        }
        .room-info {
            margin-top: 20px;
        }
        .action-buttons {
            text-align: center;
            margin-top: 30px;
        }
        .action-buttons .btn {
            margin: 0 10px;
            min-width: 100px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1 class="my-4 text-center">Pending Bookings</h1>
    <table class="table table-bordered table-hover booking-list">
        <thead class="thead-dark">
            <tr>
                <th>STT</th>
                <th>Full Name Guest</th>
                <th>Number of Rooms</th>
                <th>Date Check-In</th>
                <th>Date Check-Out</th>
                <th>Date Booked</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="booking" items="${bookings}">
                <tr onclick='showBookingDetail(${booking.id})'>
                    <td>${booking.id}</td>
                    <td>${booking.fullName}</td>
                    <td>${booking.numberOfRooms}</td>
                    <td>${booking.dateCheckIn}</td>
                    <td>${booking.dateCheckOut}</td>
                    <td>${booking.dateBooked}</td>
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
    <p><strong>Status:</strong> <span id="status"></span></p>

    <h3 class="text-center">Room Information</h3>
    <div class="room-info" id="room-info">
        <!-- Room details will be injected here by JavaScript -->
    </div>

    <div class="action-buttons">
        <button class="btn btn-success">Approve</button>
        <button class="btn btn-danger">Reject</button>
    </div>
</div>

<script>
    var bookings = ${bookingsJson};

    function showBookingDetail(id) {
        var bookingDetail = document.getElementById('booking-detail');
        var modalOverlay = document.getElementById('modal-overlay');
        
        var booking = bookings.find(b => b.id === id);
        
        document.getElementById('guest-avatar').src = booking.avatar;
        document.getElementById('guest-fullname').innerText = booking.fullName;
        document.getElementById('guest-age').innerText = booking.age;
        document.getElementById('guest-phone').innerText = booking.phoneNumber;
        document.getElementById('guest-address').innerText = booking.address;
        document.getElementById('number-of-guests').innerText = booking.numberOfGuests;
        document.getElementById('date-checkin').innerText = booking.dateCheckIn;
        document.getElementById('date-checkout').innerText = booking.dateCheckOut;
        document.getElementById('date-booked').innerText = booking.dateBooked;
        document.getElementById('status').innerText = booking.status;

        var roomInfoDiv = document.getElementById('room-info');
        roomInfoDiv.innerHTML = ''; // Clear existing room info

        booking.rooms.forEach(function(room) {
            var roomCard = document.createElement('div');
            roomCard.classList.add('card', 'mb-3');

            var roomCardContent = `
                <div class="row no-gutters">
                    <div class="col-md-4">
                        <img src="${room.imageUrl}" class="card-img" alt="Room Image">
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <h5 class="card-title">${room.name}</h5>
                            <p class="card-text"><strong>Capacity:</strong> ${room.capacity} people</p>
                            <p class="card-text"><strong>Status:</strong> ${room.status}</p>
                        </div>
                    </div>
                </div>
            `;
            roomCard.innerHTML = roomCardContent;
            roomInfoDiv.appendChild(roomCard);
        });

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
