

html
Copy code
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>banner</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">
       <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <style>
        #district{
            color:#26B4FF;
        }
        .form-select {
            padding-left: 2.5rem;
            
        }
        .select-wrapper {
            position: relative;
        }
        .select-wrapper i {
            color:#26B4FF ;
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
        }
        .select-wrapper.bi-person{
            color:black;
        }
    </style>
</head>
<body>
    <section class="hero-section">
        <div class="hero-content">
            <form action="${pageContext.request.contextPath}/searchServlet" method="post">
                <h1>Find Your Home away from Home</h1>
                <div class="row g-2 search mt-4">
                    <div class="col-md-4 select-wrapper">
                        <i class="fas fa-map-marker-alt"></i> <!-- Location icon -->
                        <select class="form-select" name="district" id="district" placeholder="Where do you want to go?">
                            <option value="" disabled selected hidden>Where do you want to go?</option>
                            <option value="Hải Châu">Hải Châu</option>
                            <option value="Sơn Trà">Sơn Trà</option>
                            <option value="Ngũ Hành Sơn">Ngũ Hành Sơn</option>
                            <option value="Thanh Khê">Thanh Khê</option>
                            <option value="Cẩm Lệ">Cẩm Lệ</option>
                            <option value="Liên Chiểu">Liên Chiểu</option>
                            <option value="Hòa Vang">Hòa Vang</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <input type="date" class="form-control" id="checkIn" name="checkIn" placeholder="Check In">
                    </div>
                    <div class="col-md-2">
                        <input type="date" class="form-control" id="checkOut" name="checkOut" placeholder="Check Out">
                    </div>
                    <div class="col-md-2 select-wrapper">
                        <i class="bi bi-person"></i> <!-- Person icon -->
                        <select class="form-select" id="guest" name="guests">
                            <option value="1" selected>1 Guest</option>
                            <option value="2">2 Guests</option>
                            <option value="3">3 Guests</option>
                            <option value="4">4 Guests</option>
                            <option value="5">5 Guests</option>
                            <option value="6">6 Guests</option>
                            <option value="7">7 Guests</option>
                        </select>
                    </div>
                    <div class="col-md-1">
                        <button type="submit" class="btn btn-primary w-100">Search</button>
                    </div>
                </div>
            </form>
                
        </div>
    </section>
   
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('checkIn').setAttribute('min', today);
        document.getElementById('checkOut').setAttribute('min', today);
    });

    document.getElementById('checkIn').addEventListener('change', function() {
        const checkInDate = new Date(this.value);
        const checkOutInput = document.getElementById('checkOut');
        const checkOutDate = new Date(checkOutInput.value);
        
        // Update min attribute of check-out date picker
        checkOutInput.setAttribute('min', this.value);

        if (checkOutDate && checkInDate > checkOutDate) {
            checkOutInput.value = '';
            alert('Check-in date cannot be later than check-out date. Please reselect the dates.');
        }
    });

    document.getElementById('checkOut').addEventListener('change', function() {
        const checkInDate = new Date(document.getElementById('checkIn').value);
        const checkOutDate = new Date(this.value);
        if (checkInDate && checkOutDate < checkInDate) {
            document.getElementById('checkIn').value = this.value;
            alert('Check-out date cannot be earlier than check-in date. Please reselect the dates.');
        }
    });
</script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
