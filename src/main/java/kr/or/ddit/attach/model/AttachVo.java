package kr.or.ddit.attach.model;

// 첨부파일VO
public class AttachVo {
	private String attach_cd;		// 첨부파일코드(P.K)
	private String notice_cd;		// 공지사항게시글코드(F.K)
	private String suggestion_cd;	// 건의사항게시글코드(F.K)
	private String attach_name;		// 원본파일명
	private String attach_path;		// 첨부파일경로
	private int attach_yn;			// 삭제여부(0:삭제, 1:삭제아님)
	
	public String getAttach_cd() {
		return attach_cd;
	}
	public void setAttach_cd(String attach_cd) {
		this.attach_cd = attach_cd;
	}
	public String getNotice_cd() {
		return notice_cd;
	}
	public void setNotice_cd(String notice_cd) {
		this.notice_cd = notice_cd;
	}
	public String getSuggestion_cd() {
		return suggestion_cd;
	}
	public void setSuggestion_cd(String suggestion_cd) {
		this.suggestion_cd = suggestion_cd;
	}
	public String getAttach_name() {
		return attach_name;
	}
	public void setAttach_name(String attach_name) {
		this.attach_name = attach_name;
	}
	public String getAttach_path() {
		return attach_path;
	}
	public void setAttach_path(String attach_path) {
		this.attach_path = attach_path;
	}
	public int getAttach_yn() {
		return attach_yn;
	}
	public void setAttach_yn(int attach_yn) {
		this.attach_yn = attach_yn;
	}
	public AttachVo(String notice_cd, String suggestion_cd, String attach_name, String attach_path) {
		super();
		this.notice_cd = notice_cd;
		this.suggestion_cd = suggestion_cd;
		this.attach_name = attach_name;
		this.attach_path = attach_path;
	}
	public AttachVo(String attach_cd, String notice_cd, String suggestion_cd, String attach_name, String attach_path,
			int attach_yn) {
		super();
		this.attach_cd = attach_cd;
		this.notice_cd = notice_cd;
		this.suggestion_cd = suggestion_cd;
		this.attach_name = attach_name;
		this.attach_path = attach_path;
		this.attach_yn = attach_yn;
	}
	public AttachVo() {
		
	}
	@Override
	public String toString() {
		return "AttachVo [attach_cd=" + attach_cd + ", notice_cd=" + notice_cd + ", suggestion_cd=" + suggestion_cd
				+ ", attach_name=" + attach_name + ", attach_path=" + attach_path + ", attach_yn=" + attach_yn + "]";
	}
}
