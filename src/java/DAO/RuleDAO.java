package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.Rule;

public class RuleDAO extends DAO {

    public static ArrayList<Rule> getHomestayRules(int homestay_id) {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select*from tblHomestayRules as hr join tblRules as r "
                    + "on hr.rule_id=r.rule_id where ht_id=?");
            stmt.setInt(1, homestay_id);
            return createRulesBaseResultset(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static ArrayList<Rule> getAll() {
        try (Connection con = getConnection()) {
            PreparedStatement stmt = con.prepareStatement("select * from tblRules");
            return createRulesBaseResultset(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static int insertHomestayRules(int homestay_id, int[]rules){
        int number=0;
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("insert into tblHomestayRules(ht_id, rule_id) values(?, ?)");
            stmt.setInt(1, homestay_id);
            for(int rule_id : rules ){
                stmt.setInt(2, rule_id);
                stmt.executeUpdate();
                number++;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return number;
    }
    
    private static ArrayList<Rule> createRulesBaseResultset(ResultSet rs) {
        try {
            ArrayList<Rule> result = new ArrayList<>();
            while (rs.next()) {
                result.add(new Rule(rs.getInt("rule_id"), rs.getString("rule_name")));
            }
            return result;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        insertHomestayRules(1, new int[]{1, 2});
    }
}
