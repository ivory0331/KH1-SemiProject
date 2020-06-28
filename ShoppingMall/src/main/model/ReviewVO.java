package main.model;

import java.util.List;

public class ReviewVO {
	private int review_num;
	private String subject;
	private String content;
	private String write_date;
	private int hit;
	private int favorite;
	private int fk_product_num;
	private int fk_order_num;
	private int fk_member_num;
	private String name;
	private List<String> imageList;
	
	private ProductVO product;
	
	public ReviewVO() {}
	

	public ReviewVO(int review_num, String subject, String content, String write_date, int hit, int favorite,
			int fk_product_num, int fk_order_num, int fk_member_num, String name, List<String> imageList, ProductVO product) {
		
		this.review_num = review_num;
		this.subject = subject;
		this.content = content;
		this.write_date = write_date;
		this.hit = hit;
		this.favorite = favorite;
		this.fk_product_num = fk_product_num;
		this.fk_order_num = fk_order_num;
		this.fk_member_num = fk_member_num;
		this.name = name;
		this.imageList = imageList;
		this.product = product;
	}
	
	
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	
	
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	
	
	public int getFavorite() {
		return favorite;
	}
	public void setFavorite(int favorite) {
		this.favorite = favorite;
	}
	
	
	public int getFk_product_num() {
		return fk_product_num;
	}
	public void setFk_product_num(int fk_product_num) {
		this.fk_product_num = fk_product_num;
	}
	
	
	public int getFk_order_num() {
		return fk_order_num;
	}
	public void setFk_order_num(int fk_order_num) {
		this.fk_order_num = fk_order_num;
	}
	
	
	public int getFk_member_num() {
		return fk_member_num;
	}
	public void setFk_member_num(int fk_member_num) {
		this.fk_member_num = fk_member_num;
	}
	

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
	public List<String> getImageList() {
		return imageList;
	}
	public void setImageList(List<String> imageList) {
		this.imageList = imageList;
	}


	public ProductVO getProduct() {
		return product;
	}
	public void setProduct(ProductVO product) {
		this.product = product;
	}
	
	
}
