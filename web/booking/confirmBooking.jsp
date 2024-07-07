<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="utilities.CurrencyUtils"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Booking Confirmation - Beautiful Homestay</title>
        <!-- META TAGS -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- FAV ICON(BROWSER TAB ICON) -->
        <link rel="shortcut icon" href="images/fav.ico" type="image/x-icon">
        <!-- GOOGLE FONT -->
        <link href="https://fonts.googleapis.com/css?family=Poppins%7CQuicksand:500,700" rel="stylesheet">
        <!-- BOOTSTRAP CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- FONT AWESOME -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <!-- CUSTOM CSS -->
        <link rel="stylesheet" href="confirmBooking.css">
        <link href="${pageContext.request.contextPath}/css/confirmBooking.css" rel="stylesheet" type="text/css" />
        <style>
            .confirmation-form {
                max-width: 900px;
                margin: auto;
            }
        </style>
    </head>

    <body data-ng-app="">
        <!--HEADER SECTION-->
        <section class="confirmation-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-10">
                        <!-- Confirmation Message -->
                        <div class="confirmation-form">
                            <form action="${pageContext.request.contextPath}/payment/authorize" method="POST" class="container mt-4">
                                <c:set var="acc" value="${sessionScope.account}" />
                                <h1 class="text-center mb-4">Booking Confirmation</h1>
                                <p>Thank you for booking your stay with Beautiful Homestay! Here are your booking details:</p>

                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="firstName"><strong>First Name:</strong></label>
                                        <input type="text" class="form-control" id="firstName" name="firstName" value="${acc.first_name}" readonly>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="lastName"><strong>Last Name:</strong></label>
                                        <input type="text" class="form-control" id="lastName" name="lastName" value="${acc.last_name}" readonly>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="email"><strong>Email:</strong></label>
                                    <input type="email" class="form-control" id="email" name="email" value="${acc.email}" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="phone"><strong>Phone Number:</strong></label>
                                    <input type="tel" class="form-control" id="phone" name="phone" value="${acc.phone}" readonly>
                                </div>

                                <c:set var="cart" value="${sessionScope.cart}" />
                                <div class="form-group">
                                    <label for="bookingDate"><strong>Booking Date:</strong></label>
                                    <input type="text" class="form-control" id="bookingDate" value="${cart.getFormattedBookingDated()}" readonly>
                                </div>
                                <div class="row">
                                    <div class="form-group col-sm-6">
                                        <label for="checkinDate"><strong>Check-In Date:</strong></label>
                                        <input type="text" class="form-control" id="checkinDate" value="${cart.getFormattedCheckIn()}" readonly>
                                    </div>

                                    <div class="form-group col-sm-6">
                                        <label for="checkoutDate"><strong>Check-Out Date:</strong></label>
                                        <input type="text" class="form-control" id="checkoutDate" value="${cart.getFormattedCheckOut()}" readonly>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="numberOfGuests"><strong>Number of Guests:</strong></label>
                                        <input type="text" class="form-control" id="numberOfGuests" value="${cart.guestNumber}" readonly>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="numberOfRooms"><strong>Number of Rooms:</strong></label>
                                        <input type="text" class="form-control" id="numberOfRooms" value="${cart.rooms.size()}" readonly>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="rooms"><strong>Rooms:</strong></label>
                                    <div class="row">
                                        <c:forEach var="entry" items="${cart.rooms.entrySet()}" varStatus="status">
                                            <div class="col-md-6">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <h5 class="card-title">${entry.key.room_name}</h5>
                                                        <p class="card-text">Guests: ${entry.value} people</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <c:if test="${status.index % 2 == 1}">
                                            </div><div class="row">
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                                <p><strong>Total Amount:</strong> <span>${CurrencyUtils.formatCurrency(cart.getTotalAmount() * 1000)}</span></p>
                                <div class="d-flex justify-content-center mt-4">
                                    <button type="submit" name="action" value="confirm" class="btn btn-success mr-2">Confirm</button>
                                    <a href="${pageContext.request.contextPath}/booking/booking_result.jsp?error=Booking Cancelled." class="btn btn-danger">Cancel</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- BOOTSTRAP JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>

</html>
