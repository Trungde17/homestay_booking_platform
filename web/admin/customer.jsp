<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.AccountDAO"%>
<%@page import="model.Account"%>
<%@page import="java.util.List" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    if (session == null || session.getAttribute("account") == null) {
        response.sendRedirect(request.getContextPath() + "/access/login.jsp");
    } else {
        Account account = (Account) session.getAttribute("account");
        int role = account.getRole_account(); // Adjust to your actual getter method for role
        
        if (role != 1) { // Assuming role 1 is Admin, redirect if not Admin
            response.sendRedirect(request.getContextPath());
        }
    }
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Admin Dashboard</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
        <link href="./lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="./lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
        <link href="./css/bootstrap.min.css" rel="stylesheet">
        <link href="./css/style.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/dataTables.bootstrap5.min.css">

    </head>

    <body>
        <div class="container-xxl position-relative bg-white d-flex p-0">
            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-light navbar-light">
                    <a href="index.jsp" class="navbar-brand mx-4 mb-3">
                        <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>Dashboard</h3>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="position-relative">
                            <img class="rounded-circle" src="${account.getAvatar_img()}" alt="" style="width: 40px; height: 40px;">
                            <div
                                class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1">
                            </div>
                        </div>
                        <div class="ms-3">
                            <h6 class="mb-0">${account.getFirst_name()}</h6>
                            <span>Admin</span>
                        </div>
                    </div>
                    <div class="navbar-nav w-100">
                        <a href="index.jsp" class="nav-item nav-link "><i
                                class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                        <a href="customer.jsp" class="nav-item nav-link active"><i class="fa fa-table me-2"></i>Customers</a>
                        <a href="owner.jsp" class="nav-item nav-link"><i class="fa fa-table me-2"></i>Owners</a>

                    </div>
                </nav>
            </div>


            <div class="content">
                <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                    <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
                        <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                    </a>
                    <a href="#" class="sidebar-toggler flex-shrink-0">
                        <i class="fa fa-bars"></i>
                    </a>
                    <form class="d-none d-md-flex ms-4">
                        <input class="form-control border-0" type="search" placeholder="Search">
                    </form>
                    <div class="navbar-nav align-items-center ms-auto">
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <img class="rounded-circle me-lg-2" src="${account.getAvatar_img()}" alt=""
                                     style="width: 40px; height: 40px;">
                                <span class="d-none d-lg-inline-flex">${account.getFirst_name()}</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                                <a href="#" class="dropdown-item">My Profile</a>
                                <a href="${pageContext.request.contextPath}" class="dropdown-item">Back to Home</a>
                                <form action="${pageContext.request.contextPath}/LogoutSeverlet" method="post">
                                    <button type="submit" class="dropdown-item">Log Out</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </nav>


                <div class="container-fluid pt-4 px-4">
                    <div class="row g-4">

                        <div class="col-sm-6 col-xl-3">
                            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-area fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Today Revenue</p>
                                    <h6 id="today-revenue"class="mb-0"></h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-xl-3">

                        </div>
                        <div class="col-sm-6 col-xl-3">
                            <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-pie fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Total Revenue</p>
                                    <h6 id="total-revenue" class="mb-0"></h6>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container-fluid pt-4 px-4">
                    <div class="bg-light text-center rounded p-4">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <h6 class="mb-0">Customer List</h6>
                            <a href="">Show All</a>
                        </div>
                        <div class="table-responsive">
                            <table id="customer-table"class="table text-start align-middle table-bordered table-hover mb-0">
                                <thead>
                                    <tr class="text-dark">
                                        <th scope="col">Email</th>
                                        <th scope="col">First Name</th>
                                        <th scope="col">Last Name</th>
                                        <th scope="col">Phone</th>
                                        <th scope="col">Address</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        List<Account> customers = AccountDAO.getAccountsByRole(3); // Fetch normal customers

                                        if (customers != null) {
                                            for (Account customer : customers) {
                                                String status = AccountDAO.getAccountStatusById(customer.getAccount_id());
                                            
                                                String buttonLabel = status.equals("inactive") ? "Unlock" : "Lock";
                                                String action = status.equals("inactive") ? "unlock" : "lock";
                                                String className = status.equals("inactive") ? "btn-primary" : "btn-danger";
                                    %>
                                    <tr>
                                        <td><%= customer.getEmail() %></td>
                                        <td><%= customer.getFirst_name() %></td>
                                        <td><%= customer.getLast_name() %></td>
                                        <td><%= customer.getPhone() %></td>
                                        <td><%= customer.getAddress() %></td>
                                        <td>
                                            <form method="post" action="${pageContext.request.contextPath}/AccountActionServlet">
                                                <input type="hidden" name="accountId" value="<%= customer.getAccount_id() %>">
                                                <input type="hidden" name="status" value="<%= customer.getRole_account() %>">
                                                <input type="hidden" name="action" value="<%= action %>">
                                                <input type="hidden" name="page" value="customer">
                                                <button type="submit" class="btn btn-sm <%= className %>"><%= buttonLabel %></button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%
                                            }
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


            </div>
            <!-- Content End -->


            <!-- Back to Top -->
            <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/chart/chart.min.js"></script>
        <script src="./lib/waypoints/waypoints.min.js"></script>
        <script src="./lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="./lib/tempusdominus/js/moment.min.js"></script>
        <script src="./lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="./lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- DataTables JS -->
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>
        <script src="./js/main.js"></script>
        <script>
            $(document).ready(function () {
                $('#customer-table').DataTable();
                $('#owner-table').DataTable();
            });

            $(document).ready(function () {
                $.ajax({
                    url: '${pageContext.request.contextPath}/RevenueServlet',
                    method: 'GET',
                    success: function (data) {
                        var labels = Object.keys(data.revenueLast10Days);
                        var revenueData = Object.values(data.revenueLast10Days);
                        $('#today-revenue').html(data.todayRevenue + "₫");
                        $('#total-revenue').html(data.totalRevenue + "₫");
                        // Create the chart
                        var ctx3 = $("#line-chart").get(0).getContext("2d");
                        var myChart3 = new Chart(ctx3, {
                            type: "line",
                            data: {
                                labels: labels,
                                datasets: [{
                                        label: "Revenue",
                                        fill: false,
                                        backgroundColor: "rgba(0, 156, 255, .3)",
                                        data: revenueData
                                    }]
                            },
                            options: {
                                responsive: true
                            }
                        });
                    },
                    error: function (error) {
                        console.error('Error fetching revenue data:', error);
                    }
                });
            });
        </script>
    </body>

</html>