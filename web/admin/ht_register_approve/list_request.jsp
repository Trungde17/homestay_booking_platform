<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        </style>
    </head>
    <body>
        <%@include file="/admin/header.jsp" %>

        <div class="container-fluid">
            <h1 class="mt-4">Yêu Cầu Đăng Ký Homestay</h1>
            <table class="table table-striped mt-4">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Owner Name</th>
                        <th>Homestay Name</th>
                        <th>Registration Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <c:set var="homestays" value="${sessionScope.homestays_approve}"/>
                <tbody>
                    <c:forEach var="ht" items="${homestays}" varStatus="status">
                        <tr class="clickable-row" data-id="${ht.getHt_id()}">
                            <td>${status.index+1}</td>
                            <td>${ht.getOwner().getFirst_name()}</td>
                            <td>${ht.getHt_name()}</td>
                            <td>${ht.getRegistration_date()}</td>
                            <td>Chờ duyệt</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <form id="homestayForm" action="${pageContext.request.contextPath}/admin/ht_register_approve/request_detail.jsp" method="post" style="display:none;">
                <input type="hidden" name="homestayId" id="homestayId" value="" />
            </form>
        </div>

        <%@include file="/admin/footer.jsp" %>

        <script>
            document.addEventListener('DOMContentLoaded', (event) => {
                const rows = document.querySelectorAll('.clickable-row');
                const form = document.getElementById('homestayForm');
                const input = document.getElementById('homestayId');
                rows.forEach(row => {
                    row.addEventListener('click', () => {
                        input.value = row.dataset.id;
                        form.submit();
                    });
                });
            });
        </script>
