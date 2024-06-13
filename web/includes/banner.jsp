<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<section class="hero-section">
    <div class="hero-content">
        <form action="${pageContext.request.contextPath}/searchServlet" method="post">
            <h1>Find Your Home away from Home</h1>
            <div class="row g-2 search mt-3">
                <div class="col-md-3" id="district">
                    <select class="form-select" name="district">
                        <option value="Hải Châu" selected>Hải Châu</option>
                        <option value="Sơn Trà">Sơn Trà</option>
                        <option value="Ngũ Hành Sơn">Ngũ Hành Sơn</option>
                        <option value="Thanh Khê">Thanh Khê</option>
                        <option value="Cẩm Lệ">Cẩm Lệ</option>
                        <option value="Liên Chiểu">Liên Chiểu</option>
                        <option value="Hòa Vang">Hòa Vang</option>
                    </select>
                </div>                   
                <div class="col-md-3">
                    <input type="date" class="form-control" id="checkIn" name="checkIn" placeholder="Check In">
                </div>
                <div class="col-md-3">
                    <input type="date" class="form-control" id="checkOut" name="checkOut" placeholder="Check Out">
                </div>
                <div class="col-md-2">
                    <select class="form-select" id="guest" name="guests">
                        <option value="1" selected>1 Guest</option>
                        <option value="2">2 Guests</option>
                        <option value="3">3 Guests</option>
                        <option value="4">4 Guests</option>
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
</script>