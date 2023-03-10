package kr.or.ddit.bdPrsct.model;

// 쿼리 결과를 저장하기 위한 Vo (연결 테이블 없음)
public class PrintVo {
	
	private String gu; // 구이름
	private int gucd; // 구 코드
	private int bd_dt; // 데이터기준연월
	private String dong; // 동이름
	private int sum1; // 사업체수 합계
	private int sum2; // 사업체수 합계
	private float iad; // 증감률
	
	public String getGu() {
		return gu;
	}
	public void setGu(String gu) {
		this.gu = gu;
	}
	public int getGucd() {
		return gucd;
	}
	public void setGucd(int gucd) {
		this.gucd = gucd;
	}
	public int getBd_dt() {
		return bd_dt;
	}
	public void setBd_dt(int bd_dt) {
		this.bd_dt = bd_dt;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public int getSum1() {
		return sum1;
	}
	public void setSum1(int sum1) {
		this.sum1 = sum1;
	}
	public int getSum2() {
		return sum2;
	}
	public void setSum2(int sum2) {
		this.sum2 = sum2;
	}
	public float getIad() {
		return iad;
	}
	public void setIad(float iad) {
		this.iad = iad;
	}
	
	public PrintVo() {
	}
	public PrintVo(String gu, int gucd, int bd_dt, String dong, int sum1, int sum2, float iad) {
		super();
		this.gu = gu;
		this.gucd = gucd;
		this.bd_dt = bd_dt;
		this.dong = dong;
		this.sum1 = sum1;
		this.sum2 = sum2;
		this.iad = iad;
	}
	@Override
	public String toString() {
		return "PrintVo [gu=" + gu + ", gucd=" + gucd + ", bd_dt=" + bd_dt + ", dong=" + dong + ", sum1=" + sum1
				+ ", sum2=" + sum2 + ", iad=" + iad + "]";
	}
	
	
}
