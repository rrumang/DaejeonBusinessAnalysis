package kr.or.ddit.bdAnalysis.service;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.ls.LSInput;

import kr.or.ddit.bdAnalysis.model.SalesAndCntRosVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;
import kr.or.ddit.testenv.LogicTestEnv;

public class BdAnalysisServiceTest extends LogicTestEnv{

	private static final Logger logger = LoggerFactory.getLogger(BdAnalysisServiceTest.class);
	
	@Resource(name = "bdAnalysisService")
	private IBdAnalysisService bdAnalysisService;
	
	
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
		List<RegionVo> guList = bdAnalysisService.getGuList();
		
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
		List<RegionVo> dongList = bdAnalysisService.getDongList(region_cd2);
		
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
		RegionVo regionVo = bdAnalysisService.getRegionInfo(region_cd);
		
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
		List<TobVo> topList = bdAnalysisService.getAllTopTobList();
		
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
		List<TobVo> midList = bdAnalysisService.getAllMidTobList();
		
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
		List<TobVo> botList = bdAnalysisService.getAllBotTobList();
			
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
		String resultName = bdAnalysisService.getRegionFullName(param);
		
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
		String resultName = bdAnalysisService.getTobFullName(param);
		
		/***Then***/
		assertNotNull(resultName);
		assertTrue(resultName.length() > 5);
		logger.debug("@@@@ name : {}", resultName);
		
	}
	
	/**
	* Method : getStoreCount_totalTest
	* 작성자 : hs
	* 변경이력 :
	* @param region_cd
	* @param tob_cd
	* @return
	* Method 설명 : 분석지역의 상권주요정보 테이블의 전체 데이터를 가져오는 메서드
	*/
	@Test
	public void getBdInformation() {
		/***Given***/
		long region_cd = 3011059000L;
		String tob_cd = "Q01A02";
		
		/***When***/
		Map<String, Object> resultMap = bdAnalysisService.getBdInformation(region_cd, tob_cd);
		
		/***Then***/
		assertNotNull(resultMap);
		assertEquals(115000, resultMap.get("region_extent"));
		assertEquals(325, resultMap.get("storeCnt_Food"));
		assertEquals(99, resultMap.get("storeCnt_Service"));
		assertEquals(138, resultMap.get("storeCnt_Retail"));
		assertEquals(20, resultMap.get("storeCnt_SelectedTob"));
		assertEquals(3290, resultMap.get("wpCnt"));
		assertEquals(10886, resultMap.get("lpCnt"));
		assertEquals(5710, resultMap.get("ppgCnt"));
		assertNotNull(resultMap.get("selectedTob_SalesVo"));
		
	}
	
	
	/**
	* Method : getBdRatingIndexTest
	* 작성자 : hs
	* 변경이력 :
	* Method 설명 : 분석지역의 상권평가지수 데이터를 가져오는 메서드
	*/
	@Test
	public void getBdRatingIndexTest() {
		/***Given***/
		long region_cd = 3014057500L;
		String tob_cd = "Q01A02";
		
		/***When***/
		Map<String, Object> resultMap = bdAnalysisService.getBdRatingIndex(region_cd, tob_cd);
		
		/***Then***/
		assertNotNull(resultMap);

		logger.debug("@@@@@ salesGrowthRate : {}", (float)resultMap.get("salesGrowthRate"));
		logger.debug("@@@@@ bdSalesRate : {}", (float)resultMap.get("bdSalesRate"));
		logger.debug("@@@@@ totalChangeRate : {}", (float)resultMap.get("totalChangeRate"));
		logger.debug("@@@@@ closeStoreRate : {}", (float)resultMap.get("closeStoreRate"));
		logger.debug("@@@@@ salesVolume : {}", (float)resultMap.get("salesVolume"));
		logger.debug("@@@@@ unitCost : {}", (float)resultMap.get("unitCost"));
		logger.debug("@@@@@ consumeLevel : {}", (float)resultMap.get("consumeLevel"));
		assertEquals(13f, (float)resultMap.get("salesGrowthRate"), 0.1f);
		assertEquals(2.9f, (float)resultMap.get("bdSalesRate"), 0.1f);
		assertEquals(3.4f, (float)resultMap.get("totalChangeRate"), 0.1f);
		assertEquals(7.76f, (float)resultMap.get("closeStoreRate"), 0.1f);
		assertEquals(5.6f, (float)resultMap.get("salesVolume"), 0.1f);
		assertEquals(4.4f, (float)resultMap.get("unitCost"), 0.1f);
		assertEquals(1.9f, (float)resultMap.get("consumeLevel"), 0.1f);
		
	}
	
	
	
	@Test
	public void getTobSaleAndCnt_TotalTest() {
		/***Given***/
		long region_cd = 3014069000L;
		String tob_cd = "Q01A09";


		/***When***/
		Map<String, Object> result = bdAnalysisService.getTobSaleAndCnt_Total(region_cd, tob_cd);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(6, ((List<SalesAndCntRosVo>)result.get("tobSac_Bot")).size());
		assertEquals(6, ((List<SalesAndCntRosVo>)result.get("tobSac_Mid")).size());
		assertEquals(6, ((List<SalesAndCntRosVo>)result.get("tobSac_Top")).size());
		
	}
	
}
