<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="account" value="${sessionScope.account}"/>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#"><img src="${pageContext.request.contextPath}/img/project_logo.jpg" alt="logo"/></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
<li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
        Destinations
    </a>
    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
        <li>
            <div class="px-3 py-2">
                <select class="form-select" name="district" id="district" onchange="redirectToSearch()">
                    <option value="Hải Châu">Hải Châu</option>
                    <option value="Sơn Trà">Sơn Trà</option>
                    <option value="Ngũ Hành Sơn">Ngũ Hành Sơn</option>
                    <option value="Thanh Khê">Thanh Khê</option>
                    <option value="Cẩm Lệ">Cẩm Lệ</option>
                    <option value="Liên Chiểu">Liên Chiểu</option>
                    <option value="Hòa Vang">Hòa Vang</option>
                </select>
            </div>
        </li>
    </ul>
</li>


                <li class="nav-item">
                    <a class="nav-link" href="#">Inspire Me</a>
                </li>                        
                <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="helpDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Help
                            </a>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="helpDropdown">
                                <a class="dropdown-item" href="#">General</a>
                                <a class="dropdown-item" href="#">Hosts</a>
                                <a class="dropdown-item" href="#">Guests</a>
                                <a class="dropdown-item" href="#">Messaging</a>
                                <a class="dropdown-item" href="#">Reviews</a>
                                <a class="dropdown-item" href="#">Trust and Safety</a>
                                <a class="dropdown-item" href="#">Invite a Friend</a>
                                <a class="dropdown-item" href="#">Regulatory Compliance</a>
                            </div>
                        </li>
                        <c:if test="${account==null}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/access/signup.jsp">Sign Up</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/access/login.jsp">Log In</a>
                            </li>
                        </c:if>
                        <c:if test="${account!=null}">
                            <li class="nav-item">
                                <a class="nav-link" href="#">Your Homestay</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="accountDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    ${account.getFirst_name()}
                                </a>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="accountDropdown">
                                    <a class="dropdown-item" href="#">Dashboard</a>
                                    <a class="dropdown-item" href="#">Inbox</a>
                                    <a class="dropdown-item" href="#">Trips</a>
                                    <a class="dropdown-item" href="#">Bookings</a>
                                    <a class="dropdown-item" href="#">Verify Me</a>
                                    <a class="dropdown-item" href="#">Invite Friends</a>
                                    <a class="dropdown-item" href="#">List a Room</a>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/account/personal_profile.jsp">Account</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/access/logout.jsp">Logout</a>
                                </div>
                            </li>      
                        </c:if>
                
           
            </ul>
        </div>
    </div>
</nav>
        <script>
function redirectToSearch() {
    // Lấy giá trị của trường input với id 'district'
    var district = document.getElementById('district').value;
    
    // Gán giá trị 1 cho biến guests
    var guests = "1"; 
    
    // Kiểm tra nếu district không rỗng
    if (district) {
        // Tạo URL tới trang search với tham số district và guests
        var searchURL = "${pageContext.request.contextPath}/searchServlet?district=" + district + "&guests=" + guests;
        
        // Chuyển hướng người dùng đến trang search
        window.location.href = searchURL;
    }
}
</script>

