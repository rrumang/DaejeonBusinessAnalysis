package kr.or.ddit.data.model;

//직장인구
public class WpVo {
	
	private int wp_dt;      // 데이터기준연도
	private int wp_gender;  // 성별
	private long region_cd; // 지역코드
	private int wp_cnt;     // 직장인구수
	
	private float wp_ratio; 	// wp_cnt가 백분율로 환산되어 들어올 컬럼
								// Wp테이블에는 없는 컬럼
	
	public int getWp_dt() {
		return wp_dt;
	}
	public void setWp_dt(int wp_dt) {
		this.wp_dt = wp_dt;
	}
	public int getWp_gender() {
		return wp_gender;
	}
	public void setWp_gender(int wp_gender) {
		this.wp_gender = wp_gender;
	}
	public long getRegion_cd() {
		return region_cd;
	}
	public void setRegion_cd(long region_cd) {
		this.region_cd = region_cd;
	}
	public int getWp_cnt() {
		return wp_cnt;
	}
	public void setWp_cnt(int wp_cnt) {
		this.wp_cnt = wp_cnt;
	}
	public float getWp_ratio() {
		return wp_ratio;
	}
	public void setWp_ratio(float wp_ratio) {
		this.wp_ratio = wp_ratio;
	}

	public WpVo() {
		
	}
	
	public WpVo(int wp_dt, int wp_gender, long region_cd, int wp_cnt) {
		this.wp_dt = wp_dt;
		this.wp_gender = wp_gender;
		this.region_cd = region_cd;
		this.wp_cnt = wp_cnt;
	}
	
	@Override
	public String toString() {
		return "WpVo [wp_dt=" + wp_dt + ", wp_gender=" + wp_gender + ", region_cd=" + region_cd + ", wp_cnt=" + wp_cnt
				+ "]";
	}
	

}
