package kr.or.ddit.marginAnalysis.model;

// 수익분석 결과 페이지의 동일상권평균매출 VO
public class AvgSalesVo {
	
	private String report_cd;	// 보고서코드(P.F.K)
	private int sales;			// 월 평균 매출
	private int cnt;			// 월 평균 결제 건수
	private int payment;		// 1회 평균 결제 금액
	
	public String getReport_cd() {
		return report_cd;
	}
	public void setReport_cd(String report_cd) {
		this.report_cd = report_cd;
	}
	public int getSales() {
		return sales;
	}
	public void setSales(int sales) {
		this.sales = sales;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}
	public AvgSalesVo(String report_cd, int sales, int cnt, int payment) {
		super();
		this.report_cd = report_cd;
		this.sales = sales;
		this.cnt = cnt;
		this.payment = payment;
	}
	
	public AvgSalesVo() {
	}
	@Override
	public String toString() {
		return "AvgSalesVo [report_cd=" + report_cd + ", sales=" + sales + ", cnt=" + cnt + ", payment=" + payment
				+ "]";
	}
}
