<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="d-flex" id="wrapper">
    <!-- Sidebar -->
    <div class="bg-dark border-right" id="sidebar-wrapper">
        <div class="sidebar-heading text-white">Admin Dashboard</div>
        <div class="list-group list-group-flush">
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="list-group-item list-group-item-action bg-dark text-white"><small>Dashboard</small></a>
            <a href="${pageContext.request.contextPath}/admin/ht_register_approve/list_request.jsp" class="list-group-item list-group-item-action bg-dark text-white"><small>Yêu cầu đăng ký</small></a>
            <a href="${pageContext.request.contextPath}/users.jsp" class="list-group-item list-group-item-action bg-dark text-white"><small>Users</small></a>
            <a href="${pageContext.request.contextPath}/properties.jsp" class="list-group-item list-group-item-action bg-dark text-white"><small>Properties</small></a>
            <a href="${pageContext.request.contextPath}/settings.jsp" class="list-group-item list-group-item-action bg-dark text-white"><small>Settings</small></a>
        </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">
        <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
            <button class="btn btn-primary" id="menu-toggle">
                <i class="bi bi-list"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Link</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Admin
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Profile</a>
                            <a class="dropdown-item" href="#">Settings</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Logout</a>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>

