<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Homestay and Room Info</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            font-family: 'Arial', sans-serif;
        }
        .sidebar {
            height: 100vh;
            width: 250px;
            background-color: #343a40;
            padding-top: 20px;
            position: fixed;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        .sidebar a {
            padding: 15px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
            transition: background-color 0.3s;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .content {
            margin-left: 250px;
            padding: 20px;
            width: 100%;
            background-color: #f8f9fa;
            min-height: 100vh;
        }
        .content h2 {
            margin-top: 0;
        }
        .form-group label {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <a href="approveBookings.jsp">Approve Bookings</a>
        <a href="editHomestayRoom.jsp">Edit Homestay and Room Info</a>
    </div>
    <div class="content">
        <h2>Edit Homestay and Room Information</h2>
        <form>
            <!-- Homestay Information -->
            <div class="form-group">
                <label for="homestayName">Homestay Name:</label>
                <input type="text" class="form-control" id="homestayName" placeholder="Enter homestay name">
            </div>
            <div class="form-group">
                <label for="homestayAddress">Address:</label>
                <input type="text" class="form-control" id="homestayAddress" placeholder="Enter address">
            </div>
            <div class="form-group">
                <label for="homestayDescription">Description:</label>
                <textarea class="form-control" id="homestayDescription" rows="3" placeholder="Enter description"></textarea>
            </div>
            <!-- Room Information -->
            <div class="form-group">
                <label for="roomName">Room Name:</label>
                <input type="text" class="form-control" id="roomName" placeholder="Enter room name">
            </div>
            <div class="form-group">
                <label for="roomCapacity">Capacity:</label>
                <input type="number" class="form-control" id="roomCapacity" placeholder="Enter room capacity">
            </div>
            <div class="form-group">
                <label for="roomStatus">Room Status:</label>
                <input type="text" class="form-control" id="roomStatus" placeholder="Enter room status">
            </div>
            <button type="submit" class="btn btn-success">Save Changes</button>
        </form>
    </div>
</body>
</html>
