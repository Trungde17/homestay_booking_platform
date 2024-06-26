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
                            <c:choose>
                                <c:when test="${not empty param.msg}">
                                    <h2 class="text-success">${param.msg}</h2>
                                </c:when>
                                <c:when test="${not empty param.error}">
                                    <h2 class="text-danger">${param.error}</h2>
                                </c:when>
                                <c:otherwise>
                                    <h2 class="text-warning">No message provided.</h2>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <a class="btn btn-success mt-2" href="../">Back To Home</a>
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
