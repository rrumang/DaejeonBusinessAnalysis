package kr.or.ddit.tobRecom.model;

//업종적합도
public class GofVo {
	
	private int gof_rank; // 순위
	private String tob_cd; // 업종분류코드
	private int bd_type_cd; // 상권유형코드
	private int gof_gender; // 성별
	private int gof_age_group; // 연령대
	
	public int getGof_rank() {
		return gof_rank;
	}
	public void setGof_rank(int gof_rank) {
		this.gof_rank = gof_rank;
	}
	public String getTob_cd() {
		return tob_cd;
	}
	public void setTob_cd(String tob_cd) {
		this.tob_cd = tob_cd;
	}
	public int getBd_type_cd() {
		return bd_type_cd;
	}
	public void setBd_type_cd(int bd_type_cd) {
		this.bd_type_cd = bd_type_cd;
	}
	public int getGof_gender() {
		return gof_gender;
	}
	public void setGof_gender(int gof_gender) {
		this.gof_gender = gof_gender;
	}
	public int getGof_age_group() {
		return gof_age_group;
	}
	public void setGof_age_group(int gof_age_group) {
		this.gof_age_group = gof_age_group;
	}
	
	public GofVo() {
	}
	
	public GofVo(int gof_rank, String tob_cd, int bd_type_cd, int gof_gender, int gof_age_group) {
		this.gof_rank = gof_rank;
		this.tob_cd = tob_cd;
		this.bd_type_cd = bd_type_cd;
		this.gof_gender = gof_gender;
		this.gof_age_group = gof_age_group;
	}
	
	@Override
	public String toString() {
		return "GofVo [gof_rank=" + gof_rank + ", tob_cd=" + tob_cd + ", bd_type_cd=" + bd_type_cd + ", gof_gender="
				+ gof_gender + ", gof_age_group=" + gof_age_group + "]";
	}
	
}
