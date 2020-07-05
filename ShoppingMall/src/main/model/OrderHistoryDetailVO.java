package main.model;

public class OrderHistoryDetailVO {
	
	private String representative_img;
	private String product_name;
	private int price;
	private int product_count;
	private String order_state;
	private int reviewFlag;
	private int product_num;
	
	public OrderHistoryDetailVO() { }
	
	public OrderHistoryDetailVO(String representative_img, String product_name, int price, int product_count, String order_state, int reviewFlag, int product_num) {
		this.representative_img = representative_img;
		this.product_name = product_name;
		this.price = price;
		this.product_count = product_count;
		this.order_state = order_state;
		this.reviewFlag = reviewFlag;
		this.product_num = product_num;
	}	
	

	public String getRepresentative_img() {
		return representative_img;
	}
	public void setRepresentative_img(String representative_img) {
		this.representative_img = representative_img;
	}

	
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}

	
	public int getProduct_count() {
		return product_count;
	}
	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	
	public String getOrder_state() {
		return order_state;
	}
	public void setOrder_state(String order_state) {
		this.order_state = order_state;
	}

	
	public int getReviewFlag() {
		return reviewFlag;
	}
	public void setReviewFlag(int reviewFlag) {
		this.reviewFlag = reviewFlag;
	}

	
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	
	
}
