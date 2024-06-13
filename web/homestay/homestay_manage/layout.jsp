<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Homestay Dashboard</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .dashboard-header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            background-color: #343a40;
            color: white;
            border-radius: 10px;
        }
        .sidebar {
            height: 100%;
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            background-color: #343a40;
            padding-top: 20px;
        }
        .sidebar a {
            padding: 15px 10px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
        }
        .sidebar a:hover {
            background-color: #007bff;
            color: white;
        }
        .content {
            margin-left: 270px;
            padding: 20px;
        }
        .card-header {
            font-weight: bold;
            background-color: #007bff;
            color: white;
        }
        .card {
            border-radius: 10px;
        }
        .form-control, .form-control-file {
            margin-bottom: 15px;
        }
        .btn-primary, .btn-danger {
            width: 100%;
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <a href="layout.jsp?section=homestayInfo">Homestay Information</a>
        <a href="layout.jsp?section=approveBooking">Approve Booking</a>
        <a href="layout.jsp?section=roomInfo">Room Information</a>
    </div>

    <div class="content">
        <div class="dashboard-header">
            <h1>Homestay Dashboard</h1>
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
