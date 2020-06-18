package hyemin.model;

public class MemberVO {
	
	private int member_num;			// 회원번호 - 필수입력 + 유일한 값(primary) + 시퀀스 사용
	private String name;			// 성명 - 필수입력
	private String userid;			// 유저id - 필수입력 + 유일한 값
	private String pwd;				// 암호 (SHA-256 암호화 대상  단방향암호화) - 필수입력
	private String email;			// 이메일 (AES-256 암호화/복호화 대상  양방향암호화) - 필수입력 + 유일한 값
	private String hp1;				// 핸드폰 번호 앞자리(010) - 필수입력
	private String hp2;				// 핸드폰 번호 중간자리 (AES-256 암호화/복호화 대상  양방향암호화) - 필수입력
	private String hp3;				// 핸드폰 번호 뒷자리 (AES-256 암호화/복호화 대상  양방향암호화) - 필수입력
	private String postcode;		// 우편번호
	private String address;			// 주소
	private String detailAddress;	// 상세주소
	private String extraAddress;	// 추가주소
	private String gender;			// 성별 (1:남자, 2:여자, 3:선택안함)
	private String birthyear;		// 생년
	private String birthmonth;		// 생월
	private String birthday;		// 생일
	private String pwd_change_date;	// 암호 수정한 날짜
	private int status;				// 회원상태 (1:일반회원, 2:관리자, 3:탈퇴자)
	
	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
	
	public MemberVO() { }

	public MemberVO(int member_num, String name, String userid, String pwd, String email, String hp1, String hp2,
			String hp3, String postcode, String address, String detailAddress, String extraAddress, String gender,
			String birthyear, String birthmonth, String birthday, String pwd_change_date, int status) {
		super();
		this.member_num = member_num;
		this.name = name;
		this.userid = userid;
		this.pwd = pwd;
		this.email = email;
		this.hp1 = hp1;
		this.hp2 = hp2;
		this.hp3 = hp3;
		this.postcode = postcode;
		this.address = address;
		this.detailAddress = detailAddress;
		this.extraAddress = extraAddress;
		this.gender = gender;
		this.birthyear = birthyear;
		this.birthmonth = birthmonth;
		this.birthday = birthday;
		this.pwd_change_date = pwd_change_date;
		this.status = status;
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

	public String getHp1() {
		return hp1;
	}

	public void setHp1(String hp1) {
		this.hp1 = hp1;
	}

	public String getHp2() {
		return hp2;
	}

	public void setHp2(String hp2) {
		this.hp2 = hp2;
	}

	public String getHp3() {
		return hp3;
	}

	public void setHp3(String hp3) {
		this.hp3 = hp3;
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

	public String getExtraAddress() {
		return extraAddress;
	}

	public void setExtraAddress(String extraAddress) {
		this.extraAddress = extraAddress;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthyear() {
		return birthyear;
	}

	public void setBirthyear(String birthyear) {
		this.birthyear = birthyear;
	}

	public String getBirthmonth() {
		return birthmonth;
	}

	public void setBirthmonth(String birthmonth) {
		this.birthmonth = birthmonth;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getPwd_change_date() {
		return pwd_change_date;
	}

	public void setPwd_change_date(String pwd_change_date) {
		this.pwd_change_date = pwd_change_date;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}	
	
}
