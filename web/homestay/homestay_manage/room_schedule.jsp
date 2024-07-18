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
    <script>
        $(document).ready(function () {
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
        });
    </script>
    <style>
        body {
            padding-top: 20px;
        }
        #calendar {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row mb-4">
            <div class="col-md-4">
                <label for="roomSelect" class="form-label">Select Room:</label>
                <div class="input-group">
                    <select class="custom-select" id="roomSelect">
                        <option value="41">Room 1</option>
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
</body>
</html>
