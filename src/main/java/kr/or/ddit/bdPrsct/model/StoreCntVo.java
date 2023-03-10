package kr.or.ddit.bdPrsct.model;

public class StoreCntVo {
	private String top_name;
	private String mid_name;
	private String bot_name;
	private int cnt;

	public String getTop_name() {
		return top_name;
	}
	public void setTop_name(String top_name) {
		this.top_name = top_name;
	}
	public String getMid_name() {
		return mid_name;
	}
	public void setMid_name(String mid_name) {
		this.mid_name = mid_name;
	}
	public String getBot_name() {
		return bot_name;
	}
	public void setBot_name(String bot_name) {
		this.bot_name = bot_name;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	@Override
	public String toString() {
		return "StoreCntVo [top_name=" + top_name + ", mid_name=" + mid_name + ", bot_name=" + bot_name + ", cnt=" + cnt
				+ "]";
	}
	
}
