package kr.or.ddit.data.model;

//매출
public class SalesVo {
	int sales_dt;       // 데이터 기준 연월
	String tob_cd;      // 업종분류코드
	long region_cd;     // 지역코드
	long sales_monthly; // 월매출액
	int sales_cnt;      // 결제건수
	
	public int getSales_dt() {
		return sales_dt;
	}
	public void setSales_dt(int sales_dt) {
		this.sales_dt = sales_dt;
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
	public long getSales_monthly() {
		return sales_monthly;
	}
	public void setSales_monthly(long sales_monthly) {
		this.sales_monthly = sales_monthly;
	}
	public int getSales_cnt() {
		return sales_cnt;
	}
	public void setSales_cnt(int sales_cnt) {
		this.sales_cnt = sales_cnt;
	}
	
	public SalesVo() {
		
	}
	
	public SalesVo(int sales_dt, String tob_cd, long region_cd, long sales_monthly, int sales_cnt) {
		this.sales_dt = sales_dt;
		this.tob_cd = tob_cd;
		this.region_cd = region_cd;
		this.sales_monthly = sales_monthly;
		this.sales_cnt = sales_cnt;
	}
	@Override
	public String toString() {
		return "SalesVo [sales_dt=" + sales_dt + ", tob_cd=" + tob_cd + ", region_cd=" + region_cd + ", sales_monthly="
				+ sales_monthly + ", sales_cnt=" + sales_cnt + "]";
	}
	
}
