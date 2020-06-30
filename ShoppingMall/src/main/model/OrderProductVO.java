package main.model;

public class OrderProductVO {
	private int order_num;
	private ProductVO product;
	private int price;
	private int count;
	
	public OrderProductVO() {}
	
	public OrderProductVO(int order_num, ProductVO product, int price, int count) {
		
		this.order_num = order_num;
		this.product = product;
		this.price = price;
		this.count = count;
	}
	
	
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	
	
	public ProductVO getProduct() {
		return product;
	}
	public void setProduct(ProductVO product) {
		this.product = product;
	}
	
	
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}

	
}
