package product.model;

public class ProductVO {
	
	private int product_num;
	private String product_name;
	private int price;
	private int stock;
	private String origin;
	private String packing;
	private String unit;
	private String registerdate;
	private int sale;
	private int fk_category_num;
	private int fk_subcategory_num;
	private int category_num;
	private String category_content;
	private int subcategory_num;
	private String subcategory_content;
	
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
	
	// 세일하는 제품의 가격 알아오기
	public int getSalePrice() {
		int result = 0;
				
		if(sale != 0) {
			result = price - (price*(sale/100));
		}
		
		return result;
	}

	public String getCategory_content() {
		return category_content;
	}

	public void setCategory_content(String category_content) {
		this.category_content = category_content;
	}

	public String getSubcategory_content() {
		return subcategory_content;
	}

	public void setSubcategory_content(String subcategory_content) {
		this.subcategory_content = subcategory_content;
	}

	public int getCategory_num() {
		return category_num;
	}

	public void setCategory_num(int category_num) {
		this.category_num = category_num;
	}

	public int getSubcategory_num() {
		return subcategory_num;
	}

	public void setSubcategory_num(int subcategory_num) {
		this.subcategory_num = subcategory_num;
	}
	
	
}
