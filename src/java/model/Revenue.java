package model;

public class Revenue {
    private String label; // Sử dụng để lưu trữ tháng hoặc ngày tùy thuộc vào truy vấn
    private double totalRevenue; // Tổng doanh thu
    private int totalBookings; // Tổng số lượng booking
    private int totalGuests; // Tổng số lượng khách

    // Getters and Setters
    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public int getTotalBookings() {
        return totalBookings;
    }

    public void setTotalBookings(int totalBookings) {
        this.totalBookings = totalBookings;
    }

    public int getTotalGuests() {
        return totalGuests;
    }

    public void setTotalGuests(int totalGuests) {
        this.totalGuests = totalGuests;
    }
}
