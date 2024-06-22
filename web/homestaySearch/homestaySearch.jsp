<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="DAO.HomestayDAO"%>
<%@page import="model.Homestay"%>
<%@page import="java.util.List"%>
<c:set var="account" value="${sessionScope.account}"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>HealingLand</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/Search_homestay.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>

    <body>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="index.jsp"><img src="${pageContext.request.contextPath}/img/project_logo.jpg" alt="logo"/></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Destinations
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#">Hải Châu</a></li>
                                <li><a class="dropdown-item" href="#">Sơn Trà</a></li>
                                <li><a class="dropdown-item" href="#">Ngũ Hành Sơn</a></li>
                                <li><a class="dropdown-item" href="#">Thanh Khê</a></li>
                                <li><a class="dropdown-item" href="#">Cẩm Lệ</a></li>
                                <li><a class="dropdown-item" href="#">Liên Chiểu</a></li>
                                <li><a class="dropdown-item" href="#">Hòa Vang</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Contact Host</a>
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

        <!-- Hero Section -->
        <section class="hero-section d-flex align-items-center">
            <div class="container text-center">
                <h1 class="welcome-text">Welcome To HealingLand</h1>
                <h1 class="hero-content">Find Your Perfect Homestay</h1>
                <form action="${pageContext.request.contextPath}/searchServlet" method="post" class="search-bar mt-4">
                    <div class="row g-2 align-items-center">
                        <div class="col-md-3 select-wrapper position-relative">
                            <i class="fas fa-map-marker-alt position-absolute"></i>
                            <select class="form-select" name="district">
                                <option value="Hải Châu" ${districtName == 'Hải Châu' ? 'selected' : ''}>Hải Châu</option>
                                <option value="Sơn Trà" ${districtName == 'Sơn Trà' ? 'selected' : ''}>Sơn Trà</option>
                                <option value="Ngũ Hành Sơn" ${districtName == 'Ngũ Hành Sơn' ? 'selected' : ''}>Ngũ Hành Sơn</option>
                                <option value="Thanh Khê" ${districtName == 'Thanh Khê' ? 'selected' : ''}>Thanh Khê</option>
                                <option value="Cẩm Lệ" ${districtName == 'Cẩm Lệ' ? 'selected' : ''}>Cẩm Lệ</option>
                                <option value="Liên Chiểu" ${districtName == 'Liên Chiểu' ? 'selected' : ''}>Liên Chiểu</option>
                                <option value="Hòa Vang" ${districtName == 'Hòa Vang' ? 'selected' : ''}>Hòa Vang</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <input type="date" id="checkIn" class="form-control" value="${checkin}" name="checkIn" placeholder="Check-in">

                        </div>
                        <div class="col-md-3">
                            <input type="date" id="checkOut" class="form-control" value="${checkout}" name="checkOut" placeholder="Check-out">
                        </div>
                        <div class="col-md-2 select-wrapper position-relative">
                            <i class="bi bi-person position-absolute"></i>
                            <select class="form-select" id="guest" name="guests">
                                <option value="1" ${guests == 1 ? "selected" : ""}>1 Guest</option>
                                <option value="2" ${guests == 2 ? "selected" : ""}>2 Guests</option>
                                <option value="3" ${guests == 3 ? "selected" : ""}>3 Guests</option>
                                <option value="4" ${guests == 4 ? "selected" : ""}>4 Guests</option>
                                <option value="5" ${guests == 5 ? "selected" : ""}>5 Guests</option>
                                <option value="6" ${guests == 6 ? "selected" : ""}>6 Guests</option>
                            </select>
                        </div>
                        <div class="col-md-1">
                            <button type="submit" class="btn btn-primary w-100">Search</button>
                        </div>
                    </div>
                </form>
            </div>
        </section>

        <!-- Homestay Listings -->
        <div class="container mt-5">
            <div class="row">
                <c:forEach var="homestay" items="${homestays}">
                    <a href="${pageContext.request.contextPath}/homestay/view_homestay/homestay_block.jsp?ht_id=${homestay.ht_id}" class="col-md-4 mb-4">
                        <div class="card hotel-card" data-id="${homestay.getHt_id()}" onclick="submitDetailForm(this)">
                            <c:if test="${not empty homestay.getImg()}">
                                
                                    <img src="${homestay.img.get(0).getImg_url()}" class="card-img-top" alt="Homestay Image">
                                
                            </c:if>
                            <div class="card-body">
                                <h5 class="card-title"><c:out value="${homestay.getHt_id()}" /></h5>
                                <h5 class="card-title"><c:out value="${homestay.getHt_name()}" /></h5>
                                <p class="card-text">Owner: <c:out value="${homestay.getOwner().getFullName()}" /></p>
                                <p class="card-text">Description: <c:out value="${homestay.getDescribe()}" /></p>
                                <p class="card-text">Address: <c:out value="${homestay.getAddress_detail()} ${homestay.getDistrict().getDistrict_name()}" /></p>                        
                            </div>
                        </div>
                    </a>
                </c:forEach>    
            </div>
        </div>
        <!-- Hidden form for detail navigation -->
        

        <!-- Hidden form for pagination -->
        <form id="paginationForm" action="${pageContext.request.contextPath}/searchServlet" method="post">
            <input type="hidden" name="district" value="${districtName}">
            <input type="hidden" name="checkIn" value="${checkin}">
            <input type="hidden" name="checkOut" value="${checkout}">
            <input type="hidden" name="guests" value="${guests}">
            <input type="hidden" name="page" id="pageInput" value="${currentPage}">
        </form>

        <!-- Pagination links -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="javascript:submitPaginationForm(${currentPage - 1})" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <c:forEach var="i" begin="1" end="${endPage}">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="javascript:submitPaginationForm(${i})">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == endPage ? 'disabled' : ''}">
                    <a class="page-link" href="javascript:submitPaginationForm(${currentPage + 1})" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                const today = new Date().toISOString().split('T')[0];
                                document.getElementById('checkIn').setAttribute('min', today);
                                document.getElementById('checkOut').setAttribute('min', today);
                            });

                            document.getElementById('checkIn').addEventListener('change', function () {
                                const checkInDate = new Date(this.value);
                                const checkOutInput = document.getElementById('checkOut');
                                const checkOutDate = new Date(checkOutInput.value);

                                // Update min attribute of check-out date picker
                                checkOutInput.setAttribute('min', this.value);

                                if (checkOutDate && checkInDate > checkOutDate) {
                                    checkOutInput.value = '';
                                    alert('Check-in date cannot be later than check-out date. Please reselect the dates.');
                                }
                            });

                            document.getElementById('checkOut').addEventListener('change', function () {
                                const checkInDate = new Date(document.getElementById('checkIn').value);
                                const checkOutDate = new Date(this.value);
                                if (checkInDate && checkOutDate < checkInDate) {
                                    document.getElementById('checkIn').value = this.value;
                                    alert('Check-out date cannot be earlier than check-in date. Please reselect the dates.');
                                }
                            });

                            function submitPaginationForm(page) {
                                document.getElementById('pageInput').value = page;
                                document.getElementById('paginationForm').submit();
                            }
                            
        </script>
    </body>
</html>
