package kr.or.ddit.tobRecom.model;

// 업종적합도 관리화면 출력용
public class GofListVo {
	
	private String code; // 업종분류코드
	private String codeName; // 업종분류명
	private String bdtrank1; // 상권유형별순위(1-5)
	private String bdtrank2;
	private String bdtrank3;
	private String bdtrank4;
	private String bdtrank5;
	private String gnarank1; // 성별&연령대별순위(1-5)
	private String gnarank2;
	private String gnarank3;
	private String gnarank4;
	private String gnarank5;
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getBdtrank1() {
		return bdtrank1;
	}
	public void setBdtrank1(String bdtrank1) {
		this.bdtrank1 = bdtrank1;
	}
	public String getBdtrank2() {
		return bdtrank2;
	}
	public void setBdtrank2(String bdtrank2) {
		this.bdtrank2 = bdtrank2;
	}
	public String getBdtrank3() {
		return bdtrank3;
	}
	public void setBdtrank3(String bdtrank3) {
		this.bdtrank3 = bdtrank3;
	}
	public String getBdtrank4() {
		return bdtrank4;
	}
	public void setBdtrank4(String bdtrank4) {
		this.bdtrank4 = bdtrank4;
	}
	public String getBdtrank5() {
		return bdtrank5;
	}
	public void setBdtrank5(String bdtrank5) {
		this.bdtrank5 = bdtrank5;
	}
	public String getGnarank1() {
		return gnarank1;
	}
	public void setGnarank1(String gnarank1) {
		this.gnarank1 = gnarank1;
	}
	public String getGnarank2() {
		return gnarank2;
	}
	public void setGnarank2(String gnarank2) {
		this.gnarank2 = gnarank2;
	}
	public String getGnarank3() {
		return gnarank3;
	}
	public void setGnarank3(String gnarank3) {
		this.gnarank3 = gnarank3;
	}
	public String getGnarank4() {
		return gnarank4;
	}
	public void setGnarank4(String gnarank4) {
		this.gnarank4 = gnarank4;
	}
	public String getGnarank5() {
		return gnarank5;
	}
	public void setGnarank5(String gnarank5) {
		this.gnarank5 = gnarank5;
	}

	public GofListVo() {
	}
	
	public GofListVo(String code, String codeName, String bdtrank1, String bdtrank2, String bdtrank3, String bdtrank4,
			String bdtrank5, String gnarank1, String gnarank2, String gnarank3, String gnarank4, String gnarank5) {
		this.code = code;
		this.codeName = codeName;
		this.bdtrank1 = bdtrank1;
		this.bdtrank2 = bdtrank2;
		this.bdtrank3 = bdtrank3;
		this.bdtrank4 = bdtrank4;
		this.bdtrank5 = bdtrank5;
		this.gnarank1 = gnarank1;
		this.gnarank2 = gnarank2;
		this.gnarank3 = gnarank3;
		this.gnarank4 = gnarank4;
		this.gnarank5 = gnarank5;
	}
	
	@Override
	public String toString() {
		return "GofListVo [code=" + code + ", codeName=" + codeName + ", bdtrank1=" + bdtrank1 + ", bdtrank2="
				+ bdtrank2 + ", bdtrank3=" + bdtrank3 + ", bdtrank4=" + bdtrank4 + ", bdtrank5=" + bdtrank5
				+ ", gnarank1=" + gnarank1 + ", gnarank2=" + gnarank2 + ", gnarank3=" + gnarank3 + ", gnarank4="
				+ gnarank4 + ", gnarank5=" + gnarank5 + "]";
	}
	
}
