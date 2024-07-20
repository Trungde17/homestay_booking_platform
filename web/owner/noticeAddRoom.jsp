<%-- 
    Document   : noticeAddRoom
    Created on : Jul 20, 2024, 11:15:32 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <div class="bg-review">
    <div class="loading">
      <div class="spinner"></div>
    </div>
    <h1>Registration Under Review</h1>

    <p>Add Room successfull.</p>
    
   <div class="navigation-links">
                        <a href="${pageContext.request.contextPath}/homestay/homestay_manage/infor.jsp?ht_id=${homestay.ht_id}">Back to menu</a>

                    </div>
  </div>
  <div class="floating-circles">
    <div class="circle" style="width: 100px; height: 100px; top: 20%; left: 10%; animation-duration: 15s;"></div>
    <div class="circle" style="width: 150px; height: 150px; top: 60%; left: 25%; animation-duration: 20s;"></div>
    <div class="circle" style="width: 80px; height: 80px; top: 40%; left: 70%; animation-duration: 12s;"></div>
    <div class="circle" style="width: 120px; height: 120px; top: 80%; left: 50%; animation-duration: 18s;"></div>
  </div>
    </body>
</html>
