

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Enter OTP</title>
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
    <body>
        <div class="container centered-form">
            <div class="card p-4">
                <h2 class="text-center mb-4">Enter OTP</h2>
                <form action="${pageContext.request.contextPath}/verifyotpcode" method="post">
                    <c:set var="otp_code" value="${requestScope.otp_code_enter}"/>
                    <div class="mb-3">                       
                        <input type="text" class="form-control" name="otp_code" value="${otp_code}" placeholder="Enter your OTP" maxlength="6" required>   
                        <c:set var="otp_code_error" value="${requestScope.otp_code_error}"/>
                        <small class="error">${otp_code_error}</small>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Verify</button>
                </form>
            </div>
        </div>
    </div>
</body>
</body>
</html>
