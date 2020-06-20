package hyemin.model;

public class OrderStateVO {

	private int category_num;		// 배송상태 카테고리 번호
	private String order_state;		// 번호에 해당하는 실제 내용
	
	public OrderStateVO() { }
	
	public OrderStateVO(int category_num, String order_state) {
		super();
		this.category_num = category_num;
		this.order_state = order_state;
	}

	public int getCategory_num() {
		return category_num;
	}

	public void setCategory_num(int category_num) {
		this.category_num = category_num;
	}

	public String getOrder_state() {
		return order_state;
	}

	public void setOrder_state(String order_state) {
		this.order_state = order_state;
	}
	
	
	
}
