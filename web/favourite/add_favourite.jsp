<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="model.Homestay"%>
<%@page import="java.util.List"%>

<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect(request.getContextPath() + "/access/login.jsp");
        return;
    }
%>

<c:set var="favourites" value="${requestScope.favourites}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Favourite Homestays</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Search_homestay.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
   
    <style>      
        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .card-title {
            font-size: 1.25rem;
            font-weight: bold;
        }
        .remove-button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }
        .card {
            cursor: pointer;
        }
        .title {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 40px;
        }
        .back-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 50px;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="title">Your Favourite Homestays</h1>
        <div class="d-flex justify-content-center mb-4">
            <button class="back-button" onclick="goBack()">Back</button>
        </div>
        <c:if test="${empty favourites}">
            <p class="text-center">No favourites found.</p>
        </c:if>
        <div class="row">
            <c:forEach var="homestay" items="${favourites}">
                <div class="col-md-4 mb-4">
                    <div class="card hotel-card" data-id="${homestay.ht_id}" onclick="submitDetailForm(${homestay.ht_id})">
                        <c:if test="${not empty homestay.img}">
                            <img src="${homestay.img[0].img_url}" class="card-img-top" alt="Homestay Image">
                        </c:if>
                        <div class="card-body">
                            <h5 class="card-title"><c:out value="${homestay.ht_name}"/></h5>
                            <p class="card-text">Owner: <c:out value="${homestay.owner.getFullName()}"/></p>
                            <p class="card-text">Description: <c:out value="${homestay.describe}"/></p>
                            <p class="card-text">Address: <c:out value="${homestay.address_detail}"/></p>
                            <form action="${pageContext.request.contextPath}/RemoveFavouriteServlet" method="post">
                                <input type="hidden" name="homestayId" value="${homestay.ht_id}"/>
                                <button type="submit" class="remove-button">Remove</button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
 
     <form id="detailForm" action="${pageContext.request.contextPath}/viewhomestay" method="post" style="display:none;">
        <input type="hidden" name="homestayId" id="hiddenHomestayId">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function submitDetailForm(homestayId) {
            document.getElementById('hiddenHomestayId').value = homestayId;
            document.getElementById('detailForm').submit();
        }
        function goBack() {
            window.location.href = "${pageContext.request.contextPath}/homestaySearch/homestaySearch.jsp";
        }
    </script>
</body>
</html>
