/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import static DAO.DAO.getConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Collectors;
import model.HostUpgradeRequest;
import model.ImageHost;

/**
 *
 * @author ASUS
 */
public class RegisterOwnerDAO {

        public static boolean submitUpgradeRequest(HostUpgradeRequest request) {
            String query = "INSERT INTO tblOwner (user_id, id_number, bank_account, bank_name, account_holder, phone_number, permanent_address, id_image_path, ownership_doc_path, status, request_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending', NOW())";
            try (Connection con = getConnection()) {
                PreparedStatement stmt = con.prepareStatement(query);
                stmt.setInt(1, request.getAccountId());
                stmt.setString(2, request.getIdNumber());
                stmt.setString(3, request.getBankAccount());
                stmt.setString(4, request.getBankName());
                stmt.setString(5, request.getAccountHolder());
                stmt.setString(6, request.getPhoneNumber());
                stmt.setString(7, request.getPermanentAddress());
                stmt.setString(8, String.join(",", request.getIdImagePath().stream().map(ImageHost::getImg_url).collect(Collectors.toList())));
                stmt.setString(9, String.join(",", request.getOwnershipDocPath().stream().map(ImageHost::getImg_url).collect(Collectors.toList())));

                stmt.executeUpdate();
                return true;
            } catch (Exception e) {
                System.out.println(e.getMessage());                
            }
            return false;
        }

        public static ArrayList<HostUpgradeRequest> getPendingRequests() {
            ArrayList<HostUpgradeRequest> requests = new ArrayList<>();
            String query = "SELECT * FROM tblOwner WHERE status = 2";
            try (Connection con = getConnection()) {
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                while (rs.next()) {
                    HostUpgradeRequest request = new HostUpgradeRequest();
                    request.setId(rs.getInt("id"));
                    request.setAccountId(rs.getInt("account_id"));
                    request.setIdNumber(rs.getString("id_number"));
                    request.setBankAccount(rs.getString("bank_account"));
                    request.setBankName(rs.getString("bank_name"));
                    request.setAccountHolder(rs.getString("account_holder"));
                    request.setPhoneNumber(rs.getString("phone_number"));
                    request.setPermanentAddress(rs.getString("permanent_address"));                    
                    request.setStatus(rs.getInt("status"));
                    request.setRequestDate(rs.getDate("request_date"));
                    requests.add(request);
                }
             } catch (Exception e) {
                System.out.println(e.getMessage());                
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
        

        public static HostUpgradeRequest getRequestById(int requestId) {
            String query = "SELECT * FROM tblOwner WHERE id = ?";
            try (Connection con = getConnection()) {
                PreparedStatement stmt = con.prepareStatement(query);
                stmt.setInt(1, requestId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        HostUpgradeRequest request = new HostUpgradeRequest();
                        request.setId(rs.getInt("id"));
                        request.setAccountId(rs.getInt("account_id"));
                        request.setIdNumber(rs.getString("id_number"));
                        request.setBankAccount(rs.getString("bank_account"));
                        request.setBankName(rs.getString("bank_name"));
                        request.setAccountHolder(rs.getString("account_holder"));
                        request.setPhoneNumber(rs.getString("phone_number"));
                        request.setPermanentAddress(rs.getString("permanent_address"));             
                        request.setStatus(rs.getInt("status"));
                        request.setRequestDate(rs.getDate("request_date"));
                        return request;
                    }
                }
              } catch (Exception e) {
                System.out.println(e.getMessage());                
            }
            return null;
        }
    }

