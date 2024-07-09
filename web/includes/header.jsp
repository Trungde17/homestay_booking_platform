<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DTO.homestay.HomestaySummaryDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="account" value="${sessionScope.account}"/>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <div class="container nav-content h-100">
        <a class="navbar-brand" href="#"><img src="${pageContext.request.contextPath}/img/project_logo.jpg" alt="logo"/></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#">Destinations</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Inspire Me</a>
                </li>                        
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/help/help.jsp">Help</a>
                </li>
                <c:if test="${account.getRole_account() == 1}">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/index.jsp" aria-expanded="false">
                        Dashboard
                    </a>
                </c:if>
                <c:if test="${account != null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="homestayDropdown" role="button" onclick="toggleDropdown('homestayList')" aria-expanded="false">
                            My Homestay
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="homestayDropdown" id="homestayList" style="display: none;">
                            <c:set var="homestaySummarys" value="${HomestaySummaryDTO.getAllHomestaySummaryDTO(account.getAccount_id())}"/>
                            <c:forEach var="ht_summary" items="${homestaySummarys}">
                                <li><a class="dropdown-item homestay-item" href="#" onclick="postToManageHomestay('${ht_summary.getHomestay_id()}')">
                                        <i class='homestay-icon bx bx-home-smile'></i>${ht_summary.getHomestay_name()}</a></li>
                            </c:forEach>
                            <c:if test="${account.getRole_account() == 3}">
                                <li>
                                    <a class="dropdown-item create-homestay" href="${pageContext.request.contextPath}/account/upgradeToHost.jsp">
                                        <i class="homestay-icon bx bx-plus-circle"></i> Upgrade to Host
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${account.getRole_account() == 2}">
                                <li>
                                    <a class="dropdown-item create-homestay" href="${pageContext.request.contextPath}/homestay/homestay_register/step1.jsp">
                                        <i class="homestay-icon bx bx-plus-circle"></i> New Homestay
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button" onclick="toggleDropdown('profileList')" aria-expanded="false">
                            My Profile
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="profileDropdown" id="profileList" style="display: none;">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/account/personal_profile.jsp">Personal Profile</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/booking_history">Booking History</a></li>
                            <li class="nav-item">
                        <form action="${pageContext.request.contextPath}/LogoutSeverlet" method="post">
                            <button type="submit" class="nav-link">Log Out</button>
                        </form>
                    </li>
                        </ul>
                    </li>
                    
                </c:if>
                <c:if test="${account == null}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/access/signup.jsp">Sign Up</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/access/login.jsp">Log In</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>  
<script>
    function toggleDropdown(elementId) {
        const element = document.getElementById(elementId);
        if (element.style.display === 'none') {
            element.style.display = 'block';
        } else {
            element.style.display = 'none';
        }
    }

    function postToManageHomestay(homestayId) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = `${window.location.origin}${pageContext.request.contextPath}/homestay/homestay_manage/approveBookings.jsp`;

        const hiddenField = document.createElement('input');
        hiddenField.type = 'hidden';
        hiddenField.name = 'ht_id';
        hiddenField.value = homestayId;

        form.appendChild(hiddenField);
        document.body.appendChild(form);
        form.submit();
    }
</script>
