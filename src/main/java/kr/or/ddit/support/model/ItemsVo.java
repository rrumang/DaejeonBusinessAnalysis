package kr.or.ddit.support.model;

public class ItemsVo {
	String year;  // 연도
	String url;   // url주소
	String title; // 제목
	
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public ItemsVo() {
		
	}
	
	public ItemsVo(String year, String url, String title) {
		this.year = year;
		this.url = url;
		this.title = title;
	}
	
	@Override
	public String toString() {
		return "ItemsVo [year=" + year + ", url=" + url + ", title=" + title + "]";
	}
}
