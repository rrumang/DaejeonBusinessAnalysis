package kr.or.ddit.data.model;

public class StoreVo {
	private long store_cd;
	private int store_dt;
	private String tob_cd;
	private long region_cd;
	private String store_name;
	private String store_addr;
	private double store_lon;
	private double store_lat;

	private String tob_name; // DB테이블에는 존재하지 않는 컬럼

	public long getStore_cd() {
		return store_cd;
	}

	public void setStore_cd(long store_cd) {
		this.store_cd = store_cd;
	}

	public int getStore_dt() {
		return store_dt;
	}

	public void setStore_dt(int store_dt) {
		this.store_dt = store_dt;
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

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

	public String getStore_addr() {
		return store_addr;
	}

	public void setStore_addr(String store_addr) {
		this.store_addr = store_addr;
	}

	public double getStore_lon() {
		return store_lon;
	}

	public void setStore_lon(double store_lon) {
		this.store_lon = store_lon;
	}

	public double getStore_lat() {
		return store_lat;
	}

	public void setStore_lat(double store_lat) {
		this.store_lat = store_lat;
	}

	public String getTob_name() {
		return tob_name;
	}

	public void setTob_name(String tob_name) {
		this.tob_name = tob_name;
	}

	@Override
	public String toString() {
		return "StoreVo [store_cd=" + store_cd + ", store_dt=" + store_dt + ", tob_cd=" + tob_cd + ", region_cd="
				+ region_cd + ", store_name=" + store_name + ", store_addr=" + store_addr + ", store_lon=" + store_lon
				+ ", store_lat=" + store_lat + ", tob_name=" + tob_name + "]";
	}
	
}
