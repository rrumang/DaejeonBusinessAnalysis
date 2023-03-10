package kr.or.ddit.faq.model;

public class FaqVo {
	String faq_cd;      //FAQ게시글 코드
	String faq_title;   //제목
	String faq_content; //내용
	int faq_yn;         //삭제여부
	
	public String getFaq_cd() {
		return faq_cd;
	}
	public void setFaq_cd(String faq_cd) {
		this.faq_cd = faq_cd;
	}
	public String getFaq_title() {
		return faq_title;
	}
	public void setFaq_title(String faq_title) {
		this.faq_title = faq_title;
	}
	public String getFaq_content() {
		return faq_content;
	}
	public void setFaq_content(String faq_content) {
		this.faq_content = faq_content;
	}
	public int getFaq_yn() {
		return faq_yn;
	}
	public void setFaq_yn(int faq_yn) {
		this.faq_yn = faq_yn;
	}
	
	public FaqVo() {
		
	}
	
	public FaqVo(String faq_cd, String faq_title, String faq_content, int faq_yn) {
		this.faq_cd = faq_cd;
		this.faq_title = faq_title;
		this.faq_content = faq_content;
		this.faq_yn = faq_yn;
	}
	
	@Override
	public String toString() {
		return "FaqVo [faq_cd=" + faq_cd + ", faq_title=" + faq_title + ", faq_content=" + faq_content + ", faq_yn="
				+ faq_yn + "]";
	}
	
}
