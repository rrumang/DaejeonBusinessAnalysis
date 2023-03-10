package kr.or.ddit.bdPrsct.service;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.ddit.bdPrsct.model.BusinessmanVo;
import kr.or.ddit.bdPrsct.model.LeaseVo;
import kr.or.ddit.bdPrsct.model.PrintVo;
import kr.or.ddit.bdPrsct.model.SalesPresentVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;
import kr.or.ddit.testenv.LogicTestEnv;

public class BdPrsctServiceTest extends LogicTestEnv{
	
	private static final Logger logger = LoggerFactory.getLogger(BdPrsctServiceTest.class);
	
	@Resource(name = "bdPrsctService")
	private IBdPrsctService bdPrsctService;
	
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
		List<RegionVo> guList = bdPrsctService.getGuList();
		
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
		List<TobVo> tobList = bdPrsctService.getTobCl1List();
		
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
		String tob_cd = "R";

		/***When***/
		List<TobVo> tobList = bdPrsctService.getTobCl2List(tob_cd);
		
		/***Then***/
		assertEquals(5, tobList.size());
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
		String tob_cd = "D08";
		int gu = 30140;

		/***When***/
		List<PrintVo> bpList = bdPrsctService.getBusinessPrsct(tob_cd, gu);

		/***Then***/
		assertEquals(168, bpList.size());
	}
	
	/**
	* Method : getSalesPrsctTest
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 선택한 업종의 구단위 반기별 매출액, 건단가 테스트
	*/
	@Test
	public void getSalesPrsctTest() {
		/***Given***/
		String tob_cd = "Q01";
		int gu = 30110;

		/***When***/
		List<SalesPresentVo> resultList = bdPrsctService.getSalesPrsct(tob_cd, gu);

		/***Then***/
		assertEquals(2, resultList.size());
		
	}
	
	/**
	* Method : getLeasePrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 임대시세현황 출력
	*/
	@Test
	public void getLeasePrsct() {
		/***Given***/
		/***When***/
		List<LeaseVo> resultList = bdPrsctService.getLeasePrsct();
		
		/***Then***/
		assertEquals("노은", resultList.get(0).getLeasearea());
	}
	
	/**
	* Method : getFcPrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* Method 설명 : 창폐업률현황 출력
	*/
	@Test
	public void getFcPrsct() {
		/***Given***/
		/***When***/
		List<BusinessmanVo> resultList = bdPrsctService.getFcPrsct();
		
		/***Then***/
		assertNotNull(resultList);
		assertEquals(3, resultList.get(resultList.size()-1).getBm_cl());
	}

}
