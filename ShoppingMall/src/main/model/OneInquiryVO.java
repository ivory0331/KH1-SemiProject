package main.model;

import java.util.List;

public class OneInquiryVO {
	private int one_inquiry_num;
	private String subject;
	private String content;
	private String write_date;
	private String answer;
	private String emailFlag;
	private String smsFlag;
	private String category_content;
	private int fk_member_num;
	private int fk_order_num;
	private List<String> imageList;
	private int fk_category_num;
	
	public OneInquiryVO() {}
	
	public OneInquiryVO(int one_inquiry_num, String subject, String content, String write_date, String answer,
			String emailFlag, String smsFlag, String category_content, int fk_member_num, int fk_order_num,
			List<String> imageList, int fk_category_num) {
		this.one_inquiry_num = one_inquiry_num;
		this.subject = subject;
		this.content = content;
		this.write_date = write_date;
		this.answer = answer;
		this.emailFlag = emailFlag;
		this.smsFlag = smsFlag;
		this.category_content = category_content;
		this.fk_member_num = fk_member_num;
		this.fk_order_num = fk_order_num;
		this.imageList = imageList;
		this.fk_category_num = fk_category_num;
	}
	
	
	public int getOne_inquiry_num() {
		return one_inquiry_num;
	}
	public void setOne_inquiry_num(int one_inquiry_num) {
		this.one_inquiry_num = one_inquiry_num;
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
	
	
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	
	public String getEmailFlag() {
		return emailFlag;
	}
	public void setEmailFlag(String emailFlag) {
		this.emailFlag = emailFlag;
	}
	
	
	public String getSmsFlag() {
		return smsFlag;
	}
	public void setSmsFlag(String smsFlag) {
		this.smsFlag = smsFlag;
	}
	
	
	public String getCategory_content() {
		return category_content;
	}
	public void setCategory_content(String category_content) {
		this.category_content = category_content;
	}
	
	
	public int getFk_member_num() {
		return fk_member_num;
	}
	public void setFk_member_num(int fk_member_num) {
		this.fk_member_num = fk_member_num;
	}
	
	
	public int getFk_order_num() {
		return fk_order_num;
	}
	public void setFk_order_num(int fk_order_num) {
		this.fk_order_num = fk_order_num;
	}
	
	
	public List<String> getImageList() {
		return imageList;
	}
	public void setImageList(List<String> imageList) {
		this.imageList = imageList;
	}

	public int getFk_category_num() {
		return fk_category_num;
	}

	public void setFk_category_num(int fk_category_num) {
		this.fk_category_num = fk_category_num;
	}
	
	
	
}
