
package DAO;

import java.sql.*;
import java.util.ArrayList;
import model.Rule;
public class RuleDAO extends DAO{
    public static ArrayList<Rule>getHomestayRules(int homestay_id){
        try(Connection con=getConnection()) {
            PreparedStatement stmt=con.prepareStatement("select*from tblHomestayRules as hr join tblRules as r "
                    + "on hr.rule_id=r.rule_id where ht_id=?");
            stmt.setInt(1, homestay_id);
            return createRulesBaseResultset(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static ArrayList<Rule> getAll(){
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("select * from tblRules");
            return createRulesBaseResultset(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    private static ArrayList<Rule>createRulesBaseResultset(ResultSet rs){
        try {
            ArrayList<Rule>result=new ArrayList<>();
            while(rs.next()){
                result.add(new Rule(rs.getInt("rule_id"), rs.getString("rule_name")));
            }
            return result;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public static void main(String[] args) {
        ArrayList<Rule> arr=getAll();
        for(Rule r:arr){
            System.out.println(r.getRule_name());
        }
    }
}
