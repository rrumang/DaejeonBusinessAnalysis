package kr.or.ddit.tobRecom.model;

// 상권내 밀집업종
public class TobCompVo {
	
	private String report_cd; // 보고서코드
	private String tob_name; // 중분류명
	private String tob_cd; // 대분류코드
	private float inRegion; // 상권 내 비율
	private float inDaejeon; // 대전 평균 비율
	private float deviation; // 편차
	
	public String getReport_cd() {
		return report_cd;
	}
	public void setReport_cd(String report_cd) {
		this.report_cd = report_cd;
	}
	public String getTob_name() {
		return tob_name;
	}
	public void setTob_name(String tob_name) {
		this.tob_name = tob_name;
	}
	public String getTob_cd() {
		return tob_cd;
	}
	public void setTob_cd(String tob_cd) {
		this.tob_cd = tob_cd;
	}
	public float getInRegion() {
		return inRegion;
	}
	public void setInRegion(float inRegion) {
		this.inRegion = inRegion;
	}
	public float getInDaejeon() {
		return inDaejeon;
	}
	public void setInDaejeon(float inDaejeon) {
		this.inDaejeon = inDaejeon;
	}
	public float getDeviation() {
		return deviation;
	}
	public void setDeviation(float deviation) {
		this.deviation = deviation;
	}
	
	@Override
	public String toString() {
		return "TobCompVo [report_cd=" + report_cd + ", tob_name=" + tob_name + ", tob_cd=" + tob_cd + ", inRegion="
				+ inRegion + ", inDaejeon=" + inDaejeon + ", deviation=" + deviation + "]";
	}
	
}
