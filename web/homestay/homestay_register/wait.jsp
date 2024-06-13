<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registration Under Review</title>
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body, html {
      height: 100%;
      margin: 0;
      font-family: 'Arial', sans-serif;
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
      color: white;
      overflow: hidden;
    }
    .bg-review {
      position: relative;
      text-align: center;
      z-index: 1;
      max-width: 600px;
    }
    .bg-review h1 {
      font-size: 3rem;
      font-weight: bold;
      margin: 0;
      animation: fadeIn 1.5s ease-in-out;
    }
    .bg-review h2 {
      font-size: 2rem;
      margin: 20px 0;
      animation: fadeIn 2s ease-in-out;
    }
    .bg-review p {
      font-size: 1.25rem;
      margin-bottom: 30px;
      animation: fadeIn 2.5s ease-in-out;
    }
    .loading {
      margin-bottom: 20px;
      animation: fadeIn 1.5s ease-in-out;
    }
    .spinner {
      width: 50px;
      height: 50px;
      border: 5px solid rgba(255, 255, 255, 0.3);
      border-top: 5px solid white;
      border-radius: 50%;
      animation: spin 1s linear infinite;
      margin: 0 auto;
    }
    .btn-custom {
      background-color: #ff6f61;
      border: none;
      padding: 15px 30px;
      font-size: 1.25rem;
      border-radius: 50px;
      animation: fadeIn 3s ease-in-out;
    }
    .btn-custom:hover {
      background-color: #ff3b30;
      box-shadow: 0 0 15px rgba(255, 107, 100, 0.7);
    }
    .floating-circles {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      overflow: hidden;
      z-index: 0;
    }
    .circle {
      position: absolute;
      background: rgba(255, 255, 255, 0.1);
      border-radius: 50%;
      animation: float 10s infinite ease-in-out;
    }
    @keyframes float {
      0% {
        transform: translateY(0);
      }
      50% {
        transform: translateY(-20px);
      }
      100% {
        transform: translateY(0);
      }
    }
    @keyframes spin {
      0% {
        transform: rotate(0deg);
      }
      100% {
        transform: rotate(360deg);
      }
    }
    @keyframes fadeIn {
      from {
        opacity: 0;
      }
      to {
        opacity: 1;
      }
    }
  </style>
</head>
<body>
  <div class="bg-review">
    <div class="loading">
      <div class="spinner"></div>
    </div>
    <h1>Registration Under Review</h1>

    <p>Your registration to become an owner is under review. Please wait.</p>
    
    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-custom">Go to Homepage</a>
  </div>
  <div class="floating-circles">
    <div class="circle" style="width: 100px; height: 100px; top: 20%; left: 10%; animation-duration: 15s;"></div>
    <div class="circle" style="width: 150px; height: 150px; top: 60%; left: 25%; animation-duration: 20s;"></div>
    <div class="circle" style="width: 80px; height: 80px; top: 40%; left: 70%; animation-duration: 12s;"></div>
    <div class="circle" style="width: 120px; height: 120px; top: 80%; left: 50%; animation-duration: 18s;"></div>
  </div>
</body>
</html>
