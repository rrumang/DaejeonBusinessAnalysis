package kr.or.ddit.select.model;

//지역
public class RegionVo {
	private long region_cd; // 지역코드
	private int region_cd2; // 상위지역코드
	private int region_cl; // 지역구분
	private String region_name; // 지역명
	private double region_extent; // 면적
	private String region_csc; // 주민센터주소
	
	private String rn2; // 지역명(동단위) db에 없음. 출력 처리용
	
	public String getRn2() {
		return rn2;
	}

	public void setRn2(String rn2) {
		this.rn2 = rn2;
	}

	public RegionVo() {
		super();
	}
	
	public RegionVo(long region_cd, int region_cl, String region_name, double region_extent, String region_csc,
			int region_cd2, String rn2) {
		super();
		this.region_cd = region_cd;
		this.region_cl = region_cl;
		this.region_name = region_name;
		this.region_extent = region_extent;
		this.region_csc = region_csc;
		this.region_cd2 = region_cd2;
		this.rn2 = rn2;
	}

	public long getRegion_cd() {
		return region_cd;
	}

	public void setRegion_cd(long region_cd) {
		this.region_cd = region_cd;
	}

	public int getRegion_cl() {
		return region_cl;
	}

	public void setRegion_cl(int region_cl) {
		this.region_cl = region_cl;
	}

	public String getRegion_name() {
		return region_name;
	}

	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}

	public double getRegion_extent() {
		return region_extent;
	}

	public void setRegion_extent(double region_extent) {
		this.region_extent = region_extent;
	}

	public String getRegion_csc() {
		return region_csc;
	}

	public void setRegion_csc(String region_csc) {
		this.region_csc = region_csc;
	}

	public int getRegion_cd2() {
		return region_cd2;
	}

	public void setRegion_cd2(int region_cd2) {
		this.region_cd2 = region_cd2;
	}

	@Override
	public String toString() {
		return "RegionVo [region_cd=" + region_cd + ", region_cl=" + region_cl + ", region_name=" + region_name
				+ ", region_extent=" + region_extent + ", region_csc=" + region_csc + ", region_cd2=" + region_cd2
				+ ", rn2=" + rn2 + "]";
	}

}
