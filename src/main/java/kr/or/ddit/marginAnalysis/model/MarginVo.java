package kr.or.ddit.marginAnalysis.model;

// 수익분석 결과 페이지의 분석설정정보에 대한 수익분석 VO
public class MarginVo {
	
	private String report_cd; 		// 보고서코드 (P.F.K)
	private String margin_region; 	// 분석지역
	private String margin_tob; 		// 분석업종
	private String margin_dt; 		// 기준데이터시점
	
	public String getReport_cd() {
		return report_cd;
	}
	public void setReport_cd(String report_cd) {
		this.report_cd = report_cd;
	}
	public String getMargin_region() {
		return margin_region;
	}
	public void setMargin_region(String margin_region) {
		this.margin_region = margin_region;
	}
	public String getMargin_tob() {
		return margin_tob;
	}
	public void setMargin_tob(String margin_tob) {
		this.margin_tob = margin_tob;
	}
	public String getMargin_dt() {
		return margin_dt;
	}
	public void setMargin_dt(String margin_dt) {
		this.margin_dt = margin_dt;
	}
	public MarginVo(String report_cd, String margin_region, String margin_tob, String margin_dt) {
		super();
		this.report_cd = report_cd;
		this.margin_region = margin_region;
		this.margin_tob = margin_tob;
		this.margin_dt = margin_dt;
	}
	public MarginVo() {
	}
	@Override
	public String toString() {
		return "MarginAnalysisVo [report_cd=" + report_cd + ", margin_region=" + margin_region + ", margin_tob="
				+ margin_tob + ", margin_dt=" + margin_dt + "]";
	}
}
