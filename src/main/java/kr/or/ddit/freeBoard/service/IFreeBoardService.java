package kr.or.ddit.freeBoard.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.freeBoard.model.CommentVo;
import kr.or.ddit.freeBoard.model.FreeBoardVo;
import kr.or.ddit.paging.model.PageVo;

public interface IFreeBoardService {
	
	/**
	 * 
	* Method : fBoardList
	* 작성자 : 강민호
	* 변경이력 :
	* @return
	* Method 설명 : 자유게시판 전체 목록 가져오기
	 */
	List<FreeBoardVo> fBoardList();
	
	/**
	 * 
	* Method : insertF_board
	* 작성자 : 강민호
	* 변경이력 :
	* @return
	* Method 설명 : 새로운 게시물 추가
	 */
	int insertF_board(FreeBoardVo fVo);
	
	/**
	 * 
	* Method : getFreeBoard
	* 작성자 : 강민호
	* 변경이력 :
	* @param freeBoard_cd
	* @return
	* Method 설명 :자유게시판 목록에서 특정 게시물 가져오기
	 */
	FreeBoardVo getFreeBoard(String freeBoard_cd);
	
	/**
	 * 
	* Method : getFreedelete
	* 작성자 : 강민호
	* 변경이력 :
	* @param freeBoard_cd
	* @return
	* Method 설명 : 게시글 삭제
	 */
	int getFreedelete(String freeBoard_cd);
	
	/**
	 * 
	* Method : getFreeUpdate
	* 작성자 : 강민호
	* 변경이력 :
	* @param freeBoard_cd
	* @return
	* Method 설명  : 게시글 수정
	 */
	int getFreeUpdate(FreeBoardVo fv);
	
	/**
	 * 
	* Method : getComList
	* 작성자 : 강민호
	* 변경이력 :
	* @param freeboard_cd
	* @return
	* Method 설명 :게시판코드에 대한 댓글리스트 불러오기
	 */
	List<CommentVo> getComList(String freeboard_cd);
	
	/**
	 * 
	* Method : getInsertCommnet
	* 작성자 : 강민호
	* 변경이력 :
	* @param cv
	* @return
	* Method 설명 :댓글작성
	 */
	int getInsertCommnet(CommentVo cv);
	
	/**
	 * 
	* Method : getMainFreeboard
	* 작성자 : 강민호
	* 변경이력 :
	* @return
	* Method 설명 :메인화면에 5개 자유게시판 꺼내기
	 */
	List<FreeBoardVo> getMainFreeboard();
	
	/**
	 * 
	* Method : getDeleteComment
	* 작성자 : 강민호
	* 변경이력 :
	* @param comment_cd
	* @return
	* Method 설명 : 해당댓글의 상태를 삭제상태로 변경
	 */
	int getDeleteComment(String comment_cd);
	
	/**
	 * 
	* Method : getSearchFreeBoard
	* 작성자 : 강민호
	* 변경이력 :
	* @return
	* Method 설명 : 키워드가 포함된 게시글 불러오기
	 */
	List<FreeBoardVo> getSearchFreeBoard(String keyword);
	
	/**
	 * 
	* Method : getAllFreeboard
	* 작성자 : 강민호
	* 변경이력 :
	* @param pageVo
	* @return
	* Method 설명 : 페이징처리된 자유게시판 리스트 가져오기
	 */
	Map<String, Object> getAllFreeboard(PageVo pageVo);
	
	/**
	 * Method : searchTitle
	 * 작성자 : 강민호
	 * 변경이력 :
	 * @return Map<String,Object>
	 * Method 설명 : 공지사항 게시글 제목으로 검색, 페이지 조회
	 */
	Map<String, Object> searchTitle(Map<String, Object> map);
	
}
