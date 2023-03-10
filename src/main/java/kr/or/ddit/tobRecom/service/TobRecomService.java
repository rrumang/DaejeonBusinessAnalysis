package kr.or.ddit.tobRecom.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.or.ddit.data.model.LpVo;
import kr.or.ddit.data.model.PpaVo;
import kr.or.ddit.data.model.PpgVo;
import kr.or.ddit.locationAnalysis.model.LocationaVo;
import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;
import kr.or.ddit.tobRecom.dao.ITobRecomDao;
import kr.or.ddit.tobRecom.model.GofListVo;
import kr.or.ddit.tobRecom.model.GofVo;
import kr.or.ddit.tobRecom.model.JbVo;
import kr.or.ddit.tobRecom.model.TobCompVo;
import kr.or.ddit.tobRecom.model.TobRecomVo;

/**
* TobRecomService.java
*
* @author 박영춘
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
* 수정자 		수정내용
* ------ ------------------------
* 박영춘 		최초 생성
*
* </pre>
*/
@Service
public class TobRecomService implements ITobRecomService {
	
	private static final Logger logger = LoggerFactory.getLogger(TobRecomService.class);
	
	@Resource(name="tobRecomDao")
	private ITobRecomDao tobRecomDao;
	
	/**
	* Method : getRegion
	* 작성자 : 박영춘
	* 변경이력 :
	* @return
	* Method 설명 : 업종추천시 선택할 대상지역 정보 읽어오기
	*/
	@Override
	public List<RegionVo> getRegion() {
		List<RegionVo> regionList = new ArrayList<RegionVo>();
		regionList = tobRecomDao.getRegion();
		return regionList;
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
		List<RegionVo> dongList = new ArrayList<RegionVo>();
		dongList = tobRecomDao.getDong(region_cd2);
		return dongList;
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
		RegionVo resultVo = new RegionVo();
		resultVo = tobRecomDao.getInterestRegion(member_id);
		return resultVo;
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
		RegionVo resultVo = new RegionVo();
		resultVo = tobRecomDao.getRegion(region_cd);
		return resultVo;
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
		int stData = tobRecomDao.getStData();
		return stData;
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
	public Map<String, Object> getBdType(long region_cd) {
		
		// 데이터 읽어오기
		List<Integer> cCount = tobRecomDao.getBdType(region_cd);
		int all = cCount.get(0);
		int food = cCount.get(1);
		int retail = cCount.get(2);
		int service = cCount.get(3);
		int education = cCount.get(4);
		
		// 상권구성 퍼센트 산출
		int foodPercent = (int)(((float)food / all)*100);
		int retailPercent = (int)(((float)retail / all)*100);
		int servicePercent = (int)(((float)service / all)*100);
		
		int eduPercent = (int)(((float)education / all)*100);
		
		// 상권유형 산출
		String btype;
		if(eduPercent >= 15) btype = "교육형";
		else if(retailPercent >= 45) btype = "유통형";
		else if(foodPercent >= 45) btype = "음식형";
		else if(retailPercent >= 33) btype = "복합형";
		else btype = "일반형";
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("foodPercent", foodPercent);
		resultMap.put("retailPercent", retailPercent);
		resultMap.put("servicePercent", servicePercent);
		resultMap.put("btype", btype);
		
		return resultMap;
	}
	
	/**
	* Method : getTobComp
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 평균 업종구성비 대비 상권 내 밀집업종
	*/
	@Override
	public Map<String, Object> getTobComp(long region_cd) {
		
		List<TobCompVo> resultList = new ArrayList<TobCompVo>();
		
		// 시, 동별 중분류별 점유율을 읽어온다
		List<JbVo> rsList = tobRecomDao.getRegionShare(region_cd);
		int total = rsList.get(rsList.size()-1).getRegion_sum();
		rsList.remove(rsList.size()-1);
		
		List<JbVo> csList = tobRecomDao.getCityShare();
		int cityTotal = csList.get(csList.size()-1).getRegion_sum();
		csList.remove(csList.size()-1);
		
		// 읽어온 값을 출력 형식에 맞게 resultList에 넣는다
		for (int i = 0; i < csList.size() ; i++) {
			
			TobCompVo tcVo = new TobCompVo();
			tcVo.setTob_cd(csList.get(i).getTob_cd());
			tcVo.setTob_name(csList.get(i).getTob_name());
			
			float inD = ((float)csList.get(i).getRegion_sum() / cityTotal) * 100;
			tcVo.setInDaejeon(inD);
			
			float inR;
			for (JbVo jbVo : rsList) {
				if(jbVo.getTob_name().equals(csList.get(i).getTob_name())) {
					inR = ((float)jbVo.getRegion_sum() / total) * 100;
					tcVo.setInRegion(inR);
					tcVo.setDeviation(inR - inD);
				} 
			}
			
			resultList.add(tcVo);
		}
		
		// inRegion 기준으로 정렬한다
		Collections.sort(resultList, new Comparator<TobCompVo>() {
			@Override
			public int compare(TobCompVo t1, TobCompVo t2) {
				float in1 = t1.getInRegion();
				float in2 = t2.getInRegion();
				
				if(in1 == in2) return 0;
				else if(in1 > in2) return 1;
				else return -1;
			}
		});
		Collections.reverse(resultList);
		
		// 음식, 소매, 서비스업별 List로 분리한다
		List<TobCompVo> fList = new ArrayList<TobCompVo>();
		List<TobCompVo> rList = new ArrayList<TobCompVo>();
		List<TobCompVo> sList = new ArrayList<TobCompVo>();
		
		for(TobCompVo tVo : resultList) {
			if(tVo.getTob_cd().equals("Q")) fList.add(tVo);
			else if(tVo.getTob_cd().equals("D")) rList.add(tVo);
			else sList.add(tVo);
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("frsList", resultList);
		resultMap.put("fList", fList);
		resultMap.put("rList", rList);
		resultMap.put("sList", sList);
		
		return resultMap;
	}
	
	/**
	* Method : getScale
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 동별 상권규모 조회
	*/
	@Override
	public int getScale(long region_cd) {
		List<JbVo> resultList = tobRecomDao.getScale();
		int rank = 0;
		int rating = 0;
		for (JbVo jbVo : resultList) {
			if(jbVo.getRegion_cd() == region_cd)
				rank = jbVo.getRank();
		}
		if(rank < 9) rating = 1; 
		else if(rank < 17) rating = 2; 
		else if(rank < 25) rating = 3; 
		else if(rank < 33) rating = 4; 
		else if(rank < 41) rating = 5; 
		else if(rank < 49) rating = 6; 
		else if(rank < 57) rating = 7; 
		else if(rank < 65) rating = 8; 
		else if(rank < 73) rating = 9; 
		else rating = 10;
		
		return rating;
	}
	
	/**
	* Method : getPopulationMost
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 동별 인구(고객) 유형 조회
	*/
	@Override
	public List<Integer> getPopulationMost(long region_cd) {
		Map<String, Object> resultMap = tobRecomDao.getPopulationMost(region_cd);
		List<LpVo> lpList = (List<LpVo>) resultMap.get("lpList");
		List<PpaVo> ppaList = (List<PpaVo>) resultMap.get("ppaList");
		List<PpgVo> ppgList = (List<PpgVo>) resultMap.get("ppgList");
		
		// 주거인구 가중치 부여
		for(LpVo lpVo : lpList) {
			lpVo.setLp_cnt(lpVo.getLp_cnt() * 3);
		}
		
		// ppg_ratio를 읽어 변수에 저장
		float mRatio = (float)ppgList.get(0).getPpg_ratio() / 100;
		float wRatio = (float)ppgList.get(1).getPpg_ratio() / 100;
		
		// 더할 인구수를 int형 list에 담는다
		List<Integer> temp = new ArrayList<Integer>();
		for(int i=0 ; i < ppaList.size() ; i++) {
			temp.add((int) (ppaList.get(i).getPpa_cnt() * mRatio));
			temp.add((int) (ppaList.get(i).getPpa_cnt() * wRatio));
		}
		
		// 인구수 합산
		for(int i=0 ; i < lpList.size() ; i++) {
			lpList.get(i).setLp_cnt(lpList.get(i).getLp_cnt() + temp.get(i));
		}
		temp.clear();
		
		// lp_cnt 기준으로 정렬한다
		Collections.sort(lpList, new Comparator<LpVo>() {
			@Override
			public int compare(LpVo l1, LpVo l2) {
				float in1 = l1.getLp_cnt();
				float in2 = l2.getLp_cnt();
				
				if(in1 == in2) return 0;
				else if(in1 > in2) return 1;
				else return -1;
			}
		});
		Collections.reverse(lpList);
		
		// 가장 많은 인구 유형 구하기
		int gender = lpList.get(0).getLp_gender();
		int ageGroup = lpList.get(0).getLp_age_group();
		temp.add(gender);
		temp.add(ageGroup);
		
		return temp;
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
	public int getSpendLevel(long region_cd) {
		List<JbVo> resultList = tobRecomDao.getSpendLevel();
		int rank = 0;
		int rating = 0;
		for (JbVo jbVo : resultList) {
			if(jbVo.getRegion_cd() == region_cd)
				rank = jbVo.getRank();
		}
		if(rank < 17) rating = 1; 
		else if(rank < 33) rating = 2; 
		else if(rank < 49) rating = 3; 
		else if(rank < 65) rating = 4; 
		else rating = 5;
		
		return rating;
	}
	
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
	@Override
	public List<JbVo> getGofPoint(Map<String, Object> paramMap) {
		
		// 중분류별 상권유형 순위
		List<GofVo> bdTypeRankList = tobRecomDao.getBdTypeRank((String)paramMap.get("btype"));
		// 중분류별 주 고객층 순위
		List<GofVo> gnaRankList = tobRecomDao.getGnaRank((int)paramMap.get("gender"), (int)paramMap.get("age"));
		
		setEmptyGnaRank(bdTypeRankList, gnaRankList); // 주 고객층 데이터가 없는 중분류 처리
		
		List<JbVo> resultList = new ArrayList<JbVo>(); // 출력할 결과값을 저장할 List
		
		List<TobVo> tobName = tobRecomDao.getTobName();
		for(GofVo gofVo : bdTypeRankList) {
			resultList.add(new JbVo(gofVo.getTob_cd())); // resultList에 tob_cd세팅
		}
		
		for(int i=0 ; i < resultList.size() ; i++) {
			if(resultList.size() == tobName.size()) 
				resultList.get(i).setTob_name(tobName.get(i).getTob_name()); // resultList에 tob_name세팅
		}
		
		int gofRank = 0;
		
		// 업종구성점수
		for(JbVo jbVo : resultList) {
			for(GofVo gofVo : bdTypeRankList) {
				if(gofVo.getTob_cd().equals(jbVo.getTob_cd())) gofRank = gofVo.getGof_rank();
			}
			switch(gofRank) {
				case 1 : jbVo.setPoint(30f); break;
				case 2 : jbVo.setPoint(24f); break;
				case 3 : jbVo.setPoint(18f); break;
				case 4 : jbVo.setPoint(12f); break;
				case 5 : jbVo.setPoint(6f); break;
				default : jbVo.setPoint(0f);
			}
			gofRank = 0;
		}
		
		// 주고객층점수
		for(JbVo jbVo : resultList) {
			for(GofVo gofVo : gnaRankList) {
				if(gofVo.getTob_cd().equals(jbVo.getTob_cd())) gofRank = gofVo.getGof_rank();
			}
			switch(gofRank) {
				case 1 : jbVo.setPoint(jbVo.getPoint() + 30f); break;
				case 2 : jbVo.setPoint(jbVo.getPoint() + 25f); break;
				case 3 : jbVo.setPoint(jbVo.getPoint() + 20f); break;
				case 4 : jbVo.setPoint(jbVo.getPoint() + 15f); break;
				case 5 : jbVo.setPoint(jbVo.getPoint() + 10f); break;
				default : jbVo.setPoint(jbVo.getPoint() + 5f);
			}
			gofRank = 0;
		}
		
		// 상권규모점수
		long region_cd = (long) paramMap.get("region_cd");
		List<JbVo> gList = tobRecomDao.getScale();
		int rank = 0;
		for (JbVo jbVo : gList) {
			if(jbVo.getRegion_cd() == region_cd)
				rank = jbVo.getRank();
		}
		float bdScore = (1 - (rank / 79f)) * 18;
		
		for(JbVo jbVo : resultList) {
			jbVo.setPoint(jbVo.getPoint() + bdScore);
		}
		
		// 소비등급점수
		List<JbVo> sList = tobRecomDao.getSpendLevel();	
		int sRank = 0;
		for (JbVo jbVo : sList) {
			if(jbVo.getRegion_cd() == region_cd)
				sRank = jbVo.getRank();
		}
		float sScore = (1 - (sRank / 79f)) * 18;
		
		for(JbVo jbVo : resultList) {
			jbVo.setPoint(jbVo.getPoint() + sScore);
		}
		
		// point 기준으로 정렬한다
		Collections.sort(resultList, new Comparator<JbVo>() {
			@Override
			public int compare(JbVo j1, JbVo j2) {
				float in1 = j1.getPoint();
				float in2 = j2.getPoint();
				
				if(in1 == in2) return 0;
				else if(in1 > in2) return 1;
				else return -1;
			}
		});
		Collections.reverse(resultList);
		
		for(int i=0 ; i < resultList.size() ; i++)
			resultList.get(i).setRank(i + 1);
		
		return resultList;
	}

	/**
	* Method : setEmptyGnaRank
	* 작성자 : 박영춘
	* 변경이력 :
	* @param bdTypeRankList
	* @param gnaRankList
	* Method 설명 : 주 고객층 데이터가 없는 중분류에 지정된 값(최하위) 설정
	*/
	private void setEmptyGnaRank(List<GofVo> bdTypeRankList, List<GofVo> gnaRankList) {
		List<GofVo> tempList = new ArrayList<GofVo>();
		
		int count = 0;
		for(GofVo gofVo : bdTypeRankList) {
			for(GofVo gofVo2 : gnaRankList) {
				if(gofVo2.getTob_cd().equals(gofVo.getTob_cd())) count = 1;
			}
			if(count == 0) tempList.add(new GofVo(6, gofVo.getTob_cd(), 6, 3, 70));
			count = 0;
		}
		gnaRankList.addAll(tempList);
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
		String report_cd = tobRecomDao.insertReport(reportVo);
		return report_cd;
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
		int insertCnt = tobRecomDao.insertTobRecom(tVo);
		return insertCnt;
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
		int insertCnt = tobRecomDao.insertLAList(lVo);
		return insertCnt;
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
		int insertCnt = tobRecomDao.insertTobCompList(tcVo);
		return insertCnt;
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
		int insertCnt = tobRecomDao.insertGofPointList(jbVo);
		return insertCnt;
	}
	
	/**
	* Method : getTobRecomReport
	* 작성자 : 박영춘
	* 변경이력 :
	* @param report_cd
	* @return
	* Method 설명 : 저장된 업종추천 분석보고서 조회
	*/
	@Override
	public Map<String, Object> getTobRecomReport(String report_cd) {
		Map<String, Object> reportMap = new HashMap<String, Object>();
		
		RegionVo regionVo = tobRecomDao.readRegionFromReport(report_cd); // 분석 대상 지역정보
		
		TobRecomVo tobRecomVo = tobRecomDao.readTobRecomReport(report_cd); // 업종추천 분석결과
		
		List<LocationaVo> oList = tobRecomDao.readLAList(report_cd); // 업종추천 업종별입지등급
		
		List<TobCompVo> frsList = tobRecomDao.readTobCompList(report_cd); // 상권내 밀집업종
		
		List<JbVo> gofPointList = tobRecomDao.readGofPointList(report_cd); // 중분류별 상권적합도 우수업종
		
		reportMap.put("regionVo", regionVo);
		reportMap.put("tobRecomVo", tobRecomVo);
		reportMap.put("oList", oList);
		reportMap.put("frsList", frsList);
		reportMap.put("gofPointList", gofPointList);
		
		return reportMap;
	}
	
	/**
	* Method : gofList
	* 작성자 : 박영춘
	* 변경이력 :
	* @param pageVo
	* @return
	* Method 설명 : 업종적합도 분석기준 조회
	*/
	@Override
	public Map<String, Object> gofList(PageVo pageVo) {
		List<GofListVo> gofList = tobRecomDao.getGofList(pageVo);
		int cnt = tobRecomDao.getAllGofCnt();
		int paginationSize = (int) Math.ceil((double) cnt / pageVo.getPageSize());
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("paginationSize", paginationSize);
		resultMap.put("gofList", gofList);
		
		return resultMap;
	}
	
	/**
	* Method : gofSearchList
	* 작성자 : 박영춘
	* 변경이력 :
	* @param searchMap
	* @return
	* Method 설명 : 업종명으로 검색된 분석기준 페이지 조회
	*/
	@Override
	public Map<String, Object> gofSearchList(Map<String, Object> searchMap) {
		List<GofListVo> gofList = tobRecomDao.getGofSearchList(searchMap);
		int cnt = tobRecomDao.getSearchGofCnt((String)searchMap.get("tob_name"));
		int paginationSize = (int) Math.ceil((double) cnt / (int) searchMap.get("pageSize"));
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("paginationSize", paginationSize);
		resultMap.put("gofList", gofList);
		
		return resultMap;
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
		return tobRecomDao.gofModify(glVo);
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
		return tobRecomDao.getTobForInsertGof();
	}
	
	/**
	* Method : gofInsert
	* 작성자 : 박영춘
	* 변경이력 :
	* @param glVo
	* Method 설명 : 업종적합도 분석기준 추가
	*/
	@Override
	public int gofInsert(GofListVo glVo) {
		return tobRecomDao.gofInsert(glVo);
	}
	
	@Override
	public List<TobVo> getMidList(String tob_cd2) {
		return tobRecomDao.getMidList(tob_cd2);
	}


}
