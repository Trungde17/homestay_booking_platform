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
        </style>
    </head>
    <body>
        <%@include file="/admin/header.jsp" %>
        <div class="container mt-4">
            <h1 class="mb-4">Chi Tiết Yêu Cầu Đăng Ký Homestay</h1>

            <!-- Thông tin chủ homestay -->
            <div class="section-title">
                <h3>Thông Tin Chủ Homestay</h3>
            </div>
            <div class="text-center mb-4">
                <img src="path_to_avatar.jpg" alt="Ảnh Đại Diện" class="rounded-circle" width="150" height="150">
            </div>
            <table class="table table-bordered">              
                <c:set var="ht_id" value="${param.homestayId}"/>
                <c:set var="ht" value="${HomestayDAO.getHomestayById(ht_id)}"/>
                <c:set var="owner" value="${ht.getOwner()}"/>
                <p>${i}</p>
                <tbody>
                    <tr>
                        <th>Name</th>
                        <td>${owner.getFirst_name()}</td>
                    </tr>
                    <tr>
                        <th>Giới Tính</th>
                        <td>Nam</td>
                    </tr>
                    <tr>
                        <th>Năm Sinh</th>
                        <td>1990</td>
                    </tr>
                    <tr>
                        <th>Địa Chỉ</th>
                        <td>123 Đường ABC, Quận 1, TP. Hồ Chí Minh</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>nguyenvana@example.com</td>
                    </tr>
                    <tr>
                        <th>Phone</th>
                        <td>0123456789</td>
                    </tr>
                    <tr>
                        <th>Số Payment</th>
                        <td>9876543210</td>
                    </tr>
                </tbody>
            </table>

            <!-- Thông tin homestay đã đăng ký -->
            <div class="section-title">
                <h3>Thông Tin Homestay</h3>
            </div>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th>Tên Homestay</th>
                        <td>Homestay XYZ</td>
                    </tr>
                    <tr>
                        <th>Địa Chỉ</th>
                        <td>456 Đường DEF, Quận 2, TP. Hồ Chí Minh</td>
                    </tr>
                    <tr>
                        <th>Ngày Đăng Ký</th>
                        <td>2024-06-10</td>
                    </tr>
                    <tr>
                        <th>Mô Tả</th>
                        <td>Một homestay đẹp với đầy đủ tiện nghi.</td>
                    </tr>
                </tbody>
            </table>

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
