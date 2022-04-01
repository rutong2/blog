package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import vo.Board;
import vo.Photo;

public class BoardDao {
	public BoardDao() {} // 생성자메서드
	
	// 게시판 정보들 리스트형식으로 출력하는 메서드
	public ArrayList<Board> selectBoardListByPage(int beginRow, int rowPerPage, String categoryName) throws Exception {
		ArrayList<Board> list = new ArrayList<Board>(); // 객체에 저장한 정보를 ArrayList형식으로 저장할 변수 선언
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = null;
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 접속
		
		
		String boardSql = null;
		
		if(categoryName == null) { // 사용자가 아직 카테고리를 선택하지 않았을때
			// 카테고리에 상관없이 출력하는 쿼리
			sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql); // 쿼리 작성
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else { // 사용자가 카테고리를 선택했을때
			// where절을 이용해 사용자가 선택한 카테고리를 출력하는 쿼리
			sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name=? ORDER BY create_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql); // 쿼리 작성
			stmt.setString(1, categoryName);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		
		System.out.println("selectBoardListByPageSql : " + stmt); // 디버깅
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		while(rs.next()) { // 객체를 이용해 멤버변수에 정보 저장
			Board board = new Board();
			board.setBoardNo(rs.getInt("boardNo"));
			board.setCategoryName(rs.getString("categoryName"));
			board.setBoardTitle(rs.getString("boardTitle"));
			board.setCreateDate(rs.getString("createDate"));
			list.add(board); // 리스트에 저장
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// 카테고리를 선택했을때 카테고리별로 정보를 리스트형식으로 출력하는 메서드
	public ArrayList<HashMap<String, Object>> boardListByCategoryPage(String categoryName) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); // 객체에 저장한 정보를 ArrayList형식으로 저장할 변수 선언
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name ORDER BY category_name";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		System.out.println("boardListByCategoryPageSql : " + stmt); // 디버깅
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		while(rs.next()) { // 객체를 이용해 멤버변수에 정보 저장
			HashMap<String, Object> map = new HashMap<String, Object>(); // vo에 없는 속성이 있으므로 HashMap 이용
			map.put("cnt", rs.getString("cnt"));
			map.put("categoryName", rs.getString("categoryName"));
			list.add(map); // 리스트에 저장
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// 상세정보를 보는 메서드
	public Board selectBoardOne(int boardNo) throws Exception {
		Board board = null; // 객체 생성 준비
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, create_date createDate, update_date updateDate FROM board WHERE board_no=?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		stmt.setInt(1, boardNo); // 상세정보를 볼 게시물 번호 받아서 저장
		System.out.println("selectBoardOneSql : " + stmt); // 디버깅
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		if(rs.next()) { // 데이터가 있으면
			board = new Board(); // 객체 생성
			// 객체를 이용해 각 멤버변수에 정보 저장
			board.setBoardNo(rs.getInt("boardNo"));
			board.setCategoryName(rs.getString("categoryName"));
			board.setBoardTitle(rs.getString("boardTitle"));
			board.setBoardContent(rs.getString("boardContent"));
			board.setCreateDate(rs.getString("createDate"));
			board.setUpdateDate(rs.getString("updateDate"));
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return board;
	}
	
	// 입력하는 메서드
	public void insertBoard(Board board) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "INSERT INTO board(category_name, board_title, board_content, board_pw, create_date, update_date) VALUES(?, ?, ?, ?, NOW(), NOW())";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		// ?에 각 값들 넣어두기
		stmt.setString(1, board.getCategoryName());
		stmt.setString(2, board.getBoardTitle());
		stmt.setString(3, board.getBoardContent());
		stmt.setString(4, board.getBoardPw());
		System.out.println("insertBoardSql : " + stmt); // 디버깅
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		if(rs.next()) { // 객체에 쿼리의 정보들 받아서 저장
			board.setCategoryName(rs.getString("categoryName"));
			board.setBoardTitle(rs.getString("boardTitle"));
			board.setBoardContent(rs.getString("boardContent"));
			board.setBoardPw(rs.getString("board_pw"));
			board.setCreateDate(rs.getString("createDate"));
			board.setUpdateDate(rs.getString("updateDate"));
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
	}
	
	// 삭제하는 메서드
	public int deleteBoard(int boardNo, String boardPw) throws Exception {
		int row = 0; // 삭제한 행의 수 저장
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "DELETE FROM board WHERE board_no=? AND board_pw=?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		// ?에 각각 값 저장
		stmt.setInt(1, boardNo);
		stmt.setString(2, boardPw);
		System.out.println("selectBoardOneSql : " + stmt); // 디버깅
		
		row = stmt.executeUpdate(); // 몇행을 실행했는지 저장
		System.out.println("삭제한 행의 갯수 : " + row); // 디버깅
		
		// 반납
		stmt.close();
		conn.close();
		
		return row; // 몇행을 삭제했는지 반환
	}
	
	// 수정하는 메서드
	public int updateBoard(Board board) throws Exception {
		int row = 0; // 수정한 행의 갯수
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "UPDATE board SET category_name=?, board_title=?, board_content=? WHERE board_no=? AND board_pw=?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		// ?에 각각 값 저장
		stmt.setString(1, board.getCategoryName());
		stmt.setString(2, board.getBoardTitle());
		stmt.setString(3, board.getBoardContent());
		stmt.setInt(4, board.getBoardNo());
		stmt.setString(5, board.getBoardPw());
		System.out.println("selectBoardOneSql : " + stmt); // 디버깅
		
		row = stmt.executeUpdate(); // 몇행의 게시물을 수정했는지 저장
		
		return row;
	}
	
	// 총 행의 갯수를 구하는 메서드
	public int selectBoardTotalRow() throws Exception {
		int total = 0; // 총 행의 갯수
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT COUNT(*) cnt FROM board";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		if(rs.next()) {
			total = rs.getInt("cnt"); // 총 몇행이 있는지 저장
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return total; // 총 몇행이 있는지 반환
	}
	
	// 카테고리별 총 행의 수
	public int selectCategoryTotalRow(String categoryName) throws Exception {
		int categoryTotal = 0; // 카테고리별 총 행의 갯수
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT COUNT(category_name) cnt FROM board WHERE category_name=?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		// ?에 값 저장
		stmt.setString(1, categoryName); 
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		if(rs.next()) {
			categoryTotal = rs.getInt("cnt"); // 총 몇행이 있는지 저장
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return categoryTotal;
	}
	
	// 카테고리 목록을 보여주는 메서드
	public ArrayList<String> selectCategory(String categoryName) throws Exception {
		ArrayList<String> list = new ArrayList<String>(); // 정보를 담을 ArrayList 생성
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT category_name categoryName FROM board GROUP BY category_name ORDER BY category_name asc";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		while(rs.next()) {
			list.add(rs.getString("categoryName")); // list에 카테고리 이름 저장
		}
		
		return list;
	}
	
}
