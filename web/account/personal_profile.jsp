<%-- 
    Document   : personal_profile
    Created on : May 23, 2024, 7:15:45 PM
    Author     : PC
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">
        <!-- Latest compiled JavaScript -->
        <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/main.css" />
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/personal_profile.css" />    
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
              rel='stylesheet'>
    </head>
    <body>
        <div class="container light-style flex-grow-1 container-p-y">
            <h4 class="mb-4">Account settings</h4>
            <div class="card overflow-hidden">
                <div class="row no-gutters row-bordered row-border-light">
                    <div class="col-md-3 pt-0">
                        <div class="list-group list-group-flush account-settings-links">
                            <a href="#account-info" class="list-group-item list-group-item-action active" data-toggle="list">Info</a>
                            <a href="#change-pass" class="list-group-item list-group-item-action" data-toggle="list">Change password</a>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="tab-content">
                            <div class="tab-pane fade ${param.tab == 'info' || param.tab == null ? 'active show' : ''}" id="account-info">
                                <div class="card-body media align-items-cente">
                                    <img id="avatar_img" src="${sessionScope.account.getAvatar_img()}" alt="alt" class="d-block ui-w-80"/>
                                    <form action="${pageContext.request.contextPath}/uploadimg" method="post" class="media-body ml-4" enctype="multipart/form-data">
                                        <label class="btn btn-outline-primary">
                                            Upload new photo
                                            <input type="file" name="img_file" id="input_file" class="account-settings-fileinput">
                                        </label>&nbsp;
                                        <button type="submit" class="btn btn-default md-btn-flat" onclick="disableButton(event)">Change</button>                                   
                                    </form>
                                </div>
                                <hr class="border-light m-0">

                                <!--FROM INFOR-->
                                <form class="form" action="${pageContext.request.contextPath}/changeProfile" method="post" id="registrationForm">
                                    <input type="hidden" name="account_id" value="${sessionScope.account.account_id}">
                                    <div class="form-group">
                                        <div class="col-xs-6">
                                            <label for="first_name"><h4>First Name</h4></label>
                                            <input type="text" class="form-control" name="first_name" id="first_name" 
                                                   value="${sessionScope.account.first_name}" required placeholder="First Name">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-6">
                                            <label for="first_name"><h4>Last Name</h4></label>
                                            <input type="text" class="form-control" name="last_name" id="last_name" 
                                                   value="${sessionScope.account.last_name}" required placeholder="Last Name">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-xs-6">
                                            <label for="gender"><h4>Gender</h4></label>
                                            <input type="text" class="form-control" name="gender" id="gender" 
                                                   value="${sessionScope.account.gender}" required placeholder="Gender">
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <div class="col-xs-6">
                                            <label for="phone"><h4>Phone</h4></label>
                                            <input type="text" class="form-control" name="phone" id="phone" value="${sessionScope.account.phone}"
                                                   required   placeholder="enter phone">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-xs-6">
                                            <label for="email"><h4>Email</h4></label>
                                            <input type="email" class="form-control" name="email" 
                                                   id="email" placeholder="you@email.com" value="${sessionScope.account.email}" readonly="" title="enter your email.">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <label for="address"><h4>Address</h4></label>
                                            <input type="text" class="form-control" id="location"
                                                   value="${sessionScope.account.address}" required name="address" placeholder="somewhere" title="enter a location">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <br>
                                            <button class="btn btn-lg btn-success" type="submit"><i class="glyphicon glyphicon-ok-sign"></i> Save</button>
                                            <label style="color: green"> ${ms}</label>
                                        </div>
                                    </div>
                                </form>

                            </div>
                            <div class="tab-pane fade tab-pane fade ${param.tab == 'change-pass' ? 'active show' : ''}" id="change-pass">                               
                                <!--FROM CHANGE PASS-->
                                <form action="${pageContext.request.contextPath}/changePassword" method="post" class="card-body">
                                    <div class="form-group mb-3">
                                        <c:set var="old_pass" value="${requestScope.old_pass}"/>
                                        <c:set var="old_pass_error" value="${requestScope.old_pass_error}"/>
                                        <input name="old_pass" type="password" value="${old_pass}" class="form-control" placeholder="Old password" required>
                                        <small class="error">${old_pass_error}</small>
                                    </div>
                                    <div class="form-group mb-3">
                                        <c:set var="new_pass" value="${requestScope.new_pass}"/>
                                        <input name="new_pass" type="password" value="${new_pass}" class="form-control" placeholder="New password" required>
                                    </div>
                                    <div class="form-group mb-5">  
                                        <c:set var="new_pass_confi" value="${requestScope.new_pass_confi}"/>
                                        <c:set var="new_pass_confi_error" value="${requestScope.new_pass_confi_error}"/>
                                        <input name="new_pass_confi" type="password" value="${new_pass_confi}" class="form-control" placeholder="Confirm new password" required>
                                        <small class="error">${new_pass_confi_error}</small>
                                    </div>
                                    <input class="btn btn-primary mt-5" type="submit" value="Save change" />
                                    <c:set var="request_error" value="${requestScope.request_error}"/>
                                    <small class="error">${request_error}</small>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                                            avatar_img = document.getElementById("avatar_img");
                                            input_file = document.getElementById("input_file");
                                            input_file.onchange = function () {
                                                avatar_img.src = URL.createObjectURL(input_file.files[0]);
                                            }
                                            function disableButton(event) {
                                                var inputFile = document.getElementById("input_file");
                                                if (inputFile.files.length === 0) {
                                                    alert("Please select a file before submitting.");
                                                    event.preventDefault();  // Ngăn chặn việc gửi form nếu không có tệp nào được chọn
                                                } else {
                                                    document.getElementById("changeButton").disabled = true;
                                                    document.getElementById("changeButton").innerText = "Processing...";
                                                }
                                            }
            </script>
    </body>
</html>
