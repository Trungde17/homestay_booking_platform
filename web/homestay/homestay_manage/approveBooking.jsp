<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="card mb-4">
    <div class="card-header">Approve Booking</div>
    <div class="card-body">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th scope="col">STT</th>
                    <th scope="col">Guest Name</th>
                    <th scope="col">Number Of Rooms</th>
                    <th scope="col">Check-in Date</th>
                    <th scope="col">Check-out Date</th>
                    <th scope="col">Date Of Booking</th>
                </tr>
            </thead>
            
            <tbody>
            <c:set var="aps" value="${BookingDAO.getAllUnapprovedBookingsOfHomestay(homestay_summary.getHt_id())}"/>
                <c:forEach var="approve_booking" items="${aps}" varStatus="status">
                <tr>
                    <td>1</td>
                    
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="bookingModal" tabindex="-1" role="dialog" aria-labelledby="bookingModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="bookingModalLabel">Booking Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p><strong>Booking ID:</strong> <span id="booking-id"></span></p>
                <p><strong>Homestay ID:</strong> <span id="homestay-id"></span></p>
                <p><strong>Room ID:</strong> <span id="room-id"></span></p>
                <p><strong>Guest Name:</strong> <span id="guest-name"></span></p>
                <p><strong>Check-in Date:</strong> <span id="checkin-date"></span></p>
                <p><strong>Check-out Date:</strong> <span id="checkout-date"></span></p>
            </div>
            <div class="modal-footer d-flex justify-content-between">
                <button type="button" class="btn btn-success btn-block mx-1">Approve</button>
                <button type="button" class="btn btn-danger btn-block mx-1">Reject</button>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function(){
    $('#bookingModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var booking = button.data('booking');

        var modal = $(this);
        modal.find('#booking-id').text(booking.id);
        modal.find('#homestay-id').text(booking.homestay);
        modal.find('#room-id').text(booking.room);
        modal.find('#guest-name').text(booking.guest);
        modal.find('#checkin-date').text(booking.checkin);
        modal.find('#checkout-date').text(booking.checkout);
    });
});
</script>
