package kr.or.ddit.tobRecom.model;

import java.io.Serializable;

// 쿼리 결과를 저장하기 위한 Vo (직결된 테이블 없음)
public class JbVo implements Serializable{
	private static final long serialVersionUID = -61393392382147316L;
	
	// 상권유형조회 결과에 사용
	private String jbunryu; // 대분류코드
	private int total; // 합계
	
	// 업종구성비조회 결과에 사용
	private String tob_cd; // 중분류코드
	private String tob_name; // 중분류명
	private int region_sum; // 동의 중분류별 사업체 수
	
	// 상권규모조회 결과에 사용
	private long region_cd; // 지역코드
	private int rank; // 매출규모순위
	
	// 업종별 적합도 결과에 사용(report_cd, tob_cd, tob_name, rank, point)
	private String report_cd; // 보고서코드
	private float point; // 적합도 총점
	
	public String getJbunryu() {
		return jbunryu;
	}
	public void setJbunryu(String jbunryu) {
		this.jbunryu = jbunryu;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getTob_cd() {
		return tob_cd;
	}
	public void setTob_cd(String tob_cd) {
		this.tob_cd = tob_cd;
	}
	public String getTob_name() {
		return tob_name;
	}
	public void setTob_name(String tob_name) {
		this.tob_name = tob_name;
	}
	public int getRegion_sum() {
		return region_sum;
	}
	public void setRegion_sum(int region_sum) {
		this.region_sum = region_sum;
	}
	public long getRegion_cd() {
		return region_cd;
	}
	public void setRegion_cd(long region_cd) {
		this.region_cd = region_cd;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public float getPoint() {
		return point;
	}
	public void setPoint(float point) {
		this.point = point;
	}
	public String getReport_cd() {
		return report_cd;
	}
	public void setReport_cd(String report_cd) {
		this.report_cd = report_cd;
	}
	
	public JbVo() {
	}
	public JbVo(String tob_cd) {
		super();
		this.tob_cd = tob_cd;
	}
	
	public JbVo(String tob_cd, String tob_name, float point) {
		super();
		this.tob_cd = tob_cd;
		this.tob_name = tob_name;
		this.point = point;
	}
	
	@Override
	public String toString() {
		return "JbVo [jbunryu=" + jbunryu + ", total=" + total + ", tob_cd=" + tob_cd + ", tob_name=" + tob_name
				+ ", region_sum=" + region_sum + ", region_cd=" + region_cd + ", rank=" + rank + ", report_cd="
				+ report_cd + ", point=" + point + "]";
	}
	
	
}
