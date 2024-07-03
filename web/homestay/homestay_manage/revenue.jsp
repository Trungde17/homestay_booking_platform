<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View Monthly Revenue</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/manage/revenue.css" />
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/manage/menu.css" />
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block sidebar">
                    <jsp:include page="menu.jsp" />
                </nav>
                <div class="col-md-9 ml-sm-auto col-lg-10 content">
                    <h2 class="mb-4">Monthly Revenue</h2>
                    <div class="revenue-card">
                        <h4>Revenue Summary</h4>
                        <form action="${pageContext.request.contextPath}/viewrevenue" method="POST" class="form-inline">
                            <div class="form-group">
                                <label for="yearInput" class="mr-2">Enter Year:</label>
                                <input type="number" name="year" id="yearInput" class="form-control" placeholder="YYYY" value="${year}" required>
                            </div>
                            <div class="form-group">
                                <label for="monthInput" class="mr-2">Enter Month:</label>
                                <input type="number" name="month" id="monthInput" class="form-control" placeholder="MM" min="1" max="12" value="${month}" required>
                            </div>
                            <button type="submit" class="btn btn-primary">View</button>
                        </form>
                        <div class="revenue-summary">
                            <p>Total Revenue: <span id="totalRevenue">${revenue}</span></p>
                            <p>Total Bookings: <span id="bookingCount">${booking_month_number}</span></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
