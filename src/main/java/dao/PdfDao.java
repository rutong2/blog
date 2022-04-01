package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.Pdf;

public class PdfDao {
	public PdfDao() {} // 생성자 메서드
	
	// pdf자료 이름을 반환하는 메서드
	public String selectPdfName(int pdfNo) throws Exception {
		String pdfName = null; // 사진 이름 저장
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		// DB에 insert하는 sql작성
		String sql = "SELECT pdf_name pdfName FROM pdf WHERE pdf_no=?";
				
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB 접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		stmt.setInt(1, pdfNo);
		rs = stmt.executeQuery(); // 쿼리 저장		
		
		if(rs.next()) {
			pdfName = rs.getString("pdfName");
		}
		
		return pdfName;
	}
	
	// pdf 리스트 출력하는 메서드
	public ArrayList<Pdf> selectPdfListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Pdf> list = new ArrayList<Pdf>(); // 정보를 담아줄 ArrayList<Pdf> 생성
		
		// 디버깅
		System.out.println("beginRow : " + beginRow);
		System.out.println("rowPerPage : " + rowPerPage);
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT pdf_no pdfNo, pdf_name pdfName, create_date createDate FROM pdf ORDER BY create_date DESC LIMIT ?, ?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		stmt.setInt(1, beginRow); // 시작하는 행 저장
		stmt.setInt(2, rowPerPage); // 내가 보고싶은 정보 갯수 저장
		rs = stmt.executeQuery(); // 쿼리 저장
		
		while(rs.next()) { // 객체 생성 후 멤버변수에 정보 저장
			Pdf pdf = new Pdf();
			pdf.setPdfNo(rs.getInt("pdfNo"));
			pdf.setPdfName(rs.getString("pdfName"));
			pdf.setCreateDate(rs.getString("createDate"));
			list.add(pdf); // 리스트 저장
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// pdf 정보 자세히보는 메서드
	public Pdf selectPdfOne(int pdfNo) throws Exception {
		Pdf pdf = null; // 객체 생성 준비
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT pdf_no pdfNo, pdf_name pdfName, writer, create_date createDate, update_date updateDate FROM pdf WHERE pdf_no=?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB접속
		stmt = conn.prepareStatement(sql); // sql 작성
		stmt.setInt(1, pdfNo); // 자세히 볼 pdf글의 번호 저장
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		if(rs.next()) { // 객체 생성 후 멤버변수에 정보 저장
			pdf = new Pdf();
			pdf.setPdfNo(rs.getInt("pdfNo"));
			pdf.setWriter(rs.getString("writer"));
			pdf.setPdfName(rs.getString("pdfName"));
			pdf.setCreateDate(rs.getString("createDate"));
			pdf.setUpdateDate(rs.getString("updateDate"));
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return pdf;
	}
	
	public void insertPdf(Pdf pdf) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "INSERT INTO pdf(pdf_no, pdf_name, pdf_original_name, pdf_type, pdf_pw, writer, create_date, update_date)VALUES(?, ?, ?, ?, ?, ?, NOW(), NOW())";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		// 각각 넣고 싶은 정보들 저장
		stmt.setInt(1, pdf.getPdfNo());
		stmt.setString(2, pdf.getPdfName());
		stmt.setString(3, pdf.getPdfOriginalName());
		stmt.setString(4, pdf.getPdfType());
		stmt.setString(5, pdf.getPdfPw());
		stmt.setString(6, pdf.getWriter());
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		if(rs.next()) { // 객체를 이용해서 멤버변수에 정보 저장
			pdf.setPdfNo(rs.getInt("pdfNo"));
			pdf.setPdfName(rs.getString("pdfName"));
			pdf.setPdfOriginalName(rs.getString("pdf_original_name"));
			pdf.setPdfType(rs.getString("pdf_type"));
			pdf.setPdfPw(rs.getString("pdf_pw"));
			pdf.setWriter(rs.getString("writer"));
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
	}
	
	public int deletePdf(Pdf pdf) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "DELETE FROM pdf WHERE pdf_no=? AND pdf_pw=?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		// 번호와 비밀번호를 이용해서 맞으면 삭제해야하므로 저장
		stmt.setInt(1, pdf.getPdfNo());
		stmt.setString(2, pdf.getPdfPw());
		
		int row = stmt.executeUpdate(); // 몇행을 실행했는지 저장
		
		// 반납
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// pdf list의 행의 수 구하는 메서드
	public int selectPdfTotalRow() throws Exception {
		int total = 0;
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "java1234"; // DB 패스워드
		String sql = "SELECT COUNT(*) cnt FROM pdf";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		rs = stmt.executeQuery(); // 쿼리 저장
		
		if(rs.next()) { // 데이터가 있으면
			total = rs.getInt("cnt"); // COUNT(*)를 이용해 구한 값을 total에 저장
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return total;
	}
}
