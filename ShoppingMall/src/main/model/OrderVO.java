package main.model;

import member.model.MemberVO;

public class OrderVO {
	private int order_num;
	private String order_date;
	private String recipient;
	private String recipient_mobile;
	private String recipient_postcode;
	private String recipient_address;
	private String recipient_detailAddress;
	private int price;
	private String memo;
	private String order_state;
	private MemberVO member;
	
	public OrderVO() { }
	
	public OrderVO(int order_num, String order_date, String recipient, String recipient_mobile,
			String recipient_postcode, String recipient_address, String recipient_detailAddress, int price, String memo,
			String order_state, MemberVO member) {
		
		this.order_num = order_num;
		this.order_date = order_date;
		this.recipient = recipient;
		this.recipient_mobile = recipient_mobile;
		this.recipient_postcode = recipient_postcode;
		this.recipient_address = recipient_address;
		this.recipient_detailAddress = recipient_detailAddress;
		this.price = price;
		this.memo = memo;
		this.order_state = order_state;
		this.member = member;
	}
	
	
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	
	
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	
	
	public String getRecipient() {
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	
	
	public String getRecipient_mobile() {
		return recipient_mobile;
	}
	public void setRecipient_mobile(String recipient_mobile) {
		this.recipient_mobile = recipient_mobile;
	}
	
	public String getMobileForm() {		
		return recipient_mobile.substring(0,3)+"-"+recipient_mobile.substring(3,7)+"-"+recipient_mobile.substring(7);
	}
	
	public String getRecipient_postcode() {
		return recipient_postcode;
	}
	public void setRecipient_postcode(String recipient_postcode) {
		this.recipient_postcode = recipient_postcode;
	}
	
	
	public String getRecipient_address() {
		return recipient_address;
	}
	public void setRecipient_address(String recipient_address) {
		this.recipient_address = recipient_address;
	}
	
	
	public String getRecipient_detailAddress() {
		return recipient_detailAddress;
	}
	public void setRecipient_detailAddress(String recipient_detailAddress) {
		this.recipient_detailAddress = recipient_detailAddress;
	}
	
	
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
	
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	
	public String getOrder_state() {
		return order_state;
	}
	public void setOrder_state(String order_state) {
		this.order_state = order_state;
	}
	
	
	public MemberVO getMember() {
		return member;
	}
	public void setMember(MemberVO member) {
		this.member = member;
	}
	
	
}
