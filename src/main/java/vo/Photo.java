package vo;

public class Photo {
	public Photo() {} // 생성자 메서드
	
	// 정보 은닉
	private int photoNo;
	private String photoName;
	private String photoOriginalName;
	private String photoType;
	private String photoPw;
	private String writer;
	private String createDate;
	private String updateDate;
	
	// Getter Setter 구현
	public int getPhotoNo() {
		return this.photoNo;
	}
	public void setPhotoNo(int photoNo) {
		this.photoNo = photoNo;
	}
	public String getPhotoName() {
		return this.photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public String getPhotoOriginalName() {
		return this.photoOriginalName;
	}
	public void setPhotoOriginalName(String photoOriginalName) {
		this.photoOriginalName = photoOriginalName;
	}
	public String getPhotoType() {
		return this.photoType;
	}
	public void setPhotoType(String photoType) {
		this.photoType = photoType;
	}
	public String getPhotoPw() {
		return this.photoPw;
	}
	public void setPhotoPw(String photoPw) {
		this.photoPw = photoPw;
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
