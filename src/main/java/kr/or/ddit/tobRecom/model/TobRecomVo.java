package kr.or.ddit.tobRecom.model;

import java.io.Serializable;

public class TobRecomVo implements Serializable{
	
	private static final long serialVersionUID = 7509167084711949889L;
	
	private String report_cd; // 보고서코드
	private String selectAddr; // 분석지역주소
	private int stData; // 기준데이터시점
	private int grade; // 종합입지등급
	private String btype; // 상권유형
	private int foodPercent; // 상권구성(음식)
	private int servicePercent; // 상권구성(서비스)
	private int retailPercent; // 상권구성(소매)
	private int rating; // 상권유형(상권규모)
	private int popNum; // 상권유형(고객구성)
	private int spendRating; // 상권유형(소비수준)
	private String btypeInfo; // 상권유형설명
	
	public String getReport_cd() {
		return report_cd;
	}
	public void setReport_cd(String report_cd) {
		this.report_cd = report_cd;
	}
	public String getSelectAddr() {
		return selectAddr;
	}
	public void setSelectAddr(String selectAddr) {
		this.selectAddr = selectAddr;
	}
	public int getStData() {
		return stData;
	}
	public void setStData(int stData) {
		this.stData = stData;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getBtype() {
		return btype;
	}
	public void setBtype(String btype) {
		this.btype = btype;
	}
	public int getFoodPercent() {
		return foodPercent;
	}
	public void setFoodPercent(int foodPercent) {
		this.foodPercent = foodPercent;
	}
	public int getServicePercent() {
		return servicePercent;
	}
	public void setServicePercent(int servicePercent) {
		this.servicePercent = servicePercent;
	}
	public int getRetailPercent() {
		return retailPercent;
	}
	public void setRetailPercent(int retailPercent) {
		this.retailPercent = retailPercent;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getPopNum() {
		return popNum;
	}
	public void setPopNum(int popNum) {
		this.popNum = popNum;
	}
	public int getSpendRating() {
		return spendRating;
	}
	public void setSpendRating(int spendRating) {
		this.spendRating = spendRating;
	}
	public String getBtypeInfo() {
		return btypeInfo;
	}
	public void setBtypeInfo(String btypeInfo) {
		this.btypeInfo = btypeInfo;
	}
	
	public TobRecomVo() {
		
	}
	
	public TobRecomVo(String report_cd, String selectAddr, int stData, int grade, String btype, int foodPercent,
			int servicePercent, int retailPercent, int rating, int popNum, int spendRating, String btypeInfo) {
		super();
		this.report_cd = report_cd;
		this.selectAddr = selectAddr;
		this.stData = stData;
		this.grade = grade;
		this.btype = btype;
		this.foodPercent = foodPercent;
		this.servicePercent = servicePercent;
		this.retailPercent = retailPercent;
		this.rating = rating;
		this.popNum = popNum;
		this.spendRating = spendRating;
		this.btypeInfo = btypeInfo;
	}
	
	@Override
	public String toString() {
		return "TobRecomVo [report_cd=" + report_cd + ", selectAddr=" + selectAddr + ", stData=" + stData + ", grade="
				+ grade + ", btype=" + btype + ", foodPercent=" + foodPercent + ", servicePercent=" + servicePercent
				+ ", retailPercent=" + retailPercent + ", rating=" + rating + ", popNum=" + popNum + ", spendRating="
				+ spendRating + ", btypeInfo=" + btypeInfo + "]";
	}
	
}
