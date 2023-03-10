package kr.or.ddit.freeBoard.model;

import java.util.Date;

public class CommentVo {

	String comment_cd;
	String freeboard_cd;
	String member_id;
	String cm_content;
	Date cm_dt;
	int cm_yn;
	
	@Override
	public String toString() {
		return "CommentVo [comment_cd=" + comment_cd + ", freeboard_cd=" + freeboard_cd + ", member_id=" + member_id
				+ ", cm_content=" + cm_content + ", cm_dt=" + cm_dt + ", cm_yn=" + cm_yn + "]";
	}
	
	public CommentVo() {
	}

	public CommentVo(String comment_cd, String freeboard_cd, String member_id, String cm_content, Date cm_dt,
			int cm_yn) {
		super();
		this.comment_cd = comment_cd;
		this.freeboard_cd = freeboard_cd;
		this.member_id = member_id;
		this.cm_content = cm_content;
		this.cm_dt = cm_dt;
		this.cm_yn = cm_yn;
	}

	public String getComment_cd() {
		return comment_cd;
	}
	public void setComment_cd(String comment_cd) {
		this.comment_cd = comment_cd;
	}
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
	public String getCm_content() {
		return cm_content;
	}
	public void setCm_content(String cm_content) {
		this.cm_content = cm_content;
	}
	public Date getCm_dt() {
		return cm_dt;
	}
	public void setCm_dt(Date cm_dt) {
		this.cm_dt = cm_dt;
	}
	public int getCm_yn() {
		return cm_yn;
	}
	public void setCm_yn(int cm_yn) {
		this.cm_yn = cm_yn;
	}
}
