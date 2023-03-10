package kr.or.ddit.tobRecom.model;

//상권유형
public class BdTypeVo {
	
	private int bd_type_cd; // 상권유형코드
	private String bd_type_name; // 상권유형이름
	
	public int getBd_type_cd() {
		return bd_type_cd;
	}
	public void setBd_type_cd(int bd_type_cd) {
		this.bd_type_cd = bd_type_cd;
	}
	public String getBd_type_name() {
		return bd_type_name;
	}
	public void setBd_type_name(String bd_type_name) {
		this.bd_type_name = bd_type_name;
	}
	
	@Override
	public String toString() {
		return "BdTypeVo [bd_type_cd=" + bd_type_cd + ", bd_type_name=" + bd_type_name + "]";
	}
	
}
