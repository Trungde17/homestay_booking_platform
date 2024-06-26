<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="DAO.HomestayDAO"%>
<%@page import="utilities.CurrencyUtils"%>
<!DOCTYPE html>
<html lang="en">
    <c:set var="homestay" value="${sessionScope.homestay_view}" />
    <head>
        <title>${homestay.ht_name}</title>
        <!-- META TAGS -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- FAV ICON(BROWSER TAB ICON) -->
        <link rel="shortcut icon" href="images/fav.ico" type="image/x-icon">
        <!-- GOOGLE FONT -->
        <link href="https://fonts.googleapis.com/css?family=Poppins%7CQuicksand:500,700" rel="stylesheet">
        <!-- BOOTSTRAP CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

        <!-- FONT AWESOME -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <!-- CUSTOM CSS -->
        <link href="${pageContext.request.contextPath}/css/homestay/view/homestay_view.css" rel="stylesheet" type="text/css" />

        <style>
            .star-rating {
                display: flex;
                flex-direction: row-reverse;
                justify-content: center;
            }
            .star-rating input {
                display: none;
            }
            .star-rating label {
                font-size: 2em;
                color: #ddd;
                cursor: pointer;
                transition: color 0.2s;
            }
            .star-rating input:checked ~ label,
            .star-rating label:hover,
            .star-rating label:hover ~ label {
                color: #f39c12;
            }
            .options-dropdown {
                position: relative;
                display: inline-block;
            }
            .options-dropdown-content {
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                min-width: 120px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }
            .options-dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }
            .options-dropdown-content a:hover {
                background-color: #f1f1f1;
            }
            .options-dropdown:hover .options-dropdown-content {
                display: block;
            }
            .options-dropdown:hover .options-dropdown-btn {
                background-color: #3e8e41;
            }

        </style>

        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.css"/>

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


                            <!-- User Reviews -->
                            <div id="reviews" class="inn-detail-p1 inn-com">
                                <h2>User reviews</h2>
                                <div class="container m-3">
                                    <div class="" id="user-feedback">
                                        <div id="feedback-content" style="max-height: 400px; /* Adjust the height as needed */
                                             overflow-y: auto; overflow-x: hidden ">
                                            <!-- Feedback content will be loaded here -->
                                        </div>
                                    </div>


                                </div>
                            </div>

                            <div id="feedback-form-wrapper">
                                <div id="floating-icon">
                                    <button type="button" class="btn btn-primary btn-sm rounded-0" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                        Feedback
                                    </button>
                                </div>
                                <div id="feedback-form-modal">
                                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title text-dark" id="exampleModalLabel">Feedback Form</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <form method="post" action="${pageContext.request.contextPath}/feedback/create">

                                                        <!-- Hidden input field for ht_id -->
                                                        <input type="hidden" id="ht_id" name="ht_id" value="">

                                                        <div class="mb-3">
                                                            <label for="rating">Rating</label>
                                                            <div class="star-rating">
                                                                <input type="radio" id="star5" name="rating" value="5"/><label for="star5" title="5 stars"><i class="fas fa-star"></i></label>
                                                                <input type="radio" id="star4" name="rating" value="4"/><label for="star4" title="4 stars"><i class="fas fa-star"></i></label>
                                                                <input type="radio" id="star3" name="rating" value="3"/><label for="star3" title="3 stars"><i class="fas fa-star"></i></label>
                                                                <input type="radio" id="star2" name="rating" value="2"/><label for="star2" title="2 stars"><i class="fas fa-star"></i></label>
                                                                <input type="radio" id="star1" name="rating" value="1"/><label for="star1" title="1 star"><i class="fas fa-star"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="mb-3">
                                                            <label for="comments">Comments</label>
                                                            <textarea class="form-control" id="comments" name="comments" rows="3" placeholder="Write your comments here..."></textarea>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            <button type="submit" class="btn btn-primary">Submit</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Edit Feedback Modal -->
                        <div class="modal fade" id="editFeedbackModal" tabindex="-1" role="dialog" aria-labelledby="editFeedbackModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title text-dark" id="editFeedbackModalLabel">Edit Feedback</h5>
                                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <form id="editFeedbackForm" action="${pageContext.request.contextPath}/feedback/edit" method="post">
                                            <input type="hidden" name="id" id="editId" value=""></label>

                                            <div class="form-group">
                                                <label for="editRating">Rating</label>
                                                <div class="star-rating">
                                                    <input type="radio" id="editStar5" name="rating" value="5"/><label for="editStar5" title="5 stars"><i class="fas fa-star"></i></label>
                                                    <input type="radio" id="editStar4" name="rating" value="4"/><label for="editStar4" title="4 stars"><i class="fas fa-star"></i></label>
                                                    <input type="radio" id="editStar3" name="rating" value="3"/><label for="editStar3" title="3 stars"><i class="fas fa-star"></i></label>
                                                    <input type="radio" id="editStar2" name="rating" value="2"/><label for="editStar2" title="2 stars"><i class="fas fa-star"></i></label>
                                                    <input type="radio" id="editStar1" name="rating" value="1"/><label for="editStar1" title="1 star"><i class="fas fa-star"></i></label>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="editComments">Comments</label>
                                                <textarea class="form-control" id="editComments" name="comments" rows="3"></textarea>
                                            </div>
                                            <input type="hidden" id="editFeedbackId" name="editFeedbackId">
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary">Save Changes</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>

    <script>
        window.onload = function () {
            const urlParams = new URLSearchParams(window.location.search);
            const ht_id = urlParams.get('ht_id');
            document.getElementById('ht_id').value = ht_id;
            loadFeedback(ht_id);
        };

        function loadFeedback(ht_id) {
            $.ajax({
                url: '${pageContext.request.contextPath}/feedback/getall',
                type: 'GET',
                data: {ht_id: ht_id},
                dataType: 'json',
                success: function (feedbackList) {
                    let feedbackHtml = '';
                    feedbackList.forEach(function (feedback) {
                        const userName = feedback.customerName;
                        feedbackHtml += `
                            <div class="row m-4">
                                <div class="col-md-12 room-rat-body">
                                    <div class="room-rat-img">
                                        <img src="../../images/users/2.png" alt="">
                                        <p>` + feedback.customerName + `</p>
                                        <span> ` + feedback.createdDate + `</span>
                                    </div>
                                    
                                    <div class="dir-rat-star">` + getStars(feedback.rating) + `
                                    </div>
                                     
                                    <p>` + feedback.comments + `</p>
                                    <div class="options-dropdown">
                                        <button class="options-dropdown-btn">...</button>
                                        <div class="options-dropdown-content">
                                            <a class="text-success" onclick="editFeedback(` + feedback.id + ` )">Edit</a>
                                            <a class="text-danger" onclick="deleteFeedback(` + feedback.id + `)">Delete</a>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                            <hr/>`;

                    });
                    $('#feedback-content').html(feedbackHtml);
                },
                error: function (error) {
                    console.error('Error fetching feedback:', error);
                }
            });
        }
        function getStars(rating) {
            let stars = '';
            for (let i = 1; i <= 5; i++) {
                if (i <= rating) {
                    stars += '<i class="fa fa-star text-warning" aria-hidden="true"></i>';
                } else {
                    stars += '<i class="far fa-star text-warning" aria-hidden="true"></i>';
                }
            }
            return stars;
        }

        function deleteFeedback(id) {
            if (confirm('Are you sure you want to delete this feedback?')) {
                // Redirect to the delete URL with the feedback ID and a message parameter
                window.location.href = `${pageContext.request.contextPath}/feedback/delete?id=` + id;
            }
        }

        function editFeedback(id) {
            // Retrieve the feedback information from the server using AJAX
            $.ajax({
                url: '${pageContext.request.contextPath}/feedback/get',
                type: 'GET',
                data: {id: id}, // Send the feedback ID to identify the feedback to edit
                dataType: 'json',
                success: function (feedback) {
                    // Populate the modal with the feedback information
                    $('#editFeedbackModal #editStar' + feedback.rating).prop('checked', true); // Set the radio button for rating
                    $('#editFeedbackModal #editComments').val(feedback.comments);
                    $('#editFeedbackModal #editId').val(feedback.id);
                    // Show the modal
                    $('#editFeedbackModal').modal('show');
                },
                error: function (error) {
                    console.error('Error fetching feedback:', error);
                }
            });
        }


    </script>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

    <script type="text/javascript">
        displayToastr();
        function displayToastr() {
            const urlParams = new URLSearchParams(window.location.search);
            const msg = urlParams.get('msg');
            const error = urlParams.get('error');

            toastr.options = {
                "closeButton": true
            };
            if (msg) {
                console.log(msg);
                toastr.success(msg);
            }
            if (error) {
                toastr.error(error);
            }
        }


    </script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>

    <!-- BOOTSTRAP JS -->
    <!--<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>-->
    <!--<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>-->
    <!--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>-->
</body>

</html>
