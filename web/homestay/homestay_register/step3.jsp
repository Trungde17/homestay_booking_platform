<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rooms - My Homestay</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/register/homestay_register.css" /> 
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/homestay/register/header.css" /> 
</head>
<body>
    <%@include file="header.jsp"%>
    <div class="container">
        <div class="listing-setup mx-auto">
            <div class="header">Rooms</div>
            <div class="progress-indicator">
                <div class="step">
                    <div class="icon"><i class="fas fa-home"></i></div>
                    <p>Home</p>
                </div>
                <div class="step">
                    <div class="icon"><i class="fas fa-map-marker-alt"></i></div>
                    <p>Location</p>
                </div>
                <div class="step active">
                    <div class="icon"><i class="fas fa-bed"></i></div>
                    <p>Rooms</p>
                </div>
                <div class="step">
                    <div class="icon"><i class="fas fa-book"></i></div>
                    <p>Rules</p>
                </div>
                <div class="step">
                    <div class="icon"><i class="fas fa-user"></i></div>
                    <p>Host</p>
                </div>
                <div class="step">
                    <div class="icon"><i class="fas fa-images"></i></div>
                    <p>Photos</p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8">
                <div class="listing-setup mx-auto">
                    <form>
                        <div class="form-group mt-3">
                            <label for="bedroomName">Bedroom Name *</label>
                            <input type="text" class="form-control" id="bedroomName" placeholder="Eg. Room 1 / Loft Room">
                        </div>
                        <div class="form-group">
                            <label for="bathroomType">Bathroom Type *</label>
                            <select class="form-control" id="bathroomType">
                                <option value="ensuite">Ensuite (within room)</option>
                                <option value="private">Private (not shared)</option>
                                <option value="shared">Shared (with other guests)</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="currency">Currency of your rates *</label>
                            <select class="form-control" id="currency">
                                <option value="VND">Vietnamese Dong (VND)</option>
                                <option value="USD">US Dollar (USD)</option>
                                <!-- Add more currencies as needed -->
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="beds">Beds *</label>
                            <select class="form-control" id="beds">
                                <option value="single">Single bed</option>
                                <option value="double">Double bed</option>
                                <option value="queen">Queen bed</option>
                                <option value="king">King bed</option>
                                <!-- Add more bed types as needed -->
                            </select>
                            <a href="#" class="d-block mt-2">Add another bed</a>
                        </div>
                        <div class="form-group">
                            <label for="guests">Number of guests in this room *</label>
                            <input type="number" class="form-control" id="guests" value="1">
                        </div>
                        <div class="form-group">
                            <label for="price">Room Prices</label>
                            <div class="bg-light p-3 rounded">
                                <div class="d-flex justify-content-between">
                                    <span class="font-weight-bold">PRICE FOR 1 PERSON</span>
                                </div>
                                <div class="mt-3">
                                    <label for="monthlyPrice" class="d-block">MONTHLY <small>(30 NIGHTS)</small></label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="monthlyPrice">
                                        <div class="input-group-append">
                                            <span class="input-group-text">VND</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block mt-4">Save Details</button>
                    </form>
                </div>
            </div>
            <div class="col-md-4">
                <div class="sidebar">
                    <div class="info-box">
                        <h6>NEW HOSTS SHOULD SET LOWER PRICES</h6>
                        <p>To compete with established hosts with positive reviews you should set a lower price at the start to attract those first few bookings. Once you are up and running with glowing guest reviews you can always increase your rates.</p>
                    </div>
                    <div class="mt-3">
                        <p>QUESTION? GET IN TOUCH:</p>
                        <p>Email us at <a href="mailto:hostsupport@homestay.com">hostsupport@homestay.com</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
