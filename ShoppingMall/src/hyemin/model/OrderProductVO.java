package hyemin.model;

public class OrderProductVO {

	private int product_count;			// 주문한 상품의 개수 - 필수
	private int fk_order_num;			// 주문정보 테이블의 주문번호를 참조
	private int fk_product_num;			// 상품테이블의 상품번호를 참조하는 컬럼
	
	public OrderProductVO() { }

	public OrderProductVO(int product_count, int fk_order_num, int fk_product_num) {
		super();
		this.product_count = product_count;
		this.fk_order_num = fk_order_num;
		this.fk_product_num = fk_product_num;
	}

	public int getProduct_count() {
		return product_count;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	public int getFk_order_num() {
		return fk_order_num;
	}

	public void setFk_order_num(int fk_order_num) {
		this.fk_order_num = fk_order_num;
	}

	public int getFk_product_num() {
		return fk_product_num;
	}

	public void setFk_product_num(int fk_product_num) {
		this.fk_product_num = fk_product_num;
	}	
	
}
