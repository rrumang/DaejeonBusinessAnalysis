package kr.or.ddit.bdAnalysis.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.bdAnalysis.model.ApartmentVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;

public interface IBdAnalysisService {

	/**
	* Method : getGuList
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 대전시의 구 리스트 조회
	*/
	public List<RegionVo> getGuList();
	
	/**
	* Method : getDongList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd2
	* @return
	* Method 설명 : 해당 구의 동 리스트 조회
	*/
	public List<RegionVo> getDongList(int region_cd2);
	
	
	/**
	* Method : getRegionInfo
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 해당 분석지역의 정보 상세조회
	*/
	public RegionVo getRegionInfo(long region_cd);
	
	
	/**
	* Method : getLargeTobList
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 전체 대분류 리스트 조회
	*/
	public List<TobVo> getAllTopTobList();

	/**
	* Method : getMidTobList
	* 작성자 : hs
	* 변경이력 :
	* @param tob_cd2
	* @return
	* Method 설명 : 전체 중분류 리스트 조회
	*/
	public List<TobVo> getAllMidTobList();
	
	/**
	* Method : getBotTobList
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 전체 소분류 리스트 조회
	*/
	public List<TobVo> getAllBotTobList();
	
	
	/**
	* Method : getRegionFullName
	* 작성자 : hs
	* 변경이력 :
	* @param region
	* @return
	* Method 설명 : 분석지역의 풀 네임을 조회
	*/
	public String getRegionFullName(Map<String, Object> region);
	
	
	/**
	* Method : getTobFullName
	* 작성자 : hs
	* 변경이력 :
	* @param tob
	* @return
	* Method 설명 : 분석업종의 풀 네임을 조회
	*/
	public String getTobFullName(Map<String, Object> tob);
	
	
	/**
	* Method : insert_BdAnalysisReport
	* 작성자 : hs
	* 변경이력 :
	* @param reportVo
	* @return
	* Method 설명 : 사용자가 상권분석을 요청하면 분석 조건값과 사용자 정보를 report(분석이력)테이블에 insert한다
	*/
	public String insert_BdAnalysisReport(ReportVo reportVo);	
	
	
	/**
	* Method : getReportVo
	* 작성자 : hs
	* 변경이력 :
	* @param report_cd
	* @return
	* Method 설명 : 	분석 이력메뉴에서 상권분석 보고서를 재 조회 요청시 조회할 reportVo 
	*/
	public ReportVo getReportVo(String report_cd);
	
	/**
	* Method : getStoreCount_total
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역의 상권주요정보 테이블의 전체 데이터를 가져오는 메서드
	*/
	public Map<String, Object> getBdInformation(long region_cd, String tob_cd);
	
	
	/**
	* Method : getBdRatingIndex
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역의 상권평가지수 데이터를 가져오는 메서드
	*/
	public Map<String, Object> getBdRatingIndex(long region_cd, String tob_cd);
	
	
	/**
	* Method : getgetEvaluationInfo
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석 지역의 상권평가지수 상세 조회
	*/ 
	public Map<String, Object> getEvaluationInfo(long region_cd);
	
	
	/**
	* Method : evaluation_rateOfChange
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역(동,구,시)의 종합평가지수 추이 리스트를 조회
	*/
	public Map<String, Object> evaluation_rateOfChange(long region_cd);
	
	
	/**
	* Method : getUpjongCntRos_Total
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 :
	* 	<업종 분석>
	* 1. 업종별 추이
	* 분석지역의 대/중/소분류 업종별 업소수 및 증감률 조회(기간 : 201803월 이후부터 분기별로)
	*/
	public Map<String, Object> getUpjongCntRos_Total(long region_cd, String tob_cd);
	
	
	/**
	* Method : getTobCntList_Total
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 :
	* 	<업종분석>
	* 2. 지역별 추이
	* 동/구/시 단위의 각 지역내에서 분석업종의 업소수 및 증감률 조회 (기간 : 201803월 이후부터 분기별로)
	*/
	public Map<String, Object> getTobCntList_Total(long region_cd, String tob_cd);
	
	
	/**
	* Method : getTobLC_Total
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 :
	* 	<업종분석>
	* 3. 업종 생애주기
	*
	* 1) 분석지역 내에서 해당 업종의 업소수 증감률 데이터 조회
	* 2) 분석지역 내에서 해당 업종의 매출액 증감률 데이터 조회
	*/
	public Map<String, Object> getTobLC_Total(long region_cd, String tob_cd);
	
	/**
	* Method : getTobSaleAndCnt_Total
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 :
	* 	<매출 분석>
	* 1. 업종별 매출추이
	* 분석지역 내에서 대/중/소분류 업종의 매출액 ,매출건수, 각 요소들의 월별 증감률 조회
	* 기간: 2018.11 ~ 2019.04 까지 월별로 
	*/
	public Map<String, Object> getTobSaleAndCnt_Total(long region_cd, String tob_cd);
	
	
	/**
	* Method : getRegSaleAndCnt_Total
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 :
	* 	<매출추이>
	* 2. 지역별 매출추이
	* 선택업종이 분석지역(동/구/시)내에서 월별 매출액, 매출건수, 각 요소들의 증감률 조회
	* 기간 : 2018.11 ~ 2019.04 까지 월별로
	*/
	public Map<String, Object> getRegSaleAndCnt_Total(long region_cd, String tob_cd);
	
	
	/**
	* Method : getPpaAndPpg
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 
	* 	<인구분석>
	* 1. 유동인구
	* 선택한 지역 내에서 성별/연령대별 유동인구 수 데이터 조회 (데이터 기준날짜 2019.06의 전반기 누적데이터)
	*/
	public Map<String, Object> getPpaAndPpg(long region_cd);
	
	
	/**
	* Method : getLpList_Total
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 :
	* 	<인구분석>
	* 2. 주거인구
	* 선택한 지역 내에서 성별/연령대별 주거인구 수 데이터 조회 (데이터 기준날짜 2019.06년의 전반기 누적데이터)
	*/
	public Map<String, Object> getLpList_Total(long region_cd);
	
	
	/**
	* Method : getWpList_Total
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 :
	* 	<인구분석>
	* 3. 직장인구
	* 선택한 지역 내에서 성별로 구분된 주거인구 수 데이터 조회 (데이터 기준날짜 : 2017 누적데이터)
	*/
	public Map<String, Object> getWpList_Total(long region_cd);

	/**
	* Method : getAptList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 해당 분석지역 내 공동 주택 현황을 파악하기 위한 조회 쿼리문
	*/
	public List<ApartmentVo> getAptList(long region_cd);
	
}
