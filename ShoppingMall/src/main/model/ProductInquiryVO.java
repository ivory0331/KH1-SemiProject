package main.model;

import java.util.List;

import member.model.MemberVO;

public class ProductInquiryVO {
	private int inquiry_num;
	private String subject;
	private String content;
	private String write_date;
	private String answer;
	private int fk_member_num;
	private int fk_product_num;
	private int emailFlag;
	private int smsFlag;
	private int secretFlag;
	private String name;
	private List<String> imageList;
	private MemberVO member;
	private String product_name;
	private int rowNum;
	private String answer_date;
	
	
	
	public ProductInquiryVO() {}
	
	
	
	public ProductInquiryVO(int inquiry_num, String subject, String content, String write_date, String answer,
			int fk_member_num, int fk_product_num, int emailFlag, int smsFlag, int secretFlag, String name, List<String> imageList, MemberVO member) {
		
		this.inquiry_num = inquiry_num;
		this.subject = subject;
		this.content = content;
		this.write_date = write_date;
		this.answer = answer;
		this.fk_member_num = fk_member_num;
		this.fk_product_num = fk_product_num;
		this.emailFlag = emailFlag;
		this.smsFlag = smsFlag;
		this.secretFlag = secretFlag;
		this.name = name;
		this.imageList = imageList;
		this.member = member;
	}
	
	
	
	public MemberVO getMember() {
		return member;
	}
	public void setMember(MemberVO member) {
		this.member = member;
	}



	public int getInquiry_num() {
		return inquiry_num;
	}
	public void setInquiry_num(int inquiry_num) {
		this.inquiry_num = inquiry_num;
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
	
	
	public int getFk_member_num() {
		return fk_member_num;
	}
	public void setFk_member_num(int fk_member_num) {
		this.fk_member_num = fk_member_num;
	}
	
	
	public int getFk_product_num() {
		return fk_product_num;
	}
	public void setFk_product_num(int fk_product_num) {
		this.fk_product_num = fk_product_num;
	}
	
	
	public int getEmailFlag() {
		return emailFlag;
	}
	public void setEmailFlag(int emailFlag) {
		this.emailFlag = emailFlag;
	}
	
	
	public int getSmsFlag() {
		return smsFlag;
	}
	public void setSmsFlag(int smsFlag) {
		this.smsFlag = smsFlag;
	}
	
	
	public int getSecretFlag() {
		return secretFlag;
	}
	public void setSecretFlag(int secretFlag) {
		this.secretFlag = secretFlag;
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



	public String getProduct_name() {
		return product_name;
	}



	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}



	public int getRowNum() {
		return rowNum;
	}



	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}



	public String getAnswer_date() {
		return answer_date;
	}



	public void setAnswer_date(String answer_date) {
		this.answer_date = answer_date;
	}
	
	
	
	
	
}
