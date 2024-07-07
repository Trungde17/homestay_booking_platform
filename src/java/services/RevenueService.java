/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package services;

import DAO.BookingDAO;
import java.util.*;
import java.text.*;
import model.Booking;

public class RevenueService {

    public RevenueService() {
    }

    public double getRevenueForDate(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date startDate = cal.getTime();

        cal.add(Calendar.DAY_OF_MONTH, 1);
        Date endDate = cal.getTime();

        List<Booking> bookings = BookingDAO.getBookingsByDateRange(startDate, endDate);
        return bookings.stream().mapToDouble(Booking::getPaid_amount).sum();
    }

    public double getTotalRevenue() {
        List<Booking> bookings = BookingDAO.getAllBookings();
        return bookings.stream().mapToDouble(Booking::getPaid_amount).sum();
    }

    public Map<String, Double> getRevenueForLast10Days() {
        Map<String, Double> revenueMap = new LinkedHashMap<>();
        Calendar cal = Calendar.getInstance();

        // Go back 10 days to start from the oldest date
        cal.add(Calendar.DAY_OF_MONTH, -10);

        for (int i = 0; i < 10; i++) {
            Date date = cal.getTime();
            double revenue = getRevenueForDate(date);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            revenueMap.put(sdf.format(date), revenue);
            cal.add(Calendar.DAY_OF_MONTH, 1);
        }

        return revenueMap;
    }
}
