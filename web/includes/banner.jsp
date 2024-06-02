<%@page contentType="text/html" pageEncoding="UTF-8"%>
<section class="hero-section">
    <div class="hero-content">
        <h1>Find Your Home away from Home</h1>
        <form class="row g-2 search mt-3">
            <div class="col-md-3" id="district">
                <select class="form-select">
                    <option value="1" selected>Hải Châu</option>
                    <option value="2">Sơn Trà</option>
                    <option value="3">Ngũ Hành Sơn</option>
                    <option value="4">Thanh Khê</option>
                    <option value="5">Cẩm Lệ</option>
                    <option value="6">Liên Chiểu</option>
                    <option value="7">Hòa Vang</option>
                </select>
            </div>                   
            <div class="col-md-3">
                <input type="date" class="form-control" id="checkIn" placeholder="Check In">
            </div>
            <div class="col-md-3">
                <input type="date" class="form-control" id="checkOut" placeholder="Check Out">
            </div>
            <div class="col-md-2">
                <select class="form-select">
                    <option selected>1 Guest</option>
                    <option value="2">2 Guests</option>
                    <option value="3">3 Guests</option>
                    <option value="4">4 Guests</option>
                </select>
            </div>
            <div class="col-md-1">
                <button type="submit" class="btn btn-primary w-100">Search</button>
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

