package hyemin.model;

public class OrderVO {
	
	private int order_num;						// 주문번호 - 필수 + 고유 + 시퀀스 사용
	private String order_date;					// 주문날짜
	private String recipient;					// 받는 사람 - 필수
	private String recipient_mobile;			// 받는 사람의 연락처 - 필수
	private String recipient_postcode;			// 받는 사람의 우편번호
	private String recipient_address;			// 받는 사람의 주소
	private String recipient_detailaddress;		// 받는 사람의 상세주소
	private String recipient_extraaddress;		// 받는 사람의 추가주소
	private int price;							// 주문금액 - 필수
	private String memo;						// 요청사항
	
	public OrderVO() { }
	
	public OrderVO(int order_num, String order_date, String recipient, String recipient_mobile,
			String recipient_postcode, String recipient_address, String recipient_detailaddress,
			String recipient_extraaddress, int price, String memo) {
		super();
		this.order_num = order_num;
		this.order_date = order_date;
		this.recipient = recipient;
		this.recipient_mobile = recipient_mobile;
		this.recipient_postcode = recipient_postcode;
		this.recipient_address = recipient_address;
		this.recipient_detailaddress = recipient_detailaddress;
		this.recipient_extraaddress = recipient_extraaddress;
		this.price = price;
		this.memo = memo;
	}

	public int getOrder_num() {
		return order_num;
	}

	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}

	public String getOrder_date() {
		return order_date;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}

	public String getRecipient() {
		return recipient;
	}

	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	public String getRecipient_mobile() {
		return recipient_mobile;
	}

	public void setRecipient_mobile(String recipient_mobile) {
		this.recipient_mobile = recipient_mobile;
	}

	public String getRecipient_postcode() {
		return recipient_postcode;
	}

	public void setRecipient_postcode(String recipient_postcode) {
		this.recipient_postcode = recipient_postcode;
	}

	public String getRecipient_address() {
		return recipient_address;
	}

	public void setRecipient_address(String recipient_address) {
		this.recipient_address = recipient_address;
	}

	public String getRecipient_detailaddress() {
		return recipient_detailaddress;
	}

	public void setRecipient_detailaddress(String recipient_detailaddress) {
		this.recipient_detailaddress = recipient_detailaddress;
	}

	public String getRecipient_extraaddress() {
		return recipient_extraaddress;
	}

	public void setRecipient_extraaddress(String recipient_extraaddress) {
		this.recipient_extraaddress = recipient_extraaddress;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
}
