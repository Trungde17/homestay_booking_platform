<%-- 
    Document   : update.jsp
    Created on : Jul 8, 2024, 7:27:59 PM
    Author     : ASUS
--%>

<!-- update.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Account</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        h2 {
            color: #333;
        }

        .message {
            color: #1e90ff;
            font-size: 18px;
            border: 1px solid #1e90ff;
            padding: 10px;
            border-radius: 5px;
            background-color: #e6f7ff;
            width: 60%;
            text-align: center;
        }

        .btn {
            display: inline-block;
            font-size: 16px;
            padding: 10px 20px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h2>Update Account</h2>
    
    <div class="message">
        Tài khoản của bạn đang trong quá trình xác nhận từ admin. Vui lòng chờ xác minh hoàn tất.
    </div>
    
    <a href="${pageContext.request.contextPath}/index.jsp" class="btn">Back to home</a>
</body>
</html>
