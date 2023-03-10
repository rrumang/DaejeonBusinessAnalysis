package kr.or.ddit.bdPrsct.model;

//사업자현황
public class BusinessmanVo {
	
	private int bm_dt; // 데이터기준연도
	private int bm_cl; // 현황구분
	private String industry_name; // 산업명
	private String bm_type_name; // 사업자유형
	private int bm_cnt; // 사업체수
	
	public int getBm_dt() {
		return bm_dt;
	}
	public void setBm_dt(int bm_dt) {
		this.bm_dt = bm_dt;
	}
	public int getBm_cl() {
		return bm_cl;
	}
	public void setBm_cl(int bm_cl) {
		this.bm_cl = bm_cl;
	}
	public String getIndustry_name() {
		return industry_name;
	}
	public void setIndustry_name(String industry_name) {
		this.industry_name = industry_name;
	}
	public String getBm_type_name() {
		return bm_type_name;
	}
	public void setBm_type_name(String bm_type_name) {
		this.bm_type_name = bm_type_name;
	}
	public int getBm_cnt() {
		return bm_cnt;
	}
	public void setBm_cnt(int bm_cnt) {
		this.bm_cnt = bm_cnt;
	}
	public BusinessmanVo(int bm_dt, int bm_cl, String industry_name, String bm_type_name, int bm_cnt) {
		this.bm_dt = bm_dt;
		this.bm_cl = bm_cl;
		this.industry_name = industry_name;
		this.bm_type_name = bm_type_name;
		this.bm_cnt = bm_cnt;
	}
	
	public BusinessmanVo() {
	}
	@Override
	public String toString() {
		return "BusinessmanVo [bm_dt=" + bm_dt + ", bm_cl=" + bm_cl + ", industry_name=" + industry_name
				+ ", bm_type_name=" + bm_type_name + ", bm_cnt=" + bm_cnt + "]";
	}
	
	
}
