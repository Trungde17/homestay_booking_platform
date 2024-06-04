<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meals - My Homestay</title>
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
            <div class="header">Meals</div>
            <div class="progress-indicator">
                <div class="step">
                    <div class="icon"><i class="fas fa-home"></i></div>
                    <p>Home</p>
                </div>
                <div class="step">
                    <div class="icon"><i class="fas fa-map-marker-alt"></i></div>
                    <p>Location</p>
                </div>
                <div class="step">
                    <div class="icon"><i class="fas fa-calendar-alt"></i></div>
                    <p>Booking Preferences</p>
                </div>
                <div class="step">
                    <div class="icon"><i class="fas fa-bed"></i></div>
                    <p>Rooms</p>
                </div>
                <div class="step active">
                    <div class="icon"><i class="fas fa-utensils"></i></div>
                    <p>Meals</p>
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
                        <div class="form-group">
                            <label>Can guests use the kitchen for cooking?</label>
                            <div class="custom-control custom-radio">
                                <input type="radio" id="kitchenYes" name="kitchenUse" class="custom-control-input">
                                <label class="custom-control-label" for="kitchenYes">Yes</label>
                            </div>
                            <div class="custom-control custom-radio">
                                <input type="radio" id="kitchenNo" name="kitchenUse" class="custom-control-input" checked>
                                <label class="custom-control-label" for="kitchenNo">No</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Do you provide meals?</label>
                            <div class="custom-control custom-radio">
                                <input type="radio" id="provideMeals" name="provideMeals" class="custom-control-input">
                                <label class="custom-control-label" for="provideMeals">I provide meals</label>
                            </div>
                            <div class="custom-control custom-radio">
                                <input type="radio" id="dontProvideMeals" name="provideMeals" class="custom-control-input" checked>
                                <label class="custom-control-label" for="dontProvideMeals">I don't provide meals</label>
                            </div>
                        </div>
                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="lightBreakfast" checked>
                            <label class="custom-control-label" for="lightBreakfast">My Prices Include a Light Breakfast</label>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block mt-4">Continue</button>
                    </form>
                </div>
            </div>
            <div class="col-md-4">
                <div class="sidebar">
                    <div class="info-box">
                        <h6>LIGHT BREAKFAST SUGGESTED</h6>
                        <p>We suggest to offer a light breakfast to your guests, such as cereals, pastries, tea/coffee, juice, etc... You don't need to serve it if it's not possible, just let your guests know where everything is!</p>
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
