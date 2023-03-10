package kr.or.ddit.bdPrsct.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.or.ddit.bdPrsct.dao.IBdPrsctDao;
import kr.or.ddit.bdPrsct.model.BusinessmanVo;
import kr.or.ddit.bdPrsct.model.LeaseVo;
import kr.or.ddit.bdPrsct.model.PrintVo;
import kr.or.ddit.bdPrsct.model.SalesPresentVo;
import kr.or.ddit.bdPrsct.model.StoreCntVo;
import kr.or.ddit.bdPrsct.model.UtilizeVo;
import kr.or.ddit.data.model.StoreVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;

@Service
public class BdPrsctService implements IBdPrsctService {
	
	private static final Logger logger = LoggerFactory.getLogger(BdPrsctService.class);
	
	@Resource(name = "bdPrsctDao")
	private IBdPrsctDao bdPrsctDao;

	/**
	* Method : getGuList
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 전체 구 목록 조회
	*/
	@Override
	public List<RegionVo> getGuList() {
		return bdPrsctDao.getGuList();
	}

	/**
	* Method : gettobCl1List
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 대분류 목록 조회
	*/
	@Override
	public List<TobVo> getTobCl1List() {
		return bdPrsctDao.getTobCl1List();
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
		return bdPrsctDao.getTobCl2List(tob_cd);
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
	public List<PrintVo> getBusinessPrsct(String tob_cd, int gu) {
		Map<String, Object> resultMap = bdPrsctDao.getBusinessPrsct(tob_cd);
		
		List<PrintVo> businessPrsctList = (List<PrintVo>) resultMap.get("list1");
		List<PrintVo> businessPrsctList2 = (List<PrintVo>) resultMap.get("list2");
		
		int size = businessPrsctList.size();
		
		for(int i = 0 ; i < size ; i++ ) {
			businessPrsctList.get(i).setSum2(businessPrsctList2.get(i).getSum1());
			businessPrsctList.get(i).setIad(
					(((float)businessPrsctList.get(i).getSum2() - businessPrsctList.get(i).getSum1()) / businessPrsctList.get(i).getSum1()) * 100);
		}
		for(int j = businessPrsctList.size()-1 ; j >= 0 ; j--)
			if(businessPrsctList.get(j).getGucd() != 0 && businessPrsctList.get(j).getGucd() != gu) businessPrsctList.remove(j);
		
		businessPrsctList.get(0).setDong("대전광역시");
		businessPrsctList.get(1).setDong(businessPrsctList.get(1).getGu());
		businessPrsctList.remove(businessPrsctList.size()-1);
		logger.debug("▶ businessPrsctList : {}", businessPrsctList);
		
		return businessPrsctList;
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
		return bdPrsctDao.getSalesPrsct(tob_cd, gu);
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
		return bdPrsctDao.getLeasePrsct();
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
		return bdPrsctDao.getFcPrsct();
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
		return bdPrsctDao.getUtilizePrsct(tob_cd, gu);
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
		return bdPrsctDao.getStoreList(param);
	}

	@Override
	public List<StoreVo> getStoreList_Circle(Map<String, Object> param) {
		return bdPrsctDao.getStoreList_Circle(param);
	}

	@Override
	public List<StoreCntVo> getStoreCnt_Polygon(Map<String, Object> param) {
		return bdPrsctDao.getStoreCnt_Polygon(param);
	}

	@Override
	public List<StoreCntVo> getStoreCnt_Circle(Map<String, Object> param) {
		return bdPrsctDao.getStoreCnt_Circle(param);
	}

}
