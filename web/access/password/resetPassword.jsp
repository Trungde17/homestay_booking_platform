
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset password</title>
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
        <style>
            .centered-form {
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }
        </style>
    </head>
    <body>
        <div class="container centered-form">
            <div class="card p-4">
                <h2 class="text-center mb-4">Reset Password</h2>
                <form action="${pageContext.request.contextPath}/resetpassword" method="post">       
                    <c:set var="pass" value="${requestScope.pass}"/>
                    <div class="mb-3">
                        <input type="password" name="pass" class="form-control" placeholder="Enter new password" required>
                    </div>
                    <c:set var="pass_conf" value="${requestScope.pass_conf}"/>
                    <div class="mb-3">
                        <input type="password" name="pass_conf" class="form-control" placeholder="Confirm new password" required>
                    </div>
                    <c:set var="pass_conf_error" value="${pass_conf_error}"/>
                    <c:set var="resetPasswordFail" value="${resetPasswordFail}"/> 
                    <small class="error">${pass_conf_error}</small>
                    <small class="error">${resetPasswordFail}</small>
                    <button type="submit" class="btn btn-primary w-100">Enter</button>
                </form>
            </div>
        </div>
    </body>
</html>
