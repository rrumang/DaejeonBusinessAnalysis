package kr.or.ddit.tobRecom.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.locationAnalysis.model.LocationaVo;
import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;
import kr.or.ddit.tobRecom.model.GofListVo;
import kr.or.ddit.tobRecom.model.JbVo;
import kr.or.ddit.tobRecom.model.TobCompVo;
import kr.or.ddit.tobRecom.model.TobRecomVo;

public interface ITobRecomService {
	
	/**
	* Method : getRegion
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 업종추천시 선택할 대상지역 정보 읽어오기
	*/
	List<RegionVo> getRegion();
	
	/**
	* Method : getDong
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd2
	* @return
	* Method 설명 : 업종추천시 선택한 구의 동 목록 출력
	*/
	List<RegionVo> getDong(int region_cd2);
	
	/**
	* Method : getInterestRegion
	* 작성자 : 박영춘
	* 변경이력 :
	* @param member_id
	* @return
	* Method 설명 : 업종추천시 저장된 관심지역이 있을 경우 해당 정보 읽어오기
	*/
	RegionVo getInterestRegion(String member_id);
	
	/**
	* Method : getRegion
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 지역코드에 해당하는 지역정보 객체를 반환
	*/
	RegionVo getRegion(long region_cd);
	
	/**
	* Method : getStData
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 매출자료를 바탕으로 기준데이터시점을 반환
	*/
	int getStData();
	
	/**
	* Method : getBdType
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 지역코드에 해당하는 상권유형을 반환
	*/
	Map<String, Object> getBdType(long region_cd);
	
	/**
	* Method : getTobComp
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 평균 업종구성비 대비 상권 내 밀집업종
	*/
	Map<String, Object> getTobComp(long region_cd);
	
	/**
	* Method : getScale
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 동별 상권규모 조회
	*/
	int getScale(long region_cd);
	
	/**
	* Method : getPopulationMost
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 동별 인구(고객) 유형 조회
	*/
	List<Integer> getPopulationMost(long region_cd);
	
	/**
	* Method : getSpendLevel
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 동별 소비수준 조회
	*/
	int getSpendLevel(long region_cd);
	
	/**
	* Method : getGofPoint
	* 작성자 : 박영춘
	* 변경이력 :
	* @param btype
	* @param gender
	* @param age
	* @return
	* Method 설명 : 업종(중분류)별 적합도
	*/
	List<JbVo> getGofPoint(Map<String, Object> paramMap);
	
	/**
	* Method : insertReport
	* 작성자 : 박영춘
	* 변경이력 :
	* @param reportVo
	* @return
	* Method 설명 : 분석보고서 저장
	*/
	String insertReport(ReportVo reportVo);
	
	/**
	* Method : insertTobRecom
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tVo
	* @return
	* Method 설명 : 업종추천결과 저장
	*/
	int insertTobRecom(TobRecomVo tVo);
	
	/**
	* Method : insertLAList
	* 작성자 : 박영춘
	* 변경이력 :
	* @param lVo
	* @return
	* Method 설명 : 업종별입지등급 저장
	*/
	int insertLAList(LocationaVo lVo);
	
	/**
	* Method : insertTobCompList
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tcVo
	* @return
	* Method 설명 : 상권내 밀집업종 저장
	*/
	int insertTobCompList(TobCompVo tcVo);
	
	/**
	* Method : insertGofPointList
	* 작성자 : 박영춘
	* 변경이력 :
	* @param jbVo
	* @return
	* Method 설명 : 중분류별 상권적합도 우수업종 저장
	*/
	int insertGofPointList(JbVo jbVo);
	
	/**
	* Method : getTobRecomReport
	* 작성자 : 박영춘
	* 변경이력 :
	* @param report_cd
	* @return
	* Method 설명 : 저장된 업종추천 분석보고서 조회
	*/
	Map<String, Object> getTobRecomReport(String report_cd);
	
	/**
	 * Method : gofList
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @param pageVo
	 * @return
	 * Method 설명 : 업종적합도 분석기준 조회
	 */
	Map<String, Object> gofList(PageVo pageVo);
	
	/**
	 * Method : gofSearchList
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @param searchMap
	 * @return
	 * Method 설명 : 업종명으로 검색된 분석기준 페이지 조회
	 */
	Map<String, Object> gofSearchList(Map<String, Object> searchMap);
	
	/**
	 * Method : gofModify
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @param glVo
	 * @return
	 * Method 설명 : 분석기준 수정
	 */
	int gofModify(GofListVo glVo);
	
	/**
	 * Method : getTobForInsertGof
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @return
	 * Method 설명 : 분석기준에 추가할 수 있는 새 중분류 조회
	 */
	List<TobVo> getTobForInsertGof();
	
	/**
	 * Method : gofInsert
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @param glVo
	 * Method 설명 : 업종적합도 분석기준 추가
	 */
	int gofInsert(GofListVo glVo);
	
	/**
	* Method : getGnaRank
	* 작성자 : 강민호
	* 변경이력 :
	* @param 대분류코드
	* @return 대분류에따른 중분류 리스트
	*/
	List<TobVo> getMidList(String tob_cd2);

}
