<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Room</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestay/manage/infor.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestay/manage/menu.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block sidebar">
                    <jsp:include page="menu.jsp" />
                </nav>
                <div class="col-md-9 ml-sm-auto col-lg-10 content">
                    <c:set var="room" value="${sessionScope.room}"/>
                    <h2 class="mb-4">Edit Room</h2>

                    <!-- Room Name and Description -->
                    <div class="form-section">
                        <h4>Basic Information</h4>
                        <div>
                            <div class="form-row">
                                <form action="${pageContext.request.contextPath}/editRoom?action=name" method="POST" class="form-group col-md-6">
                                    <label for="roomName">Name</label>
                                    <input name="room_name" type="text" class="form-control" id="roomName" placeholder="Enter Room Name" value="${room.room_name}">
                                    <button type="submit" class="btn btn-primary mt-2">Save</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/editRoom?action=description" method="POST" class="form-group col-md-6">
                                    <label for="roomDescription">Description</label>
                                    <textarea name="room_description" class="form-control" id="roomDescription" rows="1" placeholder="Enter Room Description">${room.room_description}</textarea>
                                    <button type="submit" class="btn btn-primary mt-2">Save</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Room Capacity and Size -->
                    <div class="form-section">
                        
                        <div>
                            <div class="form-row">
                                <form action="${pageContext.request.contextPath}/editRoom?action=capacity" method="POST" class="form-group col-md-6">
                                    
                                        <label for="roomCapacity">Capacity</label>
                                        <input name="capacity" type="number" class="form-control" id="roomCapacity" placeholder="Enter capacity" value="${room.capacity}">
                                    
                                    <button type="submit" class="btn btn-primary mt-2">Save</button>
                                </form>

                               
                                <form action="${pageContext.request.contextPath}/editRoom?action=size" method="POST" class="form-group col-md-6">
                                    
                                        <label for="roomSize">Size</label>
                                        <input name="size" type="text" class="form-control" id="roomSize" value="${room.size}">

                                    <button type="submit" class="btn btn-primary mt-2">Save</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- facilites-->
                    <div class="form-section">
                        <c:set var="fa" value="${RoomFacilitiesDAO.getRoomFacilities(room.room_id)}"/>
                        <h4>Facilities</h4>
                        <form action="${pageContext.request.contextPath}/editRoom?action=facilities" method="POST">
                            <div class="row">
                                <c:forEach var="fa" items="${fa}" varStatus="status">
                                    <div class="form-check col-md-3">
                                        <input class="form-check-input" type="checkbox" id="facility ${fa.facilities_id}" name="facilities" value="${fa.facilities_id}"
                                               ${room.checkFacilities(fa.facilities_id) ? 'checked' : ''}>
                                        <label class="form-check-label" for="${fa.facilities_id}">${fa.facilities_name}</label>
                                    </div>
                                </c:forEach>
                            </div>
                            <button type="submit" class="btn btn-primary mt-3">Save</button>
                        </form>
                    </div>


                    <!-- Room IMage -->
                    <div class="form-section">
                        <h4>Images</h4>
                        <c:set var="imgs" value="${room.img}"/>
                        <div class="row">
                            <c:forEach var="img" items="${imgs}" varStatus="status">
                                <div class="col-md-4 mb-3">
                                    <form action="${pageContext.request.contextPath}/editRoom?action=img" method="POST" enctype="multipart/form-data">
                                        <div class="image-square" onclick="document.getElementById('image${status.index}').click()">
                                            <input type="hidden" name="img_id" value="${img.img_id}">
                                            <img src="${img.img_url}" alt="Homestay Image ${status.index}" id="img${status.index}" data-id="${status.index}" data-url="${img.img_url}">
                                            <input name="img_file" type="file" id="image${status.index}" accept="image/*" onchange="handleImageChange(event, 'img${status.index}')" required>
                                            <button type="button" class="remove-image" onclick="removeImage(event, 'img${status.index}', 'image${status.index}')">&times;</button>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Save</button>
                                    </form>
                                </div>
                                <c:if test="${status.index % 3 == 2}">
                                </div><div class="row">
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Room bed  -->
                    <div class="form-section">
                        <h4>Beds</h4>
                        <c:set var="roomBeds" value="${BedDAO.getBedsOfRoom(room.room_id)}"/>
                        <form action="${pageContext.request.contextPath}/editRoom?action=beds" method="POST">
                            <input type="hidden" name="room_id" value="${room.room_id}">
                            <div class="row">
                                <c:forEach var="entry" items="${roomBeds}" varStatus="status">
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" 
                                                   id="${entry.key.bed_type_id}" 
                                                   name="beds" 
                                                   value="${entry.key.bed_type}"
                                                   ${entry.value > 0 ? 'checked' : ''}>
                                            <label class="form-check-label" for="bed${entry.key.bed_id}">
                                                ${entry.key.bed_type}
                                            </label>
                                            <input type="number" name="bedCount${entry.key.bed_id}" 
                                                   value="${entry.value}" min="0" max="10" 
                                                   ${entry.value > 0 ? '' : 'disabled'}>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <button type="submit" class="btn btn-primary mt-3">Save</button>
                        </form></div>
                    <!-- status  -->
                    <div class="form-section">
                        <h4>Status</h4>
                        <form action="${pageContext.request.contextPath}/editRoom?action=status" method="POST" class="d-flex align-items-center">
                            <input type="hidden" name="room_status" value="true">
                            <input type="checkbox" name="room_status" value="false" ${room.status == true ? 'checked' : ''} data-toggle="toggle" data-on="Active" data-off="Inactive" data-onstyle="success" data-offstyle="danger">
                            <button type="submit" class="btn btn-primary ml-2">Save</button>
                        </form>
                    </div>


                </div>
                <script>
                    function handleImageChange(event, imgId) {
                        const input = event.target;
                        const reader = new FileReader();
                        reader.onload = function () {
                            const img = document.getElementById(imgId);
                            img.src = reader.result;
                        };
                        reader.readAsDataURL(input.files[0]);
                    }

                    function removeImage(event, imgId, inputId) {
                        event.stopPropagation(); // Prevent the parent click event
                        document.getElementById(imgId).src = '';
                        document.getElementById(inputId).value = '';
                    }
                </script>
                <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
                </body>
                </html>
