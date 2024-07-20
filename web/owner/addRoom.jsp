<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DAO.BedDAO"%>
<%@ page import="DAO.RoomFacilitiesDAO"%>
<%@ page import="DAO.RoomDAO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Room</title>
    <style>
        /* Styles */
        :root {
            --primary-color: #007bff;
            --secondary-color: #6c757d;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --light-color: #f8f9fa;
            --dark-color: #343a40;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: var(--dark-color);
        }

        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }

        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin: 30px 0;
        }

        .form-container h2, .form-container h4 {
            color: var(--dark-color);
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            transition: border-color 0.3s ease-in-out;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            outline: none;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-align: center;
            text-decoration: none;
            color: white;
            transition: background-color 0.3s ease-in-out;
        }

        .btn-save {
            background-color: var(--success-color);
        }

        .btn-save:hover {
            background-color: darken(var(--success-color), 10%);
        }

        .btn-link {
            color: var(--primary-color);
            text-decoration: none;
            font-size: 14px;
        }

        .btn-link:hover {
            text-decoration: underline;
        }

        .card {
            border: 1px solid #ced4da;
            border-radius: 10px;
            transition: box-shadow 0.3s;
        }

        .card:hover {
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .card-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .form-check-input {
            margin-right: 10px;
        }

        .form-check-label {
            cursor: pointer;
        }

        .room-facilities, .bed-input {
            margin-bottom: 20px;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            margin-right: -15px;
            margin-left: -15px;
        }

        .col-sm-6, .col-md-4, .col-sm-8 {
            padding-right: 15px;
            padding-left: 15px;
            flex: 1;
            max-width: 50%;
        }

        .col-md-4 {
            max-width: 33.3333%;
        }

        #add-bed, #remove-bed {
            display: block;
            margin-top: 10px;
        }

        .bed-select {
            width: 100%;
        }

        .font-weight-bold {
            font-weight: bold;
        }
    </style>
</head>
<body>
                 
            
            <h4>Create new room</h4>
                <hr>
                <form action="${pageContext.request.contextPath}/AddRoomSeverlet" method="POST" enctype="multipart/form-data">
                    
    <div class="row mb-3">
        <div class="form-group col-sm-8">
            <label for="bedroomName" class="font-weight-bold">Room Name*</label>
            <input name="room_name" type="text" class="form-control" id="bedroomName" placeholder="Enter Room name"value="${room.room_name}"  required>
        </div>
        
        <div class="form-group col-sm-8">
            <label for="description" class="font-weight-bold">Description </label>
            <input name="description" type="text" class="form-control" id="description" placeholder="Enter Description" value="${room.room_description}"required>
        </div>
        <div class="form-group col-sm-4">
            <label for="size" class="font-weight-bold">size</label>
            <input name="size" type="text" class="form-control" id="size" placeholder="Enter Room size"value="${room.size}" required>
        </div>
        
        
        <div class="form-group col-sm-4">
            <label for="numGuests" class="font-weight-bold">Number of guests*</label>
            <select name="capacity" class="form-control" id="numGuests" onchange="togglePriceForTwo()">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
            </select>
        </div>
    </div>

    <div>
        <p class="font-weight-bold">Add beds*</p>
    </div>                   

    <div id="bed-container">
        <c:set var="bed_type_list" value="${BedDAO.getAllBedType()}"/>
        <div class="form-group row bed-input">
            <div class="col-sm-6">
                <select name="bed" class="form-control bed-select">
                    <c:forEach var="bed_type" items="${bed_type_list}">
                        <option value="${bed_type.getBed_id()}">${bed_type.getBed_type()}</option>    
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>
    <div class="form-group row">
        <a href="#" class="btn btn-link" id="add-bed"><small>Add another bed</small></a>
        <a href="#" class="btn btn-link" id="remove-bed" style="display: none;"><small>Remove bed</small></a>
    </div>
    <p class="font-weight-bold">Room Facilities*</p>

    <c:set var="facilities_list" value="${RoomFacilitiesDAO.getAll()}"/>
    <div class="row mb-3"> 
        <c:forEach var="facilities" items="${facilities_list}" varStatus="status">
            <c:choose>
                <c:when test="${status.index % 2 == 0}">
                    <div class="col-md-6">                                        
                        <div class="form-check">
                            <input name="room_facilities" class="form-check-input" type="checkbox" id="${facilities.getFacilities_id()}" value="${facilities.getFacilities_id()}" >
                            <label class="form-check-label text-muted" for="${facilities.getFacilities_id()}">${facilities.getFacilities_name()}</label>
                        </div>                                               
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="col-md-6">
                        <div class="form-check">
                            <input name="room_facilities" class="form-check-input" type="checkbox" id="${facilities.getFacilities_id()}" value="${facilities.getFacilities_id()}" >
                            <label class="form-check-label text-muted" for="${facilities.getFacilities_id()}">${facilities.getFacilities_name()}</label>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
    
    <p class="font-weight-bold">Room Prices*</p>
    <div class="form-group row">
        <div class="col-sm-6">
            <div class="form-group">
                <label for="nightlyPrice1"><small>Price for 1 Person (1 night)</small></label>
                <input name="price_for_one" type="number" class="form-control" id="nightlyPrice1" placeholder="VND" min="1" required>
            </div>               
        </div>
        <div class="col-sm-6" id="priceForTwo" style="display: none;">
            <div class="form-group">
                <label for="nightlyPrice2"><small>Price for 2 (or more) People (1 night)</small></label>
                <input name="price_for_more" type="number" class="form-control" id="nightlyPrice2" placeholder="VND" min="1">
            </div>              
        </div>
    </div>
    
    <div class="form-group">
        <label for="roomImage" class="font-weight-bold">Upload Room Image*</label>
        <input name="room_image" type="file" class="form-control" id="roomImage" accept="image/*" required>
    </div>
    
    <button type="submit" class="btn btn-save">Save Room</button>
    <small class="text-success">${ms}</small>
</form>
        </div>
    </div>
    <script>
        function togglePriceForTwo() {
            var numGuests = document.getElementById("numGuests").value;
            var priceForTwo = document.getElementById("priceForTwo");
            var priceForMoreInput = document.getElementById("nightlyPrice2");

            if (numGuests > 1) {
                priceForTwo.style.display = "block";
                priceForMoreInput.setAttribute("required", "required");
            } else {
                priceForTwo.style.display = "none";
                priceForMoreInput.removeAttribute("required");
            }
        }

        function updateButtons() {
            var bedCount = $('#bed-container .bed-input').length;
            if (bedCount > 1) {
                $('#remove-bed').show();
            } else {
                $('#remove-bed').hide();
            }

            if (bedCount >= 2) {
                $('#add-bed').hide();
            } else {
                $('#add-bed').show();
            }
        }

        $(document).ready(function () {
            updateButtons(); // Initial call to set button visibility

            $('#add-bed').click(function (e) {
                e.preventDefault();
                var bedInput = `
                    <div class="form-group row bed-input">
                        <div class="col-sm-6">
                            <select name="bed" class="form-control bed-select">
                                <c:forEach var="bedType" items="${bedTypes}">
                                    <option value="${bedType.getBed_id()}">${bedType.getBed_type()}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>`;
                $('#bed-container').append(bedInput);
                updateButtons(); // Update button visibility
            });

            $('#remove-bed').click(function (e) {
                e.preventDefault();
                $('#bed-container .bed-input:last').remove();
                updateButtons(); // Update button visibility after removing
            });
        });
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
                };
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