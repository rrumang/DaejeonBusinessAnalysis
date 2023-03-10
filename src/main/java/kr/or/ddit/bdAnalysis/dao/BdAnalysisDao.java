package kr.or.ddit.bdAnalysis.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

@Repository
public class BdAnalysisDao implements IBdAnalysisDao {

	@Resource(name = "sqlSession")
	private SqlSessionTemplate sqlSession;
	
	/**
	* Method : getGuList
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 대전시의 구 리스트 조회
	*/
	@Override
	public List<RegionVo> getGuList() {
		List<RegionVo> guList = sqlSession.selectList("region.getGuList");
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
		List<RegionVo> dongList = sqlSession.selectList("region.getDongList", region_cd2);
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
		RegionVo regionVo = sqlSession.selectOne("region.getRegionInfo", region_cd);
		return regionVo;
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
		List<TobVo> topList = sqlSession.selectList("tob.getAllTopTobList");
		return topList;
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
		List<TobVo> midList = sqlSession.selectList("tob.getAllMidTobList");
		return midList;
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
		List<TobVo> botList = sqlSession.selectList("tob.getAllBotTobList"); 
		return botList;
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
		String region_full_name = sqlSession.selectOne("bdAnalysis.getRegionFullName", region);
		return region_full_name;
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
		String tob_full_name = sqlSession.selectOne("bdAnalysis.getTobFullName", tob);
		return tob_full_name;
	}

	/**
	* Method : getRegionExtent
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 면적을 조회 (단위 : m^2)
	*/
	@Override
	public int getRegionExtent(long region_cd) {
		int region_extent = sqlSession.selectOne("bdAnalysis.getRegionExtent", region_cd);
		return region_extent;
	}

	/**
	* Method : getStoreCount_Food
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 '음식'의 업소수 조회
	*/
	@Override
	public int getStoreCount_Food(long region_cd) {
		int store_food_cnt = sqlSession.selectOne("bdAnalysis.getStoreCount_Food", region_cd);
		return store_food_cnt;
	}


	/**
	* Method : getStoreCount_Service
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 '서비스'의 업소수 조회
	*/
	@Override
	public int getStoreCount_Service(long region_cd) {
		int store_service_cnt = sqlSession.selectOne("bdAnalysis.getStoreCount_Service", region_cd);
		return store_service_cnt;
	}

	/**
	* Method : getStoreCount_Retail
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 '소매'의 업소수 조회
	*/
	@Override
	public int getStoreCount_Retail(long region_cd) {
		int store_retail_cnt = sqlSession.selectOne("bdAnalysis.getStoreCount_Retail", region_cd);
		return store_retail_cnt;
	}

	/**
	* Method : getStoreCount_SelectedTob
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 '선택업종'의 업소수 조회
	*/
	@Override
	public int getStoreCount_SelectedTob(Map<String, Object> param) {
		int store_selectedTob_cnt = sqlSession.selectOne("bdAnalysis.getStoreCount_SelectedTob", param);
		return store_selectedTob_cnt;
	}

	/**
	* Method : getWpCount
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 직장인구 통계 조회 (데이터 기준 : 2017)
	*/
	@Override
	public int getWpCount(long region_cd) {
		int wpCnt = sqlSession.selectOne("bdAnalysis.getWpCount", region_cd);
		return wpCnt;
	}

	/**
	* Method : getLpCount
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 주거인구 통계 조회(데이터 기준 : 201906)
	*/
	@Override
	public int getLpCount(long region_cd) {
		int lpCnt = sqlSession.selectOne("bdAnalysis.getLpCount", region_cd);
		return lpCnt;
	}

	/**
	* Method : getPpgCount
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 유동인구(성별기준 테이블)통계 조회  (데이터 기준: 2018)
	*/
	@Override
	public int getPpgCount(long region_cd) {
		int ppgCnt = sqlSession.selectOne("bdAnalysis.getPpgCount", region_cd);
		return ppgCnt;
	}

	/**
	* Method : getSelectedTobSales
	* 작성자 : hs
	* 변경이력 :
	* @param param
	* @return
	* Method 설명 : 분석지역에서 분석업종의 총 매출/건수 조회 (날짜 기준: 가장 최신 데이터)
	*/
	@Override
	public SalesVo getSelectedTobSales(Map<String, Object> param) {
		SalesVo salesVo = sqlSession.selectOne("bdAnalysis.getSelectedTobSales", param);
		return salesVo;
	}


	/**
	* Method : getSalesGrowthRate
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 성장성 - 매출증감률 조회 (날짜 기준 : 가장 최신 데이터) 
	*/
	@Override
	public float getSalesGrowthRate(long region_cd) {
		float salesGrowthRate = sqlSession.selectOne("bdAnalysis.getSalesGrowthRate", region_cd);
		return salesGrowthRate;
	}


	/**
	* Method : getBdSalesRate
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 성장성 - 상권매출비중 조회 (날짜 기준 : 가장 최신 데이터)
	*/
	@Override
	public float getBdSalesRate(long region_cd) {
		float bdSalesRate = sqlSession.selectOne("bdAnalysis.getBdSalesRate", region_cd);
		return bdSalesRate;
	}


	/**
	* Method : getStoreCnt_ChangeRate
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 안정성 - 점포수 변동률 평균을 조회
	*/
	@Override
	public float getStoreCnt_ChangeRate(long region_cd) {
		float result_rate = sqlSession.selectOne("bdAnalysis.getStoreCnt_ChangeRate", region_cd);
		return result_rate;
	}

	/**
	* Method : getTotalDongList
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 대전시 내 전체 동리스트 조회
	*/
	@Override
	public List<Long> getTotalDongList() {
		List<Long> list = sqlSession.selectList("bdAnalysis.getTotalDongList");
		return list;
	}

	/**
	* Method : getSalesRate
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석 지역의 안정성 - 매출변동률 평균 조회
	*/
	@Override
	public float getSalesRate(long region_cd) {
		float result = sqlSession.selectOne("bdAnalysis.getSalesRate", region_cd);
		return result;
	}

	/**
	* Method : getCloseStoreRate
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 안정성 - 휴/폐업률 조회
	*/
	@Override
	public float getCloseStoreRate(long region_cd) {
		float closeStoreRate = sqlSession.selectOne("bdAnalysis.getCloseStoreRate", region_cd);
		return closeStoreRate;
	}


	/**
	* Method : getBdSalesVolume
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 구매력 - 상권매출규모 점수환산 조회
	*/
	@Override
	public float getBdSalesVolume(long region_cd) {
		float bdSalesVolue = sqlSession.selectOne("bdAnalysis.getBdSalesVolume", region_cd);
		return bdSalesVolue;
	}


	/**
	* Method : getBd_UnitCost
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 구매력 - 건당 결제금액 점수환산 조회
	*/
	@Override
	public float getBd_UnitCost(long region_cd) {
		float bd_unitCost = sqlSession.selectOne("bdAnalysis.getBd_UnitCost", region_cd);
		return bd_unitCost;
	}


	/**
	* Method : getBdConsumeLevel
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 구매력 - 소비수준 점수환산 조회
	*/
	@Override
	public float getBdConsumeLevel(long region_cd) {
		float bdConsumeLevel = sqlSession.selectOne("bdAnalysis.getBdConsumeLevel", region_cd);
		return bdConsumeLevel;
	}


	/**
	* Method : getPpgScore
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 집객력 - 유동인구 점수환산 조회
	*/
	@Override
	public int getPpgScore(long region_cd) {
		int ppgScore = sqlSession.selectOne("bdAnalysis.getPpgScore", region_cd);
		return ppgScore;
	}

	/**
	* Method : getLpScore
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 집객력 - 주거인구 점수환산 조회
	*/
	@Override
	public float getLpScore(long region_cd) {
		float lpScore = sqlSession.selectOne("bdAnalysis.getLpScore", region_cd);
		return lpScore;
	}

	/**
	* Method : getWpScore
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 집객력 - 직장인구 점수환산 조회
	*/
	@Override
	public float getWpScore(long region_cd) {
		float wpScore = sqlSession.selectOne("bdAnalysis.getWpScore", region_cd);
		return wpScore;
	}


	/**
	* Method : getgetEvaluationInfo
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석 지역의 상권평가지수 상세 조회
	*/
	@Override
	public EvaluationVo getEvaluationInfo(long region_cd) {
		EvaluationVo evalVo = sqlSession.selectOne("bdAnalysis.getEvaluationInfo", region_cd);
		return evalVo;
	}

	/**
	* Method : getEvaluationTotal_dong
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석 지역(동단위) 종합평가지수 및 월별 증감률 조회
	*/
	@Override
	public List<RateOfChangeVo> getEvaluationTotal_dong(long region_cd) {
		List<RateOfChangeVo> rosList = sqlSession.selectList("bdAnalysis.getEvaluationTotal_dong", region_cd);
		return rosList;
	}

	/**
	* Method : getEvaluationTotal_gu
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석 지역(구단위) 종합평가지수 및 월별 증감률 조회
	*/
	@Override
	public List<RateOfChangeVo> getEvaluationTotal_gu(long region_cd) {
		List<RateOfChangeVo> rosList = sqlSession.selectList("bdAnalysis.getEvaluationTotal_gu", region_cd);
		return rosList;
	}

	/**
	* Method : getEvaluationTotal_si
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석 지역(시전체) 종합평가지수 및 월별 증감률 조회
	*/
	@Override
	public List<RateOfChangeVo> getEvaluationTotal_si(long region_cd) {
		List<RateOfChangeVo> rosList = sqlSession.selectList("bdAnalysis.getEvaluationTotal_si", region_cd);
		return rosList;
	}


	/**
	* Method : getEvaluationList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 상권평가지수 상세조회 월별 리스트 
	*/
	@Override
	public List<Map<String, Object>> getEvaluationList(long region_cd) {
		List<Map<String, Object>> evalList = sqlSession.selectList("bdAnalysis.getEvaluationList", region_cd);
		return evalList;
	}

	/**
	* Method : getEvalRateOfChange
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 상세평가지수 항목들의 각 4가지 부문의 점수와 즘감률을 조회 
			  	     기간 - 가장 최신데이터의 날짜에서부터 직전월 까지 <== 2019.03 ~ 2019.04
	*/
	@Override
	public Map<String, Object> getEvalRateOfChange(long region_cd) {
		Map<String, Object> rateOfChange = sqlSession.selectOne("bdAnalysis.getEvalRateOfChange", region_cd);
		return rateOfChange;
	}

	
	
	/**
	* Method : getUpjongCntRosList_Top
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역에서 해당 분석업종의 상위 업종(대분류)의 업소수 및 증감률( 201803월 이후부터 분기별로) 
	*/
	@Override
	public List<UpjongCntRosVo> getUpjongCntRosList_Top(long region_cd, String tob_cd) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", region_cd);
		param.put("tob_cd", tob_cd);
		
		List<UpjongCntRosVo> topResult = sqlSession.selectList("bdAnalysis.getUpjongCntRosList_Top", param); 
		return topResult;
	}

	/**
	* Method : getUpjongCntRosList_Mid
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역에서 해당 분석업종의 상위 업종(중분류)의 업소수 및 증감률( 201803월 이후부터 분기별로)
	*/
	@Override
	public List<UpjongCntRosVo> getUpjongCntRosList_Mid(long region_cd, String tob_cd) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", region_cd);
		param.put("tob_cd", tob_cd);
		
		List<UpjongCntRosVo> midResult = sqlSession.selectList("bdAnalysis.getUpjongCntRosList_Mid", param);
		return midResult;
	}


	/**
	* Method : getUpjongCntRosList_Bottom
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역에 해당 분석업종의 업소수 및 증감률 조회 ( 201803월 이후부터 분기별로)
	*/
	@Override
	public List<UpjongCntRosVo> getUpjongCntRosList_Bottom(long region_cd, String tob_cd) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", region_cd);
		param.put("tob_cd", tob_cd);
		
		List<UpjongCntRosVo> botResult = sqlSession.selectList("bdAnalysis.getUpjongCntRosList_Bottom", param);
		return botResult;
	}

	/**
	* Method : getUpjongNames
	* 작성자 : hs
	* 변경이력 :
	* @param tob_cd
	* @return
	* Method 설명 : 분석업종의 대분류/중분류/소분류 업종명 조회하기
	*/
	@Override
	public Map<String, Object> getUpjongNames(String tob_cd) {
		Map<String, Object> tob_names = sqlSession.selectOne("bdAnalysis.getUpjongNames", tob_cd);
		return tob_names;
	}

	/**
	* Method : getRegionNames
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 동/구/시 단위의 지역명 조회하기
	*/
	@Override
	public Map<String, Object> getRegionNames(long region_cd) {
		Map<String, Object> reg_names = sqlSession.selectOne("bdAnalysis.getRegionNames", region_cd);
		return reg_names;
	}
	
	/**
	* Method : getTobCntList_Dong
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 해당 지역(동단위)안에서의 업소수 및 증감률 조회
	*/
	@Override
	public List<UpjongCntRosVo> getTobCntList_Dong(long region_cd, String tob_cd) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", region_cd);
		param.put("tob_cd", tob_cd);

		List<UpjongCntRosVo> dongResult = sqlSession.selectList("bdAnalysis.getTobCntList_Dong", param);
		return dongResult;
	}

	/**
	* Method : getTobCntList_Gu
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석 지역의 상위지역(구단위) 안에서 업소수 및 증감률 조회
	*/
	@Override
	public List<UpjongCntRosVo> getTobCntList_Gu(long region_cd, String tob_cd) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", region_cd);
		param.put("tob_cd", tob_cd);
		
		List<UpjongCntRosVo> guResult = sqlSession.selectList("bdAnalysis.getTobCntList_Gu", param);
		return guResult;
	}

	/**
	* Method : getTobCntList_Si
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석 지역의 상위지역(대전시 전체) 안에서 업소수 및 증감률 조회
	*/
	@Override
	public List<UpjongCntRosVo> getTobCntList_Si(String tob_cd) {
		List<UpjongCntRosVo> siResult = sqlSession.selectList("bdAnalysis.getTobCntList_Si", tob_cd);
		return siResult;
	}

	/**
	* Method : getTobSaleAndCnt_Bot
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역(동단위) 내에서 선택업종(소분류)의 월별 매출건수와 매출액 및 각 요소의 증감률을 조회
	*/
	@Override
	public List<SalesAndCntRosVo> getTobSaleAndCnt_Bot(long region_cd, String tob_cd) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", region_cd);
		param.put("tob_cd", tob_cd);
		
		List<SalesAndCntRosVo> botResult = sqlSession.selectList("bdAnalysis.getTobSaleAndCnt_Bot", param);
		return botResult;
	}

	/**
	* Method : getTobSaleAndCnt_Mid
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역(동단위) 내에서 선택업종(중분류)의 월별 매출건수와 매출액 및 각 요소의 증감률을 조회
	*/
	@Override
	public List<SalesAndCntRosVo> getTobSaleAndCnt_Mid(long region_cd, String tob_cd) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", region_cd);
		param.put("tob_cd", tob_cd);
		
		List<SalesAndCntRosVo> midResult = sqlSession.selectList("bdAnalysis.getTobSaleAndCnt_Mid", param);
		return midResult;
	}

	/**
	* Method : getTobSaleAndCnt_Top
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역(동단위) 내에서 선택업종(대분류)의 월별 매출건수와 매출액 및 각 요소의 증감률을 조회
	*/
	@Override
	public List<SalesAndCntRosVo> getTobSaleAndCnt_Top(long region_cd, String tob_cd) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", region_cd);
		param.put("tob_cd", tob_cd);
		
		List<SalesAndCntRosVo> topResult = sqlSession.selectList("bdAnalysis.getTobSaleAndCnt_Top", param);
		return topResult;
	}

	/**
	* Method : getRegSaleAndCnt_Dong
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 선택 업종이 분석지역(동단위)내에서 월별 매출,매출건수 및 각 요소의 증감률을 조회
	*/
	@Override
	public List<SalesAndCntRosVo> getRegSaleAndCnt_Dong(long region_cd, String tob_cd) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", region_cd);
		param.put("tob_cd", tob_cd);
		
		List<SalesAndCntRosVo> dongResult = sqlSession.selectList("bdAnalysis.getRegSaleAndCnt_Dong", param);
		return dongResult;
	}

	/**
	* Method : getRegSaleAndCnt_Gu
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 선택 업종이 분석지역(구단위)내에서 월별 매출,매출건수 및 각 요소의 증감률을 조회
	*/
	@Override
	public List<SalesAndCntRosVo> getRegSaleAndCnt_Gu(long region_cd, String tob_cd) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", region_cd);
		param.put("tob_cd", tob_cd);
		
		List<SalesAndCntRosVo> guResult = sqlSession.selectList("bdAnalysis.getRegSaleAndCnt_Gu", param);
		return guResult;
	}

	/**
	* Method : getRegSaleAndCnt_Si
	* 작성자 : hs
	* 변경이력 :
	* @param tob_cd
	* @return
	* Method 설명 : 선택 업종이 분석지역(대전시 전체)내에서 월별 매출,매출건수 및 각 요소의 증감률을 조회
	*/
	@Override
	public List<SalesAndCntRosVo> getRegSaleAndCnt_Si(String tob_cd) {
		List<SalesAndCntRosVo> siResult = sqlSession.selectList("bdAnalysis.getRegSaleAndCnt_Si", tob_cd);
		return siResult;
	}

	/**
	* Method : getPpgList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 성별로 나눈 지역별 유동인구 통계 및 비율 조회
	*/
	@Override
	public List<Map<String, Object>> getPpgList(long region_cd) {
		List<Map<String, Object>> ppgList = sqlSession.selectList("bdAnalysis.getPpgList", region_cd);
		return ppgList;
	}

	/**
	* Method : getPpaList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 연령대별로 나눈 지역별 유동인구 통계
	*/
	@Override
	public List<PpaVo> getPpaList(long region_cd) {
		List<PpaVo> ppaList = sqlSession.selectList("bdAnalysis.getPpaList", region_cd);
		return ppaList;
	}

	/**
	* Method : getLpGenderList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 성별로 나눈 지역별 주거인구 조사 통계 및 비율 조회
	*/
	@Override
	public List<LpVo> getLpGenderList(long region_cd) {
		List<LpVo> lpGenderList = sqlSession.selectList("bdAnalysis.getLpGenderList", region_cd);
		return lpGenderList;
	}

	/**
	* Method : getLpAgeGroupList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 연령대별로 나눈 지역별 주거인구 조사 통계 및 비율 조회
	*/
	@Override
	public List<LpVo> getLpAgeGroupList(long region_cd) {
		List<LpVo> lpAgeList = sqlSession.selectList("bdAnalysis.getLpAgeGroupList", region_cd);
		return lpAgeList;
	}

	/**
	* Method : getHouseHoldCnt
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 지역별 가구수와 비율(=100.0%)을 조회
	*/
	@Override
	public Map<String, Object> getHouseHoldCnt(long region_cd) {
		Map<String, Object> hhCnt = sqlSession.selectOne("bdAnalysis.getHouseHoldCnt", region_cd); 
		return hhCnt;
	}

	/**
	* Method : getLpTotalCnt
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 지역별 주거인구 전체 수와 비율(=100.0%)을 조회
	*/
	@Override
	public Map<String, Object> getLpTotalCnt(long region_cd) {
		Map<String, Object> lpTotalCnt = sqlSession.selectOne("bdAnalysis.getLpTotalCnt", region_cd);
		return lpTotalCnt;
	}

	/**
	* Method : getWpList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 해당 지역의 직장인구 수를 조회 (성별로 구분)
	*/
	@Override
	public List<WpVo> getWpList(long region_cd) {
		List<WpVo> wpList = sqlSession.selectList("bdAnalysis.getWpList", region_cd);
		return wpList;
	}

	/**
	* Method : getWpTotalCnt
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 직장인구 전체수 및 비율(=100.0%) 조회
	*/
	@Override
	public Map<String, Object> getWpTotalCnt(long region_cd) {
		Map<String, Object> total = sqlSession.selectOne("bdAnalysis.getWpTotalCnt", region_cd);
		return total;
	}

	/**
	* Method : getTobLC_tobCnt
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 해당 분석지역 내에서 해당 업소의 증감률 조회
	*/
	@Override
	public Map<String, Object> getTobLC_tobCnt(long region_cd, String tob_cd) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", region_cd);
		param.put("tob_cd", tob_cd);
		
		Map<String, Object> result = sqlSession.selectOne("bdAnalysis.getTobLC_tobCnt", param);
		return result;
	}

	
	/**
	* Method : getTobLC_tobSale
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 해당 분석지역 내에서 해당 업종의 매출의 증감률을 조회 
	*/
	@Override
	public Map<String, Object> getTobLC_tobSale(long region_cd, String tob_cd) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", region_cd);
		param.put("tob_cd", tob_cd);
		
		Map<String, Object> result = sqlSession.selectOne("bdAnalysis.getTobLC_tobSale", param);
		return result;
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
		List<ApartmentVo> aptList = sqlSession.selectList("bdAnalysis.getAptList", region_cd);
		return aptList;
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
		sqlSession.insert("bdAnalysis.insert_BdAnalysisReport", reportVo);
		return reportVo.getReport_cd();
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
		ReportVo vo = sqlSession.selectOne("bdAnalysis.getReportVo", report_cd);
		return vo;
	}
	
	
}
