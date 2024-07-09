<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="account" value="${sessionScope.account}"/>
<c:set var="owner" value="${sessionScope.HostUpgradeRequest}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upgrade to Host</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .back-to-home {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1>Upgrade to Host</h1>
          <% if (request.getAttribute("message") != null) { %>
        <p><%= request.getAttribute("message") %></p>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
        <p><%= request.getAttribute("error") %></p>
    <% } %>
        
        
        <c:if test="${empty requestScope.message}">
            <form action="${pageContext.request.contextPath}/upgradeToHost" method="post" enctype="multipart/form-data" id="upgradeForm">
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" required>
                </div>
                <div class="form-group">
                    <label for="idNumber">ID Number</label>
                    <input type="text" class="form-control" id="idNumber" name="idNumber" required>
                </div>
                <div class="form-group">
                    <label for="bankAccount">Bank Account</label>
                    <input type="text" class="form-control" id="bankAccount" name="bankAccount" required>
                </div>
                <div class="form-group">
                    <label for="bankName">Bank Name</label>
                    <input type="text" class="form-control" id="bankName" name="bankName" required>
                </div>
                <div class="form-group">
                    <label for="accountHolder">Account Holder</label>
                    <input type="text" class="form-control" id="accountHolder" name="accountHolder" required>
                </div>
                <div class="form-group">
                    <label for="idImages">ID Images</label>
                    <input type="file" class="form-control-file" id="idImages" name="idImages" multiple required>
                </div>
                <div class="form-group">
                    <label for="ownershipDocs">Ownership Documents</label>
                    <input type="file" class="form-control-file" id="ownershipDocs" name="ownershipDocs" multiple required>
                </div>
                <button type="submit" class="btn btn-primary">Submit Request</button>
            </form>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary back-to-home">Back to home</a>
    </div>
</body>
</html>
