package kr.or.ddit.data.model;

//주거인구
public class LpVo {
	
	private int lp_dt; // 데이터기준연월
	private int lp_gender; // 성별
	private int lp_age_group; // 연령대
	private long region_cd; // 지역코드
	private int lp_cnt; // 주거인구수
	
	private float lp_ratio; // lp_cnt를 백분률로 환산된 데이터가 들어올 컬럼
							// LP테이블에는 없는 컬럼
	
	public int getLp_dt() {
		return lp_dt;
	}
	public void setLp_dt(int lp_dt) {
		this.lp_dt = lp_dt;
	}
	public int getLp_gender() {
		return lp_gender;
	}
	public void setLp_gender(int lp_gender) {
		this.lp_gender = lp_gender;
	}
	public int getLp_age_group() {
		return lp_age_group;
	}
	public void setLp_age_group(int lp_age_group) {
		this.lp_age_group = lp_age_group;
	}
	public long getRegion_cd() {
		return region_cd;
	}
	public void setRegion_cd(long region_cd) {
		this.region_cd = region_cd;
	}
	public int getLp_cnt() {
		return lp_cnt;
	}
	public void setLp_cnt(int lp_cnt) {
		this.lp_cnt = lp_cnt;
	}

	public float getLp_ratio() {
		return lp_ratio;
	}
	public void setLp_ratio(float lp_ratio) {
		this.lp_ratio = lp_ratio;
	}
	
	public LpVo() {
	}
	
	public LpVo(int lp_dt, int lp_gender, int lp_age_group, long region_cd, int lp_cnt) {
		this.lp_dt = lp_dt;
		this.lp_gender = lp_gender;
		this.lp_age_group = lp_age_group;
		this.region_cd = region_cd;
		this.lp_cnt = lp_cnt;
	}
	
	@Override
	public String toString() {
		return "LpVo [lp_dt=" + lp_dt + ", lp_gender=" + lp_gender + ", lp_age_group=" + lp_age_group + ", region_cd="
				+ region_cd + ", lp_cnt=" + lp_cnt + "]";
	}
	
}
