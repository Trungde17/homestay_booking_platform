
package DTO.homestay;
import java.sql.*;
import java.util.ArrayList;
public class HomestaySummaryDTO extends DAO.DAO{
    private int homestay_id;
    private String homestay_name;
    private int status;

    public HomestaySummaryDTO(int homestay_id, String homestay_name, int status) {
        this.homestay_id = homestay_id;
        this.homestay_name = homestay_name;
        this.status = status;
    }

    public int getHomestay_id() {
        return homestay_id;
    }

    public void setHomestay_id(int homestay_id) {
        this.homestay_id = homestay_id;
    }

    public String getHomestay_name() {
        return homestay_name;
    }

    public void setHomestay_name(String homestay_name) {
        this.homestay_name = homestay_name;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    public static ArrayList<HomestaySummaryDTO>getAllHomestaySummaryDTO(int owner_id){
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("select * from tblHomestay where owner_id=?");
            stmt.setInt(1, owner_id);
            ResultSet rs=stmt.executeQuery();
            ArrayList<HomestaySummaryDTO>homestaySummaryDTOs=new ArrayList<>();
            while(rs.next()){
                homestaySummaryDTOs.add(new HomestaySummaryDTO(rs.getInt("ht_id"), rs.getString("ht_name"), rs.getInt("ht_status")));
            }
            return homestaySummaryDTOs;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static HomestaySummaryDTO getHomestaySummaryDTOById(int homestay_id){
        try (Connection con=getConnection()){
            PreparedStatement stmt=con.prepareStatement("select * from tblHomestay where ht_id=?");
            stmt.setInt(1, homestay_id);
            ResultSet rs=stmt.executeQuery();
            if(rs.next()){
                return new HomestaySummaryDTO(rs.getInt("ht_id"), rs.getString("ht_name"), rs.getInt("ht_status"));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    public static void main(String[] args) {
        System.out.println(getHomestaySummaryDTOById(1).homestay_name);
    }
}
