<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="DAO.RoomDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile - My Homestay</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/register/homestay_register.css" />  
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/register/header.css" /> 
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/main.css" />
    </head>
    <body>  
        <%@include file="header.jsp" %>
        <div class="container">
            <div class="listing-setup mx-auto">
                <div class="header">Profile</div>
                <div class="progress-indicator">
                    <div class="step inactive">
                        <div class="icon"><i class="fas fa-home"></i></div>
                        <p>Home</p>
                    </div>
                    <div class="step inactive">
                        <div class="icon"><i class="fas fa-map-marker-alt"></i></div>
                        <p>Location</p>
                    </div>
                    <div class="step inactive">
                        <div class="icon"><i class="fas fa-bed"></i></div>
                        <p>Rooms</p>
                    </div>
                    <div class="step inactive">
                        <div class="icon"><i class="fas fa-book"></i></div>
                        <p>Rules</p>
                    </div>
                    <div class="step inactive">
                        <div class="icon"><i class="fas fa-user"></i></div>
                        <p>Profile</p>
                    </div>
                    <div class="step active">
                        <div class="icon"><i class="fas fa-images"></i></div>
                        <p>Photos</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <form action="${pageContext.request.contextPath}/register_step5_controll" method="POST" class="col-md-8" enctype="multipart/form-data">
                    <div class="listing-setup mx-auto">
                        <h1 class="text-center mb-4 photos-header">Homestay Image Upload</h1>

                        <!-- Homestay Images Section -->
                        <div class="mb-4">
                            <h5>Upload Homestay Images</h5>
                            <div class="d-flex flex-wrap">
                                <div class="upload-box m-2">
                                    <input name="homestay_img" type="file" accept="image/*" onchange="previewImage(event, this)" required>
                                    <img alt="Homestay Image 1">
                                    <button class="delete-btn" onclick="deleteImage(this)">x</button>
                                </div>
                                <div class="upload-box m-2">
                                    <input name="homestay_img" type="file" accept="image/*" onchange="previewImage(event, this)" required>
                                    <img alt="Homestay Image 2">
                                    <button class="delete-btn" onclick="deleteImage(this)">x</button>
                                </div>
                                <div class="upload-box m-2">
                                    <input name="homestay_img" type="file" accept="image/*" onchange="previewImage(event, this)" required>
                                    <img alt="Homestay Image 3">
                                    <button class="delete-btn" onclick="deleteImage(this)">x</button>
                                </div>
                            </div>
                        </div>

                        <!-- Room Image Section -->
                        <c:set var="homestay" value="${sessionScope.homestay_register}"/>
                        <c:if test="${homestay!=null}">                           
                            <div class="mb-3">
                                <h5 class="mb-3">Upload Room Image</h5>
                                <div class="d-flex flex-wrap"> 
                                    <c:set var="rooms" value="${RoomDAO.getRoomsOfHomestay(homestay.getHt_id())}"/>
                                    <c:forEach var="room" items="${rooms}">
                                        <div class="room-container m-2">
                                            <div class="upload-box">
                                                <input name="${room.getRoom_id()}" type="file" accept="image/*" onchange="previewImage(event, this)" required>
                                                <img alt="Room Image 1">
                                                <button class="delete-btn" onclick="deleteImage(this)">x</button>
                                            </div>
                                            <p class="room-name">${room.getRoom_name()}</p>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <button class="btn btn-continue">Finish</button>
                    </div>
                </form>
                <div class="col-md-4">
                    <div class="sidebar">
                        <div class="help-box">
                            <h6>Need Help Adding Photos?</h6>
                            <p>We can send you a free SMS to log you into your Homestay account on your mobile phone. <a href="#">Add photos from your phone</a></p>
                            <p>We can add your photos for you, just attach them in an email and send them to us. <a href="#">Email us with your photos</a></p>
                        </div>
                        <div class="tips-box">
                            <h6>Tips for Great Photos</h6>
                            <ul>
                                <li>Tidy up and remove any clutter!</li>
                                <li>Take photos during daytime or light up the room</li>
                                <li>Take your photos in landscape format</li>
                                <li>Highlight unique features in your home and surrounds</li>
                            </ul>
                        </div>
                        <div class="info-box">
                            <h6>Question? Get in Touch:</h6>
                            <p>Email us at <a href="mailto:hostsupport@homestay.com">hostsupport@homestay.com</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                                        function previewImage(event, input) {
                                            const file = input.files[0];
                                            if (file) {
                                                const reader = new FileReader();
                                                reader.onload = function (e) {
                                                    const img = input.nextElementSibling;
                                                    img.src = e.target.result;
                                                    img.style.display = 'block';
                                                    const deleteBtn = img.nextElementSibling;
                                                    deleteBtn.style.display = 'flex';
                                                }
                                                reader.readAsDataURL(file);
                                            }
                                        }

                                        function deleteImage(button) {
                                            const uploadBox = button.parentElement;
                                            const img = uploadBox.querySelector('img');
                                            const input = uploadBox.querySelector('input[type="file"]');
                                            img.src = '';
                                            img.style.display = 'none';
                                            input.value = '';
                                            button.style.display = 'none';
                                        }
        </script>
    </body>
</html>
