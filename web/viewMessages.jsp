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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            background-color: #e2f0d9;
            text-align: left;
            margin-right: auto;
            color: #333;
        }
        .message.right {
            background-color: #f1f3f5;
            text-align: right;
            margin-left: auto;
            color: #333;
        }
        .message p {
            margin: 0;
        }
        .message small {
            display: block;
            margin-top: 5px;
            color: #777;
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
        .user-info {
            display: flex;
            align-items: center;
        }
        .user-info img {
            border-radius: 50%;
            margin-right: 10px;
        }
        .user-info span {
            font-weight: bold;
            color: #000;
        }
        .modal-header,
        .modal-footer {
            border-bottom: none;
            border-top: none;
        }
        .modal-body {
            display: flex;
            flex-direction: column;
            height: 600px; /* Adjusted height */
        }
        .modal-body .user-info {
            flex-shrink: 0;
        }
        .modal-body .messages-container {
            flex-grow: 1;
            overflow-y: auto;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .modal-body form {
            flex-shrink: 0;
        }
        .modal-dialog {
            max-width: 600px; /* Adjust width if needed */
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
                    <a href="javascript:void(0);" onclick="showChatModal('${conversation.conversationId}', '${partnerAccount.fullName}', '${partnerAccount.avatar_img}', '${account.role_account == 2 ? 'Owner' : 'Customer'}')">
                        <div class="user-info">
                            <img src="${partnerAccount.avatar_img}" alt="Avatar" width="40" height="40">
                            <span>${partnerAccount.fullName}</span>
                        </div>
                    </a>
                </h5>
                <div class="collapse" id="conversation-${conversation.conversationId}">
                    <c:forEach var="message" items="${conversation.messages}">
                        <div class="message ${message.senderName == 'Owner' ? 'left' : 'right'}">
                            <p><strong>${message.senderFullName}:</strong> ${message.message}</p>
                            <small>${message.timestamp}</small>
                        </div>
                    </c:forEach>
                    <form action="${pageContext.request.contextPath}/sendMessage" method="POST" onsubmit="return sendMessageAjax(event, this)">
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
    <!-- Modal -->
    <div class="modal fade" id="chatModal" tabindex="-1" aria-labelledby="chatModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="chatModalLabel">Chat</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="user-info">
                        <img id="chatModalAvatar" src="" alt="Avatar" width="40" height="40">
                        <span id="chatModalName"></span>
                    </div>
                    <div id="chatModalMessages" class="messages-container mt-3"></div>
                    <form id="chatModalForm" action="${pageContext.request.contextPath}/sendMessage" method="POST">
                        <input type="hidden" id="chatModalOwnerId" name="owner_id">
                        <input type="hidden" id="chatModalCustomerId" name="customer_id">
                        <div class="form-group">
                            <label for="modalResponseText">Response</label>
                            <textarea class="form-control" id="modalResponseText" name="message" rows="3" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary mt-2">Send Response</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>       
        function showChatModal(conversationId, partnerName, partnerAvatar, role) {
            const chatModal = new bootstrap.Modal(document.getElementById('chatModal'));
            document.getElementById('chatModalName').textContent = partnerName;
            document.getElementById('chatModalAvatar').src = partnerAvatar;
            const messagesContainer = document.getElementById('chatModalMessages');
            messagesContainer.innerHTML = ''; // Clear previous messages
            const conversation = document.getElementById('conversation-' + conversationId);
            const messages = conversation.querySelectorAll('.message');
            messages.forEach((message) => {
                messagesContainer.appendChild(message.cloneNode(true));
            });

            document.getElementById('chatModalOwnerId').value = role === 'Owner' ? '${account.account_id}' : conversation.querySelector('input[name="owner_id"]').value;
            document.getElementById('chatModalCustomerId').value = role === 'Owner' ? conversation.querySelector('input[name="customer_id"]').value : '${account.account_id}';

            chatModal.show();

            // Bind the AJAX submit to the form inside the modal
            $('#chatModalForm').off('submit').on('submit', function(event) {
                event.preventDefault(); // Prevent the form from submitting the traditional way

                const form = $(this);
                const formData = form.serialize();

                $.ajax({
                    url: form.attr('action'),
                    type: form.attr('method'),
                    data: formData,
                    success: function(response) {
                        // Append the new message to the messages container
                        const newMessage = $('<div class="message right"></div>');
                        newMessage.append('<p><strong>${account.fullName}:</strong> ' + $('#modalResponseText').val() + '</p>');
                        newMessage.append('<small>Just now</small>');
                        $('#chatModalMessages').append(newMessage);

                        // Clear the textarea
                        $('#modalResponseText').val('');
                    },
                    error: function(xhr, status, error) {
                        console.error('Error sending message:', error);
                    }
                });
            });
        }

        function sendMessageAjax(event, form) {
            event.preventDefault();

            const formData = $(form).serialize();

            $.ajax({
                url: $(form).attr('action'),
                type: $(form).attr('method'),
                data: formData,
                success: function(response) {
                    // Append the new message to the conversation
                    const newMessage = $('<div class="message right"></div>');
                    newMessage.append('<p><strong>${account.fullName}:</strong> ' + $(form).find('textarea[name="message"]').val() + '</p>');
                    newMessage.append('<small>Just now</small>');
                    $(form).siblings('.collapse').append(newMessage);

                    // Clear the textarea
                    $(form).find('textarea[name="message"]').val('');
                },
                error: function(xhr, status, error) {
                    console.error('Error sending message:', error);
                }
            });

            return false; // Prevent the form from submitting the traditional way
        }
    </script>
</body>
</html>