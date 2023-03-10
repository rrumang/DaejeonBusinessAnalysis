package kr.or.ddit.data.model;

// 유동인구-연령대별
public class PpaVo {
	
	private int ppa_dt; // 데이터기준연도
	private int ppa_age_group; // 연령대
	private long region_cd; // 지역코드
	private int ppa_cnt; // 유동인구수
	
	private float ppa_ratio; // ppa_cnt를 백분율로 환산된 데이터가 들어갈 컬럼
							 // PPA테이블에는 없는 컬럼
	
	public int getPpa_dt() {
		return ppa_dt;
	}
	public void setPpa_dt(int ppa_dt) {
		this.ppa_dt = ppa_dt;
	}
	public int getPpa_age_group() {
		return ppa_age_group;
	}
	public void setPpa_age_group(int ppa_age_group) {
		this.ppa_age_group = ppa_age_group;
	}
	public long getRegion_cd() {
		return region_cd;
	}
	public void setRegion_cd(long region_cd) {
		this.region_cd = region_cd;
	}
	public int getPpa_cnt() {
		return ppa_cnt;
	}
	public void setPpa_cnt(int ppa_cnt) {
		this.ppa_cnt = ppa_cnt;
	}
	public float getPpa_ratio() {
		return ppa_ratio;
	}
	public void setPpa_ratio(float ppa_ratio) {
		this.ppa_ratio = ppa_ratio;
	}

	@Override
	public String toString() {
		return "PpaVo [ppa_dt=" + ppa_dt + ", ppa_age_group=" + ppa_age_group + ", region_cd=" + region_cd
				+ ", ppa_cnt=" + ppa_cnt + "]";
	}
	
}
