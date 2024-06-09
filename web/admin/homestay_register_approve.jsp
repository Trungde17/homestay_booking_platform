<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"/>
<div class="container-fluid">
    <h1 class="mt-4">Yêu Cầu Đăng Ký Homestay</h1>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>#</th>
                <th>Tên Chủ Nhà</th>
                <th>Địa Chỉ</th>
                <th>Ngày Đăng Ký</th>
                <th>Trạng Thái</th>
            </tr>
        </thead>
        <tbody>
            <!-- Example data, replace with dynamic content -->
            <tr data-id="1" class="request-row" data-toggle="modal" data-target="#homestayModal">
                <td>1</td>
                <td>Nguyễn Văn A</td>
                <td>123 Đường ABC, Quận 1, TP. HCM</td>
                <td>01/06/2024</td>
                <td>Chờ duyệt</td>
            </tr>
            <!-- More rows -->
        </tbody>
    </table>
</div>

<!-- Modal for Homestay Details -->
<div class="modal fade" id="homestayModal" tabindex="-1" aria-labelledby="homestayModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="homestayModalLabel">Thông Tin Homestay</h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p><strong>Tên Chủ Nhà:</strong> <span id="homestayOwner"></span></p>
                <p><strong>Địa Chỉ:</strong> <span id="homestayAddress"></span></p>
                <p><strong>Ngày Đăng Ký:</strong> <span id="homestayDate"></span></p>
                <p><strong>Trạng Thái:</strong> <span id="homestayStatus"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="approveBtn">Duyệt</button>
                <button type="button" class="btn btn-danger" id="rejectBtn">Từ chối</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('.request-row').click(function() {
            const requestId = $(this).data('id');
            // Replace with actual data fetching logic
            const requestInfo = {
                owner: 'Nguyễn Văn A',
                address: '123 Đường ABC, Quận 1, TP. HCM',
                date: '01/06/2024',
                status: 'Chờ duyệt'
            };
            // Populate modal with data
            $('#homestayOwner').text(requestInfo.owner);
            $('#homestayAddress').text(requestInfo.address);
            $('#homestayDate').text(requestInfo.date);
            $('#homestayStatus').text(requestInfo.status);
        });

        $('#approveBtn').click(function() {
            alert('Yêu cầu đã được duyệt');
            // Add API call to approve request
            $('#homestayModal').modal('hide');
        });

        $('#rejectBtn').click(function() {
            alert('Yêu cầu đã bị từ chối');
            // Add API call to reject request
            $('#homestayModal').modal('hide');
        });
    });
</script>
<jsp:include page="footer.jsp"/>
