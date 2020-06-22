package hyemin.model;

public class ReviewVO {

	private int review_num;			// 후기번호 - 필수 + 고유 + 시퀀스 사용
	private String subject;			// 후기 제목 - 필수
	private String content;			// 후기 내용 - 필수
	private String write_date;		// 작성 날짜
	private String image;			// 내용에 들어가는 이미지
	private int fk_product_num;		// 상품테이블에서 상품번호를 참조  ←─ 두 개의 컬럼을 복합해서 유니크 키로 제약 
	private int fk_order_num;		// 주문테이블에서 주문번호를 참조  ←───┘
	private int fk_member_num;		// 회원테이블에서 회원번호를 참조 
	
	public ReviewVO() { }

	public ReviewVO(int review_num, String subject, String content, String write_date, String image, int fk_product_num,
			int fk_order_num, int fk_member_num) {
		super();
		this.review_num = review_num;
		this.subject = subject;
		this.content = content;
		this.write_date = write_date;
		this.image = image;
		this.fk_product_num = fk_product_num;
		this.fk_order_num = fk_order_num;
		this.fk_member_num = fk_member_num;
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

	public int getFk_product_num() {
		return fk_product_num;
	}

	public void setFk_product_num(int fk_product_num) {
		this.fk_product_num = fk_product_num;
	}

	public int getFk_order_num() {
		return fk_order_num;
	}

	public void setFk_order_num(int fk_order_num) {
		this.fk_order_num = fk_order_num;
	}

	public int getFk_member_num() {
		return fk_member_num;
	}

	public void setFk_member_num(int fk_member_num) {
		this.fk_member_num = fk_member_num;
	}
	
	
	
}
