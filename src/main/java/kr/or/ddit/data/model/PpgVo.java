package kr.or.ddit.data.model;

// 유동인구-성별
public class PpgVo {
	
	private int ppg_dt; // 데이터기준연도
	private int ppg_gender; // 성별
	private long region_cd; // 지역코드
	private int ppg_cnt; // 유동인구수
	
	private int ppg_ratio; // ppg_cnt를 백분율로 변환. db에 없음
	
	public int getPpg_dt() {
		return ppg_dt;
	}
	public void setPpg_dt(int ppg_dt) {
		this.ppg_dt = ppg_dt;
	}
	public int getPpg_gender() {
		return ppg_gender;
	}
	public void setPpg_gender(int ppg_gender) {
		this.ppg_gender = ppg_gender;
	}
	public long getRegion_cd() {
		return region_cd;
	}
	public void setRegion_cd(long region_cd) {
		this.region_cd = region_cd;
	}
	public int getPpg_cnt() {
		return ppg_cnt;
	}
	public void setPpg_cnt(int ppg_cnt) {
		this.ppg_cnt = ppg_cnt;
	}
	public int getPpg_ratio() {
		return ppg_ratio;
	}
	public void setPpg_ratio(int ppg_ratio) {
		this.ppg_ratio = ppg_ratio;
	}
	
	public PpgVo() {
	}
	
	public PpgVo(int ppg_dt, int ppg_gender, long region_cd, int ppg_cnt, int ppg_ratio) {
		this.ppg_dt = ppg_dt;
		this.ppg_gender = ppg_gender;
		this.region_cd = region_cd;
		this.ppg_cnt = ppg_cnt;
		this.ppg_ratio = ppg_ratio;
	}
	@Override
	public String toString() {
		return "PpgVo [ppg_dt=" + ppg_dt + ", ppg_gender=" + ppg_gender + ", region_cd=" + region_cd + ", ppg_cnt="
				+ ppg_cnt + ", ppg_ratio=" + ppg_ratio + "]";
	}
	
}
