package kr.or.ddit.marginAnalysis.model;

//소요비용
public class ExpenseVo {
	private String report_cd;	// 보고서코드 (P.F.K)
	private int ep_unit_cost;	// 객단가
	private int ep_investment;	// 기타투자비
	private int ep_premium;		// 권리금
	private int ep_deposit;		// 보증금
	private int ep_loan;		// 대출금
	private double ep_roi;		// 이자율
	private int ep_iaf;			// 인테리어 및 설비비
	private int ep_monthly;		// 월세
	private int ep_personnel;	// 인건비
	private int ep_material;	// 재료비
	private int ep_etc;			// 기타비용
	
	public String getReport_cd() {
		return report_cd;
	}
	public void setReport_cd(String report_cd) {
		this.report_cd = report_cd;
	}
	public int getEp_unit_cost() {
		return ep_unit_cost;
	}
	public void setEp_unit_cost(int ep_unit_cost) {
		this.ep_unit_cost = ep_unit_cost;
	}
	public int getEp_investment() {
		return ep_investment;
	}
	public void setEp_investment(int ep_investment) {
		this.ep_investment = ep_investment;
	}
	public int getEp_premium() {
		return ep_premium;
	}
	public void setEp_premium(int ep_premium) {
		this.ep_premium = ep_premium;
	}
	public int getEp_deposit() {
		return ep_deposit;
	}
	public void setEp_deposit(int ep_deposit) {
		this.ep_deposit = ep_deposit;
	}
	public int getEp_loan() {
		return ep_loan;
	}
	public void setEp_loan(int ep_loan) {
		this.ep_loan = ep_loan;
	}
	public double getEp_roi() {
		return ep_roi;
	}
	public void setEp_roi(double ep_roi) {
		this.ep_roi = ep_roi;
	}
	public int getEp_iaf() {
		return ep_iaf;
	}
	public void setEp_iaf(int ep_iaf) {
		this.ep_iaf = ep_iaf;
	}
	public int getEp_monthly() {
		return ep_monthly;
	}
	public void setEp_monthly(int ep_monthly) {
		this.ep_monthly = ep_monthly;
	}
	public int getEp_personnel() {
		return ep_personnel;
	}
	public void setEp_personnel(int ep_personnel) {
		this.ep_personnel = ep_personnel;
	}
	public int getEp_material() {
		return ep_material;
	}
	public void setEp_material(int ep_material) {
		this.ep_material = ep_material;
	}
	public int getEp_etc() {
		return ep_etc;
	}
	public void setEp_etc(int ep_etc) {
		this.ep_etc = ep_etc;
	}
	public ExpenseVo(String report_cd, int ep_unit_cost, int ep_investment, int ep_premium, int ep_deposit, int ep_loan,
			int ep_roi, int ep_iaf, int ep_monthly, int ep_personnel, int ep_material, int ep_etc) {
		super();
		this.report_cd = report_cd;
		this.ep_unit_cost = ep_unit_cost;
		this.ep_investment = ep_investment;
		this.ep_premium = ep_premium;
		this.ep_deposit = ep_deposit;
		this.ep_loan = ep_loan;
		this.ep_roi = ep_roi;
		this.ep_iaf = ep_iaf;
		this.ep_monthly = ep_monthly;
		this.ep_personnel = ep_personnel;
		this.ep_material = ep_material;
		this.ep_etc = ep_etc;
	}
	public ExpenseVo() {
		
	}
	@Override
	public String toString() {
		return "ExpenseVo [report_cd=" + report_cd + ", ep_unit_cost=" + ep_unit_cost + ", ep_investment="
				+ ep_investment + ", ep_premium=" + ep_premium + ", ep_deposit=" + ep_deposit + ", ep_loan=" + ep_loan
				+ ", ep_roi=" + ep_roi + ", ep_iaf=" + ep_iaf + ", ep_monthly=" + ep_monthly + ", ep_personnel="
				+ ep_personnel + ", ep_material=" + ep_material + ", ep_etc=" + ep_etc + "]";
	}
}