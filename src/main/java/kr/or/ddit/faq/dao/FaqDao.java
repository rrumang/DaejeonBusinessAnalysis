package kr.or.ddit.faq.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.faq.model.FaqVo;
import kr.or.ddit.notice.model.NoticeVo;
import kr.or.ddit.paging.model.PageVo;

@Repository
public class FaqDao implements IFaqDao {
	
	@Resource(name="sqlSession")
	private SqlSessionTemplate sqlSession;

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
		return sqlSession.selectList("faq.faqList");
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
		return sqlSession.selectOne("faq.getFaq",faq_cd);
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
		return sqlSession.insert("faq.insertFaq", faqVo);
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
		return sqlSession.update("faq.updateFaq", faqVo);
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
		return sqlSession.update("faq.deleteFaq", faq_cd);
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
		return sqlSession.selectOne("faq.getFaq_cd");
	}

	/**
	 * 
	* Method : faqCnt
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 :게시글 전체수 조회
	 */
	@Override
	public int faqCnt() {
		return sqlSession.selectOne("faq.faqCnt");
	}
	
	/**
	 * 
	* Method : faqPagingList
	* 작성자 : 유민하
	* 변경이력 :
	* @param pageVo
	* @return
	* Method 설명 : 게시글 페이지 처리
	 */
	@Override
	public List<FaqVo> faqPagingList(PageVo pageVo) {
		return sqlSession.selectList("faq.faqPagingList", pageVo);
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
		return sqlSession.selectList("faq.getFaqMain");
	}

	/**
	 * 
	* Method : searchTitle
	* 작성자 : 유민하
	* 변경이력 :
	* @param map
	* @return
	* Method 설명 : 자주묻는 질문 게시글 제목으로 검색, 페이지 조회
	 */
	@Override
	public List<NoticeVo> searchTitle(Map<String, Object> map) {
		return sqlSession.selectList("faq.searchTitle", map);
	}

	/**
	 * 
	* Method : getSearchTitleCnt
	* 작성자 : 유민하
	* 변경이력 :
	* @param string
	* @return
	* Method 설명 :자주묻는 질문 게시글 제목으로 검색한 게시글 총 갯수 조회
	 */
	@Override
	public int getSearchTitleCnt(String string) {
		return sqlSession.selectOne("faq.getSearchTitleCnt", string);
	}
}
