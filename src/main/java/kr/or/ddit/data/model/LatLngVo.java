package kr.or.ddit.data.model;

public class LatLngVo {
	private double lng;	// 경도
	private double lat;	// 위도
	
	public LatLngVo() {

	}
	
	public LatLngVo(double lng, double lat) {
		super();
		this.lng = lng;
		this.lat = lat;
	}
	
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	@Override
	public String toString() {
		return "LatLngVo [lng=" + lng + ", lat=" + lat + "]";
	}
	
}
