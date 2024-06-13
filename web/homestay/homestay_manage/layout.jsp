<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="DAO.BookingDAO"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Homestay Dashboard</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/main.css" />
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/homestay/manage/manage.css" />
</head>
<body>
    <div class="sidebar">
        <a href="layout.jsp?section=homestayInfo">Homestay Information</a>
        <a href="layout.jsp?section=approveBooking">Approve Booking</a>
        <a href="layout.jsp?section=roomInfo">Room Information</a>
    </div>

    <div class="content">
        <c:set var="homestay_summary" value="${sessionScope.homestay_summary}"/>
        <div class="dashboard-header">
            <h1>${homestay_summary.getHomestay_name()}</h1>
        </div>

        <div>
            <%
                String section = request.getParameter("section");
                if (section == null || section.isEmpty()) {
                    section = "homestayInfo"; // Default section
                }
                String includePage = section + ".jsp";
            %>
            <jsp:include page="<%= includePage %>" />
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
