package kr.or.ddit.locationAnalysis.model;

public class LocationAnalysisVo {
	
	private String report_cd;  // 보고서코드
	private String member_id;  // 회원아이디
	private int movee;         // 유동인구
	private int live;          // 주거인구
	private int jobb;          // 직장인구
	private String resultt;    // 잠재고객
	private int grade;         // 종합입지등급
	private String addr;       // 선택지역
	private long region_cd;    // 지역코드
	private String region_csc; // 주민센터주소
	
	public String getReport_cd() {
		return report_cd;
	}
	public void setReport_cd(String report_cd) {
		this.report_cd = report_cd;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getMovee() {
		return movee;
	}
	public void setMovee(int movee) {
		this.movee = movee;
	}
	public int getLive() {
		return live;
	}
	public void setLive(int live) {
		this.live = live;
	}
	public int getJobb() {
		return jobb;
	}
	public void setJobb(int jobb) {
		this.jobb = jobb;
	}
	public String getResultt() {
		return resultt;
	}
	public void setResultt(String resultt) {
		this.resultt = resultt;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public long getRegion_cd() {
		return region_cd;
	}
	public void setRegion_cd(long region_cd) {
		this.region_cd = region_cd;
	}
	public String getRegion_csc() {
		return region_csc;
	}
	public void setRegion_csc(String region_csc) {
		this.region_csc = region_csc;
	}
	
	public LocationAnalysisVo() {
		
	}
	
	public LocationAnalysisVo(String report_cd, String member_id, int movee, int live, int jobb, String resultt,
			int grade, String addr, long region_cd, String region_csc) {
		this.report_cd = report_cd;
		this.member_id = member_id;
		this.movee = movee;
		this.live = live;
		this.jobb = jobb;
		this.resultt = resultt;
		this.grade = grade;
		this.addr = addr;
		this.region_cd = region_cd;
		this.region_csc = region_csc;
	}
	
	@Override
	public String toString() {
		return "LocationAnalysisVo [report_cd=" + report_cd + ", member_id=" + member_id + ", movee=" + movee
				+ ", live=" + live + ", jobb=" + jobb + ", resultt=" + resultt + ", grade=" + grade + ", addr=" + addr
				+ ", region_cd=" + region_cd + ", region_csc=" + region_csc + "]";
	}
	
}
