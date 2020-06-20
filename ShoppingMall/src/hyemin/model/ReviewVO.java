package hyemin.model;

public class ReviewVO {

	private int review_num;		// 후기번호 - 필수 + 고유 + 시퀀스 사용
	private String subject;		// 후기 제목 - 필수
	private String content;		// 후기 내용 - 필수
	private String write_date;	// 작성 날짜
	private String image;		// 내용에 들어가는 이미지
	
	public ReviewVO() { }
	
	public ReviewVO(int review_num, String subject, String content, String write_date, String image) {
		super();
		this.review_num = review_num;
		this.subject = subject;
		this.content = content;
		this.write_date = write_date;
		this.image = image;
	}

	public int getReview_num() {
		return review_num;
	}

	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	
	
}
