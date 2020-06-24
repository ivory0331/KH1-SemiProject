package main.model;

public class OrderHistoryVO {

	private int order_num;
	private String order_date;
	private int price;
	private int fk_product_num;
	private String product_name;
	private String representative_img;
	private String order_state;
	private int product_cnt;
	
	public OrderHistoryVO() { }
	
	public OrderHistoryVO(int order_num, String order_date, int price, int fk_product_num, String product_name,
			String representative_img, String order_state, int product_cnt) {
		super();
		this.order_num = order_num;
		this.order_date = order_date;
		this.price = price;
		this.fk_product_num = fk_product_num;
		this.product_name = product_name;
		this.representative_img = representative_img;
		this.order_state = order_state;
		this.product_cnt = product_cnt;
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

	
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}

	
	public int getFk_product_num() {
		return fk_product_num;
	}
	public void setFk_product_num(int fk_product_num) {
		this.fk_product_num = fk_product_num;
	}

	
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	
	public String getRepresentative_img() {
		return representative_img;
	}
	public void setRepresentative_img(String representative_img) {
		this.representative_img = representative_img;
	}

	
	public String getOrder_state() {
		return order_state;
	}
	public void setOrder_state(String order_state) {
		this.order_state = order_state;
	}

	
	public int getProduct_cnt() {
		return product_cnt;
	}
	public void setProduct_cnt(int product_cnt) {
		this.product_cnt = product_cnt;
	}

}
