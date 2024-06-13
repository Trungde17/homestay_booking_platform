<%-- 
    Document   : request_detail
    Created on : Jun 10, 2024, 2:28:40 PM
    Author     : PC
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="DAO.HomestayDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Yêu Cầu Đăng Ký Homestay</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" />
        <style>
            .clickable-row {
                cursor: pointer;
            }
            .section-title {
                margin-top: 30px;
                margin-bottom: 20px;
                border-bottom: 2px solid #ddd;
                padding-bottom: 10px;
            }
            .img{
                max-width: 500px;
            }
        </style>
    </head>
    <body>
        <%@include file="/admin/header.jsp" %>
        <div class="container mt-4">
            <h1 class="mb-4">Homestay Registration Requirements</h1>
            <c:set var="ht_id" value="${param.homestayId}"/>
            <c:set var="ht" value="${HomestayDAO.getHomestayById(ht_id)}"/>
            <c:set var="owner" value="${ht.getOwner()}"/>
            <!-- Thông tin chủ homestay -->
            <div class="section-title">
                <h3>Information Homestay Owner</h3>
            </div>
            <div class="text-center mb-4">
                <img src="${owner.getAvatar_img()}" alt="Avatar" class="rounded-circle" width="150" height="150">
            </div>
            <table class="table table-bordered">                             
                <p>${i}</p>
                <tbody>
                    <tr>
                        <th>Name</th>
                        <td>${owner.getFirst_name()}</td>
                    </tr>
                    <tr>
                        <th>Gender</th>
                        <td>${owner.getGender()}</td>
                    </tr>
                    <tr>
                        <th>Date of birth</th>
                        <td>${owner.getDate_of_birth()}</td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td>${owner.getAddress()}</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>${owner.getEmail()}</td>
                    </tr>
                    <tr>
                        <th>Phone</th>
                        <td>${owner.getPhone()}</td>
                    </tr>
                </tbody>
            </table>

            <!-- Thông tin homestay đã đăng ký -->
            <!-- Thông tin homestay đã đăng ký -->
            <div class="section-title">
                <h3>Information of Homestay</h3>
            </div>
            <div class="row">
                <c:set var="ht_img" value="${ht.getImg()}"/>
                <c:forEach var="img" items="${ht_img}">
                    <div class="col-md-4 img">
                        <img src="${img.getImg_url()}" class="img-fluid mb-3" alt="Homestay Image 1">
                    </div>                   
                </c:forEach>
            </div>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th>Homestay Name</th>
                        <td>${ht.getHt_name()}</td>
                    </tr>
                    <tr>
                        <th>Homestay Type</th>
                        <td>${ht.getHomestayType().getHomestay_type_name()}</td>
                    </tr>
                    <tr>
                        <th>About</th>
                        <td>${ht.getDescribe()}</td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td>${ht.getFullAddress()}</td>
                    </tr>
                    <tr>
                        <th>Facilities</th>
                        <td>${ht.getFacilitiesString()}</td>
                    </tr>
                    <tr>
                        <th>Neighbourhoods</th>
                        <td>${ht.getNeighbourhoodsString()}</td>
                    </tr>
                    <tr>
                        <th>Registration Date</th>
                        <td>${ht.getRegistration_date()}</td>
                    </tr>
                </tbody>
            </table>

            <!-- Thông tin phòng đã đăng ký -->
            <div class="section-title">
                <h3>Information Of Rooms</h3>
            </div>
            <c:set var="rooms" value="${ht.getRooms()}"/>
            <c:forEach var="room" items="${rooms}">
                <div class="row mb-4">
                    <div class="col-md-4">
                        <img src="${room.getImg().get(0).getImg_url()}" class="img-fluid" alt="Room 1 Image">
                    </div>
                    <div class="col-md-8">
                        <table class="table table-bordered">
                            <tbody>
                                <tr>
                                    <th>Room name</th>
                                    <td>${room.getRoom_name()}</td>
                                </tr>
                                <tr>
                                    <th>Capacity</th>
                                    <td>${room.getCapacity()}</td>
                                </tr>
                                <tr>
                                    <th>Beds</th>
                                    <td>${room.getBedNameString()}</td>
                                </tr>
                                <tr>
                                    <th>Room Facilities</th>
                                    <td>${room.getRoomFacilitiesString()}</td>
                                </tr>
                                <tr>
                                    <th>Prices</th>
                                    <td>
                                        <c:forEach var="price" items="${room.getPrices()}">
                                            ${price.getPrice_name()}: ${price.getAmount()} vnd
                                            <br>
                                        </c:forEach>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>          
            </c:forEach>
            <!-- Nút Chấp Nhận hoặc Từ Chối -->
            <div class="mt-4 text-center">
                <form action="${pageContext.request.contextPath}/homestayapprove" method="post">
                    <input type="hidden" name="homestayId" value="${ht_id}">
                    <button type="submit" name="action" value="approve" class="btn btn-success">Approve</button>
                    <button type="submit" name="action" value="reject" class="btn btn-danger">Reject</button>
                </form>
            </div>
        </div>

        <%@include file="/admin/footer.jsp" %>
