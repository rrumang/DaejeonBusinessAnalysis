package kr.or.ddit.marginAnalysis.model;

// 창업기업 자금투입현황
public class FundVo {
	private int fund_dt;	// 데이터기준연도 (P.K)
	private String sic_cd;  // 표준산업분류코드 (F.K)
	private int fund_fe;	// 설비자산 취득비용
	private int fund_pe;	// 인건비
	private int fund_me;	// 재료비
	private int fund_etc;	// 기타경비
	
	public int getFund_dt() {
		return fund_dt;
	}
	public void setFund_dt(int fund_dt) {
		this.fund_dt = fund_dt;
	}
	public String getSic_cd() {
		return sic_cd;
	}
	public void setSic_cd(String sic_cd) {
		this.sic_cd = sic_cd;
	}
	public int getFund_fe() {
		return fund_fe;
	}
	public void setFund_fe(int fund_fe) {
		this.fund_fe = fund_fe;
	}
	public int getFund_pe() {
		return fund_pe;
	}
	public void setFund_pe(int fund_pe) {
		this.fund_pe = fund_pe;
	}
	public int getFund_me() {
		return fund_me;
	}
	public void setFund_me(int fund_me) {
		this.fund_me = fund_me;
	}
	public int getFund_etc() {
		return fund_etc;
	}
	public void setFund_etc(int fund_etc) {
		this.fund_etc = fund_etc;
	}
	public FundVo(int fund_dt, String sic_cd, int fund_fe, int fund_pe, int fund_me, int fund_etc) {
		super();
		this.fund_dt = fund_dt;
		this.sic_cd = sic_cd;
		this.fund_fe = fund_fe;
		this.fund_pe = fund_pe;
		this.fund_me = fund_me;
		this.fund_etc = fund_etc;
	}
	public FundVo() {
		
	}
	@Override
	public String toString() {
		return "fundVo [fund_dt=" + fund_dt + ", sic_cd=" + sic_cd + ", fund_fe=" + fund_fe + ", fund_pe=" + fund_pe
				+ ", fund_me=" + fund_me + ", fund_etc=" + fund_etc + "]";
	}
}
