package Members;

import java.sql.*;

public class TestDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public TestDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbID = "YOON"; /* 노트북 개발시 C##Scott */
			String dbPW = "3304";
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void login(String USER_ID, String USER_PW, String USER_PERM) {
		String sql = "SELECT * FROM MEMBERS WHERE USER_ID=?";
		try{/* 쿼리문 */
	        pstmt = conn.prepareStatement(sql); /*conn으로 연결한뒤 , statement로 값을 넘긴다,쿼리문을 실행한다.  */
	        pstmt.setString(1,USER_ID);/*쿼리문에 1번쨰 ?로 입력 될 값 id가 들어간다.  */
	        rs = pstmt.executeQuery();/*execute(실행한다)Query를 */
	        while(rs.next()) {
	        	String check_id = rs.getString("USER_ID");
		        String check_pw = rs.getString("USER_PW");
		        System.out.println(check_id);
		        System.out.println(check_pw);	
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}