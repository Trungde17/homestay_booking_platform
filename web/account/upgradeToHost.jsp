<%-- 
    Document   : upgradeToHost
    Created on : Jun 26, 2024, 6:03:53 PM
    Author     : ASUS
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký trở thành Host</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/homestay/styles.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">HealingLand</a>
           
        </div>
    </nav>

    <div class="container mt-5">
        <h1 class="text-center mb-4">Đăng ký trở thành Owner</h1>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger" role="alert">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="upgrade-to-host" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="idNumber" class="form-label">Số CMND/CCCD</label>
                    <input type="text" class="form-control" id="idNumber" name="idNumber" required>
                </div>
                <div class="col-md-6">
                    <label for="idImage" class="form-label">Ảnh CMND/CCCD</label>
                    <input type="file" class="form-control" id="idImage" name="idImage" accept="image/*" required>
                </div>
                <div class="col-md-6">
                    <label for="bankAccount" class="form-label">Số tài khoản ngân hàng</label>
                    <input type="text" class="form-control" id="bankAccount" name="bankAccount" required>
                </div>
                <div class="col-md-6">
                    <label for="bankName" class="form-label">Tên ngân hàng</label>
                    <input type="text" class="form-control" id="bankName" name="bankName" required>
                </div>
                <div class="col-md-6">
                    <label for="accountHolder" class="form-label">Tên chủ tài khoản</label>
                    <input type="text" class="form-control" id="accountHolder" name="accountHolder" required>
                </div>
                <div class="col-md-6">
                    <label for="phoneNumber" class="form-label">Số điện thoại</label>
                    <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required>
                </div>
                <div class="col-12">
                    <label for="permanentAddress" class="form-label">Địa chỉ thường trú</label>
                    <input type="text" class="form-control" id="permanentAddress" name="permanentAddress" required>
                </div>
                <div class="col-12">
                    <label for="ownershipDoc" class="form-label">Giấy tờ chứng minh quyền sở hữu</label>
                    <input type="file" class="form-control" id="ownershipDoc" name="ownershipDoc" accept=".pdf,.doc,.docx" required>
                </div>
                <div class="col-12">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="agreement" name="agreement" required>
                        <label class="form-check-label" for="agreement">
                            Tôi đồng ý với các điều khoản và điều kiện dành cho chủ nhà
                        </label>
                    </div>
                </div>
            </div>

            <button class="btn btn-primary w-100 mt-4" type="submit">Gửi yêu cầu nâng cấp</button>
        </form>
    </div>

    <footer class="mt-5 py-3 bg-light">
        <div class="container text-center">
            <p> DaNangHomestay. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script> (function () {
  'use strict'

  // Fetch all the forms we want to apply custom Bootstrap validation styles to
  var forms = document.querySelectorAll('.needs-validation')

  // Loop over them and prevent submission
  Array.prototype.slice.call(forms)
    .forEach(function (form) {
      form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) {
          event.preventDefault()
          event.stopPropagation()
        }

        form.classList.add('was-validated')
      }, false)
    })
})()</script>
</body>
</html>