<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rooms - My Homestay</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f1f1f1;
        }
        .navbar-custom {
            background-color: #fff;
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
        .navbar-custom .navbar-brand img {
            height: 40px;
        }
        .navbar-custom .navbar-nav .nav-link {
            color: #555;
        }
        .navbar-custom .navbar-nav .nav-link:hover {
            color: #d81b60;
        }
        .listing-setup {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-top: 20px;
        }
        .form-group label {
            font-weight: bold;
        }
        .btn-primary {
            background-color: #d81b60;
            border-color: #d81b60;
        }
        .btn-primary:hover {
            background-color: #c2185b;
            border-color: #c2185b;
        }
        .header {
            background-color: #d81b60;
            color: white;
            padding: 10px;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
            font-size: 20px;
            text-align: center;
        }
        .progress-indicator {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
        }
        .progress-indicator .step {
            text-align: center;
            position: relative;
        }
        .progress-indicator .step .icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #f1f1f1;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 10px auto;
        }
        .progress-indicator .step.active .icon {
            background-color: #d81b60;
            color: white;
        }
        .progress-indicator .step::after {
            content: '';
            position: absolute;
            top: 20px;
            left: 50%;
            width: calc(100% - 50px);
            height: 2px;
            background-color: #ddd;
            z-index: -1;
        }
        .progress-indicator .step:last-child::after {
            content: none;
        }
        .sidebar {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-top: 20px;
        }
        .info-box {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        .info-box h6 {
            font-weight: bold;
        }
        .tips-list {
            list-style-type: none;
            padding-left: 0;
        }
        .tips-list li {
            margin-bottom: 10px;
        }
        .custom-switch {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .custom-switch input {
            margin-right: 10px;
        }
        .form-check-label a {
            color: #d81b60;
        }
        .stay-type {
            margin-bottom: 15px;
        }
        .stay-type .details {
            margin-left: 20px;
            color: #555;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="logo.png" alt="Homestay Logo">
            </a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#">CONTACT HOSTS</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">VND</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img src="user-avatar.png" alt="User Avatar" class="rounded-circle" height="30">
                            NGUY?N
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Dashboard</a>
                            <a class="dropdown-item" href="#">Inbox</a>
                            <a class="dropdown-item" href="#">Trips</a>
                            <a class="dropdown-item" href="#">Bookings</a>
                            <a class="dropdown-item" href="#">Verify Me</a>
                            <a class="dropdown-item" href="#">Invite Friends</a>
                            <a class="dropdown-item" href="#">List a Room</a>
                            <a class="dropdown-item" href="#">Account</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Logout</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="helpDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            HELP
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="helpDropdown">
                            <a class="dropdown-item" href="#">General</a>
                            <a class="dropdown-item" href="#">Hosts</a>
                            <a class="dropdown-item" href="#">Guests</a>
                            <a class="dropdown-item" href="#">Messaging</a>
                            <a class="dropdown-item" href="#">Reviews</a>
                            <a class="dropdown-item" href="#">Trust and Safety</a>
                            <a class="dropdown-item" href="#">Invite a Friend</a>
                            <a class="dropdown-item" href="#">Regulatory Compliance</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-search"></i></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
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
