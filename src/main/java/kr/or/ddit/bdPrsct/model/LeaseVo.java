package kr.or.ddit.bdPrsct.model;

// 임대시세현황
public class LeaseVo {
	
	private String leasearea; // 임대상권
	private String btype; // 건물유형
	private int dt; // 데이터기준
	private int floor; // 층구분
	private float rent; // 임대료
	
	public String getLeasearea() {
		return leasearea;
	}
	public void setLeasearea(String leasearea) {
		this.leasearea = leasearea;
	}
	public String getBtype() {
		return btype;
	}
	public void setBtype(String btype) {
		this.btype = btype;
	}
	public int getDt() {
		return dt;
	}
	public void setDt(int dt) {
		this.dt = dt;
	}
	public int getFloor() {
		return floor;
	}
	public void setFloor(int floor) {
		this.floor = floor;
	}
	public float getRent() {
		return rent;
	}
	public void setRent(float rent) {
		this.rent = rent;
	}
	public LeaseVo(String leasearea, String btype, int dt, int floor, float rent) {
		this.leasearea = leasearea;
		this.btype = btype;
		this.dt = dt;
		this.floor = floor;
		this.rent = rent;
	}
	
	public LeaseVo() {
	}
	@Override
	public String toString() {
		return "LeaseVo [leasearea=" + leasearea + ", btype=" + btype + ", dt=" + dt + ", floor=" + floor + ", rent="
				+ rent + "]";
	}
	
}
