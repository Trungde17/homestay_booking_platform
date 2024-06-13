<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">
        <!-- Latest compiled JavaScript -->
        <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/main.css" />       
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
              rel='stylesheet'>
        <title>Forget Password</title>
        <style>
            body {
                background: url('${pageContext.request.contextPath}/img/login/forgot_password_bg.jpg') no-repeat center center fixed;
                background-size: cover;
                font-family: 'Open Sans', sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .container {
                max-width: 500px;
                width: 100%;
                background: rgba(255, 255, 255, 0.9);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }
            .form-control {
                margin-bottom: 20px;
                position: relative;
            }
            .form-control input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                box-sizing: border-box;
            }
            .form-control small {
                color: #dc3545;
                position: absolute;
                bottom: -20px;
                left: 10px;
                display: none;
            }
            .text-danger {
                color: #dc3545;
                margin-left: 12px;
                text-align: center;
            }
            .card-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: transparent;
                border-top: none;
                padding-top: 20px;
            }
            .card-footer .btn {
                flex: 1;
                margin: 0px 50px;
            }
            .btn-success {
                width: 100%;
                padding: 10px;
                background: #007bff;
                border: none;
                color: #fff;
                border-radius: 5px;
                cursor: pointer;
            }
            .btn-success:hover {
                background: #0056b3;
            }
            .btn-danger {
                color: #007bff;
                margin-left: 500px;
            }
            .btn-danger:hover {
                color:blue;

            }

        </style>
    </head>
    <body>
        <div class="container">
            <h1 class="mb-5">Forgot password</h1>
            <div>
                <h4>Forgot your password?</h4>
                <p style="font-size: 14;" class="text-secondary">Change your password in three easy steps. This will help you to secure your password!</p>
                <ol>
                    <li><small class="text-secondary">Enter your email address below.</small></li>
                    <li><small class="text-secondary">Our system will send you an OTP to your email.</small></li>
                    <li><small class="text-secondary">Enter the OTP on the page.</small></li>
                </ol>

            </div>
            <form action="${pageContext.request.contextPath}/checkemailforgotpass" method="POST">               
                <div class="">
                    <c:set var="email" value="${requestScope.email}"/>
                    <c:set var="fail_request" value="${requestScope.fail_request}"/>    
                    <c:set var="email_error" value="${requestScope.email_error}"/>
                    <label class="mb-1 text-secondary" for="email"><small> Enter your email address</small></label>
                    <input type="email" name="email" class="form-control form-control-lg fs-6"
                           placeholder="Email" value="${email}" required>
                    <small class="error">${email_error}</small>
                </div>                                  
                <small class="error">${fail_request}</small>
                <div class="d-flex justify-content-between align-items-center">
                    <button class="btn btn-primary" type="submit">Send</button>
                    <a href="${pageContext.request.contextPath}/access/login.jsp" class="">Login</a>
                </div>
            </form>
        </div>
    </body>
</html>
