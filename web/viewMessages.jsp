<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="DAO.MessageDAO"%>
<%@page import="model.Conversation"%>
<%@page import="model.Message"%>
<%@page import="java.util.List"%>
<%@page import="DAO.AccountDAO"%>
<%@page import="model.Account"%>

<c:set var="account" value="${sessionScope.account}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messenger</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #002f4b, #dc4225);
            font-family: 'Poppins', sans-serif;
            color: #fff;
        }
        .container {
            max-width: 900px;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            color: #000;
        }
        .chat-container {
            border: 1px solid #ccc;
            padding: 20px;
            margin-top: 20px;
            border-radius: 8px;
            background: #ffffff;
        }
        .message {
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 5px;
            max-width: 70%;
            display: flex;
            flex-direction: column;
        }
        .message.left {
            background-color: #e9ecef;
            text-align: left;
        }
        .message.right {
            background-color: #d1e7dd;
            text-align: right;
            margin-left: auto;
        }
        .message p {
            margin: 0;
        }
        .message small {
            display: block;
            margin-top: 5px;
        }
        .close-btn {
            margin-left: auto;
            display: block;
            font-size: 1.5rem;
            color: #000;
            text-decoration: none;
        }
        .form-group label {
            font-weight: bold;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <a href="${pageContext.request.contextPath}/homestaySearch/homestaySearch.jsp" class="close-btn">&times;</a>
        <h1>Messages</h1>
        <c:if test="${account.role_account == 2}">
            <c:set var="conversations" value="${MessageDAO.getConversationsByOwnerId(account.account_id)}"/>
        </c:if>
        <c:if test="${account.role_account != 2}">
            <c:set var="conversations" value="${MessageDAO.getConversationsByCustomerId(account.account_id)}"/>
        </c:if>
        <c:forEach var="conversation" items="${conversations}">
<c:set var="partnerAccount" value="${account.role_account == 2 ? AccountDAO.getAccountById(conversation.customerId) : AccountDAO.getAccountById(conversation.ownerId)}"/>
            <div class="chat-container">
                <h5>
                    <a data-bs-toggle="collapse" href="#conversation-${conversation.conversationId}" role="button" aria-expanded="false" aria-controls="conversation-${conversation.conversationId}">
                        Conversation with ${partnerAccount.fullName}
                    </a>
                </h5>
                <div class="collapse" id="conversation-${conversation.conversationId}">
                    <c:forEach var="message" items="${conversation.messages}">
                        <div class="message ${message.senderName == 'Owner' ? 'left' : 'right'}">
                            <p><strong>${message.senderFullName}:</strong> ${message.message}</p>  <!-- Hiển thị tên đầy đủ -->
                            <small>${message.timestamp}</small>
                        </div>
                    </c:forEach>
                    <form action="${pageContext.request.contextPath}/sendMessage" method="POST" onsubmit="return keepChatOpen('${conversation.conversationId}')">
                        <input type="hidden" name="owner_id" value="${account.role_account == 2 ? account.account_id : conversation.ownerId}">
                        <input type="hidden" name="customer_id" value="${account.role_account == 2 ? conversation.customerId : account.account_id}">
                        <div class="form-group">
                            <label for="responseText">Response</label>
                            <textarea class="form-control" id="responseText" name="message" rows="3" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary mt-2">Send Response</button>
                    </form>
                </div>
            </div>
        </c:forEach>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function keepChatOpen(conversationId) {
            const element = document.getElementById('conversation-' + conversationId);
            const isVisible = element.classList.contains('show');
            sessionStorage.setItem('openConversation', conversationId);
            return true;
        }

        document.addEventListener('DOMContentLoaded', (event) => {
            const openConversation = sessionStorage.getItem('openConversation');
            if (openConversation) {
                const element = document.getElementById('conversation-' + openConversation);
                if (element) {
                    new bootstrap.Collapse(element, {toggle: true});
                }
                sessionStorage.removeItem('openConversation');
            }
        });
    </script>
</body>
</html>