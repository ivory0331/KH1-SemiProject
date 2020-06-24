package product.model;

public class CartVO {

	private int basket_num;		// 장바구니 번호
	private int product_count;  // 주문량
	private int member_num; 	// 해당 장바구니에 상품을 담은 회원번호
	private int product_num; 	// 제품번호
	
	private ProductVO prod;		// 제품정보객체

	public CartVO() { }
	
	public CartVO(int basket_num, int product_count, int member_num, int product_num, ProductVO prod) {
		super();
		this.basket_num = basket_num;
		this.product_count = product_count;
		this.member_num = member_num;
		this.product_num = product_num;
		this.prod = prod;
	}

	public int getBasket_num() {
		return basket_num;
	}

	public void setBasket_num(int basket_num) {
		this.basket_num = basket_num;
	}

	public int getProduct_count() {
		return product_count;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	public int getMember_num() {
		return member_num;
	}

	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}

	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	public ProductVO getProd() {
		return prod;
	}

	public void setProd(ProductVO prod) {
		this.prod = prod;
	}
	
	
	
	
}
