package kr.or.ddit.member.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MemberVo {
	
	private String member_id; // 회원아이디
	private String tob_cd; // 업종분류코드
	private long region_cd; // 지역코드
	private String member_password; // 비밀번호
	private String member_name; // 이름
	private String member_email; // 이메일
	private String member_tel; // 휴대전화번호
	private int member_gender; // 성별
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date member_birth; // 생년월일
	private int member_grade; // 등급
	private String member_naver_key; // 네이버인증키
	private String member_kakao_key; // 카카오인증키
	
	public MemberVo() {
	}

	public MemberVo(String member_id, String member_password, String member_name, String member_email,
			String member_tel, int member_gender, Date member_birth, int member_grade,long region_cd) {
		super();
		this.member_id = member_id;
		this.member_password = member_password;
		this.member_name = member_name;
		this.member_email = member_email;
		this.member_tel = member_tel;
		this.member_gender = member_gender;
		this.member_birth = member_birth;
		this.member_grade = member_grade;
		this.region_cd = region_cd;
	}

	public MemberVo(String member_id, String tob_cd, long region_cd, String member_password, String member_name,
			String member_email, String member_tel, int member_gender, Date member_birth, int member_grade,
			String member_naver_key, String member_kakao_key) {
		this.member_id = member_id;
		this.tob_cd = tob_cd;
		this.region_cd = region_cd;
		this.member_password = member_password;
		this.member_name = member_name;
		this.member_email = member_email;
		this.member_tel = member_tel;
		this.member_gender = member_gender;
		this.member_birth = member_birth;
		this.member_grade = member_grade;
		this.member_naver_key = member_naver_key;
		this.member_kakao_key = member_kakao_key;
	}
	
	

	public MemberVo(String member_id, String tob_cd, long region_cd, String member_password, String member_name,
			String member_email, String member_tel, int member_gender, Date member_birth, int member_grade) {
		super();
		this.member_id = member_id;
		this.tob_cd = tob_cd;
		this.region_cd = region_cd;
		this.member_password = member_password;
		this.member_name = member_name;
		this.member_email = member_email;
		this.member_tel = member_tel;
		this.member_gender = member_gender;
		this.member_birth = member_birth;
		this.member_grade = member_grade;
	}

	public MemberVo(String member_id, String member_password, String member_name, String member_email,
			String member_tel, int member_gender, Date member_birth, int member_grade) {
		super();
		this.member_id = member_id;
		this.member_password = member_password;
		this.member_name = member_name;
		this.member_email = member_email;
		this.member_tel = member_tel;
		this.member_gender = member_gender;
		this.member_birth = member_birth;
		this.member_grade = member_grade;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getTob_cd() {
		return tob_cd;
	}

	public void setTob_cd(String tob_cd) {
		this.tob_cd = tob_cd;
	}

	public long getRegion_cd() {
		return region_cd;
	}

	public void setRegion_cd(long region_cd) {
		this.region_cd = region_cd;
	}

	public String getMember_password() {
		return member_password;
	}

	public void setMember_password(String member_password) {
		this.member_password = member_password;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}

	public String getMember_tel() {
		return member_tel;
	}

	public void setMember_tel(String member_tel) {
		this.member_tel = member_tel;
	}

	public int getMember_gender() {
		return member_gender;
	}

	public void setMember_gender(int member_gender) {
		this.member_gender = member_gender;
	}

	public Date getMember_birth() {
		return member_birth;
	}

	public void setMember_birth(Date member_birth) {
		this.member_birth = member_birth;
	}

	public int getMember_grade() {
		return member_grade;
	}

	public void setMember_grade(int member_grade) {
		this.member_grade = member_grade;
	}

	public String getMember_naver_key() {
		return member_naver_key;
	}

	public void setMember_naver_key(String member_naver_key) {
		this.member_naver_key = member_naver_key;
	}

	public String getMember_kakao_key() {
		return member_kakao_key;
	}

	public void setMember_kakao_key(String member_kakao_key) {
		this.member_kakao_key = member_kakao_key;
	}

	@Override
	public String toString() {
		return "MemberVo [member_id=" + member_id + ", tob_cd=" + tob_cd + ", region_cd=" + region_cd
				+ ", member_password=" + member_password + ", member_name=" + member_name + ", member_email="
				+ member_email + ", member_tel=" + member_tel + ", member_gender=" + member_gender + ", member_birth="
				+ member_birth + ", member_grade=" + member_grade + ", member_naver_key=" + member_naver_key
				+ ", member_kakao_key=" + member_kakao_key + "]";
	}
	
	
}
