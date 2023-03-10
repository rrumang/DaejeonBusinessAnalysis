package kr.or.ddit.tobRecom.dao;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.or.ddit.data.model.LpVo;
import kr.or.ddit.data.model.PpaVo;
import kr.or.ddit.data.model.PpgVo;
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

@Repository
public class TobRecomDao implements ITobRecomDao {
	
	private static final Logger logger = LoggerFactory.getLogger(TobRecomDao.class);
	
	@Resource(name="sqlSession")
	private SqlSessionTemplate sqlSession;
	
	/**
	* Method : getRegion
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 업종추천시 선택할 대상지역 정보 읽어오기
	*/
	@Override
	public List<RegionVo> getRegion() {
		return sqlSession.selectList("tobRecom.getRegion");
	}
	
	/**
	* Method : getDong
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd2
	* @return
	* Method 설명 : 업종추천시 선택한 구의 동 목록 출력
	*/
	@Override
	public List<RegionVo> getDong(int region_cd2) {
		return sqlSession.selectList("tobRecom.getDong", region_cd2);
	}
	
	/**
	* Method : getGnaRank
	* 작성자 : 강민호
	* 변경이력 :
	* @param 대분류코드
	* @return 대분류에따른 중분류 리스트
	*/
	@Override
	public List<TobVo> getMidList(String tob_cd2) {
		return sqlSession.selectList("tob.getMidList",tob_cd2);
	}
	
	/**
	* Method : getInterestRegion
	* 작성자 : 박영춘
	* 변경이력 :
	* @param member_id
	* @return
	* Method 설명 : 업종추천시 저장된 관심지역이 있을 경우 해당 정보 읽어오기
	*/
	@Override
	public RegionVo getInterestRegion(String member_id) {
		return sqlSession.selectOne("tobRecom.getInterestRegion", member_id);
	}
	
	/**
	* Method : getRegion
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 지역코드에 해당하는 지역정보 객체를 반환
	*/
	@Override
	public RegionVo getRegion(long region_cd) {
		return sqlSession.selectOne("tobRecom.getOneRegion", region_cd);
	}
	
	/**
	* Method : getStData
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 매출자료를 바탕으로 기준데이터시점을 반환
	*/
	@Override
	public int getStData() {
		return sqlSession.selectOne("tobRecom.getStData");
	}
	
	/**
	* Method : getBdType
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 지역코드에 해당하는 상권유형을 반환
	*/
	@Override
	public List<Integer> getBdType(long region_cd) {
		
		// 지역코드로 JbVo형 리스트를 반환받는다
		List<JbVo> resultList = sqlSession.selectList("tobRecom.getBdType", region_cd);
		
		int food, retail, education, f, n, o, all, service;
		food = retail = education = f = n = o = all = service = 0;
		
		// 리스트에서 꺼내 계산하고 각 변수에 넣는다
		for (JbVo jbVo : resultList) {
			if(jbVo.getJbunryu().equals("D"))
				retail = jbVo.getTotal();
			else if(jbVo.getJbunryu().equals("Q"))
				food = jbVo.getTotal();
			else if(jbVo.getJbunryu().equals("R"))
				education = jbVo.getTotal();
			else if(jbVo.getJbunryu().equals("F"))
				f = jbVo.getTotal();
			else if(jbVo.getJbunryu().equals("N"))
				n = jbVo.getTotal();
			else if(jbVo.getJbunryu().equals("O"))
				o = jbVo.getTotal();
		}
		service = f + n + o + education;
		all = service + retail + food;
		
		// List<Integer>를 반환
		List<Integer> companyCount = new ArrayList<Integer>();
		companyCount.add(all);
		companyCount.add(food);
		companyCount.add(retail);
		companyCount.add(service);
		companyCount.add(education);
		
		return companyCount;
	}
	
	/**
	* Method : getRegionShare
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 동별 중분류별 점유율
	*/
	@Override
	public List<JbVo> getRegionShare(long region_cd) {
		return sqlSession.selectList("tobRecom.getRegionShare", region_cd);
	}

	/**
	* Method : getCityShare
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 시 중분류별 점유율
	*/
	@Override
	public List<JbVo> getCityShare() {
		return sqlSession.selectList("tobRecom.getCityShare");
	}

	/**
	* Method : getScale
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 동별 상권규모 조회
	*/
	@Override
	public List<JbVo> getScale() {
		return sqlSession.selectList("tobRecom.getScale");
	}
	
	/**
	* Method : getPopulationMost
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 동별 인구(고객)유형 조회
	*/
	@Override
	public Map<String, Object> getPopulationMost(long region_cd) {
		List<LpVo> lpList = sqlSession.selectList("tobRecom.getLpList", region_cd); // 동별 주거인구
		List<PpaVo> ppaList = sqlSession.selectList("tobRecom.getPpaList", region_cd); // 동별 연령대별 유동인구
		List<PpgVo> ppgList = sqlSession.selectList("tobRecom.getPpgList", region_cd); // 동별 성별 유동인구
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("lpList", lpList);
		resultMap.put("ppaList", ppaList);
		resultMap.put("ppgList", ppgList);
		
		return resultMap;
	}
	
	/**
	* Method : getSpendLevel
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 동별 소비수준 조회
	*/
	@Override
	public List<JbVo> getSpendLevel() {
		return sqlSession.selectList("tobRecom.getSpendLevel");
	}
	
	/**
	* Method : getBdTypeRank
	* 작성자 : 박영춘
	* 변경이력 :
	* @param bdTypeName
	* @return
	* Method 설명 : 중분류별 상권유형 순위
	*/
	@Override
	public List<GofVo> getBdTypeRank(String bd_type_name) {
		// 상권유형이름으로 상권유형코드 확인
		int bd_type_cd = sqlSession.selectOne("tobRecom.getBdTypeCd", bd_type_name);
		
		// 상권유형코드로 중분류별 상권유형 순위 확인
		return sqlSession.selectList("tobRecom.getBdTypeRank", bd_type_cd);
	}
	
	/**
	* Method : getGnaRank
	* 작성자 : 박영춘
	* 변경이력 :
	* @param gender
	* @param age
	* @return
	* Method 설명 : 중분류별 주 고객층 순위
	*/
	@Override
	public List<GofVo> getGnaRank(int gender, int age) {
		Map<String, Object> sMap = new HashMap<String, Object>();
		sMap.put("gender", gender);
		sMap.put("age", age);
		
		return sqlSession.selectList("tobRecom.getGnaRank", sMap);
	}

	/**
	* Method : getTobName
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 중분류코드와 이름 조회
	*/
	@Override
	public List<TobVo> getTobName() {
		return sqlSession.selectList("tobRecom.getTobName");
	}

	/**
	* Method : insertReport
	* 작성자 : 박영춘
	* 변경이력 :
	* @param reportVo
	* @return
	* Method 설명 : 분석보고서 저장
	*/
	@Override
	public String insertReport(ReportVo reportVo) {
		sqlSession.insert("tobRecom.insertReport", reportVo);
		return reportVo.getReport_cd();
	}

	/**
	* Method : insertTobRecom
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tVo
	* @return
	* Method 설명 : 업종추천결과 저장
	*/
	@Override
	public int insertTobRecom(TobRecomVo tVo) {
		return sqlSession.insert("tobRecom.insertTobRecom", tVo);
	}

	/**
	* Method : insertLAList
	* 작성자 : 박영춘
	* 변경이력 :
	* @param lVo
	* @return
	* Method 설명 : 업종별입지등급 저장
	*/
	@Override
	public int insertLAList(LocationaVo lVo) {
		return sqlSession.insert("tobRecom.insertLAList", lVo);
	}

	/**
	* Method : insertTobCompList
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tcVo
	* @return
	* Method 설명 : 상권내 밀집업종 저장
	*/
	@Override
	public int insertTobCompList(TobCompVo tcVo) {
		return sqlSession.insert("tobRecom.insertTobCompList", tcVo);
	}

	/**
	* Method : insertGofPointList
	* 작성자 : 박영춘
	* 변경이력 :
	* @param jbVo
	* @return
	* Method 설명 : 중분류별 상권적합도 우수업종 저장
	*/
	@Override
	public int insertGofPointList(JbVo jbVo) {
		return sqlSession.insert("tobRecom.insertGofPointList", jbVo);
	}
	
	/**
	 * Method : readTobRecomReport
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @param report_cd
	 * @return
	 * Method 설명 : 업종추천결과 조회
	 */
	@Override
	public TobRecomVo readTobRecomReport(String report_cd) {
		return sqlSession.selectOne("tobRecom.readTobRecomReport", report_cd);
	}
	
	/**
	 * Method : readLAList
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @param report_cd
	 * @return
	 * Method 설명 : 업종별입지등급 조회
	 */
	@Override
	public List<LocationaVo> readLAList(String report_cd) {
		return sqlSession.selectList("tobRecom.readLAList", report_cd);
	}
	
	/**
	 * Method : readTobCompList
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @param report_cd
	 * @return
	 * Method 설명 : 상권내 밀집업종 조회
	 */
	@Override
	public List<TobCompVo> readTobCompList(String report_cd) {
		return sqlSession.selectList("tobRecom.readTobCompList", report_cd);
	}
	
	/**
	 * Method : readGofPointList
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @param report_cd
	 * @return
	 * Method 설명 : 중분류별 상권적합도 우수업종 조회
	 */
	@Override
	public List<JbVo> readGofPointList(String report_cd) {
		return sqlSession.selectList("tobRecom.readGofPointList", report_cd);
	}
	
	/**
	* Method : readRegionFromReport
	* 작성자 : 박영춘
	* 변경이력 :
	* @param report_cd
	* @return
	* Method 설명 : 분석보고서에 해당하는 지역정보 조회
	*/
	@Override
	public RegionVo readRegionFromReport(String report_cd) {
		return sqlSession.selectOne("tobRecom.readRegionFromReport", report_cd);
	}

	/**
	* Method : getGofList
	* 작성자 : 박영춘
	* 변경이력 :
	* @param pageVo
	* @return
	* Method 설명 : 전체 업종적합도 분석기준 페이지 조회
	*/
	@Override
	public List<GofListVo> getGofList(PageVo pageVo) {
		return sqlSession.selectList("tobRecom.getGofList", pageVo);
	}

	/**
	* Method : getAllCnt
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 업종적합도 분석기준 전체 갯수 조회
	*/
	@Override
	public int getAllGofCnt() {
		return sqlSession.selectOne("tobRecom.getAllGofCnt");
	}

	/**
	* Method : getGofSearchList
	* 작성자 : 박영춘
	* 변경이력 :
	* @param searchMap
	* @return
	* Method 설명 : 업종명으로 검색된 분석기준 페이지 조회
	*/
	@Override
	public List<GofListVo> getGofSearchList(Map<String, Object> searchMap) {
		return sqlSession.selectList("tobRecom.getGofSearchList", searchMap);
	}

	/**
	* Method : getSearchGofCnt
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tob_name
	* @return
	* Method 설명 : 업종명으로 검색된 분석기준 전체 갯수 조회
	*/
	@Override
	public int getSearchGofCnt(String tob_name) {
		return sqlSession.selectOne("tobRecom.getSearchGofCnt", tob_name);
	}

	/**
	* Method : gofModify
	* 작성자 : 박영춘
	* 변경이력 :
	* @param glVo
	* @return
	* Method 설명 : 분석기준 수정
	*/
	@Override
	public int gofModify(GofListVo glVo) {
		int updateCnt = 0;
		
		String glVoStr = glVo.toString(); // GofListVo를 String[]로 변환
		glVoStr = glVoStr.substring(glVoStr.indexOf("["));
		glVoStr = glVoStr.substring(0, glVoStr.lastIndexOf("]"));
		String[] glVoArr = glVoStr.split(", ");
		
		for (int i = 0; i < glVoArr.length; i++) {
			int j = glVoArr[i].indexOf("=");
			glVoArr[i] = glVoArr[i].substring(j+1);
		}
		
		for (int i = 0; i < 5; i++) {
			Map<String, Object> updateMap = new HashMap<String, Object>();
			updateMap.put("code", glVo.getCode());
			updateMap.put("rank", i+1);
			updateMap.put("bdt", glVoArr[i+2]);
			updateMap.put("gna", glVoArr[i+7]);
			updateCnt += sqlSession.update("tobRecom.gofModify", updateMap);
		}
		
		return updateCnt;
	}

	/**
	* Method : getTobForInsertGof
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 분석기준에 추가할 수 있는 새 중분류 조회
	*/
	@Override
	public List<TobVo> getTobForInsertGof() {
		return sqlSession.selectList("tobRecom.getTobForInsertGof");
	}

	/**
	* Method : gofInsert
	* 작성자 : 박영춘
	* 변경이력 :
	* @param glVo
	* @return
	* Method 설명 : 업종적합도 분석기준 추가
	*/
	@Override
	public int gofInsert(GofListVo glVo) {
		int insertCnt = 0;
		
		String glVoStr = glVo.toString(); // GofListVo를 String[]로 변환
		glVoStr = glVoStr.substring(glVoStr.indexOf("["));
		glVoStr = glVoStr.substring(0, glVoStr.lastIndexOf("]"));
		String[] glVoArr = glVoStr.split(", ");
		
		for (int i = 0; i < glVoArr.length; i++) {
			int j = glVoArr[i].indexOf("=");
			glVoArr[i] = glVoArr[i].substring(j+1);
		}
		logger.debug("▶ glVoArr : {}", Arrays.toString(glVoArr));
		
		for (int i = 0; i < 5; i++) {
			Map<String, Object> insertMap = new HashMap<String, Object>();
			insertMap.put("code", glVo.getCode());
			insertMap.put("rank", i+1);
			insertMap.put("bdt", glVoArr[i+2]);
			insertMap.put("gna", glVoArr[i+7]);
			insertCnt = sqlSession.insert("tobRecom.gofInsert", insertMap);
		}
		
		return insertCnt;
	}

}
