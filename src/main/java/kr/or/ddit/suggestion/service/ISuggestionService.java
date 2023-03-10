package kr.or.ddit.suggestion.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.suggestion.model.SuggestionVo;

public interface ISuggestionService {
	
	/**
	 * 
	* Method : suggetionList
	* 작성자 : 강민호
	* 변경이력 :
	* @return
	* Method 설명 : 건의사항 전체 목록 가져오기
	 */
	List<SuggestionVo> suggetionList();
	
	/**
	 * 
	* Method : getMainSuggestionList
	* 작성자 : 강민호
	* 변경이력 :
	* @return
	* Method 설명 : 메인화면에 건의사항 리스트 5개 띄우기
	 */
	List<SuggestionVo> getMainSuggestionList();
	
	/**
	 * 
	* Method : insertSuggesion
	* 작성자 : 강민호
	* 변경이력 :
	* @return
	* Method 설명 :
	 */
	int insertSuggesion(SuggestionVo sv);
	
	/**
	 * 
	* Method : getSuggestion
	* 작성자 : 강민호
	* 변경이력 :
	* @param suggestion_cd
	* @return
	* Method 설명 :건의사항 아이디로 게시글 불러오기
	 */
	SuggestionVo getSuggestion(String suggestion_cd);
	
	/**
	 * 
	* Method : getSuggestionUpdate
	* 작성자 : 강민호
	* 변경이력 :
	* @param sv
	* @return
	* Method 설명 :
	 */
	int getSuggestionUpdate(SuggestionVo sv);
	
	/**
	 * 
	* Method : getSuggestionDelete
	* 작성자 : 강민호
	* 변경이력 :
	* @param suggestion_cd
	* @return
	* Method 설명  : 건의사항 삭제
	 */
	int getSuggestionDelete(String suggestion_cd);
	
	/**
	 * 
	* Method : insertReply
	* 작성자 : 강민호
	* 변경이력 :
	* @param sv
	* @return
	* Method 설명 : 답글작성
	 */
	int insertReply(SuggestionVo sv);
	
	/**
	 * 
	* Method : getReply
	* 작성자 : 강민호
	* 변경이력 :
	* @param suggestion_cd2
	* @return
	* Method 설명 :suggestion_cd2와 suggestion_cd 가 일치하는 게시물(답글)가져오기
	 */
	int getReply(String suggestion_cd2);
	
	/**
	 * 
	* Method : getSearchFreeBoard
	* 작성자 : 강민호
	* 변경이력 :
	* @return
	* Method 설명 : 키워드가 포함된 게시글 불러오기
	 */
	List<SuggestionVo> getSearchSuggestionBoard(String keyword);
	
	/**
	 * 
	* Method : getLastSg
	* 작성자 : 강민호
	* 변경이력 :
	* @return
	* Method 설명 :
	 */
	SuggestionVo getLastSg();
	
	/**
	 * 
	* Method : getAllSuggestion
	* 작성자 : 강민호
	* 변경이력 :
	* @param pageVo
	* @return
	* Method 설명 :페이징 처리된 모든 건의사항 리스트 
	* 	 */
	Map<String, Object> getAllSuggestion(PageVo pageVo);
	
	/**
	 * 
	* Method : getKeywordSuggestion
	* 작성자 : 강민호
	* 변경이력 :
	* @param map
	* @return
	* Method 설명 : 검색어가 포함된 모든 건의사항 리스트
	 */
	Map<String , Object> getKeywordSuggestion(Map<String, Object> map);
	
	
	
	

}
