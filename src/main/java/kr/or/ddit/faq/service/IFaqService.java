package kr.or.ddit.faq.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.faq.model.FaqVo;
import kr.or.ddit.paging.model.PageVo;

public interface IFaqService {
	
	/**
	 * 
	* Method : faqList
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 게시판 목록 조회
	 */
	public List<FaqVo> faqList();
	
	/**
	 * 
	* Method : getFaq
	* 작성자 : 유민하
	* 변경이력 :
	* @param faq_cd
	* @return
	* Method 설명 : 특정 게시글 조회
	 */
	public FaqVo getFaq(String faq_cd);
	
	/**
	 * 
	* Method : insertFaq
	* 작성자 : 유민하
	* 변경이력 :
	* @param faqVo
	* @return
	* Method 설명 : 게시글 등록
	 */
	public int insertFaq(FaqVo faqVo);
	
	/**
	 * 
	* Method : updateFaq
	* 작성자 : 유민하
	* 변경이력 :
	* @param faqVo
	* @return
	* Method 설명 : 게시글 수정
	 */
	public int updateFaq(FaqVo faqVo);
	
	/**
	 * 
	* Method : deleteFaq
	* 작성자 : 유민하
	* 변경이력 :
	* @param faq_cd
	* @return
	* Method 설명 : 게시글 삭제
	 */
	public int deleteFaq(String faq_cd);
	
	/**
	 * 
	* Method : getFaq_cd
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 :faq_cd를 가져오는 메서드
	 */
	public String getFaq_cd();

	/**
	 * 
	* Method : faqPagingList
	* 작성자 : 유민하
	* 변경이력 :
	* @param pageVo
	* @return
	* Method 설명 : faq 페이징 처리
	 */
	public Map<String, Object> faqPagingList(PageVo pageVo);
	
	/**
	 * 
	* Method : getFaqMain
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 최근 작성된 FAQ게시글 5개 조회(메인용)
	 */
	public List<FaqVo> getFaqMain();

	/**
	 * 
	* Method : searchTitle
	* 작성자 : 유민하
	* 변경이력 :
	* @param map
	* @return
	* Method 설명 : 자주묻는 질문 게시글 제목으로 검색, 페이지 조회
	 */
	public Map<String, Object> searchTitle(Map<String, Object> map);
}
