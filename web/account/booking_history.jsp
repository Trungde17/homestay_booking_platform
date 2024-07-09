<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking History</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

            body {
                background: #f5f7fa;
                font-family: 'Poppins', sans-serif;
                color: #333;
            }
            .container {
                margin-top: 50px;
                max-width: 900px;
            }
            .card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                background-color: #fff;
                transition: transform 0.3s, box-shadow 0.3s;
                margin-bottom: 20px;
                padding: 20px;
            }
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
            }
            .booking-card {
                position: relative;
            }
            .booking-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 5px;
                background: linear-gradient(to right, #43cea2, #185a9d);
            }
            .booking-card .card-header {
                background-color: #43cea2;
                color: #fff;
                font-weight: bold;
                text-align: center;
                font-size: 1.5em;
                border-radius: 10px 10px 0 0;
                padding: 15px;
            }
            .booking-card .card-body {
                padding: 20px;
                position: relative;
            }
            .booking-card .card-body p {
                margin: 5px 0;
                font-size: 1em;
                color: #333;
            }
            .booking-card .card-body .room-name {
                font-weight: bold;
                color: #185a9d;
                font-size: 1.3em;
                margin-top: 10px;
            }
            .booking-card .card-body .room-details {
                margin-left: 15px;
            }
            .btn-secondary {
                background-color: #185a9d;
                border: none;
                color: #fff;
                padding: 10px 20px;
                font-size: 1.1em;
                border-radius: 10px;
                transition: background-color 0.3s;
            }
            .btn-secondary:hover {
                background-color: #104971;
            }
            .btn-secondary:focus, .btn-secondary:active {
                background-color: #083859;
                box-shadow: none;
            }
            h4 {
                font-size: 2em;
                color: #185a9d;
                text-align: center;
                margin-bottom: 30px;
                animation: blink 1s infinite, jump 0.5s infinite;
            }
            @keyframes blink {
                0%, 100% {
                    opacity: 1;
                }
                50% {
                    opacity: 0;
                }
            }
            @keyframes jump {
                0%, 100% {
                    transform: translateY(0);
                }
                50% {
                    transform: translateY(-10px);
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h4 class="mb-4">Booking History</h4>
            <div class="card p-4">
                <c:forEach var="booking" items="${sessionScope.bookingHistory}">
                    <div class="card booking-card mb-3">
                        <p class="card-header">${nameList[booking.booking_id]}</p>
                        <div class="card-body">
                            <p class="card-text">Booking Date: ${booking.date_booked}</p>
                            <p class="card-text">Check-in: ${booking.check_in}</p>
                            <p class="card-text">Check-out: ${booking.check_out}</p>
                            <p class="card-text">Total Amount: ${booking.paid_amount}</p>
                            <c:forEach var="room" items="${booking.rooms.keySet()}">
                                <div class="room-details">
                                    <p class="room-name">Room Name: ${room.room_name}</p>
                                    <p class="card-text">Description: ${room.room_description}</p>
                                    <p class="card-text">Size: ${room.size}</p>
                                </div>
                            </c:forEach>          
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="d-grid gap-2 mt-4">
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary">Back to homepage</a>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
