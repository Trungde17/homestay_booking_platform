<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homestay/manage/menu.css" />
    <script>
        $(document).ready(function () {
            // Đặt giá trị tối thiểu cho ngày bắt đầu và ngày kết thúc
            var today = new Date().toISOString().split('T')[0];
            $('#startDate').attr('min', today);
            $('#endDate').attr('min', today);

            // Hàm để tải lịch của phòng từ servlet
            function loadRoomSchedule(roomId) {
                if (!roomId) {
                    console.error("Room ID is empty.");
                    return;
                }
                console.log("Loading schedule for room:", roomId); // Debugging line
                fetch('<%= request.getContextPath() %>/ScheduleServlet?room_id=' + roomId)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok ' + response.statusText);
                        }
                        return response.json();
                    })
                    .then(data => {
                        // Thêm một ngày vào end_date để đảm bảo hiển thị đúng trong FullCalendar
                        data.forEach(event => {
                            event.end = moment(event.end).add(1, 'days').format('YYYY-MM-DD');
                        });
                        $('#calendar').fullCalendar('removeEvents');
                        $('#calendar').fullCalendar('addEventSource', data);
                    })
                    .catch(error => console.error('Error:', error));
            }

            // Khi thay đổi phòng
            $('#roomSelect').on('change', function () {
                const roomId = $(this).val();
                console.log("Selected room:", roomId); // Debugging line
                loadRoomSchedule(roomId);
            });

            // Khởi tạo lịch
            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month'
                },
                defaultView: 'month',
                editable: false,
                events: [] // Khởi tạo không có sự kiện, sẽ thêm sau
            });

            // Gọi hàm loadRoomSchedule với phòng đầu tiên nếu có giá trị
            const initialRoomId = $('#roomSelect').val();
            if (initialRoomId) {
                loadRoomSchedule(initialRoomId);
            } else {
                console.error("Initial room ID is empty.");
            }

            // Khi bấm nút lưu lịch
            $('#saveScheduleBtn').on('click', function () {
                const roomId = $('#roomSelect').val();
                const startDate = $('#startDate').val();
                const endDate = $('#endDate').val();
                const action = $('#status').val();

                // Kiểm tra ngày bắt đầu và ngày kết thúc hợp lệ
                if (!startDate || !endDate || new Date(startDate) > new Date(endDate)) {
                    alert('Please select valid start and end dates.');
                    return;
                }

                const data = {
                    room_id: roomId,
                    start_date: startDate,
                    end_date: endDate,
                    action: action
                };

                console.log("Saving schedule:", data); // Debugging line

                fetch('<%= request.getContextPath() %>/ScheduleServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                })
                    .then(response => {
                        if (response.ok) {
                            loadRoomSchedule(roomId);
                        } else {
                            console.error('Failed to save schedule');
                        }
                    })
                    .catch(error => console.error('Error:', error));
            });

            // Sự kiện thay đổi cho ô nhập ngày bắt đầu và ngày kết thúc
            $('#startDate').on('change', function () {
                var startDate = $(this).val();
                $('#endDate').attr('min', startDate);
            });

            $('#endDate').on('change', function () {
                var endDate = $(this).val();
                $('#startDate').attr('max', endDate);
            });
        });
    </script>
    <style>
        body {
            padding-top: 20px;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 1200px;
            margin-top: 40px;
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        #calendar {
            margin-top: 20px;
        }
        .form-label {
            font-weight: bold;
        }
        .custom-select, .form-control {
            border-radius: 0.25rem;
            height: calc(2.25rem + 2px);
            padding: 0.375rem 0.75rem;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 0.25rem;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            line-height: 1.5;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            user-select: none;
            border: 1px solid transparent;
            color: #ffffff;
            cursor: pointer;
            text-transform: uppercase;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-2 d-none d-md-block sidebar">
                <jsp:include page="menu.jsp" />
            </nav>
            <div class="col-md-9 ml-sm-auto col-lg-10 content">
                <div class="row mb-4">
                    <div class="col-md-4">
                        <label for="roomSelect" class="form-label">Select Room:</label>
                        <div class="input-group">
                            <select class="custom-select" id="roomSelect">
                                <option value="1">Room 1</option>
                                <!-- Thêm các phòng khác -->
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col-md-3">
                        <label for="startDate" class="form-label">Start Date:</label>
                        <input type="date" class="form-control" id="startDate">
                    </div>
                    <div class="col-md-3">
                        <label for="endDate" class="form-label">End Date:</label>
                        <input type="date" class="form-control" id="endDate">
                    </div>
                    <div class="col-md-3">
                        <label for="status" class="form-label">Status:</label>
                        <select class="custom-select" id="status">
                            <option value="add">Busy</option>
                            <option value="delete">Available</option>
                        </select>
                    </div>
                    <div class="col-md-3 align-self-end">
                        <button class="btn btn-primary" id="saveScheduleBtn">Save Schedule</button>
                    </div>
                </div>
                <div id="calendar"></div>
            </div>
        </div>
    </div>
</body>
</html>
