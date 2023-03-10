package kr.or.ddit.report.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.report.dao.IReportDao;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;

@Service
public class ReportService implements IReportService {
	
	@Resource(name="reportDao")
	private IReportDao reportDao;

	/**
	 * 
	* Method : reportPagingList
	* 작성자 : 유민하
	* 변경이력 :
	* @param pageVo
	* @return
	* Method 설명 : 회원의 분석보고서 목록 조회
	 */
	@Override
	public Map<String, Object> reportPagingList(Map<String, Object> resultMap) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("reportList", reportDao.reportPagingList(resultMap));
		
		int page = (int)resultMap.get("page");
		int pageSize = (int)resultMap.get("pageSize");
		String member_id = (String)resultMap.get("member_id");
		
		int reportCnt = reportDao.reportCnt(member_id);
		int PaginationSize = (int)Math.ceil((double)reportCnt/pageSize);
		result.put("paginationSize", PaginationSize);
		return result;
	}

	/**
	 * 
	* Method : getReport
	* 작성자 : 유민하
	* 변경이력 :
	* @param resultMap
	* @return
	* Method 설명 : 특정 보고서종류 목록 출력
	 */
	@Override
	public Map<String, Object> getReport(Map<String, Object> resultMap) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("reportList", reportDao.getReport(resultMap));
		
		int page = (int) resultMap.get("page");
		int pageSize = (int) resultMap.get("pageSize");
		
		
		int report_kind = (int) resultMap.get("report_kind");
		String member_id = (String)resultMap.get("member_id");
		
		Map<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("report_kind", report_kind);
		cntMap.put("member_id", member_id);
		
		int getReportCnt = reportDao.getReportCnt(cntMap);
		int paginationSize = (int) Math.ceil((double)getReportCnt/pageSize);
		
		result.put("paginationSize", paginationSize);
		
		return result;
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
		return reportDao.getRegion(region_cd);
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
		return reportDao.getTob(tob_cd);
	}

}
