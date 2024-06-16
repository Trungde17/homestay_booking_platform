

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">
        <!-- Latest compiled JavaScript -->
        <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/login.css" />
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/main.css" />       
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
              rel='stylesheet'>
    </head>
    <body>
        <div class="row vh-100 g-0">
            <!-- left side -->
            <div class="col-lg-6 position-relative">
                <div
                    class="row align-items-center justify-content-center
                    h-100 g-0 px-4 px-sm-0">
                    <div class="col col-sm-6 col-lg-7 col-xl-6">
                        <!-- logo -->
                        <a href="${pageContext.request.contextPath}/index.jsp" class="d-flex justify-content-center"> <img
                                alt="Healing land"
                                src="${pageContext.request.contextPath}/img/project_logo.jpg"
                                width="120">
                        </a>
                        <!-- /logo -->

                        <div class="text-center mb-2">
                            <h3 class="">Login</h3>
                            <p class="text-secondary">Get access to your account</p>
                        </div>
                        <!-- social login -->
                        <button class="btn btn-outline-secondary w-100">
                            <i class='bx bxl-google text-danger me-1 fs-6'></i>Login with
                            Google
                        </button>
                        <!-- /social login -->
                        <!-- divider -->
                        <div class="position-relative">
                            <hr class="text-secondary divider">
                            <div class="divider-content-center">Or</div>
                        </div>
                        <!-- /divider -->

                        <!-- FORM -->
                        <form action="${pageContext.request.contextPath}/login_servlet" method="post">
                            <c:set var="email" value="${requestScope.email}"/>
                            <div class="input-group mb-3">
                                <span class="input-group-text "><i class='bx bx-user'></i></span>
                                <input type="text" name="email" class="form-control form-control-lg fs-6" value="${email}"
                                       placeholder="Email" required>                                
                            </div>
                            <!-- email error  -->
                            <c:set var="email_error" value="${requestScope.email_error}"/>
                            <p class="error">${email_error}</p>
                            <div class="input-group mb-3">
                                <span class="input-group-text "><i class='bx bx-lock-alt'></i></span>
                                <input type="password" name="password" class="form-control form-control-lg fs-6"
                                       placeholder="Password" required>
                            </div>
                            <!-- incorrect account -->
                            <c:set var="incorrect_account" value="${requestScope.incorrect_account}"/>
                            <p class="error">${incorrect_account}</p>
                            <div class="input-group mb-3 d-flex- justify-content-between">
                                <div class="form-check">
                                    <input type="checkbox" id="form-check" class="form-check-input"> <label
                                        for="form-check" class="text-secondary form-check-label"><small>Remember
                                            me</small></label>
                                </div>
                                <div><small><a href="${pageContext.request.contextPath}/access/password/forgotPassword.jsp">Forgot password</a></small></div>
                            </div>
                            <button type="submit" class="btn btn-primary btn-lg w-100 mb-3">LOGIN</button>
                            <div class="text-center"><small>Don't have account? <a href="${pageContext.request.contextPath}/access/signup.jsp" class="fw-both" >Sign up</a></small> </div>
                            
                        </form>
                        <!-- /FORM -->
                    </div>
                </div>
            </div>
            <!-- /left side -->
            <!-- right side -->
            <div class="col-lg-6 position-relative d-none d-lg-block">
                <div class="login-img"
                     style="background-image: url('${pageContext.request.contextPath}/img/login/login_img.jpg');">
                </div>
            </div>
            <!-- /right side -->
        </div>
    </body>
</html>
