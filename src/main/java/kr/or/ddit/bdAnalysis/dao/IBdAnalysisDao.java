package kr.or.ddit.bdAnalysis.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.bdAnalysis.model.ApartmentVo;
import kr.or.ddit.bdAnalysis.model.EvaluationVo;
import kr.or.ddit.bdAnalysis.model.RateOfChangeVo;
import kr.or.ddit.bdAnalysis.model.SalesAndCntRosVo;
import kr.or.ddit.bdAnalysis.model.UpjongCntRosVo;
import kr.or.ddit.data.model.LpVo;
import kr.or.ddit.data.model.PpaVo;
import kr.or.ddit.data.model.SalesVo;
import kr.or.ddit.data.model.WpVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;

/**
* IBdAnalysisDao.java
*
* @author hs
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
* 수정자 수정내용
* ------ ------------------------
* hs 최초 생성
*
* </pre>
*/
public interface IBdAnalysisDao {
	
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
	* Method : getRegionExtent
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 면적을 조회 (단위 : m^2)
	*/
	public int getRegionExtent(long region_cd);
	
	
	/**
	* Method : getStoreCount_Food
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 '음식'의 업소수 조회
	*/
	public int getStoreCount_Food(long region_cd);
	
	
	/**
	* Method : getStoreCount_Service
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 '서비스'의 업소수 조회
	*/
	public int getStoreCount_Service(long region_cd);
	
	
	/**
	* Method : getStoreCount_Retail
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 '소매'의 업소수 조회
	*/
	public int getStoreCount_Retail(long region_cd);
	
	
	/**
	* Method : getStoreCount_SelectedTob
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 '선택업종'의 업소수 조회
	*/
	public int getStoreCount_SelectedTob(Map<String, Object> param);
	
	
	/**
	* Method : getWpCount
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 직장인구 통계 조회 (데이터 기준 : 2017)
	*/
	public int getWpCount(long region_cd);

	
	/**
	* Method : getLpCount
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 주거인구 통계 조회(데이터 기준 : 201906)
	*/
	public int getLpCount(long region_cd);
	
	
	/**
	* Method : getPpgCount
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 유동인구(성별기준 테이블)통계 조회  (데이터 기준: 2018)
	*/
	public int getPpgCount(long region_cd);
	
	
	/**
	* Method : getSelectedTobSales
	* 작성자 : hs
	* 변경이력 :
	* @param param
	* @return
	* Method 설명 : 분석지역에서 분석업종의 총 매출/건수 조회 (날짜 기준: 가장 최신 데이터)
	*/
	public SalesVo getSelectedTobSales(Map<String, Object> param);
	
	
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
	* Method 설명 : 분석 이력메뉴에서 상권분석 보고서를 재 조회 요청시 조회할 reportVo 
	*/
	public ReportVo getReportVo(String report_cd);
	
	/**
	* Method : getSalesGrowthRate
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 성장성 - 매출증감률 조회 (날짜 기준 : 가장 최신 데이터) 
	*/
	public float getSalesGrowthRate(long region_cd);
	
	
	/**
	* Method : getBdSalesRate
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 성장성 - 상권매출비중 조회 (날짜 기준 : 가장 최신 데이터)
	*/
	public float getBdSalesRate(long region_cd);	
	
	
	
	/**
	* Method : getStoreCnt_ChangeRate
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 안정성 - 점포수 변동률 평균을 조회
	*/
	public float getStoreCnt_ChangeRate(long region_cd);
	
	
	/**
	* Method : getTotalDongList
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 대전시 내 전체 동리스트 조회
	*/
	public List<Long> getTotalDongList();
	
	
	/**
	* Method : getSalesRate
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석 지역의 안정성 - 매출변동률 평균 조회
	*/
	public float getSalesRate(long region_cd);

	
	/**
	* Method : getCloseStoreRate
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 안정성 - 휴/폐업률 조회
	*/
	public float getCloseStoreRate(long region_cd);
	
	
	
	/**
	* Method : getBdSalesVolume
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 구매력 - 상권매출규모 점수 조회
	*/
	public float getBdSalesVolume(long region_cd);
	
	
	/**
	* Method : getBd_UnitCost
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 구매력 - 건당결제금액 점수환산 조회
	*/
	public float getBd_UnitCost(long region_cd);
	
	
	/**
	* Method : getBdConsumeLevel
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 구매력 - 소비수준 점수환산 조회
	*/
	public float getBdConsumeLevel(long region_cd);
	
	
	/**
	* Method : getPpgScore
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 집객력 - 유동인구 점수환산 조회
	*/
	public int getPpgScore(long region_cd);
	
	
	/**
	* Method : getLpScore
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 집객력 - 주거인구 점수환산 조회
	*/
	public float getLpScore(long region_cd);
	
	
	/**
	* Method : getWpScore
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 집객력 - 직장인구 점수환산 조회
	*/
	public float getWpScore(long region_cd);
	
	
	/**
	* Method : getgetEvaluationInfo
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석 지역의 상권평가지수 상세 조회
	*/ 
	public EvaluationVo getEvaluationInfo(long region_cd);
	
	
	/**
	* Method : getEvaluationTotal_dong
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석 지역(동단위) 종합평가지수 및 월별 증감률 조회
	*/
	public List<RateOfChangeVo> getEvaluationTotal_dong(long region_cd);
	
	/**
	* Method : getEvaluationTotal_gu
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석 지역(구단위) 종합평가지수 및 월별 증감률 조회
	*/
	public List<RateOfChangeVo> getEvaluationTotal_gu(long region_cd);
	
	/**
	* Method : getEvaluationTotal_si
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석 지역(시단위) 종합평가지수 및 월별 증감률 조회
	*/
	public List<RateOfChangeVo> getEvaluationTotal_si(long region_cd);
	
	
	/**
	* Method : getEvaluationList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 상권평가지수 상세조회 월별 리스트 
	*/
	public List<Map<String, Object>> getEvaluationList(long region_cd);

	
	/**
	* Method : getEvalRateOfChange
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 상세평가지수 항목들의 각 4가지 부문의 점수와 즘감률을 조회 
			  	     기간 - 가장 최신데이터의 날짜에서부터 직전월 까지 <== 2019.03 ~ 2019.04
	*/
	public Map<String, Object> getEvalRateOfChange(long region_cd);
	
	
	/**
	* Method : getUpjongNames
	* 작성자 : hs
	* 변경이력 :
	* @param tob_cd
	* @return
	* Method 설명 : 분석업종의 대분류/중분류/소분류 업종명 조회하기
	*/
	public Map<String, Object> getUpjongNames(String tob_cd);
	
	/**
	* Method : getRegionNames
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 동/구/시 단위의 지역명 조회하기
	*/
	public Map<String, Object> getRegionNames(long region_cd);
	
	/**
	* Method : getUpjongCntRosList_Top
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역에 해당 분석업종의 업소수 및 증감률 조회 ( 201806월 이후부터 분기별로)
	*/
	public List<UpjongCntRosVo> getUpjongCntRosList_Top(long region_cd, String tob_cd);

	
	/**
	* Method : getUpjongCntRosList_Mid
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역에서 해당 분석업종의 상위 업종(중분류)의 업소수 및 증감률( 201806월 이후부터 분기별로)
	*/
	public List<UpjongCntRosVo> getUpjongCntRosList_Mid(long region_cd, String tob_cd);
	
	
	/**
	* Method : getUpjongCntRosList_Bottom
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역에서 해당 분석업종의 상위 업종(대분류)의 업소수 및 증감률( 201806월 이후부터 분기별로)
	*/
	public List<UpjongCntRosVo> getUpjongCntRosList_Bottom(long region_cd, String tob_cd);
	
	
	/**
	* Method : getTobCntList_Dong
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 해당 지역(동단위)안에서의 업소수 및 증감률 조회
	*/
	public List<UpjongCntRosVo> getTobCntList_Dong(long region_cd, String tob_cd);
	
	
	/**
	* Method : getTobCntList_Gu
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석 지역의 상위지역(구단위) 안에서 업소수 및 증감률 조회
	*/
	public List<UpjongCntRosVo> getTobCntList_Gu(long region_cd, String tob_cd);
	
	
	/**
	* Method : getTobCntList_Si
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석 지역의 상위지역(대전시 전체) 안에서 업소수 및 증감률 조회
	*/
	public List<UpjongCntRosVo> getTobCntList_Si(String tob_cd);
	
	
	/**
	* Method : getTobSaleAndCnt_Bot
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역(동단위) 내에서 선택업종(소분류)의 월별 매출건수와 매출액 및 각 요소의 증감률을 조회
	*/
	public List<SalesAndCntRosVo> getTobSaleAndCnt_Bot(long region_cd, String tob_cd);
	
	
	/**
	* Method : getTobSaleAndCnt_Mid
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역(동단위) 내에서 선택업종(중분류)의 월별 매출건수와 매출액 및 각 요소의 증감률을 조회
	*/
	public List<SalesAndCntRosVo> getTobSaleAndCnt_Mid(long region_cd, String tob_cd);
	
	/**
	* Method : getTobSaleAndCnt_Top
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역(동단위) 내에서 선택업종(대분류)의 월별 매출건수와 매출액 및 각 요소의 증감률을 조회
	*/
	public List<SalesAndCntRosVo> getTobSaleAndCnt_Top(long region_cd, String tob_cd);

	
	/**
	* Method : getRegSaleAndCnt_Dong
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 선택 업종이 분석지역(동단위)내에서 월별 매출,매출건수 및 각 요소의 증감률을 조회
	*/
	public List<SalesAndCntRosVo> getRegSaleAndCnt_Dong(long region_cd, String tob_cd);
	
	
	/**
	* Method : getRegSaleAndCnt_Gu
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 선택 업종이 분석지역(구단위)내에서 월별 매출,매출건수 및 각 요소의 증감률을 조회
	*/
	public List<SalesAndCntRosVo> getRegSaleAndCnt_Gu(long region_cd, String tob_cd);

	
	/**
	* Method : getRegSaleAndCnt_Si
	* 작성자 : hs
	* 변경이력 :
	* @param tob_cd
	* @return
	* Method 설명 : 선택 업종이 분석지역(대전시 전체)내에서 월별 매출,매출건수 및 각 요소의 증감률을 조회
	*/
	public List<SalesAndCntRosVo> getRegSaleAndCnt_Si(String tob_cd);
	
	
	/**
	* Method : getPpgList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 성별로 나눈 지역별 유동인구 통계 및 비율 조회
	*/
	public List<Map<String, Object>> getPpgList(long region_cd);
	
	/**
	* Method : getPpaList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 연령대별로 나눈 지역별 유동인구 통계
	*/
	public List<PpaVo> getPpaList(long region_cd);
	
	/**
	* Method : getLpGenderList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 성별로 나눈 지역별 주거인구 조사 통계 및 비율 조회
	*/
	public List<LpVo> getLpGenderList(long region_cd);
	
	/**
	* Method : getLpAgeGroupList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 연령대별로 나눈 지역별 주거인구 조사 통계 및 비율 조회
	*/
	public List<LpVo> getLpAgeGroupList(long region_cd);
	
	/**
	* Method : getHouseHoldCnt
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 지역별 가구수와 비율(=100.0%)을 조회
	*/
	public Map<String, Object> getHouseHoldCnt(long region_cd);
	
	
	/**
	* Method : getLpTotalCnt
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 지역별 주거인구 전체 수와 비율(=100.0%)을 조회
	*/
	public Map<String, Object> getLpTotalCnt(long region_cd);
	
	
	/**
	* Method : getWpList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 해당 지역의 직장인구 수를 조회 (성별로 구분)
	*/
	public List<WpVo> getWpList(long region_cd);
	
	/**
	* Method : getWpTotalCnt
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 직장인구 전체수 및 비율(=100.0%) 조회
	*/
	public Map<String, Object> getWpTotalCnt(long region_cd);

	
	/**
	* Method : getTobLC_tobCnt
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 해당 분석지역 내에서 해당 업소의 증감률 조회
	*/
	public Map<String, Object> getTobLC_tobCnt(long region_cd, String tob_cd);
	
	
	/**
	* Method : getTobLC_tobSale
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 해당 분석지역 내에서 해당 업종의 매출의 증감률을 조회 
	*/
	public Map<String, Object> getTobLC_tobSale(long region_cd, String tob_cd);
	
	
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

