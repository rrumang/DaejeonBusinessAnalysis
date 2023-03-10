package kr.or.ddit.bdAnalysis.dao;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
import kr.or.ddit.testenv.LogicTestEnv;

public class BdAnalysisDaoTest extends LogicTestEnv{
	
	private static final Logger logger = LoggerFactory.getLogger(BdAnalysisDaoTest.class);
	
	@Resource(name= "bdAnalysisDao")
	public IBdAnalysisDao bdAnalysisDao;
	
	
	/**
	* Method : getGuList
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 대전시의 구 리스트 조회 테스트
	*/
	@Test
	public void getGuListTest() {
		/***Given***/
		

		/***When***/
		List<RegionVo> guList = bdAnalysisDao.getGuList();
		
		/***Then***/
		assertNotNull(guList);
		assertEquals(5, guList.size());
		
	}

	
	/**
	* Method : getDongList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd2 : 30110 ( 동구 ) 
	* @return 동구의 동 리스트 조회
	* Method 설명 : 해당 구의 동 리스트 조회 테스트
	*/
	@Test
	public void getDongList() {
		/***Given***/
		int region_cd2 = 30110;

		/***When***/
		List<RegionVo> dongList = bdAnalysisDao.getDongList(region_cd2);
		
		/***Then***/	
		assertNotNull(dongList);
		assertEquals(16, dongList.size());

	}
	
	/**
	* Method : getRegionInfoTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 해당 분석지역의 상세정보 조회
	*/
	@Test
	public void getRegionInfoTest() {
		/***Given***/
		long region_cd = 3023052000L;

		/***When***/
		RegionVo regionVo = bdAnalysisDao.getRegionInfo(region_cd);
		
		/***Then***/
		assertNotNull(regionVo);
		assertEquals("대전광역시 대덕구 동심5길 10", regionVo.getRegion_csc());
		
	}
	

	/**
	* Method : getLargeTobList
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 전체 대분류 리스트 조회 테스트
	*/
	@Test
	public void getAllTopTobListTest() {
		/***Given***/
		

		/***When***/
		List<TobVo> topList = bdAnalysisDao.getAllTopTobList();
		
		/***Then***/
		assertNotNull(topList);
		assertEquals(6, topList.size());
		
	}
	
	/**
	* Method : getAllMidTobListTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 전체 중분류 리스트 조회 테스트
	*/
	@Test
	public void getAllMidTobListTest() {
		/***Given***/
		
		/***When***/
		List<TobVo> midList = bdAnalysisDao.getAllMidTobList();
		
		/***Then***/
		assertNotNull(midList);
		assertEquals(43, midList.size());
		
	}
	
	
	/**
	* Method : getAllBotTobListTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 전체 소분류 리스트 조회 테스트
	*/
	@Test
	public void getAllBotTobListTest() {
		/***Given***/
		

		/***When***/
		List<TobVo> botList = bdAnalysisDao.getAllBotTobList();
			
		/***Then***/
		assertNotNull(botList);
		assertEquals(275, botList.size());
		
	}

	
	/**
	* Method : getRegionFullName
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역의 풀 네임 조회 테스트
	*/
	@Test
	public void getRegionFullName() {
		/***Given***/
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("gu", 30110);
		param.put("dong", 3011059000L);
		
		/***When***/
		String resultName = bdAnalysisDao.getRegionFullName(param);
		
		/***Then***/
		assertNotNull(resultName);
		assertEquals("대전광역시 동구 자양동", resultName);
		logger.debug("@@@@ name : {}", resultName);
	}
	
	
	/**
	* Method : getTobFullName
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석업종의 풀 네임 조회 테스트
	*/
	@Test
	public void getTobFullName() {
		/***Given***/
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("topTob", "Q");
		param.put("midTob", "Q01");
		param.put("botTob", "Q01A08");
		
		/***When***/
		String resultName = bdAnalysisDao.getTobFullName(param);
		
		/***Then***/
		assertNotNull(resultName);
		assertTrue(resultName.length() > 5);
		logger.debug("@@@@ name : {}", resultName);
		
	}

	/**
	* Method : getRegionExtentTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역의 면적 조회 테스트
	*/
	@Test
	public void getRegionExtentTest() {
		/***Given***/
		long region_cd = 3011059000L;

		/***When***/
		int result = bdAnalysisDao.getRegionExtent(region_cd);

		/***Then***/
		assertNotEquals(0, result);
		assertEquals(115000, result);
	}

	/**
	 * Method : getStoreCount_FoodTest
	 * 작성자 : hs
	 * 변경이력 :
	 * @param region_cd
	 * @return
	 * Method 설명 : 분석지역의 '음식'의 업소수 조회
	 */
	@Test
	public void getStoreCount_FoodTest() {
		/***Given***/
		long region_cd = 3011059000L;

		/***When***/
		int result = bdAnalysisDao.getStoreCount_Food(region_cd);
		
		/***Then***/
		assertNotEquals(0, result);
		assertEquals(325, result);
		
	}
	
	
	
	/**
	* Method : getStoreCount_ServiceTest
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 '서비스'의 업소수 조회
	*/
	@Test
	public void getStoreCount_ServiceTest() {
		/***Given***/
		long region_cd = 3011059000L;

		/***When***/
		int result = bdAnalysisDao.getStoreCount_Service(region_cd);
		
		/***Then***/
		assertNotEquals(0, result);
		assertEquals(99, result);

	}
	
	
	/**
	* Method : getStoreCount_RetailTest
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 '소매'의 업소수 조회
	*/
	@Test
	public void getStoreCount_RetailTest() {
		/***Given***/
		long region_cd = 3011059000L;

		/***When***/
		int result = bdAnalysisDao.getStoreCount_Retail(region_cd);
		
		/***Then***/
		assertNotEquals(0, result);
		assertEquals(138, result);
		
	}
	
	
	/**
	* Method : getStoreCount_SelectedTobTest
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 '선택업종'의 업소수 조회
	*/
	@Test
	public void getStoreCount_SelectedTobTest() {
		/***Given***/
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", 3011059000L);
		param.put("tob_cd", "Q01A02");
		
		/***When***/
		int result = bdAnalysisDao.getStoreCount_SelectedTob(param);
		
		/***Then***/
		assertNotEquals(0, result);
		assertEquals(20, result);
		
	}
	
	
	/**
	* Method : getWpCountTest
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 직장인구 통계 조회 (데이터 기준 : 2017)
	*/
	@Test
	public void getWpCountTest() {
		/***Given***/
		long region_cd = 3011059000L;

		/***When***/
		int result = bdAnalysisDao.getWpCount(region_cd);
		
		/***Then***/
		assertNotEquals(0, result);
		assertEquals(3290, result);
		
	}

	
	/**
	* Method : getLpCountTest
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 주거인구 통계 조회(데이터 기준 : 201906)
	*/
	@Test
	public void getLpCountTest() {
		/***Given***/
		long region_cd = 3011059000L;

		/***When***/
		int result = bdAnalysisDao.getLpCount(region_cd);
		
		/***Then***/
		assertNotEquals(0, result);
		assertEquals(10886, result);
		
	}
	
	
	/**
	* Method : getPpgCount
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 유동인구(성별기준 테이블)통계 조회  (데이터 기준: 2018)
	*/
	@Test
	public void getPpgCountTest() {
		/***Given***/
		long region_cd = 3011059000L;

		/***When***/
		int result = bdAnalysisDao.getPpgCount(region_cd);
		
		/***Then***/
		assertNotEquals(0, result);
		assertEquals(5710, result);
		
	}

	
	/**
	* Method : getSelectedTobSalesTest
	* 작성자 : hs
	* 변경이력 :
	* @param param
	* @return
	* Method 설명 : 분석지역에서 분석업종의 총 매출/건수 조회 (날짜 기준: 가장 최신 데이터)
	*/
	@Test
	public void getSelectedTobSalesTest() {
		/***Given***/
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("region_cd", 3011059000L);
		param.put("tob_cd", "Q01A02");

		/***When***/
		SalesVo resultVo = bdAnalysisDao.getSelectedTobSales(param);
		
		/***Then***/
		assertNotNull(resultVo);
		assertEquals(1932, resultVo.getSales_monthly());
		assertEquals(588, resultVo.getSales_cnt());
		
	}
	
	
	/**
	* Method : getSalesGrowthRateTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역의 성장성 - 매출증감률 조회 (날짜 기준 : 가장 최신 데이터) 
	*/
	@Test
	public void getSalesGrowthRateTest() {
		/***Given***/
		// 대흥동
		long region_cd = 3014057500L;

		/***When***/
		float result = bdAnalysisDao.getSalesGrowthRate(region_cd);
		
		/***Then***/
		assertTrue(6 == result);
		
	}
	
	
	/**
	* Method : getBdSalesRateTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역의 성장성 - 상권매출비중 조회 (날짜 기준 : 가장 최신 데이터)
	*/
	@Test
	public void getBdSalesRateTest() {
		/***Given***/
		// 대흥동
		long region_cd = 3014057500L;

		/***When***/
		float result = bdAnalysisDao.getBdSalesRate(region_cd);

		/***Then***/
		assertEquals(0.08f, result, 0.02f);
		
	}
	
	
	/**
	* Method : changeRateTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역의 점포수/매출 변동률 평균 전체 조회 테스트
	*/
	@Test
	public void changeRateTest() {
		/***Given***/
		

		/***When***/
		List<Long> list = bdAnalysisDao.getTotalDongList();
		/***Then***/
		logger.debug("@@@@@@ size : {}", list.size());
		assertEquals(79, list.size());
		
		for(long region_cd : list) {
			logger.debug("@@@@@@ 지역별 변동률 평균 : {}", bdAnalysisDao.getStoreCnt_ChangeRate(region_cd));
			logger.debug("@@@@@@ 지역별 매출변동률 평균 : {}", bdAnalysisDao.getSalesRate(region_cd));
		}
			
	}
	
	/**
	* Method : getStoreCnt_ChangeRateTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역의 안정성- 점포수 변동률 / 매출변동률 조회
	*/
	@Test
	public void getStoreCnt_ChangeRateTest() {
		/***Given***/
		long region_cd = 3014057500L;

		/***When***/
		float storeCnt_changeRate = bdAnalysisDao.getStoreCnt_ChangeRate(region_cd);
		float salesRate = bdAnalysisDao.getSalesRate(region_cd);
		
		/***Then***/
		assertEquals(1.13f, storeCnt_changeRate, 0.1f);
		assertEquals(-0.26f, salesRate, 0.1f);
		logger.debug("@@@@@@ storeCnt_changeRate : {}", storeCnt_changeRate);
		logger.debug("@@@@@@ salesRate : {}", salesRate);
		logger.debug("@@@@@@ sum : {}", storeCnt_changeRate + salesRate);
	}
	
	
	/**
	* Method : getBdSalesVolumeTest
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 구매력 - 상권매출규모 점수 조회
	*/
	@Test
	public void getBdSalesVolumeTest() {
		/***Given***/
		long region_cd = 3014057500L;

		/***When***/
		float result = bdAnalysisDao.getBdSalesVolume(region_cd);

		/***Then***/
		assertEquals(0.6f, result, 0.1f);
			
	}
	
	
	/**
	* Method : getBd_UnitCost
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 구매력 - 건당결제금액 점수환산 조회
	*/
	@Test
	public void getBd_UnitCostTest() {
		/***Given***/
		long region_cd = 3014057500L;

		/***When***/
		float result = bdAnalysisDao.getBd_UnitCost(region_cd);
		
		/***Then***/
		assertEquals(-0.6f, result, 0.1f);
		
	}
	
	
	/**
	* Method : getBdConsumeLevel
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 분석지역의 구매력 - 소비수준 점수환산 조회
	*/
	@Test
	public void getBdConsumeLevel() {
		/***Given***/
		long region_cd = 3014057500L;

		/***When***/
		float result = bdAnalysisDao.getBdConsumeLevel(region_cd);
		
		/***Then***/
		assertEquals(-0.6f, result, 0.1f);
		
	}
	
	/**
	* Method : getPpgScoreTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역의 집객력 - 유동인구 점수환산 조회 테스트
	*/
	@Test
	public void getPpgScoreTest() {
		/***Given***/
		long region_cd = 3014057500L;

		/***When***/
		int result = bdAnalysisDao.getPpgScore(region_cd);
		
		/***Then***/
		assertEquals(8, result);
		
	}
	
	
	/**
	 * Method : getLpScoreTest
	 * 작성자 : hs
	 * 변경이력 :
	 * Method 설명 : 분석지역의 집객력 - 주거인구 점수환산 조회 테스트
	 */
	@Test
	public void getLpScoreTest() {
		/***Given***/
		long region_cd = 3014057500L;

		
		/***When***/
		float result = bdAnalysisDao.getLpScore(region_cd);
		
		/***Then***/
		assertEquals(5.5f, result, 0.1f);
	}
	
	
	/**
	 * Method : getWpScoreTest
	 * 작성자 : hs
	 * 변경이력 :
	 * Method 설명 : 분석지역의 집객력 - 직장인구 점수환산 조회 테스트
	 */
	@Test
	public void getWpScoreTest() {
		/***Given***/
		long region_cd = 3014057500L;

		
		/***When***/
		float result = bdAnalysisDao.getWpScore(region_cd);
		
		/***Then***/
		assertEquals(7.0f, result, 0.1f);
		
	}
	
	/**
	* Method : getEvaluationInfoTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역의 상권평가지수 상세조회 테스트
	*/
	@Test
	public void getEvaluationInfoTest() {
		/***Given***/
		long region_cd = 3014057500L;


		/***When***/
		EvaluationVo evalVo = bdAnalysisDao.getEvaluationInfo(region_cd);
		
		/***Then***/
		assertNotNull(evalVo);
		assertEquals(11.2, evalVo.getEvaluation_sales_growth(), 0.1f);
		assertEquals(2.9, evalVo.getEvaluation_important(), 0.1f);
		
	}
	
	
	/**
	* Method : getEvaluationTotal_dongTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역(동단위)의 종합평가지수 및 증감률 조회 테스트
	*/
	@Test
	public void getEvaluationTotal_dongTest() {
		/***Given***/
		long region_cd = 3014057500L;
		
		/***When***/
		List<RateOfChangeVo> result = bdAnalysisDao.getEvaluationTotal_dong(region_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(6, result.size());
		for(RateOfChangeVo res : result) {
			logger.debug("@@@@@ vo : {}", res);
		}
	}
	
	
	/**
	* Method : getEvaluationListTest
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 분석지역의 상권평가지수 상세조회 월별 리스트 
	*/
	@Test
	public void getEvaluationListTest() {
		/***Given***/	
		long region_cd = 3023052000L;

		/***When***/
		List<Map<String, Object>> result = bdAnalysisDao.getEvaluationList(region_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(6, result.size());
		for(Map<String, Object> map : result) {
			logger.debug("@@@@@ map : {}", map);
			
		}
	}
	
	
	/**
	* Method : getEvalRateOfChangeTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역의 상세평가지수 항목들의 각 4가지 부문의 점수와 즘감률을 조회 
			  	     기간 - 가장 최신데이터의 날짜에서부터 직전월 까지 <== 2019.03 ~ 2019.04
	*/
	@Test
	public void getEvalRateOfChangeTest() {
		/***Given***/
		long region_cd = 3023052000L;

		/***When***/
		Map<String, Object> result = bdAnalysisDao.getEvalRateOfChange(region_cd);
		
		/***Then***/
		assertNotNull(result);
		// DB에서 결과를 map객체로 받아 왔을 때 해당 맵객체를 바로 꺼내 형변환시켜 쓰려하면 오류가 일어난다
		// 그래서 String.valueOf(Object)메서드로 한번 받아서 문자열로 변환 시킨 후
		// 다시 원래 타입으로 형변환 시키면된다
		assertEquals(23.2f, 
				Float.parseFloat(String.valueOf(result.get("GROWCHANGE"))), 0.1f);
		
	}
	
	
	/**
	* Method : getUpjongCntRosList_TopTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역에서 해당 분석업종의 상위 업종(대분류)의 업소수 및 증감률( 201806월 이후부터 분기별로) 
	*/
	@Test
	public void getUpjongCntRosList_TopTest() {
		/***Given***/
		long region_cd = 3014069000L;
		String tob_cd = "Q01A01";
		/***When***/
		List<UpjongCntRosVo> result = bdAnalysisDao.getUpjongCntRosList_Top(region_cd, tob_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(5, result.size());
		assertEquals(0, result.get(0).getPrev());
	}
	

	/**
	* Method : getUpjongCntRosList_MidTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역에서 해당 분석업종의 상위 업종(중분류)의 업소수 및 증감률( 201806월 이후부터 분기별로)
	*/
	@Test
	public void getUpjongCntRosList_MidTest() {
		/***Given***/
		long region_cd = 3014069000L;
		String tob_cd = "Q01A01";

		/***When***/
		List<UpjongCntRosVo> result = bdAnalysisDao.getUpjongCntRosList_Mid(region_cd, tob_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(5, result.size());
		
	}
	
	
	/**
	* Method : getUpjongCntRosList_BottomTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역에 해당 분석업종의 업소수 및 증감률 조회 ( 201806월 이후부터 분기별로)
	*/
	@Test
	public void getUpjongCntRosList_BottomTest() {
		/***Given***/
		long region_cd = 3014069000L;
		String tob_cd = "Q01A01";

		/***When***/
		List<UpjongCntRosVo> result = bdAnalysisDao.getUpjongCntRosList_Bottom(region_cd, tob_cd);

		/***Then***/
		assertNotNull(result);
		assertEquals(5, result.size());
		
	}
	
	
	/**
	* Method : getUpjongNamesTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석업종의 대분류/중분류/소분류 업종명 조회하기
	*/
	@Test
	public void getUpjongNamesTest() {
		/***Given***/
		String tob_cd = "Q01A01";

		/***When***/
		Map<String, Object> result = bdAnalysisDao.getUpjongNames(tob_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals("음식", String.valueOf(result.get("TOP")));
		assertEquals("한식", String.valueOf(result.get("MID")));
		assertEquals("한식/백반/한정식", String.valueOf(result.get("BOT")));
		
	}
	
	
	/**
	* Method : getTobCntList_DongTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 해당 지역(동단위)안에서의 업소수 및 증감률 조회
	*/
	@Test
	public void getTobCntList_DongTest() {
		/***Given***/
		long region_cd = 3014069000L;
		String tob_cd = "Q01A01";
		
		/***When***/
		List<UpjongCntRosVo> result = bdAnalysisDao.getTobCntList_Dong(region_cd, tob_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(5, result.size());
		assertEquals(23, result.get(4).getCnt());
		
	}
	
	
	/**
	* Method : getTobCntList_GuTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석 지역의 상위지역(구단위) 안에서 업소수 및 증감률 조회
	*/
	@Test
	public void getTobCntList_GuTest() {
		/***Given***/
		long region_cd = 3014069000L;
		String tob_cd = "Q01A01";
		
		/***When***/
		List<UpjongCntRosVo> result = bdAnalysisDao.getTobCntList_Gu(region_cd, tob_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(5, result.size());
		assertEquals(1420, result.get(4).getCnt());
		
	}
	
	
	/**
	* Method : getTobCntList_SiTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석 지역의 상위지역(대전시 전체) 안에서 업소수 및 증감률 조회
	*/
	@Test
	public void getTobCntList_SiTest() {
		/***Given***/
		String tob_cd = "Q01A01";
		
		/***When***/
		List<UpjongCntRosVo> result = bdAnalysisDao.getTobCntList_Si(tob_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(5, result.size());
		assertEquals(6758, result.get(4).getCnt());
		
	}
	
	/**
	* Method : getTobSaleAndCnt_BotTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역(동단위) 내에서 선택업종(소분류)의 월별 매출건수와 매출액 및 각 요소의 증감률을 조회
	*/
	@Test
	public void getTobSaleAndCnt_BotTest() {
		/***Given***/
		long region_cd = 3014069000L;
		String tob_cd = "Q01A09";

		/***When***/
		List<SalesAndCntRosVo> result = bdAnalysisDao.getTobSaleAndCnt_Bot(region_cd, tob_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(6, result.size());
		assertEquals(2549, result.get(0).getCurSale());
		
	}
	
	/**
	* Method : getTobSaleAndCnt_BotTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역(동단위) 내에서 선택업종(중분류)의 월별 매출건수와 매출액 및 각 요소의 증감률을 조회
	*/
	@Test
	public void getTobSaleAndCnt_MidTest() {
		/***Given***/
		long region_cd = 3014069000L;
		String tob_cd = "Q01A09";

		/***When***/
		List<SalesAndCntRosVo> result = bdAnalysisDao.getTobSaleAndCnt_Mid(region_cd, tob_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(6, result.size());
		
	}
	
	/**
	* Method : getTobSaleAndCnt_BotTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역(동단위) 내에서 선택업종(대분류)의 월별 매출건수와 매출액 및 각 요소의 증감률을 조회
	*/
	@Test
	public void getTobSaleAndCnt_TopTest() {
		/***Given***/
		long region_cd = 3014069000L;
		String tob_cd = "Q01A09";

		/***When***/
		List<SalesAndCntRosVo> result = bdAnalysisDao.getTobSaleAndCnt_Top(region_cd, tob_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(6, result.size());
		
	}
	
	/**
	* Method : getRegNamesTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 :
	*/
	@Test
	public void getRegNamesTest() {
		/***Given***/
		long region_cd = 3023051000L;

		/***When***/
		Map<String, Object> result = bdAnalysisDao.getRegionNames(region_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals("오정동", (String)result.get("DONG"));
		assertEquals("대덕구", (String)result.get("GU"));
		assertEquals("대전광역시", (String)result.get("SI"));
		
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
	@Test
	public void getRegSaleAndCnt_DongTest() {
		/***Given***/
		long region_cd = 3014069000L;
		String tob_cd = "Q01A09";

		/***When***/
		List<SalesAndCntRosVo> result = bdAnalysisDao.getRegSaleAndCnt_Dong(region_cd, tob_cd);

		/***Then***/
		assertNotNull(result);
		assertEquals(6, result.size());
		
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
	@Test
	public void getRegSaleAndCnt_GuTest() {
		/***Given***/
		long region_cd = 3014069000L;
		String tob_cd = "Q01A09";
		
		/***When***/
		List<SalesAndCntRosVo> result = bdAnalysisDao.getRegSaleAndCnt_Gu(region_cd, tob_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(6, result.size());
		
	}
	
	
	/**
	* Method : getRegSaleAndCnt_Si
	* 작성자 : hs
	* 변경이력 :
	* @param tob_cd
	* @return
	* Method 설명 : 선택 업종이 분석지역(대전시 전체)내에서 월별 매출,매출건수 및 각 요소의 증감률을 조회
	*/
	@Test
	public void getRegSaleAndCnt_SiTest() {
		/***Given***/
		String tob_cd = "Q01A09";

		/***When***/
		List<SalesAndCntRosVo> result = bdAnalysisDao.getRegSaleAndCnt_Si(tob_cd);

		/***Then***/
		assertNotNull(result);
		assertEquals(6, result.size());
		
	}

	/**
	* Method : getPpgList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 성별로 나눈 지역별 유동인구 통계 및 비율 조회
	*/
	@Test
	public void getPpgListTest() {
		/***Given***/
		long region_cd = 3014069000L;

		/***When***/
		List<Map<String, Object>> result = bdAnalysisDao.getPpgList(region_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(1 , Integer.parseInt(String.valueOf(result.get(0).get("PPG_GENDER"))) );
		assertEquals(2, Integer.parseInt(String.valueOf(result.get(1).get("PPG_GENDER"))) );
		
	}

	/**
	* Method : getPpaList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 연령대별로 나눈 지역별 유동인구 통계
	*/
	@Test
	public void getPpaListTest() {
		/***Given***/
		long region_cd = 3014069000L;

		/***When***/
		List<PpaVo> result = bdAnalysisDao.getPpaList(region_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(6, result.size());
		assertEquals(10, result.get(0).getPpa_age_group());
		
	}
	
	
	/**
	* Method : getLpGenderList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 성별로 나눈 지역별 주거인구 조사 통계 및 비율 조회
	*/
	@Test
	public void getLpGenderList() {
		/***Given***/
		long region_cd = 3014069000L;

		/***When***/
		List<LpVo> result = bdAnalysisDao.getLpGenderList(region_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(1, result.get(0).getLp_gender());
		
	}
	
	/**
	* Method : getLpAgeGroupList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 연령대별로 나눈 지역별 주거인구 조사 통계 및 비율 조회
	*/
	@Test
	public void getLpAgeGroupList() {
		/***Given***/
		long region_cd = 3014069000L;

		/***When***/
		List<LpVo> result = bdAnalysisDao.getLpAgeGroupList(region_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(10, result.get(0).getLp_age_group());
		
	}
	
	/**
	* Method : getHouseHoldCnt
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 지역별 가구수와 비율(=100.0%)을 조회
	*/
	@Test
	public void getHouseHoldCnt(){
		/***Given***/
		long region_cd = 3014069000L;

		/***When***/
		Map<String, Object> result = bdAnalysisDao.getHouseHoldCnt(region_cd);

		/***Then***/
		assertNotNull(result);
		assertEquals(8589, Integer.parseInt(String.valueOf(result.get("CNT"))) );
		
	}
	
	/**
	* Method : getLpTotalCnt
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 지역별 주거인구 전체 수와 비율(=100.0%)을 조회
	*/
	@Test
	public void getLpTotalCnt() {
		/***Given***/
		long region_cd = 3014069000L;

		/***When***/
		Map<String, Object> result = bdAnalysisDao.getLpTotalCnt(region_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(27282, Integer.parseInt(String.valueOf(result.get("TOTAL"))) );
	}

	
	/**
	* Method : getWpListTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 해당 지역의 직장인구 수를 조회 (성별로 구분)
	*/
	@Test
	public void getWpListTest() {
		/***Given***/
		long region_cd = 3014069000L;

		/***When***/
		List<WpVo> result = bdAnalysisDao.getWpList(region_cd);

		/***Then***/
		assertNotNull(result);
		assertEquals(1, result.get(0).getWp_gender());
		assertEquals(2, result.get(1).getWp_gender());
		
	}
	
	
	/**
	* Method : getWpTotalCntTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 직장인구 전체수 및 비율(=100.0%) 조회
	*/
	@Test
	public void getWpTotalCntTest() {
		/***Given***/
		long region_cd = 3014069000L;

		/***When***/
		Map<String, Object> result = bdAnalysisDao.getWpTotalCnt(region_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(2492, Integer.parseInt(String.valueOf(result.get("TOTAL"))) );
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
	@Test
	public void getTobLC_tobCnt() {
		/***Given***/
		long region_cd = 3011072500L;
		String tob_cd = "Q01A08";

		/***When***/
		Map<String, Object> result = bdAnalysisDao.getTobLC_tobCnt(region_cd, tob_cd);

		/***Then***/
		logger.debug("@@@@@ result : {}", result);
		assertNotNull(result);
		assertEquals(201903, Integer.parseInt(String.valueOf(result.get("BD_DT"))) );
	
		
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
	@Test
	public void getTobLC_tobSale() {
		/***Given***/
		long region_cd = 3014057500L;
		String tob_cd = "Q01A02";

		/***When***/
		Map<String, Object> result = bdAnalysisDao.getTobLC_tobSale(region_cd, tob_cd);

		/***Then***/
		assertNotNull(result);
		assertEquals(201903, Integer.parseInt(String.valueOf(result.get("SALES_DT"))) );
		
	}

	/**
	* Method : getAptList
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 해당 분석지역 내 공동 주택 현황을 파악하기 위한 조회 쿼리문
	*/
	@Test
	public void getAptList() {
		/***Given***/
		long region_cd = 3014069000L;
		
		/***When***/
		List<ApartmentVo> result = bdAnalysisDao.getAptList(region_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(10, result.size());
		assertEquals(2892, result.get(0).getApartment_cnt());
		
	}

	/**
	* Method : insertAnalysisReport
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 사용자가 상권분석을 요청하면 분석 조건값과 사용자 정보를 report(분석이력)테이블에 insert 테스트
	*/
	@Test
	public void insertAnalysisReport() {
		/***Given***/
		long region_cd = 3011064000L;
		String tob_cd = "D01A01";
		
		ReportVo reportVo  = new ReportVo();
		reportVo.setMember_id("test01");
		reportVo.setRegion_cd(region_cd);
		reportVo.setReport_kind(1);
		reportVo.setTob_cd(tob_cd);
		
		/***When***/
		String result = bdAnalysisDao.insert_BdAnalysisReport(reportVo);
		
		/***Then***/
		assertNotNull(result);

	}
	
	/**
	* Method : getReportVoTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석 이력메뉴에서 상권분석 보고서를 재 조회 요청시 조회할 reportVo 테스트
	*/
	@Test
	public void getReportVoTest() {
		/***Given***/
		String report_cd = "report42";

		/***When***/
		ReportVo result = bdAnalysisDao.getReportVo(report_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals("report42", result.getReport_cd());
	}
	
}


