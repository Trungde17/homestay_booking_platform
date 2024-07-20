<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="sidebar.css">
<div class="sidebar-sticky">
    <h5 class="sidebar-heading ht-name">Homestay Beach View</h5>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/homestay/homestay_manage/infor.jsp">Homestay Info</a>
        </li>
        <li class="nav-item">
            <a id="bookingsLink" class="nav-link" href="javascript:void(0);" onclick="toggleSubmenu()">Bookings</a>
            <ul id="bookingsSubmenu" class="nav flex-column ml-3" style="display: none;">
                <li class="nav-item">
                    <a class="nav-link submenu" href="${pageContext.request.contextPath}/homestay/homestay_manage/bookings.jsp?page=paid">Paid</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link submenu" href="${pageContext.request.contextPath}/homestay/homestay_manage/bookings.jsp?page=current_stay">Current stays</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link submenu" href="${pageContext.request.contextPath}/homestay/homestay_manage/bookings.jsp?page=completed">Completed</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link submenu" href="${pageContext.request.contextPath}/homestay/homestay_manage/bookings.jsp?page=canceled">Canceled</a>
                </li>
            </ul>
        </li>
        
         
        
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/homestay/homestay_manage/revenue.jsp">Homestay revenue</a>
        </li>
        
         <li class="nav-item">
            <a id="roomsLink" class="nav-link" href="javascript:void(0);" onclick="toggleSubmenu('roomsSubmenu')">Rooms</a>
            <ul id="roomsSubmenu" class="nav flex-column ml-3" style="display: none;">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/owner/addRoom.jsp">Add Rooms</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/owner/Room_Information.jsp">Update Rooms</a>
                </li>
            </ul>
        </li>
        <!--

          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/owner/Room_Information.jsp"> Rooms</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/owner/addRoom.jsp">Add Rooms</a>
        </li>-->
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Back to home</a>
        </li>
    </ul>
</div>

<script>
    function toggleSubmenu() {
        var submenu = document.getElementById("bookingsSubmenu");
        if (submenu.style.display === "none") {
            submenu.style.display = "block";
        } else {
            submenu.style.display = "none";
        }
    }
     function toggleSubmenu(id) {
        var submenu = document.getElementById(id);
        if (submenu.style.display === "none") {
            submenu.style.display = "block";
        } else {
            submenu.style.display = "none";
        }
    }
</script>
