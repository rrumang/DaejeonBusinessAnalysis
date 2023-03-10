package kr.or.ddit.tobRecom.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.locationAnalysis.model.LocationaVo;
import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;
import kr.or.ddit.tobRecom.model.GofListVo;
import kr.or.ddit.tobRecom.model.GofVo;
import kr.or.ddit.tobRecom.model.JbVo;
import kr.or.ddit.tobRecom.model.TobCompVo;
import kr.or.ddit.tobRecom.model.TobRecomVo;

public interface ITobRecomDao {
	
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
	List<Integer> getBdType(long region_cd);
	
	/**
	* Method : getRegionShare
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 동별 중분류별 점유율
	*/
	List<JbVo> getRegionShare(long region_cd);
	
	/**
	* Method : getCityShare
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 시 중분류별 점유율
	*/
	List<JbVo> getCityShare();
	
	/**
	* Method : getScale
	* 작성자 : 박영춘
	* 변경이력 :
	* @param 
	* @return
	* Method 설명 : 동별 상권규모 조회
	*/
	List<JbVo> getScale();
	
	/**
	* Method : getPopulationMost
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 동별 인구(고객)유형 조회
	*/
	Map<String, Object> getPopulationMost(long region_cd);
	
	/**
	* Method : getSpendLevel
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 동별 소비수준 조회
	*/
	List<JbVo> getSpendLevel();
	
	/**
	* Method : getBdTypeRank
	* 작성자 : 박영춘
	* 변경이력 :
	* @param bd_type_name
	* @return
	* Method 설명 : 중분류별 상권유형 순위
	*/
	List<GofVo> getBdTypeRank(String bd_type_name);
	
	/**
	* Method : getGnaRank
	* 작성자 : 박영춘
	* 변경이력 :
	* @param gender
	* @param age
	* @return
	* Method 설명 : 중분류별 주 고객층 순위
	*/
	List<GofVo> getGnaRank(int gender, int age);
	
	/**
	* Method : getTobName
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 중분류코드와 이름 조회
	*/
	List<TobVo> getTobName();
	
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
	 * Method : readTobRecomReport
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @param report_cd
	 * @return
	 * Method 설명 : 업종추천결과 조회
	 */
	TobRecomVo readTobRecomReport(String report_cd);
	
	/**
	 * Method : readLAList
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @param report_cd
	 * @return
	 * Method 설명 : 업종별입지등급 조회
	 */
	List<LocationaVo> readLAList(String report_cd);
	
	/**
	 * Method : readTobCompList
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @param report_cd
	 * @return
	 * Method 설명 : 상권내 밀집업종 조회
	 */
	List<TobCompVo> readTobCompList(String report_cd);
	
	/**
	 * Method : readGofPointList
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @param report_cd
	 * @return
	 * Method 설명 : 중분류별 상권적합도 우수업종 조회
	 */
	List<JbVo> readGofPointList(String report_cd);
	
	/**
	* Method : getGnaRank
	* 작성자 : 강민호
	* 변경이력 :
	* @param 대분류코드
	* @return 대분류에따른 중분류 리스트
	*/
	List<TobVo> getMidList(String tob_cd2);

	/**
	* Method : readRegionFromReport
	* 작성자 : 박영춘
	* 변경이력 :
	* @param report_cd
	* @return
	* Method 설명 : 분석보고서에 해당하는 지역정보 조회
	*/
	RegionVo readRegionFromReport(String report_cd);

	/**
	* Method : getGofList
	* 작성자 : 박영춘
	* 변경이력 :
	* @param pageVo
	* @return
	* Method 설명 : 전체 업종적합도 분석기준 페이지 조회
	*/
	List<GofListVo> getGofList(PageVo pageVo);

	/**
	* Method : getAllCnt
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 업종적합도 분석기준 전체 갯수 조회
	*/
	int getAllGofCnt();

	/**
	* Method : getGofSearchList
	* 작성자 : 박영춘
	* 변경이력 :
	* @param searchMap
	* @return
	* Method 설명 : 업종명으로 검색된 분석기준 페이지 조회
	*/
	List<GofListVo> getGofSearchList(Map<String, Object> searchMap);

	/**
	* Method : getSearchGofCnt
	* 작성자 : 박영춘
	* 변경이력 :
	* @param string
	* @return
	* Method 설명 : 업종명으로 검색된 분석기준 전체 갯수 조회
	*/
	int getSearchGofCnt(String tob_name);

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
	* @return
	* Method 설명 : 업종적합도 분석기준 추가
	*/
	int gofInsert(GofListVo glVo);

}
