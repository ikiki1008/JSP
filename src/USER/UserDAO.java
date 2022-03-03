package USER;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO(){
		try {
			String dbURL = "jdbc:mysql://localhost:3310/BBS";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword){
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?"; //what's ID?
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs=pstmt.executeQuery();
			if (rs.next()){
				if(rs.getString(1).equals(userPassword)){
					return 1; //login success
				}
				else 
					return 0; //password is not correct
			}
			return -1; //if there's no ID
		}catch(Exception e){
			e.printStackTrace();
		}
		return -2; //-2 means error of database..
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO VALUES (?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e){
			e.printStackTrace();
		}
		return -1; //database error
	}

}
