package kr.or.ddit.marginAnalysis.model;

// 수익분석 결과 페이지의 월 소요비용에 대한 VO
public class MonthlyEpVo {
	
	private String report_cd;	// 보고서코드 (P.F.K)
	private int rent;			// 월세
	private int fix_pe;			// 고정인건비
	private int cost;			// 초기투자비용에 대한 월 발생비용
	private int etc;			// 기타운영비용
	private int material;		// 재료비
	private int var_pe;			// 변동인건비
	private int total_fix;		// 고정비용 합
	private int total_var;		// 변동비용 합
	private int total;			// 전체 합
	
	public String getReport_cd() {
		return report_cd;
	}
	public void setReport_cd(String report_cd) {
		this.report_cd = report_cd;
	}
	public int getRent() {
		return rent;
	}
	public void setRent(int rent) {
		this.rent = rent;
	}
	public int getFix_pe() {
		return fix_pe;
	}
	public void setFix_pe(int fix_pe) {
		this.fix_pe = fix_pe;
	}
	public int getCost() {
		return cost;
	}
	public void setCost(int cost) {
		this.cost = cost;
	}
	public int getEtc() {
		return etc;
	}
	public void setEtc(int etc) {
		this.etc = etc;
	}
	public int getMaterial() {
		return material;
	}
	public void setMaterial(int material) {
		this.material = material;
	}
	public int getVar_pe() {
		return var_pe;
	}
	public void setVar_pe(int var_pe) {
		this.var_pe = var_pe;
	}
	public int getTotal_fix() {
		return total_fix;
	}
	public void setTotal_fix(int total_fix) {
		this.total_fix = total_fix;
	}
	public int getTotal_var() {
		return total_var;
	}
	public void setTotal_var(int total_var) {
		this.total_var = total_var;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public MonthlyEpVo(String report_cd, int rent, int fix_pe, int cost, int etc, int material, int var_pe,
			int total_fix, int total_var, int total) {
		super();
		this.report_cd = report_cd;
		this.rent = rent;
		this.fix_pe = fix_pe;
		this.cost = cost;
		this.etc = etc;
		this.material = material;
		this.var_pe = var_pe;
		this.total_fix = total_fix;
		this.total_var = total_var;
		this.total = total;
	}
	
	public MonthlyEpVo() {
	}
	@Override
	public String toString() {
		return "MonthlyExpenseVo [report_cd=" + report_cd + ", rent=" + rent + ", fix_pe=" + fix_pe + ", cost=" + cost
				+ ", etc=" + etc + ", material=" + material + ", var_pe=" + var_pe + ", total_fix=" + total_fix
				+ ", total_var=" + total_var + ", total=" + total + "]";
	}
	
}
