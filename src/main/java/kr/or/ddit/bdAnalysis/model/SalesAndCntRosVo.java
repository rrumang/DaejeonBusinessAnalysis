package kr.or.ddit.bdAnalysis.model;

public class SalesAndCntRosVo {
	private int sales_dt;
	private int curSale;
	private int prevSale;
	private float saleRos;
	private int curCnt;
	private int prevCnt;
	private float cntRos;
	
	public int getSales_dt() {
		return sales_dt;
	}
	public void setSales_dt(int sales_dt) {
		this.sales_dt = sales_dt;
	}
	public int getCurSale() {
		return curSale;
	}
	public void setCurSale(int curSale) {
		this.curSale = curSale;
	}
	public int getPrevSale() {
		return prevSale;
	}
	public void setPrevSale(int prevSale) {
		this.prevSale = prevSale;
	}
	public float getSaleRos() {
		return saleRos;
	}
	public void setSaleRos(float saleRos) {
		this.saleRos = saleRos;
	}
	public int getCurCnt() {
		return curCnt;
	}
	public void setCurCnt(int curCnt) {
		this.curCnt = curCnt;
	}
	public int getPrevCnt() {
		return prevCnt;
	}
	public void setPrevCnt(int prevCnt) {
		this.prevCnt = prevCnt;
	}
	public float getCntRos() {
		return cntRos;
	}
	public void setCntRos(float cntRos) {
		this.cntRos = cntRos;
	}
	@Override
	public String toString() {
		return "SalesAndCntRosVo [sales_dt=" + sales_dt + ", curSale=" + curSale + ", prevSale=" + prevSale
				+ ", saleRos=" + saleRos + ", curCnt=" + curCnt + ", prevCnt=" + prevCnt + ", cntRos=" + cntRos + "]";
	}
	
}
