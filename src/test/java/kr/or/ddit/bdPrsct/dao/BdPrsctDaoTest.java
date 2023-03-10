package kr.or.ddit.bdPrsct.dao;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.bdPrsct.model.BusinessmanVo;
import kr.or.ddit.bdPrsct.model.LeaseVo;
import kr.or.ddit.bdPrsct.model.PrintVo;
import kr.or.ddit.bdPrsct.model.SalesPresentVo;
import kr.or.ddit.bdPrsct.model.StoreCntVo;
import kr.or.ddit.bdPrsct.model.UtilizeVo;
import kr.or.ddit.data.model.LatLngVo;
import kr.or.ddit.data.model.StoreVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;
import kr.or.ddit.testenv.LogicTestEnv;

public class BdPrsctDaoTest extends LogicTestEnv {
	
	private static final Logger logger = LoggerFactory.getLogger(BdPrsctDaoTest.class);
	
	@Resource(name = "bdPrsctDao")
	private IBdPrsctDao bdPrsctDao;
	
	/**
	* Method : getGuListTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 전체 구 목록 조회 테스트
	*/
	@Test
	public void getGuListTest() {
		/***Given***/
		/***When***/
		List<RegionVo> guList = bdPrsctDao.getGuList();
		
		/***Then***/
		assertEquals(5, guList.size());
	}
	
	/**
	* Method : getTobCl1ListTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 대분류 목록 조회 테스트
	*/
	@Test
	public void getTobCl1ListTest() {
		/***Given***/
		/***When***/
		List<TobVo> tobList = bdPrsctDao.getTobCl1List();
		
		/***Then***/
		assertEquals(6, tobList.size());
	}
	
	/**
	* Method : getTobCl2ListTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 선택한 대분류에 해당하는 중분류 목록 조회 테스트
	*/
	@Test
	public void getTobCl2ListTest() {
		/***Given***/
		String tob_cd = "Q";

		/***When***/
		List<TobVo> tobList = bdPrsctDao.getTobCl2List(tob_cd);

		/***Then***/
		assertNotNull(tobList);
		assertTrue(tobList.get(0).getTob_cd().startsWith("Q"));
	}
	
	/**
	* Method : getBusinessPrsctTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 선택한 업종의 시 전체, 구, 동단위 반기별 업소수
	*/
	@Test
	public void getBusinessPrsctTest() {
		/***Given***/
		String tob_cd = "N01";

		/***When***/
		Map<String, Object> resultMap = bdPrsctDao.getBusinessPrsct(tob_cd);

		/***Then***/
		assertNotNull(resultMap);
		assertEquals(2, resultMap.size());
	}
	
	/**
	* Method : getSalesPrsctTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 선택한 업종의 구단위 반기별 매출액, 건단가
	*/
	@Test
	public void getSalesPrsctTest() {
		/***Given***/
		String tob_cd = "D05";
		int gu = 30110;

		/***When***/
		List<SalesPresentVo> resultList = bdPrsctDao.getSalesPrsct(tob_cd, gu);

		/***Then***/
		assertEquals(2, resultList.size());
	}
	
	/**
	* Method : getLeasePrsctTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 임대시세현황 출력
	*/
	@Test
	public void getLeasePrsctTest() {
		/***Given***/
		/***When***/
		List<LeaseVo> resultList = bdPrsctDao.getLeasePrsct();
		
		/***Then***/
		assertEquals(60, resultList.size());
	}
	
	/**
	* Method : getFcPrsctTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 창폐업률현황 출력
	*/
	@Test
	public void getFcPrsctTest() {
		/***Given***/
		/***When***/
		List<BusinessmanVo> resultList = bdPrsctDao.getFcPrsct();
		
		/***Then***/
		assertEquals(168, resultList.size());
		assertTrue(resultList.get(0).getBm_dt() == 2017);
	}
	
	/**
	* Method : getUtilizePrsctTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 선택한 업종의 구단위 분석횟수
	*/
	@Test
	public void getUtilizePrsctTest() {
		/***Given***/
		String tob_cd = "D01";
		int gu = 30110;

		/***When***/
		List<UtilizeVo> resultList = bdPrsctDao.getUtilizePrsct(tob_cd, gu);

		/***Then***/
		assertEquals(1, resultList.get(0).getRank());
	}
	
	/**
	* Method : getStoreListTest
	* 작성자 : 김환석
	* 변경이력 :
	* Method 설명 : 상권조사 페이지에서 지도 다각형 영역 안에 존재하는 상가 리스트를 조회
	*/
	@Test
	public void getStoreListTest() {
		/***Given***/
		Map<String, Object> param = new HashMap<String, Object>();
		
		LatLngVo latLngVo1 = new LatLngVo(127.4108069308224, 36.322642141385735);
		LatLngVo latLngVo2 = new LatLngVo(127.41100482706817, 36.322154824880194);
		LatLngVo latLngVo3 = new LatLngVo(127.41175765296305, 36.322368516727884);
		LatLngVo latLngVo4 = new LatLngVo(127.41211500616362, 36.32255653261157);
		LatLngVo latLngVo5 = new LatLngVo(127.41172708861409, 36.322909328877024);
		
		List<LatLngVo> list = new ArrayList<LatLngVo>();
		list.add(latLngVo1);
		list.add(latLngVo2);
		list.add(latLngVo3);
		list.add(latLngVo4);
		list.add(latLngVo5);
	
		param.put("pointList", list);
		
		/***When***/
		List<StoreVo> result = bdPrsctDao.getStoreList(param);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(66, result.size());
	
	}
	
	/**
	* Method : getStoreList_CircleTest
	* 작성자 : 김환석
	* 변경이력 :
	* Method 설명 : 상권조사 페이지에서 지도 원형 영역 안에 존재하는 상가 리스트를 조회
	*/
	@Test
	public void getStoreList_CircleTest() {
		/***Given***/
		Map<String, Object> param = new HashMap<String, Object>();
		
		LatLngVo center = new LatLngVo(127.41286884869066, 36.32314571805134);
		LatLngVo sPoint = new LatLngVo(127.4119910137857, 36.32279355516736);
		LatLngVo ePoint = new LatLngVo(127.41286884869066, 36.32349787927754);
	
		center.setLng(center.getLng() + (center.getLng()- ePoint.getLng()));
		
		param.put("center", center);
		param.put("sPoint", sPoint);
		param.put("ePoint", ePoint);
		
		/***When***/
		List<StoreVo> result = bdPrsctDao.getStoreList_Circle(param);
		
		/***Then***/
		assertNotNull(result);
		assertEquals(31, result.size());
	
	}

	
	/**
	* Method : getStoreCnt_PolygonTest
	* 작성자 : 김환석
	* 변경이력 :
	* Method 설명 : 상권조사 페이지에서 다각형 영역 안에 존재하는 상가 업소수와 업소분류명 통계리스트들을 조회
	*/
	@Test
	public void getStoreCnt_PolygonTest() {
		/***Given***/
		Map<String, Object> param = new HashMap<String, Object>();
		
		LatLngVo latLngVo1 = new LatLngVo(127.4108069308224, 36.322642141385735);
		LatLngVo latLngVo2 = new LatLngVo(127.41100482706817, 36.322154824880194);
		LatLngVo latLngVo3 = new LatLngVo(127.41175765296305, 36.322368516727884);
		LatLngVo latLngVo4 = new LatLngVo(127.41211500616362, 36.32255653261157);
		LatLngVo latLngVo5 = new LatLngVo(127.41172708861409, 36.322909328877024);
		
		List<LatLngVo> list = new ArrayList<LatLngVo>();
		list.add(latLngVo1);
		list.add(latLngVo2);
		list.add(latLngVo3);
		list.add(latLngVo4);
		list.add(latLngVo5);
	
		param.put("pointList", list);

		/***When***/
		List<StoreCntVo> result = bdPrsctDao.getStoreCnt_Polygon(param);

		/***Then***/
		assertNotNull(result);
		assertEquals(25, result.size());
		
	}
	
	/**
	* Method : getStoreCnt_CircleTest
	* 작성자 : 김환석
	* 변경이력 :
	* Method 설명 : 상권조사 페이지에서 원형 영역 안에 존재하는 상가 업소수와 업소분류명 통계리스트들을 조회
	*/
	@Test
	public void getStoreCnt_CircleTest() {
		/***Given***/
		Map<String, Object> param = new HashMap<String, Object>();
		
		LatLngVo center = new LatLngVo(127.41286884869066, 36.32314571805134);
		LatLngVo sPoint = new LatLngVo(127.4119910137857, 36.32279355516736);
		LatLngVo ePoint = new LatLngVo(127.41286884869066, 36.32349787927754);
	
		center.setLng(center.getLng() + (center.getLng()- ePoint.getLng()));
		
		param.put("center", center);
		param.put("sPoint", sPoint);
		param.put("ePoint", ePoint);


		/***When***/
		List<StoreCntVo> result = bdPrsctDao.getStoreCnt_Circle(param);

		/***Then***/
		assertNotNull(result);
		assertEquals(17, result.size());
		
	}
	
	
}
