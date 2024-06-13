package DAO;

import static DAO.DAO.getConnection;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import model.Account;
import model.Payment;

public class AccountDAO extends DAO {

    public static Account verifyTheAccount(String email, String password) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblAccount where email=? AND password=?");
            stmt.setString(1, email);
            stmt.setString(2, password);
            ArrayList<Account> accounts = createAccountFromResultSet(stmt.executeQuery());
            return accounts.get(0);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    public static Account getBasicInforOfAccount(int account_id){
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select account_id, email, first_name,"
                    + "last_name, gender, date_of_birth, phone, address, avatar_img from tblAccount where account_id=?");
            stmt.setInt(1, account_id);
            ResultSet rs=stmt.executeQuery();
            if(rs.next()){
                return new Account(rs.getInt("account_id"), rs.getString("email"), rs.getString("first_name"), rs.getString("last_name"), 
                        rs.getString("gender"), rs.getDate("date_of_birth"), rs.getString("phone"), rs.getString("address"), rs.getString("avatar_img"));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    private static ArrayList<Account> createAccountFromResultSet(ResultSet rs) {
        if (rs != null) {
            ArrayList<Account> result = new ArrayList();
            try {
                while (rs.next()) {
                    try {
                        int account_id = rs.getInt("account_id");
                        ArrayList<Payment>payments=PaymentDAO.getPaymentsOfAccount(account_id);
                        result.add(new Account(
                                account_id, rs.getString("email"), rs.getString("password"), rs.getString("first_name"), rs.getString("last_name"),
                                rs.getString("gender"), rs.getDate("date_of_birth"), rs.getString("phone"), rs.getString("address"), rs.getString("avatar_img"),
                                payments, rs.getInt("roles_account"), rs.getDate("registration_date")));
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                }

                return result;
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return null;
    }
    //hàm kiểm tra email có tồn tại hay không?

    public static boolean checkEmail(String email) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblAccount where email=?");
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    //hàm đếm số lượng account

    public static int count() {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select count(*) as number_account from tblAccount");
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("number_account");
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return -1;
    }

    //hàm signup
    public static Account signupAccount(String email, String password, String first_name, String last_name, int account_role) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("EXEC InsertDataFormSignup @email=?, @password=?, @first_name=?, @last_name=?, @account_role=?");
            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.setString(3, first_name);
            stmt.setString(4, last_name);
            stmt.setInt(5, account_role);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("account_id");
                return getAccountById(id);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public static Account getAccountById(int account_id) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblAccount where account_id=?");
            stmt.setInt(1, account_id);
            ResultSet rs = stmt.executeQuery();
            return createAccountFromResultSet(rs).get(0);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public static Account getAccountByEmail(String email) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblAccount where email=?");
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return createAccountFromResultSet(rs).get(0);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public static boolean changePassword(String email, String password) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("UPDATE tblAccount set password=? where email=?");
            stmt.setString(1, password);
            stmt.setString(2, email);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }   
    
    public static boolean changeAvatar(int account_id, String avatar_img){
        try (Connection con = getConnection()){
            PreparedStatement stmt = con.prepareStatement("UPDATE tblAccount set avatar_img=? where account_id =? ");
            stmt.setString(1, avatar_img);
            stmt.setInt(2, account_id);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
        }
        return false;
    }
    public static void updateProfile(Account c) {
        String sql = "UPDATE tblAccount\n"
                + "   SET "
                + "[first_name] = ?,\n"
                + "[last_name] = ?,\n"
                + "[gender] = ?,\n"
                + "[email] = ?,\n"
                + "[phone] = ?,\n"
                + "[address] = ?\n"
                + "WHERE account_id = ?";
        try (Connection con = getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, c.getFirst_name());
            ps.setString(2, c.getLast_name());
            ps.setString(3, c.getGender());
            ps.setString(4, c.getEmail());
            ps.setString(5, c.getPhone());
            ps.setString(6, c.getAddress());
            ps.setInt(7, c.getAccount_id());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }
    public static void main(String[] args) {
        System.out.println(getBasicInforOfAccount(1).getFirst_name());
    }

}
