package DAO;

import model.Payment;
import java.sql.*;
import java.util.ArrayList;

public class PaymentDAO extends DAO {

    public static Payment getPaymentById(int payment_id) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblPaymentAccount where payment_id=?");
            stmt.setInt(1, payment_id);
            return createPaymentBaseResultSet(stmt.executeQuery()).get(0);
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static ArrayList<Payment> getPaymentsOfAccount(int account_id) {
        try (Connection con = getConnection()) {
            ArrayList<Payment> payments = new ArrayList<>();
            PreparedStatement stmt = con.prepareStatement("select * from tblPaymentAccount where account_id=?");
            stmt.setInt(1, account_id);
            return createPaymentBaseResultSet(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    private static ArrayList<Payment> createPaymentBaseResultSet(ResultSet rs) {

        try {
            ArrayList<Payment> payments = new ArrayList<>();
            while (rs.next()) {
                Payment payment = new Payment(rs.getInt("payment_id"), rs.getString("payment_number"));
                payments.add(payment);
            }
            return payments;
        } catch (Exception e) {
            System.out.println(e);
        }

        return null;
    }

    public static void main(String[] args) {
        ArrayList<Payment> payment = getPaymentsOfAccount(1);
        for (Payment p : payment) {
            System.out.println(p.getPayment_number());
        }
    }
}
