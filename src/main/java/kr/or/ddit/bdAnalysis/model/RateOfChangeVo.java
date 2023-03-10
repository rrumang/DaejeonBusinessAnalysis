package kr.or.ddit.bdAnalysis.model;

public class RateOfChangeVo {
	private int evaluation_dt;
	private long region_cd;
	private String region_name;
	private float total;
	private float growpt;
	
	
	public int getEvaluation_dt() {
		return evaluation_dt;
	}
	public void setEvaluation_dt(int evaluation_dt) {
		this.evaluation_dt = evaluation_dt;
	}
	public long getRegion_cd() {
		return region_cd;
	}
	public void setRegion_cd(long region_cd) {
		this.region_cd = region_cd;
	}
	public String getRegion_name() {
		return region_name;
	}
	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	public float getGrowpt() {
		return growpt;
	}
	public void setGrowpt(float growpt) {
		this.growpt = growpt;
	}
	
	@Override
	public String toString() {
		return "RateOfChangeVo [evaluation_dt=" + evaluation_dt + ", region_cd=" + region_cd + ", region_name="
				+ region_name + ", total=" + total + ", growpt=" + growpt + "]";
	}
	
}
