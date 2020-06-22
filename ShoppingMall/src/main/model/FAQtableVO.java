package main.model;

public class FAQtableVO {
	private int faq_num;
	private String subject;
	private String content;
	private String write_date;
	private int hits;
	private String category_content;
	
	public FAQtableVO() {}
	
	public FAQtableVO(int faq_num, String subject, String content, String write_date, int hits,
			String category_content) {
		this.faq_num = faq_num;
		this.subject = subject;
		this.content = content;
		this.write_date = write_date;
		this.hits = hits;
		this.category_content = category_content;
	}
	
	
	public int getFaq_num() {
		return faq_num;
	}
	public void setFaq_num(int faq_num) {
		this.faq_num = faq_num;
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
	
	
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
	}
	
	
	public String getCategory_content() {
		return category_content;
	}
	public void setCategory_content(String category_content) {
		this.category_content = category_content;
	}
	
	
	
}
