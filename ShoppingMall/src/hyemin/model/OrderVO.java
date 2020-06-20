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
	private int fk_member_num;					// 회원 테이블의 회원번호를 참조
	private int fk_category_num;				// 주문상태 테이블의 주문상태 번호를 참조
	
	private OrderProductVO orderProduct;		// 주문 상품에 대한 모든 정보
	private ProductVO product;					// 상품에 대한 모든 정보
	private OrderStateVO orderState;			// 배송상태에 대한 모든 정보
	
	public OrderVO() { }

	public OrderVO(int order_num, String order_date, String recipient, String recipient_mobile,
			String recipient_postcode, String recipient_address, String recipient_detailaddress,
			String recipient_extraaddress, int price, String memo, int fk_member_num, int fk_category_num) {
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
		this.fk_member_num = fk_member_num;
		this.fk_category_num = fk_category_num;
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

	public int getFk_member_num() {
		return fk_member_num;
	}

	public void setFk_member_num(int fk_member_num) {
		this.fk_member_num = fk_member_num;
	}

	public int getFk_category_num() {
		return fk_category_num;
	}

	public void setFk_category_num(int fk_category_num) {
		this.fk_category_num = fk_category_num;
	}

	public OrderProductVO getOrderProduct() {
		return orderProduct;
	}

	public void setOrderProduct(OrderProductVO orderProduct) {
		this.orderProduct = orderProduct;
	}

	public ProductVO getProduct() {
		return product;
	}

	public void setProduct(ProductVO product) {
		this.product = product;
	}

	public OrderStateVO getOrderState() {
		return orderState;
	}

	public void setOrderState(OrderStateVO orderState) {
		this.orderState = orderState;
	}
	
	
	
}
