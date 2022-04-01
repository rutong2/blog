package vo;

public class Guestbook {
	public Guestbook() {} // 생성자 메서드
	
	// 정보 은닉
	private int guestbookNo;
	private String guestbookContent;
	private String writer;
	private String createDate;
	private String updateDate;
	private String guestbookPw;
	
	// Getter Setter 구현
	public int getGuestbookNo() {
		return this.guestbookNo;
	}
	public void setGuestbookNo(int guestbookNo) {
		this.guestbookNo = guestbookNo;
	}
	public String getGuestbookContent() {
		return this.guestbookContent;
	}
	public void setGuestbookContent(String guestbookContent) {
		this.guestbookContent = guestbookContent;
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
	public String getGuestbookPw() {
		return this.guestbookPw;
	}
	public void setGuestbookPw(String guestbookPw) {
		this.guestbookPw = guestbookPw;
	}
	
	
}
