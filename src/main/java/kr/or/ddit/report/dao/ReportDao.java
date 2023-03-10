package kr.or.ddit.report.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;

@Repository
public class ReportDao implements IReportDao {
	
	@Resource(name="sqlSession")
	private SqlSessionTemplate sqlSession;

	/**
	 * 
	* Method : reportList
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 회원의 분석보고서 목록 조회
	 */
	@Override
	public List<ReportVo> reportPagingList(Map<String, Object> resultMap) {
		return sqlSession.selectList("report.reportPagingList", resultMap);
	}

	/**
	 * 
	* Method : reportCnt
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 분석보고서 전체수 조회
	 */
	@Override
	public int reportCnt(String member_id) {
		return sqlSession.selectOne("report.reportCnt", member_id);
	}

	/**
	 * 
	* Method : getReport
	* 작성자 : 유민하
	* 변경이력 :
	* @param report_kind
	* @return
	* Method 설명 : 특정 보고서종류 목록 출력
	 */
	@Override
	public List<ReportVo> getReport(Map<String, Object> resultMap) {
		return sqlSession.selectList("report.getReport", resultMap);
	}

	/**
	 * 
	* Method : reportCnt
	* 작성자 : 유민하
	* 변경이력 :
	* @param report_kind
	* @return
	* Method 설명 : 특정보고서 전체수 조회
	 */
	@Override
	public int getReportCnt(Map<String, Object> cntMap) {
		return sqlSession.selectOne("report.getReportCnt",cntMap );
	}

	/**
	 * 
	* Method : getRegion
	* 작성자 : 유민하
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 지역코드에 해당하는 지역정보 객체를 반환
	 */
	@Override
	public RegionVo getRegion(long region_cd) {
		return sqlSession.selectOne("report.getOneRegion", region_cd);
	}

	/**
	 * 
	* Method : getTob
	* 작성자 : 유민하
	* 변경이력 :
	* @param tob_cd
	* @return
	* Method 설명 : 업종코드에 해당하는 업종정보 객체를 반환
	 */
	@Override
	public TobVo getTob(String tob_cd) {
		return sqlSession.selectOne("report.getOneTob", tob_cd);
	}

}
