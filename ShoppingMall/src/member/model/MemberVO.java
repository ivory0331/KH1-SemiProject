package member.model;

public class MemberVO {

	private int member_num; // 회원번호 - 필수입력 + 유일한 값(primary) + 시퀀스 사용
	private String name; // 성명 - 필수입력
	private String userid; // 유저id - 필수입력 + 유일한 값
	private String pwd; // 암호 (SHA-256 암호화 대상 단방향암호화) - 필수입력
	private String email; // 이메일 (AES-256 암호화/복호화 대상 양방향암호화) - 필수입력 + 유일한 값
	private String mobile; // 핸드폰 번호 (AES-256 암호화/복호화 대상 양방향암호화) - 필수입력
	private String postcode; // 우편번호
	private String address; // 주소 + 추가주소
	private String detailAddress; // 상세주소
	private String gender; // 성별 (1:남자, 2:여자, 3:선택안함)
	private String birthday; //생년월일 
	private int status; // 회원상태 (1:일반회원, 2:관리자, 0:휴면계정)
	private String registerdate; //가입일자 
	private String last_login_date; // 마지막으로 로그인 한 날짜시간 기록용
	private String pwd_change_date; // 마지막으로 암호를 변경한 날짜시간 기록용

	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false

	private boolean idleStatus = false; // 휴면유무(휴면이 아니라면 false, 휴면이면 true)
	// 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 true(휴면으로 지정)
	// 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지나지 않았으면 false

	public MemberVO() {}

	public MemberVO(int member_num, String name, String userid, String pwd, String email, String mobile,
			String postcode, String address, String detailAddress, String gender, String birthday, int status,
			String registerdate) {
		
		super();
		this.member_num = member_num;
		this.name = name;
		this.userid = userid;
		this.pwd = pwd;
		this.email = email;
		this.mobile = mobile;
		this.postcode = postcode;
		this.address = address;
		this.detailAddress = detailAddress;
		this.gender = gender;
		this.birthday = birthday;
		this.status = status;
		this.registerdate = registerdate;
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

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		
		return mobile;
	}
	
	public String getMobileForm() {
		
		return mobile.substring(0,3)+"-"+mobile.substring(3,7)+"-"+mobile.substring(7);
	}


	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDetailAddress() {
		return detailAddress;
	}

	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getRegisterdate() {
		return registerdate;
	}

	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
	}

	public String getLast_login_date() {
		return last_login_date;
	}

	public void setLast_login_date(String last_login_date) {
		this.last_login_date = last_login_date;
	}

	public String getPwd_change_date() {
		return pwd_change_date;
	}

	public void setPwd_change_date(String pwd_change_date) {
		this.pwd_change_date = pwd_change_date;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}

	public boolean isIdleStatus() {
		return idleStatus;
	}

	public void setIdleStatus(boolean idleStatus) {
		this.idleStatus = idleStatus;
	}

}