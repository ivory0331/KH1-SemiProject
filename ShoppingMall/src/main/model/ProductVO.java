package main.model;

import java.util.List;

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
	private int best_point; //MD추천용 변수
	private String seller; // 쇼핑몰로 상품을 판매한 판매자 정보(관리자에서 사용)
	private String seller_phone; // 판매자 번호
	private int fk_category_num; // 상품 카테고리 번호
	private int fk_subcategory_num; // 상품 카테고리 번호2
	private String representative_img; // 대표 이미지
	private String explain; //상품 설명
	private List<String> imageList; // 상품 상세정보페이지에서 사용할 이미지 파일들
	
	
	//상품과 관련된 카테고리 내용
	private String category_content; // 상품 카테고리명
	private String subcategory_content; // 상품 카테고리명2
	
	
	public ProductVO() {}
	
	
	public ProductVO(int product_num, String product_name, int price, int stock, String origin, String packing,
			String unit, String registerdate, int sale, int best_point, String seller, String seller_phone,
			int fk_category_num, int fk_subcategory_num, String representative_img, String explain,
			List<String> imageList, String category_content, String subcategory_content) {
		
		this.product_num = product_num;
		this.product_name = product_name;
		this.price = price;
		this.stock = stock;
		this.origin = origin;
		this.packing = packing;
		this.unit = unit;
		this.registerdate = registerdate;
		this.sale = sale;
		this.best_point = best_point;
		this.seller = seller;
		this.seller_phone = seller_phone;
		this.fk_category_num = fk_category_num;
		this.fk_subcategory_num = fk_subcategory_num;
		this.representative_img = representative_img;
		this.explain = explain;
		this.imageList = imageList;
		this.category_content = category_content;
		this.subcategory_content = subcategory_content;
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
	
	
	public String getRepresentative_img() {
		return representative_img;
	}
	public void setRepresentative_img(String representative_img) {
		this.representative_img = representative_img;
	}
	
	
	public String getExplain() {
		return explain;
	}
	public void setExplain(String explain) {
		this.explain = explain;
	}
	
	
	public List<String> getImageList() {
		return imageList;
	}
	public void setImageList(List<String> imageList) {
		this.imageList = imageList;
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
	
	
	
	
}
