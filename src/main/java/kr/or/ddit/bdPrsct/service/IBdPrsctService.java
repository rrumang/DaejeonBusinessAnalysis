package kr.or.ddit.bdPrsct.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.bdPrsct.model.BusinessmanVo;
import kr.or.ddit.bdPrsct.model.LeaseVo;
import kr.or.ddit.bdPrsct.model.PrintVo;
import kr.or.ddit.bdPrsct.model.SalesPresentVo;
import kr.or.ddit.bdPrsct.model.StoreCntVo;
import kr.or.ddit.bdPrsct.model.UtilizeVo;
import kr.or.ddit.data.model.StoreVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;

public interface IBdPrsctService {

	/**
	* Method : getGuList
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 전체 구 목록 조회
	*/
	List<RegionVo> getGuList();

	/**
	* Method : gettobCl1List
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 대분류 목록 조회
	*/
	List<TobVo> getTobCl1List();

	/**
	* Method : getTobCl2List
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tob_cd
	* @return
	* Method 설명 : 선택한 대분류에 해당하는 중분류 목록 조회
	*/
	List<TobVo> getTobCl2List(String tob_cd);
	
	/**
	* Method : getBusinessPrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tob_cd
	* @return
	* Method 설명 : 선택한 업종의 시 전체, 구, 동단위 반기별 업소수
	*/
	List<PrintVo> getBusinessPrsct(String tob_cd, int gu);

	/**
	* Method : getSalesPrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tob_cd
	* @param gu
	* @return
	* Method 설명 : 선택한 업종의 구단위 반기별 매출액, 건단가
	*/
	List<SalesPresentVo> getSalesPrsct(String tob_cd, int gu);

	/**
	* Method : getLeasePrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 임대시세현황 출력
	*/
	List<LeaseVo> getLeasePrsct();
	
	/**
	* Method : getFcPrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 창폐업률현황 출력
	*/
	List<BusinessmanVo> getFcPrsct();
	
	/**
	* Method : getUtilizePrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tob_cd
	* @param gu
	* @return
	* Method 설명 : 선택한 업종의 구단위 분석횟수
	*/
	List<UtilizeVo> getUtilizePrsct(String tob_cd, int gu);
	
	/**
	* Method : getStoreList
	* 작성자 : 김환석
	* 변경이력 :
	* @param param
	* @return
	* Method 설명 : 상권조사 페이지에서 지도 다각형 영역 안에 존재하는 상가 리스트를 조회
	*/
	public List<StoreVo> getStoreList(Map<String, Object> param);
	
	
	/**
	* Method : getStoreList_Circle
	* 작성자 : hs
	* 변경이력 :
	* @param param
	* @return
	* Method 설명 : 상권조사 페이지에서 지도 원형 영역 안에 존재하는 상가 리스트를 조회
	*/
	public List<StoreVo> getStoreList_Circle(Map<String, Object> param);
	
	
	/**
	* Method : getStoreCnt_Polygon
	* 작성자 : hs
	* 변경이력 :
	* @param param
	* @return
	* Method 설명 : 상권조사 페이지에서 다각형 영역 안에 존재하는 상가 업소수와 업소분류명 통계리스트들을 조회
	*/
	public List<StoreCntVo> getStoreCnt_Polygon(Map<String, Object> param);
	

	/**
	* Method : getStoreCnt_Circle
	* 작성자 : hs
	* 변경이력 :
	* @param param
	* @return
	* Method 설명 : 상권조사 페이지에서 원형 영역 안에 존재하는 상가 업소수와 업소분류명 통계리스트들을 조회
	*/
	public List<StoreCntVo> getStoreCnt_Circle(Map<String, Object> param);

	
}
