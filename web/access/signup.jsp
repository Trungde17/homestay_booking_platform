<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
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
        <title>Login Form</title>
        <style>
            body {
                background: url('${pageContext.request.contextPath}/img/danang.jpg') no-repeat center center fixed;
                background-size: cover;
                font-family: 'Open Sans', sans-serif;
            }
            .container {
                max-width: 500px;
                margin: 50px auto;
                padding: 20px;
                background: rgba(255, 255, 255, 0.9); /* White background with transparency */
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }
            .form-control {
                display: flex;
                justify-content: space-between;
                text-align: center;
                margin-bottom: 20px;
            }
            .form-control input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            .form-control small {
                color: #dc3545;
                display: none;
            }
            .btn-submit {
                width: 100%;
                padding: 10px;
                background: #007bff;
                border: none;
                color: #fff;
                border-radius: 5px;
                cursor: pointer;
            }
            .btn-submit:hover {
                background: #0056b3;
            }
            .signup-link {
                text-align: center;
                margin-top: 20px;
            }
            .signup-link a {
                color: #007bff;
                text-decoration: none;
            }
            .signup-link a:hover {
                text-decoration: underline;
            }
            .text-danger {
                color: #dc3545;
            }
            
        </style>
    </head>
    <body>
        <div class="container">
            <h1 class="mt-5 mb-5">Sign Up</h1>
            <form action="${pageContext.request.contextPath}/sigupservlet" method="post" class="form-signup">
                <div class="form-control">
                    <c:set var="first_name" value="${requestScope.first_name}"/>
                    <div >
                        <input name="first_name" type="text" placeholder="First name" value="${first_name}" required>
                    </div>
                    <c:set var="last_name" value="${requestScope.last_name}"/>
                    <div>
                        <input name="last_name" type="text" placeholder="Last name" value="${last_name}" required>
                    </div>
                    <small></small>
                </div>
                <c:set var="email" value="${requestScope.email}"/>
                <c:set var="email_error" value="${requestScope.email_error}"/>
                <div class="form-control">
                    <input name="email" class="input_email" type="email" placeholder="Email" value="${email}" required>
                </div>
                <p class="error">${email_error}</p>
                <c:set var="pass" value="${requestScope.pass}"/>
                <div class="form-control">
                    <input name="pass" type="password" placeholder="Password" value="${pass}" required>
                    <small></small>
                </div>
                <c:set var="pass_conf" value="${requestScope.pass_conf}"/>
                <c:set var="pass_conf_error" value="${requestScope.pass_conf_error}"/>
                <div class="form-control">
                    <input name="pass_conf" type="password" placeholder="Confirm password" value="${pass_conf}" required>
                    <small class="error"></small>
                </div>
                <p class="error">${pass_conf_error}</p>
                <div class="input-group mb-3 d-flex justify-content-between">
                    <div class="form-check">
                        <input type="checkbox" id="form-check" class="form-check-input" required> <label
                            for="form-check" class="text-secondary form-check-label"><small class="accept">I accept the Terms and Conditions and Privacy Statement
                                </small></label>
                    </div>                    
                </div>  
                    <c:set var="signup_failed" value="${requestScope.signup_failed}"/>
                    <p class="error">${signup_failed}</p>
                <button class="btn-submit" type="submit">Sign up</button>
                <div class="signup-link">
                    You have account?
                    <a href="login.jsp">Log in</a>
                </div>
            </form>
            <br>
        </div>  
    </body>
</html>
