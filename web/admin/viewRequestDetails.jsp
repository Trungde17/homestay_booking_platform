<%@ page contentType="text/html" language="java" %>
<%@ page import="model.HostUpgradeRequest" %>
<%@ page import="model.ImageHost" %>
<%@ page import="DAO.RegisterOwnerDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Host Upgrade Request Details</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" />
</head>
<body>
    <%@include file="/admin/header.jsp" %>
    <div class="container-fluid">
        <h1 class="mt-4">Host Upgrade Request Details</h1>
        <div class="card mt-4">
            <div class="card-body">
                <% 
                    try {
                        int requestId = Integer.parseInt(request.getParameter("requestId"));
                        HostUpgradeRequest requestDetails = RegisterOwnerDAO.getRequestById(requestId);
                        if (requestDetails != null) {
                %>
<!--                <h5 class="card-title">Request ID: <%= requestDetails.getId() %></h5>-->
                <p class="card-text">Account ID: <%= requestDetails.getAccountId() %></p>
                <p class="card-text">ID Number: <%= requestDetails.getIdNumber() %></p>
                <p class="card-text">Bank Account: <%= requestDetails.getBankAccount() %></p>
                <p class="card-text">Bank Name: <%= requestDetails.getBankName() %></p>
                <p class="card-text">Account Holder: <%= requestDetails.getAccountHolder() %></p>
                <p class="card-text">Request Date: <%= new java.text.SimpleDateFormat("dd-MM-yyyy").format(requestDetails.getRequestDate()) %></p>
                <p class="card-text">Status: <%= (requestDetails.getStatus() == 2) ? "Pending" : "" %></p>
                
                <!-- Display ID Images -->
                <p class="card-text">ID Images:</p>
                <div class="row">
                    <% for (ImageHost idImage : requestDetails.getIdImagePath()) { %>
                        <div class="col-md-3">
                            <img src="<%= idImage.getImg_url() %>" class="img-fluid mb-3" alt="ID Image">
                        </div>
                    <% } %>
                </div>

                <!-- Display Ownership Document Images -->
                <p class="card-text">Ownership Document Images:</p>
                <div class="row">
                    <% for (ImageHost docImage : requestDetails.getOwnershipDocPath()) { %>
                        <div class="col-md-3">
                            <img src="<%= docImage.getImg_url() %>" class="img-fluid mb-3" alt="Ownership Document">
                        </div>
                    <% } %>
                </div>
                <% 
                        } else {
                %>
                <p class="card-text">Request details not found.</p>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
                <a href="${pageContext.request.contextPath}/admin/pendingRequests.jsp" class="btn btn-primary">
                    <i class="bi bi-arrow-left"></i> Back to Requests
                </a>
            </div>
        </div>
    </div>
    <%@include file="/admin/footer.jsp" %>
</body>
</html>
