package kr.or.ddit.notice.model;

import java.util.Date;

// 공지사항VO
public class NoticeVo {
	private String notice_cd;		// 공지사항게시글코드(P.K)
	private String notice_title;	// 제목
	private String notice_content;	// 내용
	private Date notice_dt;			// 작성일자
	private int notice_yn;			// 삭제여부(0:삭제, 1:삭제아님)
	
	public String getNotice_cd() {
		return notice_cd;
	}
	public void setNotice_cd(String notice_cd) {
		this.notice_cd = notice_cd;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public Date getNotice_dt() {
		return notice_dt;
	}
	public void setNotice_dt(Date notice_dt) {
		this.notice_dt = notice_dt;
	}
	public int getNotice_yn() {
		return notice_yn;
	}
	public void setNotice_yn(int notice_yn) {
		this.notice_yn = notice_yn;
	}
	public NoticeVo(String notice_cd, String notice_title, String notice_content, Date notice_dt, int notice_yn) {
		super();
		this.notice_cd = notice_cd;
		this.notice_title = notice_title;
		this.notice_content = notice_content;
		this.notice_dt = notice_dt;
		this.notice_yn = notice_yn;
	}
	public NoticeVo() {
		
	}
	@Override
	public String toString() {
		return "NoticeVo [notice_cd=" + notice_cd + ", notice_title=" + notice_title + ", notice_content="
				+ notice_content + ", notice_dt=" + notice_dt + ", notice_yn=" + notice_yn + "]";
	}
}
