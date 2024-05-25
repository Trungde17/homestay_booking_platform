package DAO;

import static DAO.DAO.getConnection;
import java.sql.*;
import java.util.ArrayList;
import model.Account;

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

    private static ArrayList<Account> createAccountFromResultSet(ResultSet rs) {
        if (rs != null) {
            ArrayList<Account> result = new ArrayList();
            try {
                while (rs.next()) {
                    try {
                        result.add(new Account(
                                rs.getInt("account_id"), rs.getString("email"), rs.getString("password"), rs.getString("first_name"), rs.getString("last_name"),
                                rs.getString("gender"), rs.getString("phone"), rs.getString("address"), rs.getString("avatar_img"),
                                rs.getString("payment_account"), rs.getInt("roles_account"), rs.getDate("registration_date")));
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
    // Account

    public  Account checkAcc(String email, String password) {
        String sql = "SELECT * FROM tblAccount WHERE email = ? AND password = ?";
                
        try (Connection con = getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account c = new Account(//0, email, password, sql, password, email, sql, sql, email, password, 0, registration_date)
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getInt(11),
                        rs.getDate(12)
                );
                return c;
            }
        } catch (SQLException e) {
            System.out.println("Err check acc");
        }
        return null;
    }
    

    public static void changePass(Account c) {
        String sql = """
                     UPDATE tblAccount
                        SET password = ?
                        WHERE email = ?""";
        try (Connection con = getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, c.getPassword());
            ps.setString(2, c.getEmail());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
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
       
        getConnection();
        //updateProfile(c);

                
    }

}
