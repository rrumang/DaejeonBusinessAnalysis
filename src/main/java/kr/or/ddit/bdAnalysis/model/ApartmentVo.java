package kr.or.ddit.bdAnalysis.model;

public class ApartmentVo {
	private int apartment_cd;
	private long region_cd;
	private String apartment_name;
	private String apartment_addr;
	private int apartment_cnt;

	
	public int getApartment_cd() {
		return apartment_cd;
	}
	public void setApartment_cd(int apartment_cd) {
		this.apartment_cd = apartment_cd;
	}
	public long getRegion_cd() {
		return region_cd;
	}
	public void setRegion_cd(long region_cd) {
		this.region_cd = region_cd;
	}
	public String getApartment_name() {
		return apartment_name;
	}
	public void setApartment_name(String apartment_name) {
		this.apartment_name = apartment_name;
	}
	public String getApartment_addr() {
		return apartment_addr;
	}
	public void setApartment_addr(String apartment_addr) {
		this.apartment_addr = apartment_addr;
	}
	public int getApartment_cnt() {
		return apartment_cnt;
	}
	public void setApartment_cnt(int apartment_cnt) {
		this.apartment_cnt = apartment_cnt;
	}

	@Override
	public String toString() {
		return "ApartmentVo [apartment_cd=" + apartment_cd + ", region_cd=" + region_cd + ", apartment_name="
				+ apartment_name + ", apartment_addr=" + apartment_addr + ", apartment_cnt=" + apartment_cnt + "]";
	}
	
}
