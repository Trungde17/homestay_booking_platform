<!-- File: guide.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Da Nang Booking Homestay Platform Guide</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #00c6ff, #0072ff);
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            width: 80%;
            margin: 50px auto;
            background: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            transform: translateY(-50px);
            animation: slideIn 1s ease-in-out forwards;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(0);
            }
            to {
                opacity: 1;
                transform: translateY(-50px);
            }
        }

        h1, h2 {
            color: #333;
            text-align: center;
            font-weight: bold;
        }

        h1 {
            font-size: 42px;
            margin-bottom: 30px;
        }

        h2 {
            font-size: 32px;
            margin-bottom: 20px;
            position: relative;
            display: inline-block;
        }

        h2::after {
            content: '';
            width: 60px;
            height: 4px;
            background: #0072ff;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            bottom: -10px;
        }

        p {
            line-height: 1.8;
            font-size: 18px;
            margin-bottom: 20px;
        }

        ol, ul {
            margin-left: 40px;
            margin-bottom: 20px;
        }

        li {
            margin-bottom: 10px;
            font-size: 18px;
        }

        .section {
            margin-bottom: 50px;
            padding: 30px;
            border-radius: 15px;
            background: #f3f9ff;
            box-shadow: 0 10px 30px rgba(0, 114, 255, 0.1);
            position: relative;
        }

        .section::before {
            content: '';
            width: 100px;
            height: 100px;
            background: rgba(0, 114, 255, 0.1);
            border-radius: 50%;
            position: absolute;
            top: -50px;
            left: -50px;
        }

        .contact {
            text-align: center;
            margin-top: 40px;
            font-size: 20px;
        }

        .contact a {
            color: #0072ff;
            text-decoration: none;
            font-weight: bold;
        }

        .contact a:hover {
            text-decoration: underline;
        }

        .button {
            display: inline-block;
            background: #0072ff;
            color: #fff;
            padding: 12px 25px;
            border-radius: 30px;
            text-decoration: none;
            margin-top: 20px;
            font-size: 18px;
            font-weight: bold;
            box-shadow: 0 5px 15px rgba(0, 114, 255, 0.4);
            transition: background 0.3s, transform 0.3s;
        }

        .button:hover {
            background: #005bb5;
            transform: translateY(-3px);
        }

        .card {
            background: #fff;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
        }

        .faq-question {
            font-size: 22px;
            font-weight: bold;
            color: #0072ff;
            margin-top: 30px;
            position: relative;
            padding-left: 30px;
        }

        .faq-question::before {
            content: '?';
            color: #0072ff;
            font-size: 30px;
            font-weight: bold;
            position: absolute;
            left: 0;
            top: 0;
        }

        .icon {
            font-size: 50px;
            color: #0072ff;
            margin-bottom: 20px;
        }

        .landscape {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }

        .landscape-item {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin: 20px;
            width: calc(33% - 40px);
            padding: 20px;
            text-align: center;
        }

        .landscape-item img {
            width: 100%;
            height: auto;
            border-radius: 10px;
            margin-bottom: 15px;
        }

        .landscape-item h3 {
            font-size: 20px;
            color: #0072ff;
            margin-bottom: 10px;
        }

        .landscape-item p {
            font-size: 16px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to Da Nang Booking Homestay Platform</h1>
        
        <div class="section card">
            <i class="fas fa-info-circle icon"></i>
            <h2>Introduction</h2>
            <p>Welcome to the Da Nang Booking Homestay Platform. This platform allows you to book homestays in Da Nang easily and efficiently. Whether you are traveling for leisure or business, our platform provides you with a wide range of homestay options to choose from. Enjoy your stay in beautiful Da Nang!</p>
        </div>

        <div class="section card">
            <i class="fas fa-book icon"></i>
            <h2>How to Book a Homestay</h2>
            <p>Booking a homestay on our platform is simple and straightforward. Follow these steps to complete your booking:</p>
            <ol>
                <li>Search for available homestays by entering your desired dates and location.</li>
                <li>Browse through the list of available homestays and select the one that suits your needs.</li>
                <li>Review the details of the homestay, including amenities, prices, and guest reviews.</li>
                <li>Click on the "Book Now" button to proceed with your booking.</li>
                <li>Fill in your personal details and payment information.</li>
                <li>Confirm your booking. You will receive a confirmation email with all the details of your booking.</li>
            </ol>
            <a class="button" href="../index.jsp">Start Booking Now</a>
        </div>

        <div class="section card">
            <i class="fas fa-cogs icon"></i>
            <h2>Features and Functions</h2>
            <p>Our platform offers a variety of features to enhance your booking experience:</p>
            <ul>
                <li>Easy search and filter options to find the perfect homestay.</li>
                <li>Secure payment gateway to ensure the safety of your transactions.</li>
                <li>Detailed homestay listings with photos, descriptions, and reviews from other guests.</li>
                <li>User-friendly interface for managing your bookings and personal information.</li>
                <li>24/7 customer support to assist you with any queries or issues.</li>
                <li>Exclusive deals and discounts for registered users.</li>
            </ul>
        </div>

        <div class="section card">
            <i class="fas fa-question-circle icon"></i>
            <h2>Frequently Asked Questions</h2>
            <p>Here are some common questions and answers to help you navigate our platform:</p>
            <div class="faq-question">How do I cancel a booking?</div>
            <p>You can cancel a booking by logging into your account, navigating to your bookings, and selecting the cancel option. Please note that cancellation policies may apply.</p>
            <div class="faq-question">Can I modify my booking?</div>
            <p>Yes, you can modify your booking details such as dates and guest information by accessing your booking details in your account.</p>
            <div class="faq-question">What payment methods are accepted?</div>
            <p>We accept various payment methods including credit/debit cards, and online payment systems. All transactions are secured.</p>
            <div class="faq-question">How do I contact customer support?</div>
            <p>Our customer support is available 24/7. You can contact us via email or phone. Contact details are provided in the contact section below.</p>
        </div>

        <div class="section card">
            <i class="fas fa-map-marker-alt icon"></i>
            <h2>Discover Da Nang</h2>
            <div class="landscape">
                <div class="landscape-item">
                    <img src="../img/m.jpg" alt="Marble Mountains">
                    <h3>Marble Mountains</h3>
                    <p>Explore the beautiful Marble Mountains, a cluster of five hills made from limestone and marble, each representing a natural element.</p>
                </div>
                <div class="landscape-item">
                    <img src="../img/mykhe.jpg" alt="My Khe Beach">
                    <h3>My Khe Beach</h3>
                    <p>Relax at My Khe Beach, known for its long sandy shores and crystal-clear waters, perfect for swimming and sunbathing.</p>
                </div>
                <div class="landscape-item">
                    <img src="../img/bana.jpg" alt="Ba Na Hills">
                    <h3>Ba Na Hills</h3>
                    <p>Visit Ba Na Hills, a stunning resort complex with a French village, beautiful gardens, and the famous Golden Bridge.</p>
                </div>
            </div>
        </div>

        <div class="contact">
            <p>If you have any questions or need assistance, please feel free to contact our admin at:</p>
            <p>Email: <a href="mailto:admin@dananghomestay.com">admin@dananghomestay.com</a></p>
        </div>
    </div>
</body>
</html>
