package manager.model;

public class MemberVO {
	
	private int member_num;
	private String name;
	private String userid;
	private String address;
	
	
	public MemberVO() {}
	
	
	public MemberVO(int member_num, String name, String userid, String address) {
		super();
		this.member_num = member_num;
		this.name = name;
		this.userid = userid;
		this.address = address;
	}

	
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	
	
	
	
	

}
