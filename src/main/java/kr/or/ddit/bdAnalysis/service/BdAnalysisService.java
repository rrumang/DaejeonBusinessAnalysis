package kr.or.ddit.bdAnalysis.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.naming.spi.DirStateFactory.Result;

import org.springframework.stereotype.Service;

import kr.or.ddit.bdAnalysis.dao.IBdAnalysisDao;
import kr.or.ddit.bdAnalysis.model.ApartmentVo;
import kr.or.ddit.bdAnalysis.model.EvaluationVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;

@Service
public class BdAnalysisService implements IBdAnalysisService {

	@Resource(name = "bdAnalysisDao")
	private IBdAnalysisDao bdAnalysisDao;
	
	/**
	* Method : getGuList
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 대전시의 구 리스트 조회
	*/
	@Override
	public List<RegionVo> getGuList() {
		List<RegionVo> guList = bdAnalysisDao.getGuList();
		return guList;
	}

	/**
	* Method : getDongList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd2
	* @return
	* Method 설명 : 해당 구의 동 리스트 조회
	*/
	@Override
	public List<RegionVo> getDongList(int region_cd2) {
		List<RegionVo> dongList = bdAnalysisDao.getDongList(region_cd2);
		return dongList;
	}

	/**
	* Method : getRegionInfo
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 해당 분석지역의 정보 상세조회
	*/
	@Override
	public RegionVo getRegionInfo(long region_cd) {
		return bdAnalysisDao.getRegionInfo(region_cd);
	}
	
	/**
	* Method : getLargeTobList
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 전체 대분류 리스트 조회
	*/
	@Override
	public List<TobVo> getAllTopTobList() {
		return bdAnalysisDao.getAllTopTobList();
	}

	/**
	* Method : getMidTobList
	* 작성자 : hs
	* 변경이력 :
	* @param tob_cd2
	* @return
	* Method 설명 : 전체 중분류 리스트 조회
	*/
	@Override
	public List<TobVo> getAllMidTobList() {
		return bdAnalysisDao.getAllMidTobList();
	}

	/**
	* Method : getBotTobList
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 전체 소분류 리스트 조회
	*/
	@Override
	public List<TobVo> getAllBotTobList() {
		return bdAnalysisDao.getAllBotTobList();
	}

	/**
	* Method : getRegionFullName
	* 작성자 : hs
	* 변경이력 :
	* @param region
	* @return
	* Method 설명 : 분석지역의 풀 네임을 조회
	*/
	@Override
	public String getRegionFullName(Map<String, Object> region) {
		return bdAnalysisDao.getRegionFullName(region);
	}

	/**
	* Method : getTobFullName
	* 작성자 : hs
	* 변경이력 :
	* @param tob
	* @return
	* Method 설명 : 분석업종의 풀 네임을 조회
	*/
	@Override
	public String getTobFullName(Map<String, Object> tob) {
		return bdAnalysisDao.getTobFullName(tob);
	}

	/**
	* Method : getStoreCount_total
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역의 상권주요정보 테이블의 전체 데이터를 가져오는 메서드
	*/
	@Override
	public Map<String, Object> getBdInformation(long region_cd, String tob_cd) {
		// 결과를 반환할 map 객체
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 선택업종의 업소수 조회하기 위한 매개변수를 넘겨준 map 객체
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", region_cd);
		param.put("tob_cd", tob_cd);
		
		resultMap.put("region_extent", bdAnalysisDao.getRegionExtent(region_cd));
		resultMap.put("storeCnt_Food", bdAnalysisDao.getStoreCount_Food(region_cd));
		resultMap.put("storeCnt_Service", bdAnalysisDao.getStoreCount_Service(region_cd));
		resultMap.put("storeCnt_Retail", bdAnalysisDao.getStoreCount_Retail(region_cd));
		resultMap.put("storeCnt_SelectedTob", bdAnalysisDao.getStoreCount_SelectedTob(param));
		resultMap.put("wpCnt", bdAnalysisDao.getWpCount(region_cd));
		resultMap.put("lpCnt", bdAnalysisDao.getLpCount(region_cd));
		resultMap.put("ppgCnt", bdAnalysisDao.getPpgCount(region_cd));
		resultMap.put("selectedTob_SalesVo", bdAnalysisDao.getSelectedTobSales(param));
		
		return resultMap;
	}

	
	/**
	* Method : getBdRatingIndex
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역의 상권평가지수 데이터를 가져오는 메서드
	*/
	@Override
	public Map<String, Object> getBdRatingIndex(long region_cd, String tob_cd) {
		// 모든 상세평가지수를 담아서 반환할 map객체
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// ========================= 성장성 =========================
		// 20점 만점에서 기준 default점수는 10점으로 가정하고 점수를 산정
		// 성장성 - 매출증감률 점수
		float salesGrowthRate = 10f + ((float)bdAnalysisDao.getSalesGrowthRate(region_cd) / 2);
		// 성장성 - 상권매출비중 점수
		float bdSalesRate = 2.5f + ((float)bdAnalysisDao.getBdSalesRate(region_cd) * 5);

		// ========================= 안전성 =========================
		
		// ----------- 변동성 점수 산출 ----------
		// 15점 만점 : 점포수 변동률(7.5점) + 매출변동률(7.5점)
		// 안정성 - 변동성( 점포수 변동률)  ==== 7.5점만점
		// 단, 점포변동률이 7.5f 보다 크면 만점을 준다 
		// +) 점포변동률이 3f보다 작으면 현재 변동률에 3점을 합산해준다
		float storeCnt_changeRate = bdAnalysisDao.getStoreCnt_ChangeRate(region_cd);
		
		if ( storeCnt_changeRate < 3f ) {
			storeCnt_changeRate = storeCnt_changeRate + 3f;
		} else if(storeCnt_changeRate >= 6.5f) {
			storeCnt_changeRate = 7.5f;
		}
		// 안정성 - 변동성( 매출변동률)    ==== 7.5점만점
		// 단, 매출 변동이 7.5f 보다 크면  7.5점 만점을 준다
		float salesRate = bdAnalysisDao.getSalesRate(region_cd);
		if(salesRate < 0f) {
			salesRate = 0f;
		} else if(salesRate >= 0f && salesRate <3f) {
			salesRate = salesRate + 3f;
		} else if(salesRate >= 6.5f) {
			salesRate = 7.5f;
		}
		// 변동성 점수 산출 : 점포수 변동률
		float totalChangeRate = storeCnt_changeRate + salesRate;
		
		// ----------- 휴/폐업 비율 점수 산출 ------------
		// 폐업률 점수 초기화
		float closeStore_score = 10f;
		// 휴폐업 비율 조회
		float closeStoreRate = bdAnalysisDao.getCloseStoreRate(region_cd);
		
		if(closeStoreRate < 0.2f) {
			closeStore_score = 10f;
		} else if(closeStoreRate >= 0.2f && closeStoreRate < 0.5f) {
			closeStore_score = closeStore_score - (closeStoreRate + 1f);
		} else if(closeStoreRate >= 0.5f && closeStoreRate < 0.75f) {
			closeStore_score = closeStore_score - (closeStoreRate + 1.5f); 
		} else {
			closeStore_score = closeStore_score - 4f;
		}
		
		// ========================= 구매력 =========================
		// 구매력 - 상권매출규모(10점) 점수환산
		// 기본값 : 5점 ==> 조회한 상권 매출규모 점수 환산 수치랑 합산하여 결과 점수 도출
		float salesVolume_score = 5f + bdAnalysisDao.getBdSalesVolume(region_cd);
		// 구매력 - 건당 결제금액(10점) 점수환산
		// 기본값 : 5점  ==> 조회한 상권 건당 결제금액 점수 환산 수치랑 합산하여 결과 점수 도출
		float unitCost_score= 5f + bdAnalysisDao.getBd_UnitCost(region_cd);
		// 구매력 - 소비수준 (5점) 점수환산
		// 기본값 : 2.5점 ==> 조회한 소비수준 점수 환산수치랑 합산하여 결과 점수를 도출
		float consumeLevel_score = 2.5f + bdAnalysisDao.getBdConsumeLevel(region_cd);
		
		// ========================= 집객력 =========================
		// 집객력 - 유동인구(10점) 점수환산 데이터 조회
		int ppgScore = bdAnalysisDao.getPpgScore(region_cd);
		// 집객력 - 주거인구(7.5점) 점수환산 데이터 조회
		float lpScore = bdAnalysisDao.getLpScore(region_cd);
		// 집개력 - 직장인구(7.5점) 점수환산 데이터 조회
		float wpScore = bdAnalysisDao.getWpScore(region_cd);
		
		resultMap.put("salesGrowthRate", salesGrowthRate);
		resultMap.put("bdSalesRate", bdSalesRate);
		resultMap.put("totalChangeRate", totalChangeRate);
		resultMap.put("closeStoreRate", closeStore_score);
		resultMap.put("salesVolume", salesVolume_score);
		resultMap.put("unitCost", unitCost_score);
		resultMap.put("consumeLevel", consumeLevel_score);
		resultMap.put("ppgScore", ppgScore);
		resultMap.put("lpScore", lpScore);
		resultMap.put("wpScore", wpScore);
		
		return resultMap;
	}

	/**
	* Method : getEvaluationInfo
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석 지역의 상권평가지수 상세 조회 및 증감률 조회
	*/
	@Override
	public Map<String, Object> getEvaluationInfo(long region_cd) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 분석지역의 상권평가지수의 상세 조회
		resultMap.put("evalInfo", bdAnalysisDao.getEvaluationInfo(region_cd));
		// 분석지역의 상권평가지수의 최신 데이터의 월이 직전월과의 증감률을 조회
		resultMap.put("evalRateOfChange", bdAnalysisDao.getEvalRateOfChange(region_cd));
		
		return resultMap;
	}

	@Override
	public Map<String, Object> evaluation_rateOfChange(long region_cd) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 분석지역의 상권평가지수 월별 리스트 조회
		resultMap.put("evalList", bdAnalysisDao.getEvaluationList(region_cd));
		
		// 종합평가지수 추이 - 동단위
		resultMap.put("rosList_dong", bdAnalysisDao.getEvaluationTotal_dong(region_cd));
		// 종합평가지수 추이 - 구단위
		resultMap.put("rosList_gu", bdAnalysisDao.getEvaluationTotal_gu(region_cd));
		// 종합평가지수 추이 - 시전체
		resultMap.put("rosList_si", bdAnalysisDao.getEvaluationTotal_si(region_cd));
		
		return resultMap;
	}

	
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
	@Override
	public Map<String, Object> getUpjongCntRos_Total(long region_cd, String tob_cd) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 분석업종 대/중/소분류 업종명을 조회
		resultMap.put("tobNames", bdAnalysisDao.getUpjongNames(tob_cd));
		// 대분류 업종의 업소수 및 증감률
		resultMap.put("topCntRos", bdAnalysisDao.getUpjongCntRosList_Top(region_cd, tob_cd));
		// 중분류 업종의 업소수 및 증감률
		resultMap.put("midCntRos", bdAnalysisDao.getUpjongCntRosList_Mid(region_cd, tob_cd));
		// 소분류 업종의 업소수 및 증감률
		resultMap.put("botCntRos", bdAnalysisDao.getUpjongCntRosList_Bottom(region_cd, tob_cd));
		
		return resultMap;
	}

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
	@Override
	public Map<String, Object> getTobCntList_Total(long region_cd, String tob_cd) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 분석지역 동/구/시단위 지역명을 조회
		resultMap.put("regNames", bdAnalysisDao.getRegionNames(region_cd));
		// 분석지역 (동단위)에서의 분석업종의 업소수 및 증감률 조회 리스트
		resultMap.put("tobCntList_Dong", bdAnalysisDao.getTobCntList_Dong(region_cd, tob_cd));
		// 분석지역 (구단위)에서의 분석업종의 업소수 및 증감률 조회 리스트
		resultMap.put("tobCntList_Gu", bdAnalysisDao.getTobCntList_Gu(region_cd, tob_cd));
		// 분석지역 (대전시 전체)에서의 분석업종의 업소수 및 증감률 조회 리스트
		resultMap.put("tobCntList_Si", bdAnalysisDao.getTobCntList_Si(tob_cd));
		
		return resultMap;
	}

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
	@Override
	public Map<String, Object> getTobSaleAndCnt_Total(long region_cd, String tob_cd) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 분석지역 내 소분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		resultMap.put("tobSac_Bot", bdAnalysisDao.getTobSaleAndCnt_Bot(region_cd, tob_cd));
		// 분석지역 내 중분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		resultMap.put("tobSac_Mid", bdAnalysisDao.getTobSaleAndCnt_Mid(region_cd, tob_cd));
		// 분석지역 내 소분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		resultMap.put("tobSac_Top", bdAnalysisDao.getTobSaleAndCnt_Top(region_cd, tob_cd));
		
		return resultMap;
	}

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
	* 선택업종의 분석지역(동/구/시)내에서 월별 매출액, 매출건수, 각 요소들의 증감률 조회
	* 기간 : 2018.11 ~ 2019.04 까지 월별로
	*/
	@Override
	public Map<String, Object> getRegSaleAndCnt_Total(long region_cd, String tob_cd) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 선택업종의 분석지역(동단위) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		resultMap.put("regSac_Dong", bdAnalysisDao.getRegSaleAndCnt_Dong(region_cd, tob_cd));
		// 선택업종의 분석지역(구단위) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		resultMap.put("regSac_Gu", bdAnalysisDao.getRegSaleAndCnt_Gu(region_cd, tob_cd));
		// 선택업종의 분석지역(대전 전체) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		resultMap.put("regSac_Si", bdAnalysisDao.getRegSaleAndCnt_Si(tob_cd));
		
		return resultMap;
	}

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
	@Override
	public Map<String, Object> getPpaAndPpg(long region_cd) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 선택한 지역 내에서 성별로 나눈 유동인구 데이터 조회
		resultMap.put("ppgList", bdAnalysisDao.getPpgList(region_cd));
		// 선택한 지역 내에서 연령별로 나눈 유동인구 데이터 조회
		resultMap.put("ppaList", bdAnalysisDao.getPpaList(region_cd));
		
		return resultMap;
	}
	
	/**
	* Method : getPpaAndPpg
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 
	* 	<인구분석>
	* 2. 주거인구
	* 선택한 지역 내에서 성별/연령대별 유동인구 수 데이터 조회 (데이터 기준날짜 2019.06의 전반기 누적데이터)
	*/
	@Override
	public Map<String, Object> getLpList_Total(long region_cd) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 선택한 지역 내에서 주거인구를 성별로 나눈 데이터 조회
		resultMap.put("lpGenderList", bdAnalysisDao.getLpGenderList(region_cd));
		// 선택한 지역 내에서 주거인구를 연령별로 나눈 데이터 조회
		resultMap.put("lpAgeList", bdAnalysisDao.getLpAgeGroupList(region_cd));
		// 선택한 지역 내에서 주거인구 가구수와 비율 조회
		resultMap.put("hhCnt", bdAnalysisDao.getHouseHoldCnt(region_cd));
		// 선택한 지역 내에서 주거인구 전체 수와 비율 조회
		resultMap.put("lpTotal", bdAnalysisDao.getLpTotalCnt(region_cd));
		
		
		return resultMap;
	}

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
	@Override
	public Map<String, Object> getWpList_Total(long region_cd) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 해당 지역의 직장인구 수를 조회 (성별로 구분)
		resultMap.put("wpList", bdAnalysisDao.getWpList(region_cd));
		// 직장인구 전체수 및 비율(=100.0%) 조회
		resultMap.put("wpTotal", bdAnalysisDao.getWpTotalCnt(region_cd));
		
		return resultMap;
	}

	
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
	@Override
	public Map<String, Object> getTobLC_Total(long region_cd, String tob_cd) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 1) 분석지역 내에서 해당 업종의 업소수 증감률 데이터 조회
		resultMap.put("tobLC_Cnt", bdAnalysisDao.getTobLC_tobCnt(region_cd, tob_cd));
		// 2) 분석지역 내에서 해당 업종의 매출액 증감률 데이터 조회
		resultMap.put("tobLC_Sale", bdAnalysisDao.getTobLC_tobSale(region_cd, tob_cd));
		
		return resultMap;
	}

	/**
	* Method : getAptList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 해당 분석지역 내 공동 주택 현황을 파악하기 위한 조회 쿼리문
	*/
	@Override
	public List<ApartmentVo> getAptList(long region_cd) {
		return bdAnalysisDao.getAptList(region_cd);
	}

	/**
	* Method : insert_BdAnalysisReport
	* 작성자 : hs
	* 변경이력 :
	* @param reportVo
	* @return
	* Method 설명 : 사용자가 상권분석을 요청하면 분석 조건값과 사용자 정보를 report(분석이력)테이블에 insert한다
	*/
	@Override
	public String insert_BdAnalysisReport(ReportVo reportVo) {
		String result = bdAnalysisDao.insert_BdAnalysisReport(reportVo);
		return result;
	}

	/**
	* Method : getReportVo
	* 작성자 : hs
	* 변경이력 :
	* @param report_cd
	* @return
	* Method 설명 : 분석 이력메뉴에서 상권분석 보고서를 재 조회 요청시 조회할 reportVo 
	*/
	@Override
	public ReportVo getReportVo(String report_cd) {
		ReportVo vo = bdAnalysisDao.getReportVo(report_cd);
		return vo;
	}

}
