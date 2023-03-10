package kr.or.ddit.tobRecom.dao;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;
import kr.or.ddit.testenv.LogicTestEnv;
import kr.or.ddit.tobRecom.model.GofListVo;
import kr.or.ddit.tobRecom.model.GofVo;
import kr.or.ddit.tobRecom.model.JbVo;

public class TobRecomDaoTest extends LogicTestEnv{
	
	private static final Logger logger = LoggerFactory.getLogger(TobRecomDaoTest.class);
	
	@Resource(name="tobRecomDao")
	private ITobRecomDao tobRecomDao;
	
	/**
	* Method : getRegionTest
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 업종추천시 선택할 대상지역 정보 읽어오기 테스트
	*/
	@Test
	public void getRegionTest() {
		/***Given***/
		/***When***/
		List<RegionVo> regionList = tobRecomDao.getRegion();
		
		/***Then***/
		assertNotNull(regionList);
		assertEquals(84, regionList.size());
	}
	
	/**
	* Method : getDongTest
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd2
	* @return
	* Method 설명 : 업종추천시 선택한 구의 동 목록 출력 테스트
	*/
	@Test
	public void getDongTest() {
		/***Given***/
		int region_cd2 = 30170;

		/***When***/
		List<RegionVo> dongList = tobRecomDao.getDong(region_cd2);
		
		/***Then***/
		assertNotNull(dongList);
		assertEquals(30170, dongList.get(0).getRegion_cd2());
	}
	
	/**
	* Method : getInterestRegionTest
	* 작성자 : 박영춘
	* 변경이력 :
	* @param member_id
	* @return
	* Method 설명 : 업종추천시 저장된 관심지역 정보 읽어오기 테스트
	*/
	@Test
	public void getInterestRegionTest() {
		/***Given***/
		String member_id = "ryu123";

		/***When***/
		RegionVo regionVo = tobRecomDao.getInterestRegion(member_id);

		/***Then***/
		assertNotNull(regionVo);
		assertEquals("중구", regionVo.getRegion_name());
		assertEquals("오류동", regionVo.getRn2());
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
		long region_cd = 3011064000L;

		/***When***/
		RegionVo regionVo = tobRecomDao.getRegion(region_cd);

		/***Then***/
		assertNotNull(regionVo);
		assertEquals("용전동", regionVo.getRegion_name());
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
		int stData = tobRecomDao.getStData();
		
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
		List<Integer> cCount = tobRecomDao.getBdType(region_cd);
		
		/***Then***/
		assertNotNull(cCount);
		assertEquals(607, (int)cCount.get(0));
		assertEquals(167, (int)cCount.get(1));
		assertEquals(5, cCount.size());
	}
	
	/**
	* Method : getRegionShareTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 동별 중분류별 점유율 테스트
	*/
	@Test
	public void getRegionShareTest() {
		/***Given***/
		long region_cd = 3011069500L;

		/***When***/
		List<JbVo> resultList = tobRecomDao.getRegionShare(region_cd);

		/***Then***/
		assertEquals(44, resultList.size());
	}
	
	/**
	* Method : getCityShareTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 시 중분류별 점유율 테스트
	*/
	@Test
	public void getCityShareTest() {
		/***Given***/
		/***When***/
		List<JbVo> resultList = tobRecomDao.getCityShare();
		
		/***Then***/
		assertEquals(44, resultList.size());
		assertTrue(resultList.get(0).getTob_name().equals("가구소매"));
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
		/***When***/
		List<JbVo> resultList = tobRecomDao.getScale();
		
		/***Then***/
		assertEquals(79, resultList.size());
		
	}
	
	/**
	* Method : getPopulationMostTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 동별 인구(고객)유형 조회 테스트
	*/
	@Test
	public void getPopulationMostTest() {
		/***Given***/
		long region_cd = 3011069500L;

		/***When***/
		Map<String, Object> resultMap = tobRecomDao.getPopulationMost(region_cd);

		/***Then***/
		assertEquals(3, resultMap.size());
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
		/***When***/
		List<JbVo> resultList = tobRecomDao.getSpendLevel();
		
		/***Then***/
		assertEquals(1, resultList.get(0).getRank());
		assertEquals(79, resultList.get(resultList.size()-1).getRank());
	}
	
	/**
	* Method : getBdTypeRankTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 중분류별 상권유형 순위 조회 테스트
	*/
	@Test
	public void getBdTypeRankTest() {
		/***Given***/
		String bd_type_name = "복합형";

		/***When***/
		List<GofVo> resultList = tobRecomDao.getBdTypeRank(bd_type_name);

		/***Then***/
		assertNotNull(resultList);
	}
	
	/**
	* Method : getGnaRankTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 중분류별 주 고객층 순위 조회 테스트
	*/
	@Test
	public void getGnaRankTest() {
		/***Given***/
		int gender = 1;
		int age = 30;

		/***When***/
		List<GofVo> resultList = tobRecomDao.getGnaRank(gender, age);

		/***Then***/
		assertEquals(34, resultList.size());
		assertTrue(resultList.get(0).getGof_rank() < 6);
	}
	
	/**
	* Method : getTobNameTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 중분류코드와 이름 조회 테스트
	*/
	@Test
	public void getTobNameTest() {
		/***Given***/
		/***When***/
		List<TobVo> resultList = tobRecomDao.getTobName();
		
		/***Then***/
		assertEquals(43, resultList.size());
	}
	
	/**
	* Method : insertReportTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 분석보고서 저장 테스트
	*/
	@Test
	public void insertReportTest() {
		/***Given***/
		ReportVo reportVo = new ReportVo("test01", 3011062000L); 

		/***When***/
		String report_cd = tobRecomDao.insertReport(reportVo);
		logger.debug("▶ report_cd : {}", report_cd);
		
		/***Then***/
		assertNotNull(report_cd);
		assertTrue(report_cd.startsWith("report"));
	}
	
	/**
	* Method : getGofListTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 전체 업종적합도 분석기준 페이지 조회 테스트
	*/
	@Test
	public void getGofListTest() {
		/***Given***/
		PageVo pageVo = new PageVo(1, 10);

		/***When***/
		List<GofListVo> gofList = tobRecomDao.getGofList(pageVo);

		/***Then***/
		assertEquals(10, gofList.size());
	}
	
	/**
	* Method : getAllGofCntTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 업종적합도 분석기준 전체 갯수 조회 테스트
	*/
	@Test
	public void getAllGofCntTest() {
		/***Given***/
		/***When***/
		int cnt = tobRecomDao.getAllGofCnt();

		/***Then***/
		assertEquals(43, cnt);
	}
	
	/**
	* Method : getGofSearchListTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 업종명으로 검색된 분석기준 페이지 조회 테스트
	*/
	@Test
	public void getGofSearchListTest() {
		/***Given***/
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("page", 1);
		searchMap.put("pageSize", 10);
		searchMap.put("tob_name", "소매");

		/***When***/
		List<GofListVo> resultList = tobRecomDao.getGofSearchList(searchMap);

		/***Then***/
		assertNotNull(resultList);
		assertEquals(10, resultList.size());
	}
	
	/**
	* Method : getSearchGofCntTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 업종명으로 검색된 분석기준 전체 갯수 조회 테스트
	*/
	@Test
	public void getSearchGofCntTest() {
		/***Given***/
		String tob_name = "소매";

		/***When***/
		int cnt = tobRecomDao.getSearchGofCnt(tob_name);

		/***Then***/
		assertEquals(10, cnt);
	}
	
	/**
	* Method : gofModifyTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 분석기준 수정 테스트
	*/
	@Test
	public void gofModifyTest() {
		/***Given***/
		//GofListVo glVo = new GofListVo("D05", "의복의류", "일반형", "복합형", "교육형", "음식형", "유통형", "40대 여성", "30대 남성", "40대 남성", "20대 여성", "30대 여성");
		GofListVo glVo = new GofListVo("D05", "의복의류", "유통형", "일반형", "복합형", "교육형", "음식형", "30대 여성", "40대 여성", "30대 남성", "40대 남성", "20대 여성");

		/***When***/
		int cnt = tobRecomDao.gofModify(glVo);

		/***Then***/
		assertEquals(5, cnt);
	}
	
	/**
	* Method : getTobForInsertGofTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 분석기준에 추가할 수 있는 새 중분류 조회 테스트
	*/
	@Test
	public void getTobForInsertGofTest() {
		/***Given***/
		/***When***/
		List<TobVo> resultList = tobRecomDao.getTobForInsertGof();
		
		/***Then***/
		assertEquals(0, resultList.size());
	}
	
//	@Test
//	public void 
}
