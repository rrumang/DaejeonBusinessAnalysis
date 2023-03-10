package kr.or.ddit.report.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;

public interface IReportDao {
	
	/**
	 * 
	* Method : reportList
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 분석보고서 목록 조회
	 */
	public List<ReportVo> reportPagingList(Map<String, Object> resultMap);
	
	/**
	 * 
	* Method : reportCnt
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 분석보고서 전체수 조회
	 */
	public int reportCnt(String member_id);
	
	/**
	 * 
	* Method : getReport
	* 작성자 : 유민하
	* 변경이력 :
	* @param resultMap
	* @return
	* Method 설명 : 특정 보고서 목록 출력
	 */
	public List<ReportVo> getReport(Map<String, Object> resultMap);
	
	/**
	 * 
	* Method : reportCnt
	* 작성자 : 유민하
	* 변경이력 :
	* @param report_kind
	* @return
	* Method 설명 : 특정보고서 전체수 조회
	 */
	public int getReportCnt(Map<String, Object> cntMap);
	
	/**
	 * 
	* Method : getRegion
	* 작성자 : 유민하
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 지역코드에 해당하는 지역정보 객체를 반환
	 */
	public RegionVo getRegion(long region_cd);
	
	/**
	 * 
	* Method : getTob
	* 작성자 : 유민하
	* 변경이력 :
	* @param tob_cd
	* @return
	* Method 설명 : 업종코드에 해당하는 업종정보 객체를 반환
	 */
	public TobVo getTob(String tob_cd);
	
	

}
