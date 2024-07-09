<%@ page contentType="text/html" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.HostUpgradeRequest" %>
<%@ page import="DAO.RegisterOwnerDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pending Host Upgrade Requests</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        <style>
            .clickable-row {
                cursor: pointer;
            }
            .clickable-row:hover {
                background-color: #f5f5f5;
            }
        </style>
    </head>
    <body>
        <%@include file="/admin/header.jsp" %>
        <div class="container-fluid">
            <h1 class="mt-4">Pending Host Upgrade Requests</h1>

            <!-- Display Success Message -->
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.message}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <% session.removeAttribute("message"); %>
            </c:if>

            <!-- Display Error Message -->
            <c:if test="${not empty requestScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${requestScope.error}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <% request.removeAttribute("error"); %>
            </c:if>

            <table class="table table-hover mt-4">
                <thead class="thead-light">
                    <tr>
                        <th>STT</th>
                        <th>Account ID</th>
                        <th>ID Number</th>
                        <th>Bank Account</th>
                        <th>Bank Name</th>
                        <th>Account Holder</th>
                        <th>Request Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        try {
                            ArrayList<HostUpgradeRequest> pendingRequests = RegisterOwnerDAO.getPendingRequests();
                            int count=0;
                            for (HostUpgradeRequest req : pendingRequests) {
                            count++;
                    %>
                    <tr class="clickable-row" data-id="<%= req.getAccountId() %>">
                        <td><%= count %> </td> 
                        <td><%= req.getAccountId() %></td>
                        <td><%= req.getIdNumber() %></td>
                        <td><%= req.getBankAccount() %></td>
                        <td><%= req.getBankName() %></td>
                        <td><%= req.getAccountHolder() %></td>
                        <td><fmt:formatDate value="<%= req.getRequestDate() %>" pattern="dd-MM-yyyy"/></td>
                        <td>
                            <% if (req.getStatus() == 2) { %>
                            Pending
                            <% } %>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/processUpgrade" method="post" class="d-inline">
                                <input type="hidden" name="requestId" value="<%= req.getId()%>">
                                <button type="submit" name="action" value="Approve" class="btn btn-success btn-sm">
                                    <i class="bi bi-check-circle"></i> Approve
                                </button>
                                <button type="submit" name="action" value="Reject" class="btn btn-danger btn-sm">
                                    <i class="bi bi-x-circle"></i> Reject
                                </button>
                            </form>
                            <a href="${pageContext.request.contextPath}/admin/viewRequestDetails.jsp?requestId=<%= req.getId() %>" class="btn btn-primary btn-sm ml-2">
                                <i class="bi bi-eye"></i> View Details
                            </a>
                        </td>
                    </tr>
                    <% 
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>
        <%@include file="/admin/footer.jsp" %>
        <script>
            document.addEventListener('DOMContentLoaded', (event) => {
                const rows = document.querySelectorAll('.clickable-row');
                rows.forEach(row => {
                    row.addEventListener('click', (e) => {
                        if (!e.target.closest('button')) {
                            window.location.href = '${pageContext.request.contextPath}/admin/viewRequestDetails.jsp?requestId=' + row.dataset.id;
                        }
                    });
                });
            });
        </script>
    </body>
</html>
