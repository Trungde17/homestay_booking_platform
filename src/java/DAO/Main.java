package DAO;
import java.sql.Date;
import java.util.ArrayList;
import model.Homestay;
import DAO.SearchHomestay;
//
//public class Main {
//    public static void main(String[] args) {
//        // Example values for district and dates
//        String district = "Hải Châu";
//        Date checkIn = Date.valueOf("2024-06-10");
//        Date checkOut = Date.valueOf("2024-06-15");
//
//        // Search for homestays
//        ArrayList<Homestay> homestays = SearchHomestay.searchHomestay(district, checkIn, checkOut);
//
//        // Display the results
//        for (Homestay homestay : homestays) {
//            System.out.println(homestay.getHt_name());
//            // Display other details as needed
//        }
//    }
//}
import java.sql.*;

public class Main {
    public static void main(String[] args) {
        // JDBC URL, username, and password
        

        // Parameters for the SQL query
        String districtName = "Hải Châu";
        Date checkOutDate = Date.valueOf("2024-06-10");
        Date checkInDate = Date.valueOf("2024-06-15");
        int minCapacity = 2;

        // SQL query
        ArrayList<Homestay> homestays = SearchHomestay.searchHomestay(districtName, checkInDate, checkOutDate,minCapacity);

        // Display the results
        for (Homestay homestay : homestays) {
            System.out.println(homestay.getHt_name());
    }

        
    }
}

