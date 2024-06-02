package DAO;
import java.sql.*;
import java.util.ArrayList;
import model.Neighbourhood;
public class NeighbourhoodDAO extends DAO{
    public static ArrayList<Neighbourhood>getNeighbourhoods(int homestay_id){
        try(Connection con=getConnection()) {
            PreparedStatement stmt=con.prepareStatement("select * from tblNeighbourhood as n join tblNeighbourhoodOfHomestay as nh on n.neighhourhood_id=nh.neighhourhood_id where ht_id=?");
            stmt.setInt(1, homestay_id);
            return createNeighbourhoodsBaseResultSet(stmt.executeQuery());
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    private static ArrayList<Neighbourhood>createNeighbourhoodsBaseResultSet(ResultSet rs){
        try {
            ArrayList<Neighbourhood>result=new ArrayList<>();
            while(rs.next()){
                result.add(new Neighbourhood(rs.getInt("neighhourhood_id"), rs.getString("neighhourhood_name")));
            }
            return result;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
}
