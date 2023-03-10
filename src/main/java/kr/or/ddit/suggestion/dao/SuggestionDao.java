package kr.or.ddit.suggestion.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.suggestion.model.SuggestionVo;

@Repository
public class SuggestionDao implements ISuggestionDao {
	
	@Resource(name="sqlSession")
	private SqlSessionTemplate sqlSession;
	
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
		return sqlSession.selectList("suggestion.getAllSuggestion");
	}
	
	
	/**
	 * 
	* Method : insertSuggesion
	* 작성자 : 강민호
	* 변경이력 :
	* @return
	* Method 설명 : 건의사항 추가하기
	 */
	@Override
	public int insertSuggesion(SuggestionVo sv) {
		return sqlSession.insert("suggestion.insertSuggestion",sv);
	}


	@Override
	public SuggestionVo getSuggestion(String suggestion_cd) {
		return sqlSession.selectOne("suggestion.getSuggestion",suggestion_cd);
	}


	@Override
	public int getSuggestionUpdate(SuggestionVo sv) {
		return sqlSession.update("suggestion.getSuggestionModify",sv);
	}


	@Override
	public int getSuggestionDelete(String suggestion_cd) {
		return sqlSession.update("suggestion.getSuggestiondel",suggestion_cd);
	}

	@Override
	public int insertReply(SuggestionVo sv) {
		return sqlSession.insert("suggestion.insertReply",sv);
	}

	@Override
	public int getReply(String suggestion_cd2) {
		return sqlSession.selectOne("suggestion.getReply",suggestion_cd2);
	}

	@Override
	public List<SuggestionVo> getSearchSuggestionBoard(String keyword) {
		return sqlSession.selectList("suggestion.getSuggestionboardSearch",keyword);
	}

	@Override
	public SuggestionVo getLastSg() {
		return sqlSession.selectOne("suggestion.getLastSg");
	}

	@Override
	public int getAllSuggestionCnt() {
		return sqlSession.selectOne("suggestion.getAllSuggestionCnt");
	}

	@Override
	public int getKeywordSuggestionCnt(String keyword) {
		return sqlSession.selectOne("suggestion.getAllKeywordSuggestionCnt",keyword);
	}

	@Override
	public List<SuggestionVo> getPagingSuggestion(PageVo pageVo) {
		return sqlSession.selectList("suggestion.getPagingSuggestion",pageVo);
	}

	@Override
	public List<SuggestionVo> getKeywordPagingSuggestion(Map<String, Object> map) {
		return sqlSession.selectList("suggestion.getKeywordPagingSuggestion",map);
	}


	@Override
	public List<SuggestionVo> getMainSuggestionList() {
		return sqlSession.selectList("suggestion.getMainSuggestionBoard");
	}

}
