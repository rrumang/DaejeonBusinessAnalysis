package kr.or.ddit.notice.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.notice.model.NoticeVo;
import kr.or.ddit.paging.model.PageVo;

public interface INoticeService {
	/**
	 * Method : getAllNotice
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return Map<String,Object>
	 * Method 설명 : 삭제되지 않은 전체 공지사항 게시글 페이지 조회
	 */
	Map<String, Object> getAllNotice(PageVo pageVo);
	
	/**
	 * Method : getNotice
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return NoticeVo
	 * Method 설명 : 특정 공지사항 게시글 조회
	 */
	NoticeVo getNotice(String notice_cd);
	
	/**
	 * Method : insertNotice
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 공지사항 게시글 등록 후 등록한 게시글코드를 반환
	 */
	String insertNotice(NoticeVo noticeVo);
	
	/**
	 * Method : updateNotice
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return int
	 * Method 설명 : 공지사항 게시글 수정 
	 */
	int updateNotice(NoticeVo noticeVo);
	
	/**
	 * Method : updateStatus
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return int
	 * Method 설명 : 공지사항 게시글 삭제(삭제여부 수정)
	 */
	int updateStatus(String notice_cd);
	
	/**
	 * Method : searchTitle
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return Map<String,Object>
	 * Method 설명 : 공지사항 게시글 제목으로 검색, 페이지 조회
	 */
	Map<String, Object> searchTitle(Map<String, Object> map);
	
	/**
	 * Method : getNoticeMain
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return List<NoticeVo>
	 * Method 설명 : 최근 작성된 공지사항 게시글 5개 조회(메인용)
	 */
	List<NoticeVo> getNoticeMain();
}
