
package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Account;
import model.District;
import model.Homestay;
import model.HomestayFacilities;
import model.HomestayImg;
import model.HomestayType;
import model.Payment;

public class SearchHomestay {

    // Method to search for homestays based on district, dates, and number of guests
    public static ArrayList<Homestay> searchHomestay(String district, Date checkIn, Date checkOut, int numberOfPersons) {
        ArrayList<Homestay> homestays = new ArrayList<>();

        String sql = "SELECT h.* " +
                     "FROM dbo.tblHomestay h " +
                     "LEFT JOIN ( " +
                     "    SELECT ht_id, SUM(capacity) AS total_capacity " +
                     "    FROM dbo.tblRoom rm " +
                     "    WHERE rm.room_status = 1 " +
                     "    GROUP BY ht_id " +
                     ") rc ON h.ht_id = rc.ht_id " +
                     "WHERE h.district_id IN ( " +
                     "    SELECT district_id " +
                     "    FROM dbo.tblDnDistrict " +
                     "    WHERE district_name LIKE ? " +
                     ") " +
                     "AND rc.total_capacity >= ? "+
                "AND h.ht_status = 3 " ;


        // If both checkIn and checkOut are not null, add date conditions to the query
        if (checkIn != null && checkOut != null) {
            sql += "AND EXISTS ( " +
                   "    SELECT 1 " +
                   "    FROM dbo.tblRoom rm " +
                   "    WHERE rm.ht_id = h.ht_id " +
                   "    AND rm.room_id NOT IN ( " +
                   "        SELECT bd.room_id " +
                   "        FROM dbo.tblBooking_detail bd " +
                   "        JOIN dbo.tblBooking bk ON bd.booking_id = bk.booking_id " +
                   "        WHERE (? <= bk.date_checkout OR bk.date_checkout IS NULL) " +
                   "        AND (? >= bk.date_checkin OR bk.date_checkin IS NULL) " +
                   "    ) " +
                   ")";
        }

        try (Connection conn = DAO.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + district + "%");
            pstmt.setInt(2, numberOfPersons);

            // If both checkIn and checkOut are not null, set date parameters
            if (checkIn != null && checkOut != null) {
                pstmt.setDate(3, checkIn);
                pstmt.setDate(4, checkOut);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Homestay homestay = extractHomestayFromResultSet(rs);
                    homestays.add(homestay);
                }
            }

        } catch (SQLException e) {
            // Handle SQLException properly
            e.printStackTrace();
        }

        return homestays;
    }

    // Method to extract a Homestay object from the ResultSet
    private static Homestay extractHomestayFromResultSet(ResultSet rs) throws SQLException {
        int id = rs.getInt("ht_id");
        String name = rs.getString("ht_name");
        Account owner = AccountDAO.getAccountById(rs.getInt("owner_id"));
        HomestayType type = HomestayTypeDAO.getHomestayTypeById(rs.getInt("ht_type_id"));
        String description = rs.getString("describe");
        District district = DistrictDAO.getDistrictById(rs.getInt("district_id"));
        String addressDetail = rs.getString("address_detail");
        Payment payment = PaymentDAO.getPaymentById(rs.getInt("payment_id"));
        String rules = rs.getString("ht_rules");
        ArrayList<HomestayImg> imgs = HomestayImgDAO.getHomestayImgs(id);
        ArrayList<HomestayFacilities> facilities = HomestayFacilitiesDAO.getHomestayFacilities(id);
        // Add other necessary fields as needed

        return new Homestay(name, owner, type, description, district, addressDetail, payment, imgs, facilities);
    }

  public static List<Homestay> searchHomestay(String district, java.util.Date checkIn, java.util.Date checkOut, int numberOfPersons) {
        Date sqlCheckIn = checkIn != null ? new Date(checkIn.getTime()) : null;
        Date sqlCheckOut = checkOut != null ? new Date(checkOut.getTime()) : null;
        return searchHomestay(district, sqlCheckIn, sqlCheckOut, numberOfPersons);
    }

public static int count(String district, Date checkIn, Date checkOut, int numberOfPersons){
     String sql = " Select count(*)" +
                     "FROM dbo.tblHomestay h " +
                     "LEFT JOIN ( " +
                     "    SELECT ht_id, SUM(capacity) AS total_capacity " +
                     "    FROM dbo.tblRoom rm " +
                     "    WHERE rm.room_status = 1 " +
                     "    GROUP BY ht_id " +
                     ") rc ON h.ht_id = rc.ht_id " +
                     "WHERE h.district_id IN ( " +
                     "    SELECT district_id " +
                     "    FROM dbo.tblDnDistrict " +
                     "    WHERE district_name LIKE ? " +
                     ") " +
                     "AND rc.total_capacity >= ? "+
                       "AND h.ht_status = 3 " ;

        // If both checkIn and checkOut are not null, add date conditions to the query
        if (checkIn != null && checkOut != null) {
            sql += "AND EXISTS ( " +
                   "    SELECT 1 " +
                   "    FROM dbo.tblRoom rm " +
                   "    WHERE rm.ht_id = h.ht_id " +
                   "    AND rm.room_id NOT IN ( " +
                   "        SELECT bd.room_id " +
                   "        FROM dbo.tblBooking_detail bd " +
                   "        JOIN dbo.tblBooking bk ON bd.booking_id = bk.booking_id " +
                   "        WHERE (? <= bk.date_checkout OR bk.date_checkout IS NULL) " +
                   "        AND (? >= bk.date_checkin OR bk.date_checkin IS NULL) " +
                   "    ) " +
                   ")";
        }

        try (Connection conn = DAO.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + district + "%");
            pstmt.setInt(2, numberOfPersons);

            // If both checkIn and checkOut are not null, set date parameters
            if (checkIn != null && checkOut != null) {
                pstmt.setDate(3,  checkIn);
                pstmt.setDate(4,checkOut);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                  return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            // Handle SQLException properly
            e.printStackTrace();
        }
        return 0;
    }


 public static int count (String district, java.util.Date checkIn, java.util.Date checkOut, int numberOfPersons) {
        Date sqlCheckIn = checkIn != null ? new Date(checkIn.getTime()) : null;
        Date sqlCheckOut = checkOut != null ? new Date(checkOut.getTime()) : null;
        return count(district, sqlCheckIn, sqlCheckOut, numberOfPersons);
    }
}
        