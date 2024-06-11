<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .action-button {
        width: 100px; /* Set a fixed width */
    }
    .details-form {
        display: none;
    }
</style>
<div class="container mt-4">
    <div class="card mb-4">
        <div class="card-header">Approve Booking</div>
        <div class="card-body">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col">Booking ID</th>
                        <th scope="col">Homestay Name</th>
                        <th scope="col">Guest Name</th>
                        <th scope="col">Rooms Booked</th>
                        <th scope="col">Guests</th>
                        <th scope="col">Check-in Date</th>
                        <th scope="col">Check-out Date</th>
                    </tr>
                </thead>
                <tbody>
                    <tr data-toggle="collapse" data-target="#details-001" aria-expanded="false">
                        <td>001</td>
                        <td>Homestay A</td>
                        <td>John Doe</td>
                        <td>2</td>
                        <td>4</td>
                        <td>2024-06-10</td>
                        <td>2024-06-15</td>
                    </tr>
                    <tr id="details-001" class="collapse details-form">
                        <td colspan="7">
                            <div class="card card-body">
                                <h5>Booking Details</h5>
                                <p>Booking ID: 001</p>
                                <p>Homestay Name: Homestay A</p>
                                <p>Guest Name: John Doe</p>
                                <p>Rooms Booked: 2</p>
                                <p>Guests: 4</p>
                                <p>Check-in Date: 2024-06-10</p>
                                <p>Check-out Date: 2024-06-15</p>
                                <button class="btn btn-success btn-sm action-button">Approve</button>
                                <button class="btn btn-danger btn-sm action-button">Reject</button>
                            </div>
                        </td>
                    </tr>
                    <tr data-toggle="collapse" data-target="#details-002" aria-expanded="false">
                        <td>002</td>
                        <td>Homestay B</td>
                        <td>Jane Smith</td>
                        <td>1</td>
                        <td>2</td>
                        <td>2024-06-12</td>
                        <td>2024-06-18</td>
                    </tr>
                    <tr id="details-002" class="collapse details-form">
                        <td colspan="7">
                            <div class="card card-body">
                                <h5>Booking Details</h5>
                                <p>Booking ID: 002</p>
                                <p>Homestay Name: Homestay B</p>
                                <p>Guest Name: Jane Smith</p>
                                <p>Rooms Booked: 1</p>
                                <p>Guests: 2</p>
                                <p>Check-in Date: 2024-06-12</p>
                                <p>Check-out Date: 2024-06-18</p>
                                <button class="btn btn-success btn-sm action-button">Approve</button>
                                <button class="btn btn-danger btn-sm action-button">Reject</button>
                            </div>
                        </td>
                    </tr>
                    <!-- Add more rows as needed -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

