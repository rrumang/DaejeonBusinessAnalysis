package kr.or.ddit.bdPrsct.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.or.ddit.bdPrsct.model.BusinessmanVo;
import kr.or.ddit.bdPrsct.model.LeaseVo;
import kr.or.ddit.bdPrsct.model.PrintVo;
import kr.or.ddit.bdPrsct.model.SalesPresentVo;
import kr.or.ddit.bdPrsct.model.StoreCntVo;
import kr.or.ddit.bdPrsct.model.UtilizeVo;
import kr.or.ddit.data.model.StoreVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;

@Repository
public class BdPrsctDao implements IBdPrsctDao{
	
	private static final Logger logger = LoggerFactory.getLogger(BdPrsctDao.class);
	
	@Resource(name = "sqlSession")
	private SqlSessionTemplate sqlSession;

	/**
	* Method : getGuList
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 전체 구 목록 조회
	*/
	@Override
	public List<RegionVo> getGuList() {
		return sqlSession.selectList("bdPrsct.getGuList");
	}

	/**
	* Method : getTobCl1List
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 대분류 목록 조회
	*/
	@Override
	public List<TobVo> getTobCl1List() {
		return sqlSession.selectList("bdPrsct.getTobCl1List");
	}

	/**
	* Method : getTobCl2List
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tob_cd
	* @return
	* Method 설명 : 선택한 대분류에 해당하는 중분류 목록 조회
	*/
	@Override
	public List<TobVo> getTobCl2List(String tob_cd) {
		return sqlSession.selectList("bdPrsct.getTobCl2List", tob_cd);
	}

	/**
	* Method : getBusinessPrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tob_cd
	* @return
	* Method 설명 : 선택한 업종의 시 전체, 구, 동단위 반기별 업소수
	*/
	@Override
	public Map<String, Object> getBusinessPrsct(String tob_cd) {
		List<PrintVo> list1 = sqlSession.selectList("bdPrsct.getBusinessPrsct", tob_cd);
		List<PrintVo> list2 = sqlSession.selectList("bdPrsct.getBusinessPrsct2", tob_cd);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list1", list1);
		resultMap.put("list2", list2);
		
		return resultMap;
	}

	/**
	* Method : getSalesPrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tob_cd
	* @param gu
	* @return
	* Method 설명 : 선택한 업종의 구단위 반기별 매출액, 건단가
	*/
	@Override
	public List<SalesPresentVo> getSalesPrsct(String tob_cd, int gu) {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("tob_cd", tob_cd);
		searchMap.put("gu", gu);
		return sqlSession.selectList("bdPrsct.getSalesPrsct", searchMap);
	}

	/**
	* Method : getLeasePrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 임대시세현황 출력
	*/
	@Override
	public List<LeaseVo> getLeasePrsct() {
		return sqlSession.selectList("bdPrsct.getLeasePrsct");
	}

	/**
	* Method : getFcPrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 창폐업률현황 출력
	*/
	@Override
	public List<BusinessmanVo> getFcPrsct() {
		return sqlSession.selectList("bdPrsct.getFcPrsct");
	}

	/**
	* Method : getUtilizePrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tob_cd
	* @param gu
	* @return
	* Method 설명 : 선택한 업종의 구단위 분석횟수
	*/
	@Override
	public List<UtilizeVo> getUtilizePrsct(String tob_cd, int gu) {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("tob_cd", tob_cd);
		searchMap.put("gu", gu);
		return sqlSession.selectList("bdPrsct.getUtilizePrsct", searchMap);
	}
	
	/**
	* Method : getStoreList
	* 작성자 : 김환석
	* 변경이력 :
	* @param param
	* @return
	* Method 설명 : 상권조사 페이지에서 지도 다각형 영역 안에 존재하는 상가 리스트를 조회
	*/
	@Override
	public List<StoreVo> getStoreList(Map<String, Object> param) {
		List<StoreVo> storeList = sqlSession.selectList("bdInvestigate.getStoreList", param);
		return storeList;
	}

	@Override
	public List<StoreVo> getStoreList_Circle(Map<String, Object> param) {
		List<StoreVo> storeList = sqlSession.selectList("bdInvestigate.getStoreList_Circle", param);
		return storeList;
	}

	@Override
	public List<StoreCntVo> getStoreCnt_Polygon(Map<String, Object> param) {
		List<StoreCntVo> storeCntList = sqlSession.selectList("bdInvestigate.getStoreCnt_Polygon", param);
		return storeCntList;
	}

	@Override
	public List<StoreCntVo> getStoreCnt_Circle(Map<String, Object> param) {
		List<StoreCntVo> storeCntList = sqlSession.selectList("bdInvestigate.getStoreCnt_Circle", param);
		return storeCntList;
	}

	
}
