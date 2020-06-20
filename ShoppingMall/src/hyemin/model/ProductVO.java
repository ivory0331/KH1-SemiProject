package hyemin.model;

public class ProductVO {
	
	private int product_num;				// 상품번호 - 필수 + 고유 + 시퀀스 사용
	private String product_name;			// 상품이름 - 필수 + 고유
	private int price;						// 가격 - 필수
	private int stock;						// 재고 - 필수
	private String origin;					// 원산지
	private String packing;					// 포장방법
	private String unit;					// 단위
	private String registerdate;			// 등록날짜
	private int sale;						// 할인율?
	private int fk_category_num;			// 상품 대분류 카테고리 테이블에 있는 대분류 카테고리 번호를 참조
	private int fk_subcategory_num;			// 상품 소분류 카테고리 테이블에 있는 소분류 카테고리 번호를 참조
	
	public ProductVO() { }
	
	public ProductVO(int product_num, String product_name, int price, int stock, String origin, String packing,
			String unit, String registerdate, int sale, int fk_category_num, int fk_subcategory_num) {
		
		this.product_num = product_num;
		this.product_name = product_name;
		this.price = price;
		this.stock = stock;
		this.origin = origin;
		this.packing = packing;
		this.unit = unit;
		this.registerdate = registerdate;
		this.sale = sale;
		this.fk_category_num = fk_category_num;
		this.fk_subcategory_num = fk_subcategory_num;
	}

	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
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
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getPacking() {
		return packing;
	}
	public void setPacking(String packing) {
		this.packing = packing;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getRegisterdate() {
		return registerdate;
	}
	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
	}
	public int getSale() {
		return sale;
	}
	public void setSale(int sale) {
		this.sale = sale;
	}
	public int getFk_category_num() {
		return fk_category_num;
	}
	public void setFk_category_num(int fk_category_num) {
		this.fk_category_num = fk_category_num;
	}
	public int getFk_subcategory_num() {
		return fk_subcategory_num;
	}
	public void setFk_subcategory_num(int fk_subcategory_num) {
		this.fk_subcategory_num = fk_subcategory_num;
	}
	
	
}
