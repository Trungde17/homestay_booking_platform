<%-- 
    Document   : img_upload
    Created on : Jun 16, 2024, 11:57:51 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="${pageContext.request.contextPath}/uploadimghomestay" method="POST" enctype="multipart/form-data">
            <input type="number" name="ht_id" required>
            <input type="file" name="img">
            <input type="submit" value="Save">
        </form>
    </body>
</html>
