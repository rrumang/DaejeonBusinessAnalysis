package kr.or.ddit.marginAnalysis.model;

// 수익분석 결과 페이지의 투자비 회수 시점별 목표매출에 대한 VO
public class SalesGoalVo {
	
	private String report_cd;		// 보고서코드 (P.F.K)
	private int sg_peroid;				// 투자비 회수기간
	private int m_sales;			// 월 목표 매출액
	private int d_sales;			// 일 평균 목표 매출액
	private int d_customer;			// 일 평균 목표 고객 수
	private int tax;				// 세금
	private int profit;				// 월 추정경상이익
	
	public String getReport_cd() {
		return report_cd;
	}
	public void setReport_cd(String report_cd) {
		this.report_cd = report_cd;
	}
	public int getSg_peroid() {
		return sg_peroid;
	}
	public void setSg_peroid(int sg_peroid) {
		this.sg_peroid = sg_peroid;
	}
	public int getM_sales() {
		return m_sales;
	}
	public void setM_sales(int m_sales) {
		this.m_sales = m_sales;
	}
	public int getD_sales() {
		return d_sales;
	}
	public void setD_sales(int d_sales) {
		this.d_sales = d_sales;
	}
	public int getD_customer() {
		return d_customer;
	}
	public void setD_customer(int d_customer) {
		this.d_customer = d_customer;
	}
	public int getTax() {
		return tax;
	}
	public void setTax(int tax) {
		this.tax = tax;
	}
	public int getProfit() {
		return profit;
	}
	public void setProfit(int profit) {
		this.profit = profit;
	}
	public SalesGoalVo(String report_cd, int sg_peroid, int m_sales, int d_sales, int d_customer, int tax, int profit) {
		super();
		this.report_cd = report_cd;
		this.sg_peroid = sg_peroid;
		this.m_sales = m_sales;
		this.d_sales = d_sales;
		this.d_customer = d_customer;
		this.tax = tax;
		this.profit = profit;
	}
	
	public SalesGoalVo() {
	}
	@Override
	public String toString() {
		return "SalesGoalVo [report_cd=" + report_cd + ", sg_peroid=" + sg_peroid + ", m_sales=" + m_sales
				+ ", d_sales=" + d_sales + ", d_customer=" + d_customer + ", tax=" + tax + ", profit=" + profit + "]";
	}
}
