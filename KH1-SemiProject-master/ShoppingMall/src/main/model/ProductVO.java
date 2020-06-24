package main.model;

public class ProductVO {
	// 상품VO
	private int product_num; // 상품 고유 번호
	private String product_name; // 상품명
	private int price; // 상품 가격
	private int stock; // 상품 재고
	private String origin; // 상품 원산지
	private String packing; // 상품 포장방법
	private String unit; // 상품 단위
	private String registerdate; // 상품 등록날짜
	private int sale; // 상품 세일(0=>세일x , 10=> 10%세일)
	private String seller; // 쇼핑몰로 상품을 판매한 판매자 정보(관리자에서 사용)
	private String seller_phone; // 판매자 번호
	private int fk_category_num; // 상품 카테고리 번호
	private int fk_subcategory_num; // 상품 카테고리 번호2
	private String representative_img; // 대표 이미지
	private String image1; //상품이미지1
	private String image2; //상품이미지2
	private String image3; //상품이미지3
	private String explain; //상품 설명
	
	
	//상품과 관련된 카테고리 내용
	private String category_content; // 상품 카테고리명
	private String subcategory_content; // 상품 카테고리명2
	
	
	// product_num //
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	
	// product_name //
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	
	// price //
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
	// stock //
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	
	// origin //
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	
	// packing //
	public String getPacking() {
		return packing;
	}
	public void setPacking(String packing) {
		this.packing = packing;
	}
	
	// unit //
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	// registerdate //
	public String getRegisterdate() {
		return registerdate;
	}
	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
	}
	
	// sale //
	public int getSale() {
		return sale;
	}
	public void setSale(int sale) {
		this.sale = sale;
	}
	
	// seller //
	public String getSeller() {
		return seller;
	}
	public void setSeller(String seller) {
		this.seller = seller;
	}
	
	// seller_phone //
	public String getSeller_phone() {
		return seller_phone;
	}
	public void setSeller_phone(String seller_phone) {
		this.seller_phone = seller_phone;
	}
	
	// fk_category_num //
	public int getFk_category_num() {
		return fk_category_num;
	}
	public void setFk_category_num(int fk_category_num) {
		this.fk_category_num = fk_category_num;
	}
	
	// fk_subcategory_num //
	public int getFk_subcategory_num() {
		return fk_subcategory_num;
	}
	public void setFk_subcategory_num(int fk_subcategory_num) {
		this.fk_subcategory_num = fk_subcategory_num;
	}
	
	// category_content //
	public String getCategory_content() {
		return category_content;
	}
	public void setCategory_content(String category_content) {
		this.category_content = category_content;
	}
	
	// subcategory_content //
	public String getSubcategory_content() {
		return subcategory_content;
	}
	public void setSubcategory_content(String subcategory_content) {
		this.subcategory_content = subcategory_content;
	}
	
	// representativ_img //
	public String getRepresentative_img() {
		return representative_img;
	}
	public void setRepresentative_img(String representative_img) {
		this.representative_img = representative_img;
	}
	
	// image1 //
	public String getImage1() {
		return image1;
	}
	public void setImage1(String image1) {
		this.image1 = image1;
	}
	
	// image2 //
	public String getImage2() {
		return image2;
	}
	public void setImage2(String image2) {
		this.image2 = image2;
	}
	
	// image3 //
	public String getImage3() {
		return image3;
	}
	public void setImage3(String image3) {
		this.image3 = image3;
	}
	
	// explain //
	public String getExplain() {
		return explain;
	}
	public void setExplain(String explain) {
		this.explain = explain;
	}
	
	
	
}
