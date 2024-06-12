package DAO;
import java.sql.*;
public class DAO {
    public static Connection getConnection() {
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://DESKTOP-TH6U346\\SQLEXPRESS:1433;databaseName=booking;encrypt=true;trustServerCertificate=true";
			String userName="sa";
			String password="123";
			Connection connection = DriverManager.getConnection(url, userName, password);
			System.out.println("Connect successfully");
			return connection;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	public static void main(String[] args) {
		getConnection();
	}

}