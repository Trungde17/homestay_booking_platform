<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <h2 class="text-center ht-name">${homestay_summary.getHomestay_name()}</h2>
    <a href="${pageContext.request.contextPath}/homestay/homestay_manage/Bookings.jsp">Approve Bookings</a>
    <a href="${pageContext.request.contextPath}/homestay/homestay_manage/editHomestayRoom.jsp">Homestay Info</a>
</div>
