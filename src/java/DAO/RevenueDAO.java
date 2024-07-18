
package DAO;
import java.sql.*;
import java.util.ArrayList;
import model.Revenue;


public class RevenueDAO extends DAO{
    public static ArrayList<Revenue> getRevenueData(String year, String month, int homestayId) {
        ArrayList<Revenue> revenueList = new ArrayList<>();
        String sql = "";

        if (month == null || month.isEmpty()|| month.equals("0")) {
            sql = "SELECT Month, SUM(total_revenue) AS total_revenue, SUM(total_bookings) AS total_bookings, SUM(total_guests) AS total_guests " +
                  "FROM vw_Revenue " +
                  "WHERE Year = ? AND ht_id = ? " +
                  "GROUP BY Month";
        } else {
            sql = "SELECT Day, total_revenue, total_bookings, total_guests " +
                  "FROM vw_Revenue " +
                  "WHERE Year = ? AND Month = ? AND ht_id = ?";
        }

        try (Connection con=getConnection();
                PreparedStatement stmt = con.prepareStatement(sql);){
            
            stmt.setString(1, year);
            if (month != null && !month.isEmpty() && !month.equals("0")) {
                stmt.setString(2, month);
                stmt.setInt(3, homestayId);
            }
            else stmt.setInt(2, homestayId);
            ResultSet resultSet = stmt.executeQuery();

            while (resultSet.next()) {
                Revenue revenue = new Revenue();
                if (month == null || month.isEmpty() || month.equals("0")) {
                    revenue.setLabel(resultSet.getString("Month"));
                } else {
                    revenue.setLabel(resultSet.getString("Day"));
                }
                revenue.setTotalRevenue(resultSet.getDouble("total_revenue"));
                revenue.setTotalBookings(resultSet.getInt("total_bookings"));
                revenue.setTotalGuests(resultSet.getInt("total_guests"));
                revenueList.add(revenue);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return revenueList;
    }
    public static void main(String[] args) {
        ArrayList<Revenue>list=getRevenueData("2024", "7", 1);
        for(Revenue r:list){
            System.out.println(r.getTotalRevenue());
        }
    }
}
