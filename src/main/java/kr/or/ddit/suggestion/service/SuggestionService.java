package kr.or.ddit.suggestion.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.suggestion.dao.ISuggestionDao;
import kr.or.ddit.suggestion.model.SuggestionVo;

@Service
public class SuggestionService implements ISuggestionService {

	
	
	@Resource(name="suggestionDao")
	private ISuggestionDao suggestionDao;
	
	
	/**
	 * 
	* Method : suggetionList
	* 작성자 : 강민호
	* 변경이력 :
	* @return
	* Method 설명 : 건의사항 전체 목록 가져오기
	 */
	@Override
	public List<SuggestionVo> suggetionList() {
		return suggestionDao.suggetionList();
	}


	@Override
	public int insertSuggesion(SuggestionVo sv) {
		return suggestionDao.insertSuggesion(sv);
	}


	@Override
	public SuggestionVo getSuggestion(String suggestion_cd) {
		return suggestionDao.getSuggestion(suggestion_cd);
	}


	@Override
	public int getSuggestionUpdate(SuggestionVo sv) {
		return suggestionDao.getSuggestionUpdate(sv);
	}


	@Override
	public int getSuggestionDelete(String suggestion_cd) {
		return suggestionDao.getSuggestionDelete(suggestion_cd);
	}


	@Override
	public int insertReply(SuggestionVo sv) {
		return suggestionDao.insertReply(sv);
	}


	@Override
	public int getReply(String suggestion_cd2) {
		return suggestionDao.getReply(suggestion_cd2);
	}


	@Override
	public List<SuggestionVo> getSearchSuggestionBoard(String keyword) {
		return suggestionDao.getSearchSuggestionBoard(keyword);
	}


	@Override
	public SuggestionVo getLastSg() {
		return suggestionDao.getLastSg();
	}


	@Override
	public Map<String, Object> getAllSuggestion(PageVo pageVo) {
		List<SuggestionVo> suggestionList  = suggestionDao.getPagingSuggestion(pageVo);
		int allCnt  = suggestionDao.getAllSuggestionCnt();
		
		int paginationSize = (int)Math.ceil((double)allCnt/pageVo.getPageSize());
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("paginationSize", paginationSize);
		resultMap.put("suggestionList",suggestionList);
		
		return resultMap;
	}


	@Override
	public Map<String, Object> getKeywordSuggestion(Map<String, Object> map) {
		List<SuggestionVo> suggestionList = suggestionDao.getKeywordPagingSuggestion(map);
		int cnt = suggestionDao.getKeywordSuggestionCnt((String)map.get("keyword"));
		int paginationSize = (int)Math.ceil((double)cnt/(int)map.get("pageSize"));
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("paginationSize", paginationSize);
		resultMap.put("suggestionList", suggestionList);
		
		return resultMap;
	}


	@Override
	public List<SuggestionVo> getMainSuggestionList() {
		return suggestionDao.getMainSuggestionList();
	}

}
