package product.model;

import java.util.List;

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
	private int best_point;
	private String seller;
	private String seller_phone;
	private String explain;
	private int fk_category_num;
	private int fk_subcategory_num;
	private int category_num;
	private String category_content;
	private int subcategory_num;
	private String subcategory_content;
	private String representative_img;
	private List<String> imageList; // 상품 상세정보페이지에서 사용할 이미지 파일들
	
	private int finalPrice;
	private int totalPrice;
	
	public ProductVO() { }

	public ProductVO(int product_num, String product_name, int price, int stock, String origin, String packing,
			String unit, String registerdater, int sale, int best_point, int fk_category_num, int fk_subcategory_num, int category_num,
			String category_content, int subcategory_num, String subcategory_content, String representative_img,
			List<String> imageList) {
		super();
		this.product_num = product_num;
		this.product_name = product_name;
		this.price = price;
		this.stock = stock;
		this.origin = origin;
		this.packing = packing;
		this.unit = unit;
		this.registerdate = registerdate;
		this.sale = sale;
		this.best_point=best_point;
		this.fk_category_num = fk_category_num;
		this.fk_subcategory_num = fk_subcategory_num;
		this.category_num = category_num;
		this.category_content = category_content;
		this.subcategory_num = subcategory_num;
		this.subcategory_content = subcategory_content;
		this.representative_img = representative_img;
		this.imageList = imageList;
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
	public int getBest_point() {
		return best_point;
	}
	public void setBest_point(int best_point) {
		this.best_point = best_point;
	}
	
	public String getSeller() {
		return seller;
	}

	public void setSeller(String seller) {
		this.seller = seller;
	}

	public String getSeller_phone() {
		return seller_phone;
	}

	public void setSeller_phone(String seller_phone) {
		this.seller_phone = seller_phone;
	}

	public String getExplain() {
		return explain;
	}

	public void setExplain(String explain) {
		this.explain = explain;
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

	public String getRepresentative_img() {
		return representative_img;
	}

	public void setRepresentative_img(String representative_img) {
		this.representative_img = representative_img;
	}

	public List<String> getImageList() {
		return imageList;
	}

	public void setImageList(List<String> imageList) {
		this.imageList = imageList;
	}

	////////////////////////////////////////////////////////////
	// *** 제품의 총판매가(실제판매가 * 주문량) 구해오기 ***
	public void setTotalPrice(int price, int sale, int product_count) {
		
		double salePrice = Double.valueOf(price)*(Double.valueOf(sale)/100);
		
		finalPrice = (int)(Double.valueOf(price)-salePrice);
		
		totalPrice =  finalPrice * product_count; // 세일까지 적용한 최종 판매가 * 주문량

	}
	
	public int getTotalPrice() {
		return totalPrice;
	}

	public int getFinalPrice() {
		
		if(sale != 0) {
			double salePrice = Double.valueOf(price)*(Double.valueOf(sale)/100);
		
			finalPrice = (int)(Double.valueOf(price)-salePrice);
		}
		else {
			finalPrice = price;
		}
		
		return finalPrice;
	}

	
	
}
