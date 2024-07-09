/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import static DAO.DAO.getConnection;
import java.awt.List;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import model.HostUpgradeRequest;
import model.ImageHost;

/**
 *
 * @author ASUS
 */
public class RegisterOwnerDAO {

    public static boolean submitUpgradeRequest(HostUpgradeRequest request) {
        String ownerQuery = "INSERT INTO tblOwner (account_id, id_number, bank_account, bank_name, account_holder, status, request_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String imgQuery = "INSERT INTO tblHostImg (id, img_url, roles) VALUES (?, ?, ?)";

        try (Connection con = getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement ownerStmt = con.prepareStatement(ownerQuery, Statement.RETURN_GENERATED_KEYS); PreparedStatement imgStmt = con.prepareStatement(imgQuery)) {

                // Insert into tblOwner
                ownerStmt.setInt(1, request.getAccountId());
                ownerStmt.setString(2, request.getIdNumber());
                ownerStmt.setString(3, request.getBankAccount());
                ownerStmt.setString(4, request.getBankName());
                ownerStmt.setString(5, request.getAccountHolder());
                ownerStmt.setInt(6, 2);
                ownerStmt.setTimestamp(7, new java.sql.Timestamp(new java.util.Date().getTime()));
                ownerStmt.executeUpdate();

                //get the generate request id
                ResultSet generatedKeys = ownerStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1);
                    request.setId(id); // Set the generated ID back to the request object
                } else {
                    throw new SQLException("Failed to get generated owner ID.");
                }

                // Insert ID images into tblHostIMG
                for (ImageHost idImage : request.getIdImagePath()) {
                    imgStmt.setInt(1, request.getId());
                    imgStmt.setString(2, idImage.getImg_url());
                    imgStmt.setInt(3, 1); // Assuming 1 is the role for ID images
                    imgStmt.executeUpdate();
                }

                // Insert ownership document images into tblHostIMG
                for (ImageHost docImage : request.getOwnershipDocPath()) {
                    imgStmt.setInt(1, request.getId());
                    imgStmt.setString(2, docImage.getImg_url());
                    imgStmt.setInt(3, 2); // Assuming 2 is the role for ownership documents
                    imgStmt.executeUpdate();
                }

                con.commit();
                return true;
            } catch (SQLException e) {
                con.rollback();
                System.out.println("Error in submitUpgradeRequest: " + e.getMessage());
                return false;
            }
        } catch (SQLException e) {
            System.out.println("Database connection error: " + e.getMessage());
            return false;
        }
    }

    public static ArrayList<HostUpgradeRequest> getPendingRequests() {
        ArrayList<HostUpgradeRequest> requests = new ArrayList<>();
        String query = "SELECT * FROM tblOwner WHERE status = ?";
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setInt(1, 2);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                HostUpgradeRequest request = new HostUpgradeRequest();
                request.setId(rs.getInt("id"));
                request.setAccountId(rs.getInt("account_id"));
                request.setIdNumber(rs.getString("id_number"));
                request.setBankAccount(rs.getString("bank_account"));
                request.setBankName(rs.getString("bank_name"));
                request.setAccountHolder(rs.getString("account_holder"));
                request.setStatus(rs.getInt("status"));
                request.setRequestDate(rs.getDate("request_date"));
                requests.add(request);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return requests;
    }

    public static boolean updateRequestStatus(int requestId, int status) {
        String query = "UPDATE tblOwner SET status = ? WHERE id = ?";
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setInt(1, status);
            stmt.setInt(2, requestId);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

//   public static HostUpgradeRequest getRequestById(int requestId) {
//    String ownerQuery = "SELECT * FROM tblOwner WHERE id = ?";
//    String imgQuery = "SELECT * FROM tblHostIMG WHERE id = ?";
//
//    try (Connection con = getConnection()) {
//        PreparedStatement ownerStmt = con.prepareStatement(ownerQuery);
//        ownerStmt.setInt(1, requestId);
//        try (ResultSet rs = ownerStmt.executeQuery()) {
//            if (rs.next()) {
//                HostUpgradeRequest request = new HostUpgradeRequest();
//                request.setAccountId(rs.getInt("account_id"));
//                
//                return request;
//            }
//        }
//    } catch (SQLException e) {
//        System.out.println("Error fetching request by ID: " + e.getMessage());
//    }
//    return null;
//}
    public static HostUpgradeRequest getRequestById(int requestId) {
        String ownerQuery = "SELECT * FROM tblOwner WHERE id = ?";
        String imgQuery = "SELECT * FROM tblHostImg WHERE id = ?";

        try (Connection con = getConnection()) {
            // Retrieve data from tblOwner
            PreparedStatement ownerStmt = con.prepareStatement(ownerQuery);
            ownerStmt.setInt(1, requestId);
            try (ResultSet rs = ownerStmt.executeQuery()) {
                if (rs.next()) {
                    HostUpgradeRequest request = new HostUpgradeRequest();
                    request.setId(rs.getInt("id"));
                    request.setAccountId(rs.getInt("account_id"));
                    request.setIdNumber(rs.getString("id_number"));
                    request.setBankAccount(rs.getString("bank_account"));
                    request.setBankName(rs.getString("bank_name"));
                    request.setAccountHolder(rs.getString("account_holder"));
                    request.setStatus(rs.getInt("status"));
                    request.setRequestDate(rs.getDate("request_date"));

                    // Retrieve associated images from tblHostIMG
                    PreparedStatement imgStmt = con.prepareStatement(imgQuery);
                    imgStmt.setInt(1, requestId);
                    try (ResultSet imgRs = imgStmt.executeQuery()) {
                        ArrayList<ImageHost> idImages = new ArrayList<>();
                        ArrayList<ImageHost> docImages = new ArrayList<>();
                        while (imgRs.next()) {
                            ImageHost image = new ImageHost();
                            image.setImg_id(imgRs.getInt("img_id"));
                            image.setImg_url(imgRs.getString("img_url"));
                            image.setRoles(imgRs.getInt("roles"));

                            if (image.getRoles() == 1) {
                                idImages.add(image); // Assuming role 1 is for ID images
                            } else if (image.getRoles() == 2) {
                                docImages.add(image); // Assuming role 2 is for ownership documents
                            }
                        }

                        request.setIdImagePath(idImages);
                        request.setOwnershipDocPath(docImages);
                    }
                    return request;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching request by ID: " + e.getMessage());
        }
        return null;
    }

    public static boolean isUpgradeRequestPending(int accountId) {
        String query = "SELECT COUNT(*) AS count FROM tblOwner WHERE account_id = ? AND status = 2";

        try (Connection con = getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, accountId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("count");
                    return count > 0; // Return true if there is at least one pending request
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching request by ID: " + e.getMessage());
        }
        return false;
    }

    public static int getOwnerStatus(int accountId) {
        String sql = "SELECT status FROM tblOwner WHERE account_id = ?";
        int status=0;

        try (Connection con = getConnection(); 
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, accountId);

           
            try (ResultSet rs = stmt.executeQuery()) {
                
                if (rs.next()) {
                    status = rs.getInt("status");
                }
            }

        } catch (SQLException e) {
            System.out.println("Error in getOwnerStatus: " + e.toString());
            // Consider throwing an exception or logging based on your application's error handling strategy
        }

        return status;
    }

    public static void main(String[] args) {

//        // Create sample ImageHost objects for ID images
        ImageHost idImage1 = new ImageHost(1, 1, "http://example.com/id_image1.jpg");
        ImageHost idImage2 = new ImageHost(1, 2, "http://example.com/id_image2.jpg");

        ArrayList<ImageHost> idImages = new ArrayList<>(Arrays.asList(idImage1, idImage2));
        // Create sample ImageHost objects for ownership document images
        ImageHost docImage1 = new ImageHost(2, 1, "http://example.com/doc_image1.jpg");
        ImageHost docImage2 = new ImageHost(2, 2, "http://example.com/doc_image2.jpg");
        ArrayList<ImageHost> docImages = new ArrayList<>(Arrays.asList(docImage1, docImage2));

        // Create a sample HostUpgradeRequest object
        HostUpgradeRequest request = new HostUpgradeRequest();
        request.setId(1);
        request.setAccountId(1); // Assuming account_id 1 exists in tblAccount
        request.setIdNumber("156789");
        request.setBankAccount("987654321");
        request.setBankName("Sample Bank");
        request.setAccountHolder("John Doe");
        request.setIdImagePath(idImages);
        request.setOwnershipDocPath(docImages);

        // Call the method to test
        boolean success = submitUpgradeRequest(request);

        if (success) {
            System.out.println("Data inserted successfully!");
        } else {
            System.out.println("Failed to insert data.");
        }

//// Assuming the submitUpgradeRequest method is defined elsewhere in the same class
//        ArrayList<HostUpgradeRequest> pendingRequests = RegisterOwnerDAO.getPendingRequests();
//
//        // Print out the details of each pending request
//        System.out.println("Pending Upgrade Requests:");
//        for (HostUpgradeRequest request1 : pendingRequests) {
//            System.out.println("Request ID: " + request1.getId()); // Assuming getId() method exists in HostUpgradeRequest
//            System.out.println("Account ID: " + request1.getAccountId());
//            System.out.println("ID Number: " + request1.getIdNumber());
//            System.out.println("Bank Account: " + request1.getBankAccount());
//            System.out.println("Bank Name: " + request1.getBankName());
//            System.out.println("Account Holder: " + request1.getAccountHolder());
//            System.out.println("Status: " + request1.getStatus());
//            System.out.println("Request Date: " + request1.getRequestDate());
//            System.out.println("ID Images:");
//            for (ImageHost idImage : request
//                    .getIdImagePath()) {
//                System.out.println("Image URL: " + idImage.getImg_url() + ", Role: " + idImage.getRoles());
//            }
//            System.out.println("Ownership Document Images:");
//            for (ImageHost docImage : request.getOwnershipDocPath()) {
//                System.out.println("- Image URL: " + docImage.getImg_url() + ", Role: " + docImage.getRoles());
//            }
//            System.out.println("-----------------------------------------");
//        }
//    }}
        // Example account IDs to test
        int accountId1 = 1;
        int accountId2 = 2;

        // Test getOwnerStatus method
        int status1 = RegisterOwnerDAO.getOwnerStatus(accountId1);
        int status2 = RegisterOwnerDAO.getOwnerStatus(accountId2);

        // Display results
        System.out.println("Status for accountId1: " + status1);
        System.out.println("Status for accountId2: " + status2);
        getRequestById(1);
    }}



