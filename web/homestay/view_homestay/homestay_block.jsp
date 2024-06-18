<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="DAO.HomestayDAO"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Beautiful Homestay - Homestay Profile</title>
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
        <link href="${pageContext.request.contextPath}/css/homestay/view/homestay_view.css" rel="stylesheet" type="text/css" />
    </head>

    <body data-ng-app="">
        <!-- Navigation Section -->
        <div class="nav-section">
            <div class="nav-container">
                <a href="#gallery">Gallery</a>
                <a href="#information">Information</a>
                <a href="#amenities">Amenities</a>
                <a href="#locations">Nearby</a>
                <a href="#rules">Rules</a>
                <a href="#rooms">Rooms</a>
                <a href="#reviews">User Reviews</a>
            </div>
        </div>
        <c:set var="homestay" value="${HomestayDAO.getHomestayById(1)}" />
        <!--HEADER SECTION-->      
        <section>
            <c:set var="owner" value="${homestay.owner}" />
            <div class="inn-body-section inn-detail">
                <div class="container">
                    <div class="row">
                        <div class="col-md-3">
                            <!-- Owner Avatar and Information -->
                            <div class="owner-profile fixed-profile">
                                <img src="${owner.avatar_img}" alt="Owner Avatar" class="owner-avatar">
                                <div class="owner-info">
                                    <h2>${owner.fullName}</h2>
                                    <p>Owner of ${homestay.ht_name}</p>
                                    <p>Contact: ${owner.email}</p>
                                    <p>Phone: ${owner.phone}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <!-- Homestay Name -->
                            <div class="inn-detail-p1" id="homestay-name">
                                <h1>${homestay.ht_name}</h1>
                            </div>

                            <!-- Homestay Gallery -->
                            <c:set var="imgs" value="${homestay.img}" />
                            <div id="gallery" class="inn-detail-p1 inn-com">
                                <h2>Homestay Gallery</h2>
                                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                                    <ol class="carousel-indicators">
                                        <c:forEach var="img" items="${imgs}" varStatus="status">
                                            <li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="${status.first ? 'active' : ''}"></li>
                                            </c:forEach>
                                    </ol>

                                    <div class="carousel-inner">
                                        <c:forEach var="img" items="${imgs}" varStatus="status">
                                            <div class="carousel-item ${status.first ? 'active' : ''}">
                                                <img src="${img.img_url}" class="d-block w-100" alt="Homestay Image ${status.index + 1}">
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                </div>
                            </div>

                            <!-- Homestay Information -->
                            <div id="information" class="inn-detail-p1 inn-com">
                                <h2>Homestay Information</h2>
                                <p>${homestay.describe}</p>
                            </div>

                            <!-- Amenities -->
                            <c:set var="facilities_list" value="${homestay.facilities}" />
                            <div id="amenities" class="inn-detail-p1 inn-com">
                                <h2>Homestay Amenities</h2>
                                <c:forEach var="facilities" items="${facilities_list}">
                                    <ul>
                                        <li><i class="fa fa-check" aria-hidden="true"></i>${facilities.facilities_name}</li>
                                    </ul>
                                </c:forEach>
                            </div>

                            <!-- Nearby Locations -->
                            <div id="locations" class="inn-detail-p1 inn-com">
                                <h2>Nearby</h2>
                                <c:set var="neighbourhoods" value="${homestay.neighbourhoods}" />
                                <ul>
                                    <c:forEach var="neighbourhood" items="${neighbourhoods}">
                                        <li><i class="fa fa-check" aria-hidden="true"></i>${neighbourhood.neighbourhood_name}</li>
                                        </c:forEach>
                                </ul>
                            </div>

                            <!-- Homestay Rules -->
                            <c:set var="rules" value="${homestay.commonRules}" />
                            <div id="rules" class="inn-detail-p1 inn-com">
                                <h2>Homestay Rules</h2>
                                <ul>
                                    <c:forEach var="rule" items="${rules}">
                                        <li><i class="fa fa-check" aria-hidden="true"></i>${rule.rule_name}</li>
                                        </c:forEach>
                                </ul>
                                <small>${homestay.homestay_rules}</small>
                            </div>

                            <!-- Room Price and Booking -->
                            <div id="rooms" class="inn-detail-p1 inn-com inn-com-price">
                                <!-- Check-in and Check-out Dates -->
                                <div class="detail-title">
                                    <h2>Select Dates</h2>
                                </div>
                                <form action="${pageContext.request.contextPath}/searchroomsavailable" method="POST" class="checkin-checkout-card row">

                                    <div class="col-sm-5">
                                        <label for="checkinDate">Check-in Date:</label>
                                    </div>
                                    <div class="col-sm-5">
                                        <label for="checkoutDate">Check-out Date:</label>
                                    </div>
                                    <div class="col-sm-5">
                                        <input name="checkin_date" value="${sessionScope.checkinDate_str}" type="date" class="form-control mb-3" id="checkinDate" required>
                                    </div>
                                    <div class="col-sm-5">
                                        <input name="checkout_date" value="${sessionScope.checkoutDate_str}" type="date" class="form-control mb-3" id="checkoutDate" required>
                                    </div>
                                    <div class="col-sm-2">
                                        <button name="homestay_id" class="btn btn-primary w-100" type="submit" value="${homestay.ht_id}">Find</button>
                                    </div>
                                </form>
                                <div class="detail-title">
                                    <h2>Rooms</h2>
                                    <p>Choose from our various room options and book your stay with us.</p>
                                </div>
                                <div class="room-price-cards">
                                    <c:set var="rooms" value="${sessionScope.available_rooms}" />

                                    <c:forEach var="room" items="${rooms}">
                                        <div class="card mb-3">
                                            <div class="row no-gutters">
                                                <div class="col-md-4">
                                                    <img src="${room.img.get(0).img_url}" class="card-img" alt="Room Image">
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="card-body">
                                                        <h5 class="card-title">${room.room_name}</h5>
                                                        <p class="card-text">${room.room_description}</p>
                                                        <p class="card-text"><small class="text-muted">Size: ${room.size}</small></p>
                                                        <p class="card-text"><small class="text-muted">Capacity: ${room.capacity} People.</small></p>
                                                        <c:set var="onePersonPrice" value="${0.0}" />
                                                        <c:set var="moreThanOnePersonPrice" value="${0.0}" />
                                                        <c:set var="prices" value="${room.prices}"/>
                                                        <c:forEach var="price" items="${prices}">
                                                            <c:if test="${price.price_id==1}">
                                                                <c:set var="onePersonPrice" value="${price.getAmount()}" />
                                                            </c:if>  
                                                            <c:if test="${price.price_id==2}">
                                                                <c:set var="moreThanOnePersonPrice" value="${price.getAmount()}" />
                                                            </c:if>

                                                        </c:forEach>
                                                        <p class="card-text">Price per night (1 person): <small>${onePersonPrice}</small></p>
                                                        <p class="card-text">Price per night (more than 1 person): <small>${moreThanOnePersonPrice}</small></p>
                                                        <form action="${pageContext.request.contextPath}/addcart" method="POST">
                                                            <label for="guests${room.room_id}">Number of Guests:</label>
                                                            <c:set var="capacity" value="${room.capacity}" />
                                                            <select class="form-control mb-3" id="guests${room.room_id}" name="${room.room_id}">
                                                                <c:forEach var="number" begin="1" end="${capacity}">
                                                                    <option value="${number}">${number} Guests</option>
                                                                </c:forEach>
                                                            </select>
                                                            <button name="room_id" value="${room.room_id}" type="submit" class="btn btn-primary">Select Room</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>

                                </div>
                            </div>
                            <!-- Pricing Summary Section -->
                            <c:set var="cart" value="${sessionScope.cart}"/>
                            <c:if test="${cart!=null}">
                                <div class="fixed-bottom">
                                    <div class="container">
                                        <div class="card">
                                            <div class="card-body d-flex justify-content-between align-items-center booking-cart" style="color: #000;">
                                                <div>
                                                    <h5 class="card-title">Pricing Summary</h5>
                                                    <div class="pricing-summary-content">
                                                        <c:forEach var="entry" items="${cart.rooms}">
                                                            <p>Room Name: <span id="roomType">${entry.key.room_name}</span></p>
                                                                <c:set var="number" value="${entry.value}"/>
                                                            <p>Number of Guests: <span id="numGuests">${number}</span></p>
                                                                <c:set var="price" value="${entry.key.prices.get(0)}"/>
                                                                <c:if test="${number>1}"><c:set var="price" value="${entry.key.prices.get(1)}"/></c:if>
                                                            <p>Price per night: <span id="pricePerNight">${price.getAmount()}vnd</span></p>
                                                            </c:forEach>
                                                        <p>Date Check In: <span id="totalNights">${cart.getFormattedCheckIn()}</span></p>
                                                        <p>Date Check Out: <span id="totalNights">${cart.getFormattedCheckOut()}</span></p>
                                                        <p>Total cost: $<span id="totalCost">${cart.getTotalAmount()}vnd</span></p>
                                                    </div>
                                                </div>
                                                <a href="booking.jsp" class="btn btn-primary">Book Now</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <!-- User Reviews -->
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- BOOTSTRAP JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', (event) => {
                const today = new Date().toISOString().split('T')[0];
                document.getElementById('checkinDate').setAttribute('min', today);
                document.getElementById('checkoutDate').setAttribute('min', today);

                document.getElementById('checkinDate').addEventListener('change', (event) => {
                    const checkinDate = event.target.value;
                    const minCheckoutDate = new Date(new Date(checkinDate).getTime() + (24 * 60 * 60 * 1000)).toISOString().split('T')[0];
                    document.getElementById('checkoutDate').setAttribute('min', minCheckoutDate);
                    calculateNights();
                });

                document.getElementById('checkoutDate').addEventListener('change', calculateNights);
                // Scroll to rooms if needed
                const scrollToRooms = ${scrollToRooms != null ? scrollToRooms : 'false'};
                if (scrollToRooms) {
                    document.getElementById('rooms').scrollIntoView();
                }
            });

            function calculateNights() {
                const checkinDate = new Date(document.getElementById('checkinDate').value);
                const checkoutDate = new Date(document.getElementById('checkoutDate').value);
                const nightCountElement = document.getElementById('nightCount').querySelector('p');

                if (checkinDate && checkoutDate && checkoutDate > checkinDate) {
                    const differenceInTime = checkoutDate.getTime() - checkinDate.getTime();
                    const differenceInDays = differenceInTime / (1000 * 3600 * 24);
                    nightCountElement.textContent = `${differenceInDays} NIGHTS`;
                    document.getElementById('totalNights').textContent = differenceInDays;
                    updatePricingSummary();
                } else {
                    nightCountElement.textContent = 'NIGHTS';
                    document.getElementById('totalNights').textContent = 0;
                    updatePricingSummary();
                }
            }
            // Initialize the summary with default values
            calculateNights();
        </script>
    </body>

</html>
