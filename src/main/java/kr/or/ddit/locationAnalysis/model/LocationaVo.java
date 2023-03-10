package kr.or.ddit.locationAnalysis.model;

public class LocationaVo {
	private String report_cd; // 보고서코드
	private String tob;       // 업종(중분류)
	private long maxx;        // 최고매출액
	private int grade;        // 등급
	
	public String getTob() {
		return tob;
	}
	public void setTob(String tob) {
		this.tob = tob;
	}
	public long getMaxx() {
		return maxx;
	}
	public void setMaxx(long maxx) {
		this.maxx = maxx;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getReport_cd() {
		return report_cd;
	}
	public void setReport_cd(String report_cd) {
		this.report_cd = report_cd;
	}
	
	public LocationaVo() {
		
	}
	
	public LocationaVo(String report_cd, String tob, long maxx, int grade) {
		this.report_cd = report_cd;
		this.tob = tob;
		this.maxx = maxx;
		this.grade = grade;
	}
	
	@Override
	public String toString() {
		return "LocationaVo [report_cd=" + report_cd + ", tob=" + tob + ", maxx=" + maxx + ", grade=" + grade + "]";
	}
	
}
