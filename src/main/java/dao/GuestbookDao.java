package dao;

import java.sql.*;
import java.util.ArrayList;
import vo.Guestbook;

public class GuestbookDao {
	// 생성자 메서드
	public GuestbookDao() {}
	
	// 입력
	// GuestbookDao guestbookDao = new GuestbookDao();
	// Guestbook guestbook - new Guestbook();
	// guestbookDao.insertGuestbook(guestbook);
	
	// 방명록 insert 메서드
	public void insertGuestbook(Guestbook guestbook) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "INSERT INTO guestbook(writer, guestbook_pw, guestbook_content, create_date, update_date) VALUES(?,?,?,NOW(),NOW())";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 로그인
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		// ?에 값들 넣기
		stmt.setString(1, guestbook.getWriter());
		stmt.setString(2, guestbook.getGuestbookPw());
		stmt.setString(3, guestbook.getGuestbookContent());
		System.out.println("insertGuestbookSql : " + stmt); // 디버깅
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		if(rs.next()) { // 정보가 있을때
			// 객체를 이용해서 쿼리에서 받아온 값들 각 멤버변수에 저장
			guestbook.setWriter(rs.getString("writer"));
			guestbook.setGuestbookPw(rs.getString("guestbook_pw"));
			guestbook.setGuestbookContent(rs.getString("guestbook_content"));
		}
		// 반납
		rs.close();
		stmt.close();
		conn.close();
	}
	
	// updateGuestbookForm.jsp에서 호출
	public Guestbook selectGuestbookOne(int guestbookNo) throws Exception {
		Guestbook guestbook = null; // 객체 생성 준비
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 로그인
		
		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, guestbook_pw guestbookPw FROM guestbook WHERE guestbook_no=?";
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		stmt.setInt(1, guestbookNo); // 방명록 번호를 이용하기 위해 저장
		System.out.println("sql selectOne : " + stmt); // 디버깅
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		if(rs.next()) { // 데이터가 있을때
			// 객체 생성 후 각 멤버변수에 값들 저장
			guestbook = new Guestbook();
			guestbook.setGuestbookNo(rs.getInt("guestbookNo"));
			guestbook.setGuestbookContent(rs.getString("guestbookContent"));
			guestbook.setGuestbookPw(rs.getString("guestbookPw"));
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return guestbook;
	}
	
	// updateGuestbookAction.jsp에서 호출
	// 수정 메서드
	public int updateGuestbook(Guestbook guestbook) throws Exception {
		int row = 0; // 수정한 행 갯수 반환하기 위한 변수
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 로그인
		
		String sql = "UPDATE guestbook SET guestbook_content=? WHERE guestbook_no=? AND guestbook_pw=?";
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		// ?에 값들 저장
		stmt.setString(1, guestbook.getGuestbookContent());
		stmt.setInt(2, guestbook.getGuestbookNo());
		stmt.setString(3, guestbook.getGuestbookPw());
		
		System.out.println("sql update : " + stmt); // 디버깅
		
		row = stmt.executeUpdate(); // 수정한 행의 갯수 저장

		// 반납
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// 삭제 메서드
	public int deleteGuestbook(int guestbookNo, String guestbookPw) throws Exception {
		int row = 0; // 삭제한 행 갯수 반환하기 위한 변수
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 로그인
		
		String sql = "DELETE FROM guestbook WHERE guestbook_no=? AND guestbook_pw=?";
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		// ?에 값들 저장
		stmt.setInt(1, guestbookNo);
		stmt.setString(2, guestbookPw);
		System.out.println("deleteGuestbookSql : " + stmt); // 디버깅
		
		row = stmt.executeUpdate(); // 삭제한 행의 갯수 저장

		// 반납
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// guestbook 전체 행의 수를 반환 메서드
	public int selectGuestbookTotalRow() throws Exception{
		int row = 0; // 리스트에 들어있는 정보 총 행의 수 담을 변수
		
		// 구현
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT COUNT(*) cnt FROM guestbook";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 로그인
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		System.out.println("selectGuestbookTotalRowSql : " + stmt); // 디버깅
		
		rs = stmt.executeQuery(); // 리스트에 들어있는 정보 총 행의 수 저장
		
		if(rs.next()) { // 데이터가 있을때
			row = rs.getInt("cnt"); // 총 행의 갯수를 row에 저장
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// guestbook (rowPerPage-beginRow)행식 반환하는 메서드
	public ArrayList<Guestbook> selectGuestbookListByPage(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Guestbook> list = new ArrayList<Guestbook>(); // ArrayList객체 생성
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer, create_date createDate FROM guestbook ORDER BY create_date desc LIMIT ?, ?";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 로그인
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		// ?에 값들 저장
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println("selectGuestbookListByPage : " + stmt); // 디버깅
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		// 데이터 가공
		while(rs.next()) { // 데이터가 있을동안
			Guestbook guestbook = new Guestbook(); // 객체 생성
			// 객체를 이용해서 각 멤버변수에 저장
			guestbook.setGuestbookNo(rs.getInt("guestbookNo"));
			guestbook.setGuestbookContent(rs.getString("guestbookContent"));
			guestbook.setWriter(rs.getString("writer"));
			guestbook.setCreateDate(rs.getString("createDate"));
			list.add(guestbook); // ArrayList<GuestBook>에 저장
		}
		
		// 데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
}
