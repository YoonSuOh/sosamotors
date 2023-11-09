package Members;

import java.sql.*;
import java.util.ArrayList;

import Car.Car;
import bbs.Bbs;

public class MembersDAO {
	private static MembersDAO dao = new MembersDAO();
	private static Connection conn;
	private static PreparedStatement pstmt;
	private static ResultSet rs;
	
	public static MembersDAO getInstance() {
		return dao;
	}
	
	public MembersDAO() {
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
	
	public static int getNext() {
		String sql = "select USER_NUM from Members order by USER_NUM desc";
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbID = "YOON"; /* 노트북 개발시 C##Scott */
			String dbPW = "3304";
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public Members login(String USER_ID, String USER_PW) {
		Members dto = new Members();
		String sql = "SELECT * FROM MEMBERS WHERE USER_ID=? AND USER_PW=?";
		try{/* 쿼리문 */
	        pstmt = conn.prepareStatement(sql); /*conn으로 연결한뒤 , statement로 값을 넘긴다,쿼리문을 실행한다.  */
	        pstmt.setString(1,USER_ID);/*쿼리문에 1번쨰 ?로 입력 될 값 id가 들어간다.  */
	        pstmt.setString(2, USER_PW);
	        rs = pstmt.executeQuery();/*execute(실행한다)Query를 */
	        if(rs.next()) {
	        	dto.setUSER_ID(rs.getString("USER_ID"));
	        	dto.setUSER_PW(rs.getString("USER_PW"));
	        	dto.setUSER_PERM(rs.getString("USER_PERM"));
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public int join(Members Members) {
		String sql = "insert into MEMBERS Values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, Members.getUSER_ID());
			pstmt.setString(3, Members.getUSER_PW());
			pstmt.setString(4, Members.getUSER_NICK());
			pstmt.setString(5, Members.getUSER_NAME());
			pstmt.setString(6, Members.getUSER_PERM());
			pstmt.setString(7, Members.getUSER_EMAIL());
			pstmt.setString(8, Members.getUSER_PHONE());
			pstmt.setInt(9, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	public static boolean nextPage(int pageNumber) {
		String sql = "select * from CAR where LIST_NUM < ? and LIST_NUM_AVAILABLE = 1";
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbID = "YOON"; /* 노트북 개발시 C##Scott */
			String dbPW = "3304";
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1)*12);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public String find_id(String USER_NAME, String USER_EMAIL) {
		String id = null;
		String sql = "SELECT USER_ID FROM MEMBERS WHERE USER_NAME=? AND USER_EMAIL=?";
		try{/* 쿼리문 */
	        pstmt = conn.prepareStatement(sql); /*conn으로 연결한뒤 , statement로 값을 넘긴다,쿼리문을 실행한다.  */
	        pstmt.setString(1, USER_NAME);/*쿼리문에 1번쨰 ?로 입력 될 값 id가 들어간다.  */
	        pstmt.setString(2, USER_EMAIL);
	        rs = pstmt.executeQuery();/*execute(실행한다)Query를 */
	        if(rs.next()) {
	        	id = rs.getString("USER_ID");
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}
	public String find_pw(String USER_ID) {
		String id = null;
		String sql = "SELECT USER_PW FROM MEMBERS WHERE USER_ID=?";
		try{/* 쿼리문 */
	        pstmt = conn.prepareStatement(sql); /*conn으로 연결한뒤 , statement로 값을 넘긴다,쿼리문을 실행한다.  */
	        pstmt.setString(1, USER_ID);/*쿼리문에 1번쨰 ?로 입력 될 값 id가 들어간다.  */
	        rs = pstmt.executeQuery();/*execute(실행한다)Query를 */
	        if(rs.next()) {
	        	id = rs.getString("USER_ID");
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}
// 관리자 영역 코드
	public static ArrayList<Members> getList(int pageNumber){
		String sql = "select * from MEMBERS where USER_NUM <? and USER_NUM_AVAILABLE = 1 and ROWNUM <= 12 order by USER_NUM desc";
		ArrayList<Members> list = new ArrayList<Members>();
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbID = "YOON"; /* 노트북 개발시 C##Scott */
			String dbPW = "3304";
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Members userlist = new Members();
				userlist.setUSER_NUM(rs.getInt(1));
				userlist.setUSER_ID(rs.getString(2));
				userlist.setUSER_PW(rs.getString(3));
				userlist.setUSER_NICK(rs.getString(4));
				userlist.setUSER_NAME(rs.getString(5));
				userlist.setUSER_PERM(rs.getString(6));
				userlist.setUSER_EMAIL(rs.getString(7));
				userlist.setUSER_PHONE(rs.getString(8));
				userlist.setUSER_NUM_AVAILABLE(rs.getInt(9));
				list.add(userlist);
			}	
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Members getMembers(int USER_NUM) {
		String sql = "select * from Members where USER_NUM = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, USER_NUM);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Members userlist = new Members();
				userlist.setUSER_NUM(rs.getInt(1));
				userlist.setUSER_ID(rs.getString(2));
				userlist.setUSER_PW(rs.getString(3));
				userlist.setUSER_NICK(rs.getString(4));
				userlist.setUSER_NAME(rs.getString(5));
				userlist.setUSER_PERM(rs.getString(6));
				userlist.setUSER_EMAIL(rs.getString(7));
				userlist.setUSER_PHONE(rs.getString(8));
				userlist.setUSER_NUM_AVAILABLE(rs.getInt(9));
				return userlist;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int grant(int USER_NUM, String USER_PERM) {
		String sql = "update Members set USER_PERM = ? where USER_NUM = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, USER_PERM);
			pstmt.setInt(2, USER_NUM);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}
