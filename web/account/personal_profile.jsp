<%-- 
    Document   : personal_profile
    Created on : May 23, 2024, 7:15:45 PM
    Author     : PC
--%>

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
                            <div class="tab-pane fade active show" id="account-info">
                                <div class="card-body media align-items-cente">
                                    <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="alt" class="d-block ui-w-80"/>
                                    <div class="media-body ml-4">
                                        <label class="btn btn-outline-primary">
                                            Upload new photo
                                            <input type="file" class="account-settings-fileinput">
                                        </label>&nbsp;
                                        <button type="button" class="btn btn-default md-btn-flat">Reset</button>                                   
                                    </div>
                                </div>
                                <hr class="border-light m-0">
                                
                                <!--FROM INFOR-->
                                <form action="" method="" class="card-body">
                                    <div class="form-group">
                                        <label class="form-label">First name</label>
                                        <input type="text" class="form-control mb-1" value="">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Last name</label>
                                        <input type="text" class="form-control" value="">
                                    </div>

                                    <input class="btn btn-primary mt-5" type="submit" value="Save change" />
                                </form>
                                
                            </div>
                            <div class="tab-pane fade" id="change-pass">
                                
                                <!--FROM CHANGE PASS-->
                                <form action="" method="" class="card-body">
                                    <div class="form-group pb-2">
                                        <label class="form-label">Current password</label>
                                        <input type="password" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">New password</label>
                                        <input type="password" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Repeat new password</label>
                                        <input type="password" class="form-control">
                                    </div>
                                    <input class="btn btn-primary mt-5" type="submit" value="Save change" />
                                </form>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
            <script type="text/javascript">

    </script>
    </body>
</html>
