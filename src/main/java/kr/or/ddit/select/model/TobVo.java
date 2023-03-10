package kr.or.ddit.select.model;

//상권정보업종분류
public class TobVo {
	
	private String tob_cd; // 업종분류코드
	private String sic_cd; // 표준산업분류코드
	private String tob_cd2; // 상위업종분류코드
	private String tob_cd3; // 최상위업종분류코드
	private int tob_cl; // 업종구분
	private String tob_name; // 업종분류명
	private int tob_yn; // 사용여부
	
	public TobVo() {
	}
	
	public TobVo(String tob_cd, String sic_cd, String tob_cd2, String tob_cd3, int tob_cl, String tob_name,
			int tob_yn) {
		this.tob_cd = tob_cd;
		this.sic_cd = sic_cd;
		this.tob_cd2 = tob_cd2;
		this.tob_cd3 = tob_cd3;
		this.tob_cl = tob_cl;
		this.tob_name = tob_name;
		this.tob_yn = tob_yn;
	}

	public String getTob_cd() {
		return tob_cd;
	}

	public void setTob_cd(String tob_cd) {
		this.tob_cd = tob_cd;
	}

	public String getSic_cd() {
		return sic_cd;
	}

	public void setSic_cd(String sic_cd) {
		this.sic_cd = sic_cd;
	}

	public String getTob_cd2() {
		return tob_cd2;
	}

	public void setTob_cd2(String tob_cd2) {
		this.tob_cd2 = tob_cd2;
	}

	public String getTob_cd3() {
		return tob_cd3;
	}

	public void setTob_cd3(String tob_cd3) {
		this.tob_cd3 = tob_cd3;
	}

	public int getTob_cl() {
		return tob_cl;
	}

	public void setTob_cl(int tob_cl) {
		this.tob_cl = tob_cl;
	}

	public String getTob_name() {
		return tob_name;
	}

	public void setTob_name(String tob_name) {
		this.tob_name = tob_name;
	}

	public int getTob_yn() {
		return tob_yn;
	}

	public void setTob_yn(int tob_yn) {
		this.tob_yn = tob_yn;
	}

	@Override
	public String toString() {
		return "TobVo [tob_cd=" + tob_cd + ", sic_cd=" + sic_cd + ", tob_cd2=" + tob_cd2 + ", tob_cd3=" + tob_cd3
				+ ", tob_cl=" + tob_cl + ", tob_name=" + tob_name + ", tob_yn=" + tob_yn + "]";
	}
}
