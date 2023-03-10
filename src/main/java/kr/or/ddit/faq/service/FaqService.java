package kr.or.ddit.faq.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.faq.dao.IFaqDao;
import kr.or.ddit.faq.model.FaqVo;
import kr.or.ddit.notice.model.NoticeVo;
import kr.or.ddit.paging.model.PageVo;

@Service
public class FaqService implements IFaqService {
	
	@Resource(name="faqDao")
	private IFaqDao faqDao;
	
	/**
	 * 
	* Method : faqList
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 게시판 목록 조회
	 */
	@Override
	public List<FaqVo> faqList() {
		return faqDao.faqList();
	}

	/**
	 * 
	* Method : getFaq
	* 작성자 : 유민하
	* 변경이력 :
	* @param faq_cd
	* @return
	* Method 설명 : 특정 게시글 조회
	 */
	@Override
	public FaqVo getFaq(String faq_cd) {
		return faqDao.getFaq(faq_cd);
	}

	/**
	 * 
	* Method : insertFaq
	* 작성자 : 유민하
	* 변경이력 :
	* @param faqVo
	* @return
	* Method 설명 : 게시글 등록
	 */
	@Override
	public int insertFaq(FaqVo faqVo) {
		return faqDao.insertFaq(faqVo);
	}

	/**
	 * 
	* Method : updateFaq
	* 작성자 : 유민하
	* 변경이력 :
	* @param faqVo
	* @return
	* Method 설명 : 게시글 수정
	 */
	@Override
	public int updateFaq(FaqVo faqVo) {
		return faqDao.updateFaq(faqVo);
	}

	/**
	 * 
	* Method : deleteFaq
	* 작성자 : 유민하
	* 변경이력 :
	* @param faq_cd
	* @return
	* Method 설명 : 게시글 삭제
	 */
	@Override
	public int deleteFaq(String faq_cd) {
		return faqDao.deleteFaq(faq_cd);
	}

	/**
	 * 
	* Method : getFaq_cd
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 :faq_cd를 가져오는 메서드
	 */
	@Override
	public String getFaq_cd() {
		return faqDao.getFaq_cd();
	}

	/**
	 * 
	* Method : faqPagingList
	* 작성자 : 유민하
	* 변경이력 :
	* @param pageVo
	* @return
	* Method 설명 : faq 페이징 처리
	 */
	@Override
	public Map<String, Object> faqPagingList(PageVo pageVo) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("faqList", faqDao.faqPagingList(pageVo));
		int faqCnt = faqDao.faqCnt();		
		int paginationSize = (int) Math.ceil((double)faqCnt/pageVo.getPageSize());
		resultMap.put("paginationSize", paginationSize);
		return resultMap;
	}

	/**
	 * 
	* Method : getFaqMain
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 최근 작성된 FAQ게시글 5개 조회(메인용)
	 */
	@Override
	public List<FaqVo> getFaqMain() {
		return faqDao.getFaqMain();
	}

	@Override
	public Map<String, Object> searchTitle(Map<String, Object> map) {
		List<NoticeVo> faqList = faqDao.searchTitle(map);
		int cnt = faqDao.getSearchTitleCnt((String) map.get("faq_title"));
		int paginationSize = (int) Math.ceil((double) cnt / (int) map.get("pageSize"));
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("paginationSize", paginationSize);
		resultMap.put("faqList", faqList);
		
		return resultMap;
	}
	

}
