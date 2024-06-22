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
    <link href="${pageContext.request.contextPath}/css/confirmBooking.css" rel="stylesheet" type="text/css"/>
</head>

<body data-ng-app="">
    <!--HEADER SECTION-->
    <section class="confirmation-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <!-- Confirmation Message -->
                    <div class="confirmation-form">
                        <c:set var="acc" value="${sessionScope.account}"/>
                        <h1 class="text-center">Booking Confirmation</h1>
                        <p>Thank you for booking your stay with Beautiful Homestay! Here are your booking details:</p>
                        <p><strong>First Name:</strong> ${acc.first_name}</p>
                        <p><strong>Last Name:</strong> ${acc.last_name}</p>
                        <p><strong>Email:</strong> ${acc.email}</p>
                        <p><strong>Phone Number:</strong> ${acc.phone}</p>
                        <c:set var="cart" value="${sessionScope.cart}"/>
                        <p><strong>Booking Date:</strong> ${cart.getFormattedBookingDated()}</p>
                        <p><strong>Check-In Date:</strong> ${cart.getFormattedCheckIn()}</p>
                        <p><strong>Check-Out Date:</strong> ${cart.getFormattedCheckOut()}</p>
                        <p><strong>Number of Guests:</strong> ${param.guests}</p>
                        <p><strong>Number of Rooms:</strong> ${cart.rooms.size()}</p>
                        <p><strong>Rooms:</strong> ${param.roomType}</p>
                        <p><strong>Total Amount:</strong> $<span>${CurrencyUtils.formatCurrency(cart.getTotalAmount())}</span></p>
                        
                        <!-- Confirm and Cancel Buttons -->
                        <form action="${pageContext.request.contextPath}/confirmbooking" method="post" class="text-center mt-4">
                            <button type="submit" name="action" value="confirm" class="btn btn-success">Confirm</button>
                            <button type="submit" name="action" value="cancel" class="btn btn-danger">Cancel</button>
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
