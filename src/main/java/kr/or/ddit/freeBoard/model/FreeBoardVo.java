package kr.or.ddit.freeBoard.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class FreeBoardVo {
	
	private String freeboard_cd;
	
	private String member_id;
	
	private String fb_title;
	
	private String fb_content;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date fb_dt;
	
	private int fb_yn;
	
	public String getFreeboard_cd() {
		return freeboard_cd;
	}
	public void setFreeboard_cd(String freeboard_cd) {
		this.freeboard_cd = freeboard_cd;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	public FreeBoardVo(String freeboard_cd, String fb_title, String fb_content) {
		super();
		this.freeboard_cd = freeboard_cd;
		this.fb_title = fb_title;
		this.fb_content = fb_content;
	}
	
	public String getFb_title() {
		return fb_title;
	}
	public void setFb_title(String fb_title) {
		this.fb_title = fb_title;
	}
	public String getFb_content() {
		return fb_content;
	}
	public void setFb_content(String fb_content) {
		this.fb_content = fb_content;
	}
	public Date getFb_dt() {
		return fb_dt;
	}
	public void setFb_dt(Date fb_dt) {
		this.fb_dt = fb_dt;
	}
	public int getFb_yn() {
		return fb_yn;
	}
	public void setFb_yn(int fb_yn) {
		this.fb_yn = fb_yn;
	}
	@Override
	public String toString() {
		return "FreeBoardVo [freeboard_cd=" + freeboard_cd + ", member_id=" + member_id + ", fb_title=" + fb_title
				+ ", fb_content=" + fb_content + ", fb_dt=" + fb_dt + ", fb_yn=" + fb_yn + "]";
	}
	
	public FreeBoardVo() {
	}
	
	public FreeBoardVo(String freeboard_cd, String member_id, String fb_title, String fb_content, Date fb_dt,
			int fb_yn) {
		super();
		this.freeboard_cd = freeboard_cd;
		this.member_id = member_id;
		this.fb_title = fb_title;
		this.fb_content = fb_content;
		this.fb_dt = fb_dt;
		this.fb_yn = fb_yn;
	}
	
	
	
	
}
