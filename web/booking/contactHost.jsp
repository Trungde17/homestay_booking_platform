<!DOCTYPE html>
<html lang="en">
<head>
    <title>HeadlingLand - Booking</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Poppins%7CQuicksand:500,700" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
    <link href="${pageContext.request.contextPath}/css/materialize.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/css/responsive.css" rel="stylesheet">
    <link href="css/custom.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css" />

    <style>
        .small-image {
            width: 170px; 
            height: auto;
        }
        .booking-summary {
            background-color: #fff; /* Changed to white */
            color: #000; /* Changed to black */
            padding: 10px;
        }
        .booking-summary th, .booking-summary td {
            padding: 10px;
            text-align: left;
        }
        .booking-summary th {
            background-color: #eee; /* Changed to a light grey for better readability */
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#guestNumber, #checkIn, #checkOut').on('change', function () {
                var guestNumber = $('#guestNumber').val();
                var checkIn = new Date($('#checkIn').val());
                var checkOut = new Date($('#checkOut').val());
                
                $('#selectedGuests').text(guestNumber);

                if (checkIn && checkOut) {
                    var timeDiff = Math.abs(checkOut.getTime() - checkIn.getTime());
                    var nights = Math.ceil(timeDiff / (1000 * 3600 * 24));
                    $('#nights').text(nights);

                    // Set default values for price and prepayment
                    var pricePerNight = 50000;
                    var prepayment = 10000;
                    var totalPrice = pricePerNight * nights;
                    var outstandingAmount = totalPrice - prepayment;

                    $('#priceDisplay').text(pricePerNight + ' VND');
                    $('#prepaymentDisplay').text(prepayment + ' VND');
                    $('#totalDisplay').text(totalPrice + ' VND');

                    $('#price').val(totalPrice); // Set the hidden field value for total price
                    $('#prepayment').val(prepayment); // Set the hidden field value for prepayment
                }
            });

            $('form').on('submit', function () {
                var priceDisplay = $('#totalDisplay').text().replace(' VND', '').trim();
                var prepaymentDisplay = $('#prepaymentDisplay').text().replace(' VND', '').trim();
                $('#price').val(priceDisplay);
                $('#prepayment').val(prepaymentDisplay);
            });
        });
    </script>
</head>
<body data-ng-app="">
    <!--HEADER SECTION-->
    <section>
        <%@include file="/includes/header.jsp" %>
        <!-- Booking Section -->
        <div class="inn-body-section inn-booking">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <div class="book-title">
                            <h2>Homestay Booking</h2>
                            <p> Hope you have a good experience using the HealingLand platform.
                                Wishing you and your loved ones a very happy holiday.
                                Thank you !</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="book-form inn-com-form">
                            <form action="${pageContext.request.contextPath}/BookingServlet" method="post" class="col s12">
                                <div class="row">
                                    <div class="input-field col s6">
                                        <input type="text" class="form-control validate" id="guestName" name="guestName" placeholder="Full Name" required>
                                    </div>
                                    <div class="input-field col s6">
                                        <input type="text" class="form-control validate" id="email" name="email" placeholder="Email" required>
                                    </div>
                                    <div class="input-field col s6">
                                        <input type="text" class="form-control validate" id="homestayId" name="homestayId" placeholder="Homestay ID" value="3" readonly required>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="input-field col s6">
                                        <input type="number" class="form-control validate" id="guestNumber" name="guestNumber" placeholder="Number of Guests" required>
                                    </div>
                                    <div class="input-field col s6">
                                        <input type="date" id="dateBooked" name="dateBooked" class="form-control" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="input-field col s6">
                                        <input type="date" id="checkIn" name="checkIn" class="form-control" required>
                                    </div>
                                    <div class="input-field col s6">
                                        <input type="date" id="checkOut" name="checkOut" class="form-control" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="input-field col s12">
                                        <input type="hidden" id="price" name="price">
                                        <input type="hidden" id="prepayment" name="prepayment">
                                        <input type="submit" value="Submit" class="btn btn-primary form-btn">
                                    </div>
                                </div>
                            </form>
                            <div id="message">
                                <p>${message}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Booking Summary Section -->
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="booking-summary">
                            <h3>Booking Summary</h3>
                            <table>
                                <thead>
                                    <tr>
                                        <th>You have selected</th>
                                        <th>Nights</th>
                                        <th>Price of Stay</th>
                                        <th>Prepayment</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Double room (Guests: <span id="selectedGuests">0</span>)</td>
                                        <td><span id="nights">0</span></td>
                                        <td><span id="priceDisplay">50000 VND</span></td>
                                        <td><span id="prepaymentDisplay">10000 VND</span></td>
                                        <td><span id="totalDisplay">0 VND</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Footer Section -->
    <div class="hom-footer-section">
        <div class="container">
            <div class="row">
                <div class="foot-com foot-1 col-md-3">
                    <ul class="list-inline">
                        <li class="list-inline-item"><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                        <li class="list-inline-item"><a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
                        <li class="list-inline-item"><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                    </ul>
                </div>
                <div class="foot-com foot-2 col-md-3">
                    <h5>Phone: 038 332 57 41 </h5>
                </div>
                <div class="foot-com foot-3 col-md-3">
                    <a class="waves-effect waves-light btn btn-primary" href="homestaySearch.jsp">Search Homestay</a>
                </div>
                <div class="foot-com foot-4 col-md-3">
                    <a href="#"><img src="images/card.png" alt="" /></a>
                </div>
            </div>
        </div>
    </div>
    <!-- Site Footer -->
    <footer class="site-footer clearfix">
        <div class="sidebar-container">
            <div class="sidebar-inner">
                <div class="widget-area clearfix">
                    <div class="widget widget_azh_widget">
                        <div>
                            <div class="container">
                                <div class="row">
                                    <div class="col-sm-12 col-md-4 foot-logo">
                                       
                                        <img class="small-image" src="../img/project_logo.jpg" alt="logo">  
                                        <p class="hasimg">Providing Homestay throughout Da Nang. Fast, comfortable, convenient. Let's book a cheap homestay room.</p>
                                        <p class="hasimg">Highest rated homestay booking service.</p>
                                    </div>
                                    <div class="col-sm-12 col-md-4">
                                        <h4>Support & Help</h4>
                                        <ul class="two-columns">
                                            <li><a href="dashboard.html">Dashboard</a></li>
                                            <li><a href="db-activity.html">DB Activity</a></li>
                                            <li><a href="booking.html">Booking</a></li>
                                            <li><a href="contact-us.html">Contact Us</a></li>
                                            <li><a href="about-us.html">About Us</a></li>
                                            <li><a href="aminities.html">Amenities</a></li>
                                            <li><a href="blog.html">Blog</a></li>
                                            <li><a href="menu1.html">Food Menu</a></li>
                                        </ul>
                                    </div>                                   
                                    <div class="col-sm-12 col-md-4">
                                        <h4>Address</h4>
                                        <p>Da Nang - Viet Nam</p>
                                        <p><span class="foot-phone">Phone: </span><span class="foot-phone">+01 1245 2541</span></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                       
    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
    <script src="${pageContext.request.contextPath}/js/angular.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/materialize.min.js" type="text/javascript"></script>    
</body>
</html>
