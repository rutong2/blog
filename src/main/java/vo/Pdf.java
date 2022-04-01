package vo;

public class Pdf {
	public Pdf() {} // 생성자 메서드
	
	// 정보 은닉
	private int pdfNo;
	private String pdfName;
	private String pdfOriginalName;
	private String pdfType;
	private String pdfPw;
	private String writer;
	private String createDate;
	private String updateDate;
	
	// Getter Setter 구현
	public int getPdfNo() {
		return this.pdfNo;
	}
	public void setPdfNo(int pdfNo) {
		this.pdfNo = pdfNo;
	}
	public String getPdfName() {
		return this.pdfName;
	}
	public void setPdfName(String pdfName) {
		this.pdfName = pdfName;
	}
	public String getPdfOriginalName() {
		return this.pdfOriginalName;
	}
	public void setPdfOriginalName(String pdfOriginalName) {
		this.pdfOriginalName = pdfOriginalName;
	}
	public String getPdfType() {
		return this.pdfType;
	}
	public void setPdfType(String pdfType) {
		this.pdfType = pdfType;
	}
	public String getPdfPw() {
		return this.pdfPw;
	}
	public void setPdfPw(String pdfPw) {
		this.pdfPw = pdfPw;
	}
	public String getWriter() {
		return this.writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getCreateDate() {
		return this.createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return this.updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
}
