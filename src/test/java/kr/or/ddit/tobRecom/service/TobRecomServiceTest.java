package kr.or.ddit.tobRecom.service;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.testenv.LogicTestEnv;
import kr.or.ddit.tobRecom.model.GofListVo;
import kr.or.ddit.tobRecom.model.JbVo;
import kr.or.ddit.tobRecom.model.TobCompVo;

public class TobRecomServiceTest extends LogicTestEnv{
	
	private static final Logger logger = LoggerFactory.getLogger(TobRecomServiceTest.class);
	
	@Resource(name="tobRecomService")
	private ITobRecomService tobRecomService;
	
	/**
	* Method : getRegionTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 업종추천시 선택할 대상지역 정보 읽어오기 테스트
	*/
	@Test
	public void getRegionTest() {
		/***Given***/
		/***When***/
		List<RegionVo> regionList = tobRecomService.getRegion();
		
		/***Then***/
		assertEquals(84, regionList.size());
	}
	
	/**
	* Method : getDongTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 업종추천시 선택한 구의 동 목록 출력 테스트
	*/
	@Test
	public void getDongTest() {
		/***Given***/
		int region_cd2 = 30200;

		/***When***/
		List<RegionVo> dongList = tobRecomService.getDong(region_cd2);

		/***Then***/
		assertEquals(11, dongList.size());
	}
	
	/**
	* Method : getInterestRegion
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 업종추천시 저장된 관심지역 정보 읽어오기 테스트
	*/
	@Test
	public void getInterestRegionTest() {
		/***Given***/
		String member_id = "testid";

		/***When***/
		RegionVo regionVo = tobRecomService.getInterestRegion(member_id);

		/***Then***/
		assertEquals(30110, regionVo.getRegion_cd2());
	}
	
	/**
	* Method : getRegionOneTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 지역코드에 해당하는 지역정보 객체 반환 테스트
	*/
	@Test
	public void getRegionOneTest() {
		/***Given***/
		long region_cd = 3014062000L;
		
		/***When***/
		RegionVo regionVo = tobRecomService.getRegion(region_cd);

		/***Then***/
		assertNotNull(regionVo);
		assertEquals("석교동", regionVo.getRegion_name());
	}
	
	/**
	* Method : getStDataTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 매출자료를 바탕으로 기준데이터시점 반환 테스트
	*/
	@Test
	public void getStDataTest() {
		/***Given***/
		/***When***/
		int stData = tobRecomService.getStData();
		
		/***Then***/
		assertEquals(201904, stData);
	}
	
	/**
	* Method : getBdTypeTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 지역코드에 해당하는 상권유형 반환 테스트
	*/
	@Test
	public void getBdTypeTest() {
		/***Given***/
		long region_cd = 3011069500L;

		/***When***/
		Map<String, Object> resultMap = tobRecomService.getBdType(region_cd);

		/***Then***/
		assertNotNull(resultMap);
		assertEquals("유통형", resultMap.get("btype"));
		assertEquals(48, resultMap.get("retailPercent"));
	}
	
	/**
	* Method : getTobCompTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 평균 업종구성비 대비 상권 내 밀집업종 테스트
	*/
	@Test
	public void getTobCompTest() {
		/***Given***/
		long region_cd = 3011069500L;

		/***When***/
		Map<String, Object> resultMap = tobRecomService.getTobComp(region_cd);

		/***Then***/
		assertEquals(3, resultMap.size());
		assertNotNull(resultMap.get("fList"));
	}
	
	/**
	* Method : getScaleTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 동별 상권규모 조회 테스트
	*/
	@Test
	public void getScaleTest() {
		/***Given***/
		long region_cd = 3017064000L;
		
		/***When***/
		int result = tobRecomService.getScale(region_cd);

		/***Then***/
		assertEquals(1, result);
	}
	
	/**
	* Method : getPopulationMostTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 동별 인구(고객) 유형 조회 테스트
	*/
	@Test
	public void getPopulationMostTest() {
		/***Given***/
		long region_cd = 3020053000L;

		/***When***/
		List<Integer> resultList = tobRecomService.getPopulationMost(region_cd);

		/***Then***/
		assertNotNull(resultList);
		assertEquals(2, resultList.size());
		assertTrue(resultList.get(0) == 1 || resultList.get(0) == 2);
	}
	
	/**
	* Method : getSpendLevelTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 동별 소비수준 조회 테스트
	*/
	@Test
	public void getSpendLevelTest() {
		/***Given***/
		long region_cd = 3011072500L;
		
		/***When***/
		int result = tobRecomService.getSpendLevel(region_cd);
		
		/***Then***/
		assertEquals(5, result);
	}
	
	/**
	* Method : getGofPointTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 업종(중분류)별 적합도 테스트
	*/
	@Test
	public void getGofPointTest() {
		/***Given***/
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("btype", "복합형");
		paramMap.put("gender", 2);
		paramMap.put("age", 50);
		paramMap.put("region_cd", 3020053000L);

		/***When***/
		List<JbVo> resultList = tobRecomService.getGofPoint(paramMap);

		/***Then***/
		assertNotNull(resultList);
	}
	
	/**
	* Method : gofListTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 업종적합도 분석기준 조회 테스트
	*/
	@Test
	public void gofListTest() {
		/***Given***/
		PageVo pageVo = new PageVo(1, 10);

		/***When***/
		Map<String, Object> resultMap = tobRecomService.gofList(pageVo);
		int paginationSize = (int) resultMap.get("paginationSize");
		List<GofListVo> gofList = (List<GofListVo>) resultMap.get("gofList");
		
		/***Then***/
		assertEquals(5, paginationSize);
		assertEquals(10, gofList.size());
	}
	
	/**
	* Method : gofSearchListTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 업종명으로 검색된 분석기준 페이지 조회 테스트
	*/
	@Test
	public void gofSearchListTest() {
		/***Given***/
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("page", 1);
		searchMap.put("pageSize", 10);
		searchMap.put("tob_name", "의류");

		/***When***/
		Map<String, Object> resultMap = tobRecomService.gofSearchList(searchMap);
		int paginationSize = (int) resultMap.get("paginationSize");
		List<GofListVo> glList = (List<GofListVo>) resultMap.get("gofList");
		
		/***Then***/
		assertEquals(1, paginationSize);
		assertEquals(1, glList.size());
	}
	
}
