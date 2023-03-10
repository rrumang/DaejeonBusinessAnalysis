package kr.or.ddit.bdPrsct.model;

//매출현황
public class SalesPresentVo {
	
	private int sp_dt; // 데이터기준연반기
	private String tob; // 업종분류
	private String gu; // 지역
	private int sp_monthly; // 월평균매출액
	private int sp_unit_cost; // 건단가
	
	public int getSp_dt() {
		return sp_dt;
	}
	public void setSp_dt(int sp_dt) {
		this.sp_dt = sp_dt;
	}
	public String getTob() {
		return tob;
	}
	public void setTob(String tob) {
		this.tob = tob;
	}
	public String getGu() {
		return gu;
	}
	public void setGu(String gu) {
		this.gu = gu;
	}
	public int getSp_monthly() {
		return sp_monthly;
	}
	public void setSp_monthly(int sp_monthly) {
		this.sp_monthly = sp_monthly;
	}
	public int getSp_unit_cost() {
		return sp_unit_cost;
	}
	public void setSp_unit_cost(int sp_unit_cost) {
		this.sp_unit_cost = sp_unit_cost;
	}
	public SalesPresentVo(int sp_dt, String tob, String gu, int sp_monthly, int sp_unit_cost) {
		super();
		this.sp_dt = sp_dt;
		this.tob = tob;
		this.gu = gu;
		this.sp_monthly = sp_monthly;
		this.sp_unit_cost = sp_unit_cost;
	}
	
	public SalesPresentVo() {
	}
	@Override
	public String toString() {
		return "SalesPresentVo [sp_dt=" + sp_dt + ", tob=" + tob + ", gu=" + gu + ", sp_monthly=" + sp_monthly
				+ ", sp_unit_cost=" + sp_unit_cost + "]";
	}
	
	
}
