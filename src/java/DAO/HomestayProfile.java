package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.*;

public class HomestayProfile {

    public Homestay getHomestayById(int homestayId) {
        Homestay homestay = null;
        Connection connection = DAO.getConnection();
        try {
            String sql = "SELECT h.*, a.first_name AS owner_first_name, a.last_name AS owner_last_name, "
                       + "ht.ht_type_name, d.district_name, p.payment_number "
                       + "FROM tblHomestay h "
                       + "JOIN tblAccount a ON h.owner_id = a.account_id "
                       + "JOIN tblHomestayType ht ON h.ht_type_id = ht.ht_type_id "
                       + "JOIN tblDnDistrict d ON h.district_id = d.district_id "
                       + "LEFT JOIN tblPaymentAccount p ON h.payment_id = p.payment_id "
                       + "WHERE h.ht_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, homestayId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account owner = new Account(rs.getInt("owner_id"), rs.getString("owner_first_name"), rs.getString("owner_last_name"));
                HomestayType homestayType = new HomestayType(rs.getInt("ht_type_id"), rs.getString("ht_type_name"));
                District district = new District(rs.getInt("district_id"), rs.getString("district_name"));
                Payment payment = new Payment(rs.getInt("payment_id"), rs.getString("payment_number"));
                homestay = new Homestay(
                    rs.getInt("ht_id"),
                    rs.getString("ht_name"),
                    owner,
                    homestayType,
                    rs.getString("describe"),
                    district,
                    rs.getString("address_detail"),
                    payment,
                    rs.getString("ht_rules"),
                    getHomestayRules(homestayId, connection),
                    getHomestayImages(homestayId, connection),
                    getHomestayFacilities(homestayId, connection),
                    getHomestayNeighbourhoods(homestayId, connection),
                    rs.getDate("registration_date"),
                    getRoomsByHomestayId(homestayId, connection),
                    null, // Admin details are not required as per your comment
                    rs.getBoolean("ht_status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return homestay;
    }

    private ArrayList<Rule> getHomestayRules(int homestayId, Connection connection) {
        ArrayList<Rule> rules = new ArrayList<>();
        String sql = "SELECT r.* FROM tblRules r JOIN tblHomestayRules hr ON r.rule_id = hr.rule_id WHERE hr.ht_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, homestayId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rules.add(new Rule(rs.getInt("rule_id"), rs.getString("rule_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rules;
    }

    private ArrayList<HomestayImg> getHomestayImages(int homestayId, Connection connection) {
        ArrayList<HomestayImg> images = new ArrayList<>();
        String sql = "SELECT * FROM tblHomestayImg WHERE ht_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, homestayId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                images.add(new HomestayImg(rs.getInt("img_id"), rs.getString("image_url"), rs.getInt("img_role")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return images;
    }

    private ArrayList<HomestayFacilities> getHomestayFacilities(int homestayId, Connection connection) {
        ArrayList<HomestayFacilities> facilities = new ArrayList<>();
        String sql = "SELECT f.* FROM tblHomestayFacilities f JOIN tblFacilitiesOfHomestay fh ON f.facility_id = fh.facility_id WHERE fh.ht_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, homestayId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                facilities.add(new HomestayFacilities(rs.getInt("facility_id"), rs.getString("facility_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return facilities;
    }

    private ArrayList<Neighbourhood> getHomestayNeighbourhoods(int homestayId, Connection connection) {
        ArrayList<Neighbourhood> neighbourhoods = new ArrayList<>();
        String sql = "SELECT n.* FROM tblNeighbourhood n JOIN tblNeighbourhoodOfHomestay nh ON n.neighhourhood_id = nh.neighhourhood_id WHERE nh.ht_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, homestayId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                neighbourhoods.add(new Neighbourhood(rs.getInt("neighhourhood_id"), rs.getString("neighhourhood_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return neighbourhoods;
    }

    private ArrayList<Room> getRoomsByHomestayId(int homestayId, Connection connection) {
        ArrayList<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM tblRoom WHERE ht_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, homestayId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Room room = new Room(
                    rs.getInt("room_id"),
                    rs.getString("room_name"),
                    rs.getString("room_description"),
                    rs.getInt("capacity"),
                    rs.getString("size"),
                    rs.getString("bed_type"),
                    getRoomImages(rs.getInt("room_id"), connection),
                    getRoomFacilities(rs.getInt("room_id"), connection),
                    getRoomPrices(rs.getInt("room_id"), connection),
                    rs.getBoolean("room_status")
                );
                rooms.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    private ArrayList<Img> getRoomImages(int roomId, Connection connection) {
        ArrayList<Img> images = new ArrayList<>();
        String sql = "SELECT * FROM tblRoomImg WHERE room_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                images.add(new Img(rs.getInt("img_id"), rs.getString("img_url")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return images;
    }

    private ArrayList<RoomFacilities> getRoomFacilities(int roomId, Connection connection) {
        ArrayList<RoomFacilities> facilities = new ArrayList<>();
        String sql = "SELECT f.* FROM tblRoomFacilities f JOIN tblFacilitiesOfRoom fr ON f.facility_id = fr.facility_id WHERE fr.room_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                facilities.add(new RoomFacilities(rs.getInt("facility_id"), rs.getString("facility_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return facilities;
    }

    private ArrayList<RoomPrice> getRoomPrices(int roomId, Connection connection) {
        ArrayList<RoomPrice> prices = new ArrayList<>();
        String sql = "SELECT * FROM tblRoomPrice WHERE room_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                prices.add(new RoomPrice(rs.getInt("price_id"), rs.getString("price_type"), rs.getDouble("amount_per_night")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return prices;
    }
}
