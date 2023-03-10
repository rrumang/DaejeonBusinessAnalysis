package kr.or.ddit.bdPrsct.model;

// 활용현황
public class UtilizeVo {
	
	private String rank; // 순위
	private String tob_name; // 업종명
	private int count; // 분석횟수
	
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public String getTob_name() {
		return tob_name;
	}
	public void setTob_name(String tob_name) {
		this.tob_name = tob_name;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
}
