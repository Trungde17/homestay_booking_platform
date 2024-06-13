<%-- 
    Document   : personal_profile
    Created on : May 23, 2024, 7:15:45 PM
    Author     : PC
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/personal_profile.css" />
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }
            .container {
                margin-top: 50px;
            }
            .card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .account-settings-links .list-group-item {
                border: none;
                border-bottom: 1px solid #e9ecef;
                color: #007bff;
                background-color: #f8f9fa;
            }
            .account-settings-links .list-group-item.active {
                background-color: #007bff;
                color: #fff;
            }
            #avatar_img {
                width: 150px;
                height: 150px;
                object-fit: cover;
                border-radius: 50%;
                border: 3px solid #007bff;
                cursor: pointer;
            }
            .btn-outline-primary {
                color: #007bff;
                border-color: #007bff;
            }
            .btn-outline-primary:hover {
                background-color: #007bff;
                color: #fff;
            }
            .form-label {
                font-weight: bold;
            }
            .form-control {
                border-radius: 10px;
                border: 1px solid #007bff;
            }
            .btn-success {
                background-color: #28a745;
                border: none;
            }
            .btn-success:hover {
                background-color: #218838;
            }
            .btn-primary {
                background-color: #007bff;
                border: none;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
            .text-success {
                font-weight: bold;
                color: #28a745;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h4 class="mb-4">Account Settings</h4>
            <div class="card p-4">
                <div class="row g-0">
                    <div class="col-md-3">
                        <div class="list-group list-group-flush account-settings-links">
                            <a href="#account-info" class="list-group-item list-group-item-action active" data-bs-toggle="tab">Info</a>
                            <a href="#change-pass" class="list-group-item list-group-item-action" data-bs-toggle="tab">Change Password</a>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="tab-content">
                            <div class="tab-pane fade show active" id="account-info">
                                <div class="card-body d-flex align-items-center">
                                    <img id="avatar_img" src="${sessionScope.account.getAvatar_img()}" alt="Profile Picture" class="rounded-circle" data-bs-toggle="modal" data-bs-target="#avatarModal">
                                    <form action="${pageContext.request.contextPath}/uploadimg" method="post" enctype="multipart/form-data" class="ms-4">
                                        <label class="btn btn-outline-primary">
                                            Upload New Photo
                                            <input type="file" name="img_file" id="input_file" class="d-none">
                                        </label>
                                        <button type="submit" class="btn btn-default ms-2">Change</button>
                                    </form>
                                </div>
                                <hr class="my-4">
                                <form class="form" action="${pageContext.request.contextPath}/changeProfile" method="post" id="registrationForm">
                                    <input type="hidden" name="account_id" value="${sessionScope.account.account_id}">
                                    <div class="mb-3">
                                        <label for="first_name" class="form-label">First Name</label>
                                        <input type="text" class="form-control" name="first_name" id="first_name" value="${sessionScope.account.first_name}" required placeholder="First Name">
                                    </div>
                                    <div class="mb-3">
                                        <label for="last_name" class="form-label">Last Name</label>
                                        <input type="text" class="form-control" name="last_name" id="last_name" value="${sessionScope.account.last_name}" required placeholder="Last Name">
                                    </div>
                                    <div class="mb-3">
                                        <label for="gender" class="form-label">Gender</label>
                                        <input type="text" class="form-control" name="gender" id="gender" value="${sessionScope.account.gender}" required placeholder="Gender">
                                    </div>
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Phone</label>
                                        <input type="text" class="form-control" name="phone" id="phone" value="${sessionScope.account.phone}" required placeholder="Phone">
                                    </div>
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" name="email" id="email" value="${sessionScope.account.email}" readonly placeholder="Email">
                                    </div>
                                    <div class="mb-3">
                                        <label for="address" class="form-label">Address</label>
                                        <input type="text" class="form-control" id="address" name="address" value="${sessionScope.account.address}" required placeholder="Address">
                                    </div>
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-success">Save</button>
                                        <small class="text-success">${ms}</small>
                                    </div>
                                </form>
                            </div>
                            <div class="tab-pane fade" id="change-pass">
                                <form action="${pageContext.request.contextPath}/changePassword" method="post" class="card-body">
                                    <div class="mb-3">
                                        <input name="old_pass" type="password" value="${requestScope.old_pass}" class="form-control" placeholder="Old Password" required>
                                        <small class="text-danger">${requestScope.old_pass_error}</small>
                                    </div>
                                    <div class="mb-3">
                                        <input name="new_pass" type="password" value="${requestScope.new_pass}" class="form-control" placeholder="New Password" required>
                                    </div>
                                    <div class="mb-3">
                                        <input name="new_pass_confi" type="password" value="${requestScope.new_pass_confi}" class="form-control" placeholder="Confirm New Password" required>
                                        <small class="text-danger">${requestScope.new_pass_confi_error}</small>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                    <small class="text-danger">${requestScope.request_error}</small>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="avatarModal" tabindex="-1" aria-labelledby="avatarModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        <img id="full_avatar_img" src="${sessionScope.account.getAvatar_img()}" alt="Full Profile Picture" class="img-fluid">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.getElementById("input_file").onchange = function () {
                const file = this.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById("avatar_img").src = e.target.result;
                        document.getElementById("full_avatar_img").src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            };
        </script>
    </body>
</html>