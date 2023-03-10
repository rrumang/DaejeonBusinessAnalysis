package kr.or.ddit.suggestion.model;

import java.util.Date;

public class SuggestionVo {
	
	private String suggestion_cd;
	private String member_id;
	private String sg_group;
	private String suggestion_cd2;
	private String sg_title;
	private String sg_content;
	private Date sg_dt;
	private int sg_secret_yn;
	private int sg_yn;
	
	
	public SuggestionVo(String suggestion_cd, String sg_title, String sg_content, int sg_secret_yn) {
		super();
		this.suggestion_cd = suggestion_cd;
		this.sg_title = sg_title;
		this.sg_content = sg_content;
		this.sg_secret_yn = sg_secret_yn;
	}
	public String getSuggestion_cd() {
		return suggestion_cd;
	}
	public void setSuggestion_cd(String suggestion_cd) {
		this.suggestion_cd = suggestion_cd;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getSg_group() {
		return sg_group;
	}
	public void setSg_group(String sg_group) {
		this.sg_group = sg_group;
	}
	public String getSuggestion_cd2() {
		return suggestion_cd2;
	}
	public void setSuggestion_cd2(String suggestion_cd2) {
		this.suggestion_cd2 = suggestion_cd2;
	}
	public String getSg_title() {
		return sg_title;
	}
	public void setSg_title(String sg_title) {
		this.sg_title = sg_title;
	}
	public String getSg_content() {
		return sg_content;
	}
	public void setSg_content(String sg_content) {
		this.sg_content = sg_content;
	}
	public Date getSg_dt() {
		return sg_dt;
	}
	public void setSg_dt(Date sg_dt) {
		this.sg_dt = sg_dt;
	}
	public int getSg_secret_yn() {
		return sg_secret_yn;
	}
	public void setSg_secret_yn(int sg_secret_yn) {
		this.sg_secret_yn = sg_secret_yn;
	}
	public int getSg_yn() {
		return sg_yn;
	}
	public void setSg_yn(int sg_yn) {
		this.sg_yn = sg_yn;
	}
	
	@Override
	public String toString() {
		return "SuggestionVo [suggestion_cd=" + suggestion_cd + ", member_id=" + member_id + ", sg_group=" + sg_group
				+ ", suggestion_cd2=" + suggestion_cd2 + ", sg_title=" + sg_title + ", sg_content=" + sg_content
				+ ", sg_dt=" + sg_dt + ", sg_secret_yn=" + sg_secret_yn + ", sg_yn=" + sg_yn + "]";
	}
	
	public SuggestionVo(String suggestion_cd, String member_id, String sg_group, String suggestion_cd2, String sg_title,
			String sg_content, Date sg_dt, int sg_secret_yn, int sg_yn) {
		super();
		this.suggestion_cd = suggestion_cd;
		this.member_id = member_id;
		this.sg_group = sg_group;
		this.suggestion_cd2 = suggestion_cd2;
		this.sg_title = sg_title;
		this.sg_content = sg_content;
		this.sg_dt = sg_dt;
		this.sg_secret_yn = sg_secret_yn;
		this.sg_yn = sg_yn;
	}
	
	public SuggestionVo() {
		
	}
	

}
