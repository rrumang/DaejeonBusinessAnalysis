package kr.or.ddit.report.model;

import java.util.Date;

public class ReportVo {
	
	String report_cd;  // 보고서코드
	String member_id;  // 회원아이디
	String tob_cd;     // 업종분류코드
	long region_cd;    // 지역코드
	int report_kind;   // 보고서 종류
	Date report_dt;    // 분석일시
	
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
	public int getReport_kind() {
		return report_kind;
	}
	public void setReport_kind(int report_kind) {
		this.report_kind = report_kind;
	}
	public Date getReport_dt() {
		return report_dt;
	}
	public void setReport_dt(Date report_dt) {
		this.report_dt = report_dt;
	}
	
	public ReportVo() {
		
	}
	
	public ReportVo(String report_cd, String member_id, String tob_cd, long region_cd, int report_kind, Date report_dt) {
		this.report_cd = report_cd;
		this.member_id = member_id;
		this.tob_cd = tob_cd;
		this.region_cd = region_cd;
		this.report_kind = report_kind;
		this.report_dt = report_dt;
	}
	
	public ReportVo(String member_id, String tob_cd, long region_cd, int report_kind) {
		super();
		this.member_id = member_id;
		this.tob_cd = tob_cd;
		this.region_cd = region_cd;
		this.report_kind = report_kind;
	}
	
	public ReportVo(String report_cd, String member_id, long region_cd) {
		this.report_cd = report_cd;
		this.member_id = member_id;
		this.region_cd = region_cd;
	}
	
	public ReportVo(String member_id, long region_cd) {
		super();
		this.member_id = member_id;
		this.region_cd = region_cd;
	}
	
	@Override
	public String toString() {
		return "ReportVo [report_cd=" + report_cd + ", member_id=" + member_id + ", tob_cd=" + tob_cd + ", region_cd="
				+ region_cd + ", report_kind=" + report_kind + ", report_dt=" + report_dt + "]";
	}
}
