package kr.or.ddit.support.model;

import java.util.List;

public class ItemVo {
	
	String areaNo; 			 // 지역번호
	String areaNm; 			 // 지역이름
	int itemCnt;   			 // 아이템수
	List<ItemsVo> itemsList; // 아이템 목록
	
	public String getAreaNo() {
		return areaNo;
	}
	public void setAreaNo(String areaNo) {
		this.areaNo = areaNo;
	}
	public String getAreaNm() {
		return areaNm;
	}
	public void setAreaNm(String areaNm) {
		this.areaNm = areaNm;
	}
	public int getItemCnt() {
		return itemCnt;
	}
	public void setItemCnt(int itemCnt) {
		this.itemCnt = itemCnt;
	}
	public List<ItemsVo> getItemsList() {
		return itemsList;
	}
	public void setItemsList(List<ItemsVo> itemsList) {
		this.itemsList = itemsList;
	}
	
	public ItemVo() {
		
	}
	
	public ItemVo(String areaNo, String areaNm, int itemCnt, List<ItemsVo> itemsList) {
		this.areaNo = areaNo;
		this.areaNm = areaNm;
		this.itemCnt = itemCnt;
		this.itemsList = itemsList;
	}
	
	@Override
	public String toString() {
		return "ItemVo [areaNo=" + areaNo + ", areaNm=" + areaNm + ", itemCnt=" + itemCnt + ", itemsList=" + itemsList
				+ "]";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
