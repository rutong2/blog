package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.Photo;

public class PhotoDao {
	public PhotoDao() {} // 생성자 메서드
	
	// 이미지 이름을 반환하는 메서드
	public String selectPhotoName(int photoNo) throws Exception {
		String photoName = null; // 사진 이름 저장
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		// DB에 insert하는 sql작성
		String sql = "SELECT photo_name photoName FROM photo WHERE photo_no=?";
				
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		stmt.setInt(1,photoNo);
		rs = stmt.executeQuery(); // 쿼리 저장		
		
		if(rs.next()) {
			photoName = rs.getString("photoName");
		}
		
		return photoName;
	}
	
	// 이미지 입력
	public void insertPhoto(Photo photo) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		// DB에 insert하는 sql작성
		String sql = "INSERT INTO photo(photo_name, photo_original_name, photo_type, photo_pw, writer, create_date, update_date)VALUES(?, ?, ?, ?, ?, NOW(), NOW())";
		
		// 객체의 멤버변수에 있는 정보 저장
		String photoName = photo.getPhotoName();
		String photoOriginalName = photo.getPhotoOriginalName();
		String photoType = photo.getPhotoType();
		String photoPw = photo.getPhotoPw();
		String writer = photo.getWriter();
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB접속
		stmt = conn.prepareStatement(sql); // sql작성
		// ?에 값들 저장
		stmt.setString(1, photoName);
		stmt.setString(2, photoOriginalName);
		stmt.setString(3, photoType);
		stmt.setString(4, photoPw);
		stmt.setString(5, writer);
		
		System.out.println("sql insertPhoto : " + stmt); // 디버깅
		
		rs = stmt.executeQuery(); // sql ResultSet형태로 저장
		
		if(rs.next()) { // 데이터가 있으면 각 객체에 저장 후 DB에 저장
			photo.setPhotoName(rs.getString("photo_name"));
			photo.setPhotoOriginalName(rs.getString("photo_original_name"));
			photo.setPhotoType(rs.getString("photo_type"));
			photo.setPhotoPw(rs.getString("photo_pw"));
			photo.setWriter(rs.getString("writer"));
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
	}
	
	// 이미지 삭제
	public int deletePhoto(int photoNo, String photoPw) throws Exception {
		int row = 0; // 삭제한 행의 갯수
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "DELETE FROM photo WHERE photo_no=? AND photo_pw=?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		// ?에 각각 값 저장
		stmt.setInt(1, photoNo);
		stmt.setString(2, photoPw);
		System.out.println("deletePhotoSql : " + stmt); // 디버깅
		
		row = stmt.executeUpdate(); // 삭제한 행의 갯수 저장
		System.out.println("삭제한 행의 갯수 : " + row); // 디버깅
		
		// 반납
		stmt.close();
		conn.close();
		
		return row; // 삭제한 행의 갯수 반환
	}
	
	// 이미지 목록
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo>(); // ArrayList<Photo> 객체 생성
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT photo_no photoNo, photo_name photoName, photo_original_name photoOriginalName, photo_type photoType, photo_pw photoPw, writer, create_date createDate, update_date updateDate FROM photo ORDER BY create_date DESC LIMIT ?, ?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		// selectPhotoListByPage 메서드의 매개변수가 beginRow(시작 페이지), rowPerPage(몇개씩 보고싶은지)가 있으므로 이것을 이용해 LIMIT 사용
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		System.out.println("sql selectPhotoListByPage : " + stmt); // 디버깅
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		// 데이터 가공
		while(rs.next()) {
			Photo photo = new Photo(); // 객체 생성
			// 객체를 이용해 각 멤버변수에 정보 저장
			photo.setPhotoNo(rs.getInt("photoNo"));
			photo.setPhotoName(rs.getString("photoName"));
			photo.setPhotoOriginalName(rs.getString("photoOriginalName"));
			photo.setPhotoType(rs.getString("photoType"));
			photo.setPhotoPw(rs.getString("photoPw"));
			photo.setWriter(rs.getString("writer"));
			photo.setCreateDate(rs.getString("createDate"));
			photo.setUpdateDate(rs.getString("updateDate"));
			list.add(photo); // ArrayList에 저장
		}
		
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return list; // 정보 ArrayList값 반환
	}
	
	// 전체 행의 수
	public int selectPhotoTotalRow() throws Exception {
		int total = 0; // 총 행의 갯수 저장하는 변수 선언
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT COUNT(*) cnt FROM photo";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		rs = stmt.executeQuery(); // 쿼리 저장
		
		if(rs.next()) { // 데이터가 있을때
			total = rs.getInt("cnt"); // 몇행인지 받아서 저장
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return total;
	}
	
	// 1개의 이미지 상세보기
	public Photo selectPhotoOne(int photoNo) throws Exception {
		Photo photo = null; // 객체 생성 준비
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT photo_no photoNo, photo_name photoName, writer, create_date createDate, update_date updateDate FROM photo WHERE photo_no=?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		stmt.setInt(1, photoNo); // 이미지의 번호를 이용해 사용자가 어떤 이미지를 보고 있는지 판단
		
		System.out.println("sql selectPhotoOne : " + stmt); // 디버깅
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		if(rs.next()) { // 사용자에게 보여줄 정보가 있을때 객체를 이용해 멤버변수에 저장
			photo = new Photo();
			photo.setPhotoNo(rs.getInt("photoNo"));
			photo.setPhotoName(rs.getString("photoName"));
			photo.setWriter(rs.getString("writer"));
			photo.setCreateDate(rs.getString("createDate"));
			photo.setUpdateDate(rs.getString("updateDate"));
		}
		
		
		// 반납
		rs.close();
		conn.close();
		stmt.close();
		
		return photo;
	}
}
