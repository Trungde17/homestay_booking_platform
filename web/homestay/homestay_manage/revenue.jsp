<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Revenue Dashboard</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/manage/revenue.css" />
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/homestay/manage/menu.css" />
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block sidebar">
                    <jsp:include page="menu.jsp" />
                </nav>
                <div class="col-md-9 ml-sm-auto col-lg-10 content">
                    <div class="container">
                        <div class="revenue-header text-center">
                            <h1>Revenue</h1>
                            <div class="form-inline justify-content-center mb-3">
                                <input type="number" class="form-control mr-2" id="input-year" placeholder="Year" min="2024">
                                <input type="number" class="form-control mr-2" id="input-month" placeholder="Month (optional)" min="0" max="12">
                                <button type="button" class="btn btn-primary" id="view-revenue">View Revenue</button>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="revenueChart"></canvas>
                                </div>
                                <div class="summary">
                                    <div class="summary-item">
                                        <strong>Total Revenue: </strong><span id="total-revenue"></span>
                                    </div>
                                    <div class="summary-item">
                                        <strong>Total Bookings: </strong><span id="total-bookings"></span>
                                    </div>
                                    <div class="summary-item">
                                        <strong>Total Guests: </strong><span id="total-guests"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var ctx = document.getElementById('revenueChart').getContext('2d');
                var revenueChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: [],
                        datasets: [{
                                label: 'Revenue',
                                data: [],
                                borderColor: 'rgba(75, 192, 192, 1)',
                                borderWidth: 2,
                                fill: false
                            }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            x: {
                                title: {
                                    display: true,
                                    text: 'Time'
                                }
                            },
                            y: {
                                title: {
                                    display: true,
                                    text: 'Revenue'
                                },
                                min: 0,
                                max: 10000000, // Default maximum value
                                ticks: {
                                    callback: function (value, index, values) {
                                        return value.toLocaleString();  // Format ticks with commas
                                    }
                                }
                            }
                        }
                    }
                });

                document.getElementById('view-revenue').addEventListener('click', function () {
                    const year = document.getElementById('input-year').value;
                    const month = document.getElementById('input-month').value;
                    if (year) {
                        fetchRevenueData(year, month);
                    } else {
                        alert('Please enter a year.');
                    }
                });

                function fetchRevenueData(year, month) {
                    const url = '/healingland/GetRevenueData?year=' + year + '&month=' + month;
                    fetch(url)
                            .then(response => response.json())
                            .then(data => updateChartAndSummary(data, year, month))
                            .catch(error => console.error('Error:', error));
                }

                function updateChartAndSummary(data, year, month) {
                    let labels = [];
                    let revenueData = [];
                    let maxRevenue = 0;

                    if (month) {
                        // Generate days in the selected month
                        const daysInMonth = new Date(year, month, 0).getDate();
                        labels = Array.from({length: daysInMonth}, (_, i) => (i + 1).toString());
                        revenueData = labels.map(day => {
                            const record = data.find(item => item.label === day);
                            const revenue = record ? record.totalRevenue : 0;
                            if (revenue > maxRevenue) {
                                maxRevenue = revenue;
                            }
                            return revenue;
                        });
                    } else {
                        // Generate all months of the year
                        labels = Array.from({length: 12}, (_, i) => (i + 1).toString());
                        revenueData = labels.map(month => {
                            const record = data.find(item => item.label === month);
                            const revenue = record ? record.totalRevenue : 0;
                            if (revenue > maxRevenue) {
                                maxRevenue = revenue;
                            }
                            return revenue;
                        });
                    }

                    // Set max value for y-axis dynamically if there is revenue data
                    if (maxRevenue > 0) {
                        revenueChart.options.scales.y.max = maxRevenue * 1.1; // Add 10% padding to the max revenue
                    } else {
                        revenueChart.options.scales.y.max = 10000000; // Default to 10,000,000 if no revenue data
                    }

                    revenueChart.data.labels = labels;
                    revenueChart.data.datasets[0].data = revenueData;
                    revenueChart.data.datasets[0].label = month ? 'Revenue for ' + month + '/' + year : 'Revenue for ' + year;
                    revenueChart.update();

                    updateSummary(data);
                }

                function updateSummary(data) {
                    const totalRevenue = data.reduce((acc, val) => acc + val.totalRevenue, 0);
                    const totalBookings = data.reduce((acc, val) => acc + val.totalBookings, 0);
                    const totalGuests = data.reduce((acc, val) => acc + val.totalGuests, 0);

                    document.getElementById('total-revenue').innerText = totalRevenue.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                    document.getElementById('total-bookings').innerText = totalBookings;
                    document.getElementById('total-guests').innerText = totalGuests;
                }

                // Default view
                const currentYear = new Date().getFullYear();
                document.getElementById('input-year').value = currentYear;
                fetchRevenueData(currentYear, '', 1); // Assuming homestayId is 1 for default view
            });


        </script>
    </body>
</html>
