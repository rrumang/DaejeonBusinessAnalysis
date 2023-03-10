package kr.or.ddit.tobRecom.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.locationAnalysis.controller.MakeExcel;
import kr.or.ddit.locationAnalysis.controller.locationCompare;
import kr.or.ddit.locationAnalysis.model.LocationaVo;
import kr.or.ddit.locationAnalysis.service.ILocationAnalysisService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;
import kr.or.ddit.tobRecom.model.GofListVo;
import kr.or.ddit.tobRecom.model.JbVo;
import kr.or.ddit.tobRecom.model.TobCompVo;
import kr.or.ddit.tobRecom.model.TobRecomVo;
import kr.or.ddit.tobRecom.service.ITobRecomService;

/**
* TobRecomController.java
* 업종추천 처리 컨트롤러
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
@RequestMapping("/tobRecom")
@Controller
public class TobRecomController {

	private static final Logger logger = LoggerFactory.getLogger(TobRecomController.class);

	@Resource(name = "tobRecomService")
	private ITobRecomService tobRecomService;
	
	@Resource(name="locationAnalysisService")
	private ILocationAnalysisService locationAnalysisService;

	/**
	 * Method : inputTobRecom 
	 * 작성자 : 박영춘
	 * 변경이력 :
	 * @return 
	 * Method 설명 : 업종추천 정보입력 화면 요청
	 */
	@RequestMapping(path = "/input", method = RequestMethod.GET)
	public String inputTobRecom(HttpSession session, Model model) {
		
		MemberVo memberVo = new MemberVo();
		memberVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		
		List<RegionVo> rList = tobRecomService.getRegion();
		RegionVo rVo = new RegionVo();
		
		if(memberVo == null) {
			session.setAttribute("MESSAGE", "로그인이 필요한 기능입니다.");
			return "redirect:/login";
		} else {
			rVo = tobRecomService.getInterestRegion(memberVo.getMember_id());
			if(rVo != null) model.addAttribute("interestRegion", rVo);
		}
		
		session.setAttribute("READ_TOBRECOM", "not");
		model.addAttribute("regionList", rList);
		return "tobRecom/tobRecomAdd";
	}

	/**
	 * Method : inputTobRecomDong
	 * 작성자 : 박영춘 
	 * 변경이력 :
	 * @param region_cd2
	 * @param model
	 * @return 
	 * Method 설명 : 선택한 구에 해당하는 동 목록을 출력
	 */
	@RequestMapping(path = "/inputDong", method = RequestMethod.POST)
	@ResponseBody
	public List<RegionVo> inputTobRecomDong(int region_cd2, Model model) {

		List<RegionVo> dongList = new ArrayList<RegionVo>();
		dongList = tobRecomService.getDong(region_cd2);

		model.addAttribute("data", dongList);

		return dongList;
	}
	
	/**
	* Method : laResult
	* 작성자 : 박영춘
	* 변경이력 :
	* @param dongcd
	* @param model
	* @return
	* Method 설명 : 업종추천 분석결과 출력 - 종합입지평가
	*/
	@RequestMapping(path = "/result", method = RequestMethod.GET)
	public String laResult(long dongcd, String checkRe, 
					HttpSession session, Model model, String report_cd) {
		RegionVo regionVo = tobRecomService.getRegion(dongcd);

		String regionCsc = regionVo.getRegion_csc();
		String sigu = regionCsc.substring(0, regionCsc.indexOf("구") + 1);

		StringBuffer sb = new StringBuffer(sigu);
		sb.append(" ").append(regionVo.getRegion_name());
		String addr = sb.toString(); // 출력용 주소 처리
		
		int stData = tobRecomService.getStData();
		String stDataTemp = Integer.toString(stData);
		String pre = stDataTemp.substring(0, 4);
		String suf = stDataTemp.substring(4);
		
		StringBuffer sBuffer = new StringBuffer(pre);
		sBuffer.append("년 ").append(suf).append("월");
		String stDataStr = sBuffer.toString(); // 출력용 기준데이터시점 처리 
		
		model.addAttribute("stData", stDataStr); // 기준데이터시점
		model.addAttribute("regionVo", regionVo); // 지역정보 객체
		model.addAttribute("selectAddr", addr); // 출력용 주소
		model.addAttribute("report_cd", report_cd);
		
		// 입지분석 결과----------------------------------------------------------------------------
		//대전지역의 업종별 최고 매출액(기준데이터)
		List<LocationaVo> sList = locationAnalysisService.getStandard();
		
		//해당지역의 업종별 월매출액(대상데이터)
		List<LocationaVo> oList = locationAnalysisService.getObject(regionVo.getRegion_cd());
		
		//선택지역의 업종별 입지등급 구하기
		//최고매출액의 75%이상이면 1등급, 최고매출액의 60%이하면 3등급, 중간은 2등급
		for (int i = 0; i < sList.size(); i++) {
			for(LocationaVo oVo : oList) {
				if(oVo.getTob().equals(sList.get(i).getTob())) {
					if(oVo.getMaxx() >= sList.get(i).getMaxx()*0.75) oVo.setGrade(1);
					else if(oVo.getMaxx() <= sList.get(i).getMaxx()*0.6) oVo.setGrade(3);
					else oVo.setGrade(2);
				}
			}
		}
		
		int one   = 0;   // 1등급
		int two   = 0;   // 2등급
		int three = 0;   // 3등급
		
		//산술평균 구하기
		for (int i = 0; i < oList.size(); i++) {
			if(oList.get(i).getGrade() == 1) one += oList.get(i).getGrade();
			else if(oList.get(i).getGrade() == 2) two += oList.get(i).getGrade();
			else three += oList.get(i).getGrade(); 
		}
		
		//종합입지등급
		int grade = (int) Math.round((double)(one + two + three)/oList.size());
		
		//업종별 입지등급 구하기
		//업종코드에 해당하는 업종명을 세팅
		for (int i = 0; i < oList.size(); i++) {
			oList.get(i).setTob(locationAnalysisService.getTobName(oList.get(i).getTob()));
		}
		
		//등급순으로 오름차순, 매출액으로 내림차순 정렬 
		Collections.sort(oList, new locationCompare());
		
		model.addAttribute("grade", grade); // 종합입지등급
		model.addAttribute("resultList", oList); // 업종별 입지등급
		// 입지분석 끝----------------------------------------------------------------------------
		
		if(session.getAttribute("READ_TOBRECOM") == "read") return "tobRecom/locationAppraisal"; // 업종추천 분석보고서 확인화면일 경우 다시 저장되지 않게 한다
		if(checkRe != null) return "tobRecom/locationAppraisal"; // 업종추천 보고서 내 다른 페이지에서 이동했을 경우 다시 저장되지 않게 한다
		
		// 분석결과 테이블에 저장할 데이터 처리
		Map<String, Object> sumMap = superbTobLogic(dongcd); // 2-1페이지 결과
		Map<String, Object> resultMap = (Map<String, Object>) sumMap.get("resultMap");
		
		int popNum = (int) sumMap.get("popNum");
		String gusungV = makeGusungValue(popNum);
		
		Map<String, Object> sumMap2 = totalResultLogic((String)resultMap.get("btype"), (int)sumMap.get("rating"), // 2-2페이지 결과
									  gusungV, (int)sumMap.get("spendRating"), dongcd);
		
		List<TobCompVo> frsList = (List<TobCompVo>) sumMap.get("frsList");
		List<JbVo> gofPointList = (List<JbVo>) sumMap2.get("resultList");
		
		// 업종추천 보고서 저장
		MemberVo memberVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		String member_id = memberVo.getMember_id();
		ReportVo reportVo = new ReportVo(member_id, dongcd);
		String insertReport_cd = tobRecomService.insertReport(reportVo); // 여러 데이터 저장에 사용되는 분석보고서 코드
		
		// 업종추천 저장
		TobRecomVo tVo = new TobRecomVo(insertReport_cd, addr, stData, grade, (String)resultMap.get("btype"), 
				(int)resultMap.get("foodPercent"), (int)resultMap.get("servicePercent"), (int)resultMap.get("retailPercent"), 
				(int)sumMap.get("rating"), popNum, (int)sumMap.get("spendRating"), (String)sumMap2.get("btypeInfo"));
		
		tobRecomService.insertTobRecom(tVo);
		
		// 리스트들을 저장
		for(LocationaVo lVo : oList) {
			lVo.setReport_cd(insertReport_cd);
			tobRecomService.insertLAList(lVo);
		}
		
		for(TobCompVo tcVo : frsList) {
			tcVo.setReport_cd(insertReport_cd);
			tobRecomService.insertTobCompList(tcVo);
		}
		
		for (JbVo jbVo : gofPointList) {
			jbVo.setReport_cd(insertReport_cd);
			tobRecomService.insertGofPointList(jbVo);
		}
		
		model.addAttribute("report_cd", insertReport_cd);
		
		return "tobRecom/locationAppraisal";
	}
	
	/**
	* Method : makeGusungValue
	* 작성자 : 박영춘
	* 변경이력 :
	* @param popNum
	* @return
	* Method 설명 : 상권유형(고객구성)을 출력 형식에 맞게 변환
	*/
	private String makeGusungValue(int popNum) {
		String gusungV = null;
		switch (popNum) {
			case 1: gusungV = "20대<br>남성";	break;
			case 2: gusungV = "20대<br>여성";	break;
			case 3: gusungV = "30대<br>남성";	break;
			case 4: gusungV = "30대<br>여성";	break;
			case 5: gusungV = "40대<br>남성";	break;
			case 6: gusungV = "40대<br>여성";	break;
			case 7: gusungV = "50대<br>남성";	break;
			case 8: gusungV = "50대<br>여성";	break;
			case 9: gusungV = "60대이상<br>남성"; break;
			default: gusungV = "60대이상<br>여성";
		}
		return gusungV;
	}

	/**
	* Method : superbTob
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @param model
	* @return
	* Method 설명 : 업종추천 분석결과 출력 - 상권적합도 우수업종(상권유형 판별)
	*/
	@RequestMapping(path = "/superbTob", method = RequestMethod.POST)
	public String superbTob(long region_cd, HttpSession session, /*@RequestParam(required = false) Map<String, Object> reportMap 시도했지만 전송한 Map과 다른 형태의 Map이 출력됨*/
							Model model, String report_cd) {
		
		String readTobRecom = (String) session.getAttribute("READ_TOBRECOM");
		if(readTobRecom == "read") { // 업종추천 분석보고서 확인화면일 경우
			Map<String, Object> reportMap = (Map<String, Object>) session.getAttribute("READ_TOBRECOM_MAP");
			
			logger.debug("▶ reportMap : {}", reportMap);
			
			TobRecomVo tobRecomVo = (TobRecomVo) reportMap.get("tobRecomVo");
			RegionVo regionVo = (RegionVo) reportMap.get("regionVo");
			List<TobCompVo> frsList = (List<TobCompVo>) reportMap.get("frsList");
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("foodPercent", tobRecomVo.getFoodPercent());
			resultMap.put("retailPercent", tobRecomVo.getRetailPercent());
			resultMap.put("servicePercent", tobRecomVo.getServicePercent());
			resultMap.put("btype", tobRecomVo.getBtype());
			
			model.addAttribute("resultMap", resultMap); // 1. 업종구성에 따른 상권유형
			model.addAttribute("region_cd", regionVo.getRegion_cd());
			
			List<TobCompVo> fList = new ArrayList<TobCompVo>();
			List<TobCompVo> rList = new ArrayList<TobCompVo>();
			List<TobCompVo> sList = new ArrayList<TobCompVo>();
			
			for(TobCompVo tVo : frsList) {
				if(tVo.getTob_cd().equals("Q")) fList.add(tVo);
				else if(tVo.getTob_cd().equals("D")) rList.add(tVo);
				else sList.add(tVo);
			}
			model.addAttribute("fList", fList); // 2. 평균 업종구성비 대비 상권 내 밀집업종
			model.addAttribute("rList", rList);
			model.addAttribute("sList", sList);
			
			model.addAttribute("rating", tobRecomVo.getRating()); // 3. 상권규모에 따른 상권유형
			model.addAttribute("popNum", tobRecomVo.getPopNum()); // 4. 주요 고객구성에 따른 상권유형
			model.addAttribute("spendRating", tobRecomVo.getSpendRating()); // 5. 소비수준에 따른 상권유형
			
			model.addAttribute("report_cd", report_cd);
			
			return "tobRecom/superbTob";
		}
		
		Map<String, Object> sumMap = superbTobLogic(region_cd);
		
		model.addAttribute("resultMap", sumMap.get("resultMap")); // 1. 업종구성에 따른 상권유형
		model.addAttribute("region_cd", region_cd);
		
		model.addAttribute("fList", sumMap.get("fList")); // 2. 평균 업종구성비 대비 상권 내 밀집업종
		model.addAttribute("rList", sumMap.get("rList"));
		model.addAttribute("sList", sumMap.get("sList"));
		
		model.addAttribute("rating", sumMap.get("rating")); // 3. 상권규모에 따른 상권유형
		
		model.addAttribute("popNum", sumMap.get("popNum")); // 4. 주요 고객구성에 따른 상권유형
		
		model.addAttribute("spendRating", sumMap.get("spendRating")); // 5. 소비수준에 따른 상권유형
		
		model.addAttribute("report_cd", report_cd);
		
		return "tobRecom/superbTob";
	}
	
	/**
	* Method : superbTobLogic
	* 작성자 : 박영춘
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 : 상권적합도 우수업종(상권유형 판별) 로직
	*/
	private Map<String, Object> superbTobLogic(long region_cd){
		Map<String, Object> sumMap = new HashMap<String, Object>(); // db에 저장할 분석결과를 모은 Map
		
		// 1. 업종구성에 따른 상권유형
		Map<String, Object> resultMap = tobRecomService.getBdType(region_cd);
		sumMap.put("resultMap", resultMap);
		
		// 2. 평균 업종구성비 대비 상권 내 밀집업종
		Map<String, Object> compMap = tobRecomService.getTobComp(region_cd);
		List<TobCompVo> frsList = (List<TobCompVo>) compMap.get("frsList");
		List<TobCompVo> fList = (List<TobCompVo>) compMap.get("fList");
		List<TobCompVo> rList = (List<TobCompVo>) compMap.get("rList");
		List<TobCompVo> sList = (List<TobCompVo>) compMap.get("sList");
		sumMap.put("frsList", frsList);
		sumMap.put("fList", fList);
		sumMap.put("rList", rList);
		sumMap.put("sList", sList);
		
		// 3. 상권규모에 따른 상권유형
		int rating = tobRecomService.getScale(region_cd);
		sumMap.put("rating", rating);
		
		// 4. 주요 고객구성에 따른 상권유형
		int popNum = 0;
		List<Integer> pop = tobRecomService.getPopulationMost(region_cd);
		if(pop.get(0) == 1 && pop.get(1) == 20) popNum = 1; 
		else if(pop.get(0) == 2 && pop.get(1) == 20) popNum = 2; 
		else if(pop.get(0) == 1 && pop.get(1) == 30) popNum = 3; 
		else if(pop.get(0) == 2 && pop.get(1) == 30) popNum = 4; 
		else if(pop.get(0) == 1 && pop.get(1) == 40) popNum = 5; 
		else if(pop.get(0) == 2 && pop.get(1) == 40) popNum = 6; 
		else if(pop.get(0) == 1 && pop.get(1) == 50) popNum = 7; 
		else if(pop.get(0) == 2 && pop.get(1) == 50) popNum = 8; 
		else if(pop.get(0) == 1 && pop.get(1) == 60) popNum = 9; 
		else if(pop.get(0) == 2 && pop.get(1) == 60) popNum = 10;
		
		sumMap.put("popNum", popNum);
		
		// 5. 소비수준에 따른 상권유형
		int spendRating = tobRecomService.getSpendLevel(region_cd);
		sumMap.put("spendRating", spendRating);
		
		return sumMap;
	}
	
	/**
	* Method : totalResult
	* 작성자 : 박영춘
	* 변경이력 :
	* @param btype
	* @param gyumoV
	* @param gusungV
	* @param sobiV
	* @param regionCd
	* @param model
	* @return
	* Method 설명 : 업종추천 분석결과 출력 - 상권적합도 우수업종(상권유형에 따른 적합업종)
	*/
	@RequestMapping(path = "/totalResult", method = RequestMethod.POST)
	public String totalResult(String btype, int gyumoV, String gusungV, int sobiV, long regionCd, 
							HttpSession session, Model model, String report_cd) {
		
		String readTobRecom = (String) session.getAttribute("READ_TOBRECOM");
			if(readTobRecom == "read") {
				Map<String, Object> reportMap = (Map<String, Object>) session.getAttribute("READ_TOBRECOM_MAP");
				TobRecomVo tobRecomVo = (TobRecomVo) reportMap.get("tobRecomVo");
				RegionVo regionVo = (RegionVo) reportMap.get("regionVo");
				List<JbVo> gofPointList = (List<JbVo>) reportMap.get("gofPointList");
				
				model.addAttribute("btype", tobRecomVo.getBtype());
				model.addAttribute("btypeInfo", tobRecomVo.getBtypeInfo());
				model.addAttribute("gyumoV", tobRecomVo.getRating());
				model.addAttribute("gusungV", makeGusungValue(tobRecomVo.getPopNum()));
				model.addAttribute("sobiV", tobRecomVo.getSpendRating());
				model.addAttribute("region_cd", regionVo.getRegion_cd());
				model.addAttribute("resultList", gofPointList);
				model.addAttribute("report_cd", report_cd);
				
				return "tobRecom/tobRecomTotalResult";
			}
		
		Map<String, Object> sumMap = totalResultLogic(btype, gyumoV, gusungV, sobiV, regionCd);
		
		model.addAttribute("btype", btype);
		model.addAttribute("btypeInfo", sumMap.get("btypeInfo"));
		model.addAttribute("gyumoV", gyumoV);
		model.addAttribute("gusungV", gusungV);
		model.addAttribute("sobiV", sobiV);
		model.addAttribute("region_cd", regionCd);
		model.addAttribute("resultList", sumMap.get("resultList"));
		model.addAttribute("report_cd", report_cd);
		
		return "tobRecom/tobRecomTotalResult";
	}
	
	/**
	* Method : totalResultLogic
	* 작성자 : 박영춘
	* 변경이력 :
	* @param btype
	* @param gyumoV
	* @param gusungV
	* @param sobiV
	* @param regionCd
	* @return
	* Method 설명 : 상권적합도 우수업종(상권유형에 따른 적합업종) 로직
	*/
	private Map<String, Object> totalResultLogic(String btype, int gyumoV, String gusungV, int sobiV, long regionCd){
		Map<String, Object> sumMap = new HashMap<String, Object>();
		
		String btypeInfo = null;
		if(btype.equals("일반형")) btypeInfo = "전체 업종구성비 기준 음식:소매:서비스업 비중이 4:3:3 정도로 형성된 일반 상권";
		else if(btype.equals("음식형")) btypeInfo = "전체 업종구성비 기준 음식업 비중이 45% 이상인 지역으로써 음식업 위주의 상권";
		else if(btype.equals("복합형")) btypeInfo = "전체 업종구성비 기준 소매업 비중이 35% 정도이면서 서비스업을 강화한 유형";
		else if(btype.equals("유통형")) btypeInfo = "전체 업종구성비 기준 소매업 비중이 45% 이상인 지역으로써 소매업 특수 유형";
		else btypeInfo = "교육업 비중이 15% 이상으로써 특화서비스업 비중이 높은 지역";
		
		sumMap.put("btypeInfo", btypeInfo);
		
		List<Integer> pop = tobRecomService.getPopulationMost(regionCd);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("btype", btype);
		paramMap.put("gender", pop.get(0));
		paramMap.put("age", pop.get(1));
		paramMap.put("region_cd", regionCd);
		
		List<JbVo> resultList = tobRecomService.getGofPoint(paramMap);
		
		sumMap.put("resultList", resultList);
		
		return sumMap;
	}
	
	/**
	* Method : showTobRecomReport
	* 작성자 : 박영춘
	* 변경이력 :
	* @param report_cd
	* @param session
	* @param model
	* @return
	* Method 설명 : 분석보고서 메뉴에서 업종추천 보고서 확인
	*/
	@RequestMapping(path = "/resultFromReport", method = RequestMethod.GET)
	public String showTobRecomReport(String report_cd, HttpSession session, Model model) {
		
		session.setAttribute("READ_TOBRECOM", "read");
		Map<String, Object> reportMap = tobRecomService.getTobRecomReport(report_cd); // 저장된 결과를 읽어온다
		TobRecomVo tobRecomVo = (TobRecomVo) reportMap.get("tobRecomVo");
		List<LocationaVo> oList = (List<LocationaVo>) reportMap.get("oList");
		
		int stData = tobRecomVo.getStData();
		String stDataTemp = Integer.toString(stData);
		String pre = stDataTemp.substring(0, 4);
		String suf = stDataTemp.substring(4);

		StringBuffer sBuffer = new StringBuffer(pre);
		sBuffer.append("년 ").append(suf).append("월");
		String stDataStr = sBuffer.toString();  // 출력용 기준데이터시점 처리 
		
		// 화면출력에 사용되는 값
		model.addAttribute("stData", stDataStr); // 기준데이터시점
		model.addAttribute("regionVo", reportMap.get("regionVo")); // 지역정보 객체
		model.addAttribute("selectAddr", tobRecomVo.getSelectAddr()); // 출력용 주소
		model.addAttribute("grade", tobRecomVo.getGrade()); // 종합입지등급
		model.addAttribute("resultList", oList); // 업종별 입지등급
		model.addAttribute("report_cd", report_cd);
		
		// 다음 화면출력에 사용되는 값
		session.setAttribute("READ_TOBRECOM_MAP", reportMap);
		
		return "tobRecom/locationAppraisal";
	}
	
	/**
	* Method : tobRecomComparison
	* 작성자 : 박영춘
	* 변경이력 :
	* @param report_cd1
	* @param report_cd2
	* @param model
	* @return
	* Method 설명 : 분석보고서 비교분석
	*/
	@RequestMapping(path = "/tobRecomComparison", method = RequestMethod.GET)
	public String tobRecomComparison(String report_cd1, String report_cd2, Model model) {
		
		// 저장된 보고서 두 건을 읽어온다
		Map<String, Object> reportMap1 = tobRecomService.getTobRecomReport(report_cd1);
		Map<String, Object> reportMap2 = tobRecomService.getTobRecomReport(report_cd2);
		
		RegionVo regionVo1 = (RegionVo) reportMap1.get("regionVo"); // 분석 대상 지역정보
		RegionVo regionVo2 = (RegionVo) reportMap2.get("regionVo");
		
		TobRecomVo tobRecomVo1 = (TobRecomVo) reportMap1.get("tobRecomVo"); // 업종추천 분석결과
		TobRecomVo tobRecomVo2 = (TobRecomVo) reportMap2.get("tobRecomVo");
		
		List<LocationaVo> oList1 = (List<LocationaVo>) reportMap1.get("oList"); // 업종추천 업종별입지등급
		List<LocationaVo> oList2 = (List<LocationaVo>) reportMap2.get("oList");
		
		List<TobCompVo> frsList1 = (List<TobCompVo>) reportMap1.get("frsList"); // 상권내 밀집업종
		List<TobCompVo> frsList2 = (List<TobCompVo>) reportMap2.get("frsList");
		
		List<JbVo> gofPointList1 = (List<JbVo>) reportMap1.get("gofPointList"); // 중분류별 상권적합도 우수업종
		List<JbVo> gofPointList2 = (List<JbVo>) reportMap2.get("gofPointList");
		
		
		// 화면 출력 형태에 맞게 Model에 추가한다
		model.addAttribute("selectAddr1", tobRecomVo1.getSelectAddr()); // 출력용 주소
		model.addAttribute("selectAddr2", tobRecomVo2.getSelectAddr());
		
		model.addAttribute("grade1", tobRecomVo1.getGrade()); // 종합입지등급
		model.addAttribute("grade2", tobRecomVo2.getGrade());
		
		model.addAttribute("resultList1", oList1); // 업종별 입지등급
		model.addAttribute("resultList2", oList2);
		
		Map<String, Object> resultMap1 = new HashMap<String, Object>();
		resultMap1.put("foodPercent", tobRecomVo1.getFoodPercent());
		resultMap1.put("retailPercent", tobRecomVo1.getRetailPercent());
		resultMap1.put("servicePercent", tobRecomVo1.getServicePercent());
		resultMap1.put("btype", tobRecomVo1.getBtype());
		
		Map<String, Object> resultMap2 = new HashMap<String, Object>();
		resultMap2.put("foodPercent", tobRecomVo2.getFoodPercent());
		resultMap2.put("retailPercent", tobRecomVo2.getRetailPercent());
		resultMap2.put("servicePercent", tobRecomVo2.getServicePercent());
		resultMap2.put("btype", tobRecomVo2.getBtype());
		
		model.addAttribute("resultMap1", resultMap1); // 1. 업종구성에 따른 상권유형
		model.addAttribute("resultMap2", resultMap2);
		
		model.addAttribute("region_cd1", regionVo1.getRegion_cd()); // 선택한 지역정보
		model.addAttribute("region_cd2", regionVo2.getRegion_cd());
		
		List<TobCompVo> fList1 = new ArrayList<TobCompVo>();
		List<TobCompVo> rList1 = new ArrayList<TobCompVo>();
		List<TobCompVo> sList1 = new ArrayList<TobCompVo>();
		List<TobCompVo> fList2 = new ArrayList<TobCompVo>();
		List<TobCompVo> rList2 = new ArrayList<TobCompVo>();
		List<TobCompVo> sList2 = new ArrayList<TobCompVo>();
		
		for(TobCompVo tVo : frsList1) {
			if(tVo.getTob_cd().equals("Q")) fList1.add(tVo);
			else if(tVo.getTob_cd().equals("D")) rList1.add(tVo);
			else sList1.add(tVo);
		}
		for(TobCompVo tVo : frsList2) {
			if(tVo.getTob_cd().equals("Q")) fList2.add(tVo);
			else if(tVo.getTob_cd().equals("D")) rList2.add(tVo);
			else sList2.add(tVo);
		}
		
		model.addAttribute("fList1", fList1); // 2. 평균 업종구성비 대비 상권 내 밀집업종
		model.addAttribute("fList2", fList2);
		model.addAttribute("rList1", rList1);
		model.addAttribute("rList2", rList2);
		model.addAttribute("sList1", sList1);
		model.addAttribute("sList2", sList2);
		
		model.addAttribute("rating1", tobRecomVo1.getRating()); // 3. 상권규모에 따른 상권유형
		model.addAttribute("rating2", tobRecomVo2.getRating());
		
		model.addAttribute("gValue1", makeGusungValue(tobRecomVo1.getPopNum()).replace("<br>", " ")); // 4. 주요 고객구성에 따른 상권유형
		model.addAttribute("gValue2", makeGusungValue(tobRecomVo2.getPopNum()).replace("<br>", " "));
		
		model.addAttribute("spendRating1", tobRecomVo1.getSpendRating()); // 5. 소비수준에 따른 상권유형
		model.addAttribute("spendRating2", tobRecomVo2.getSpendRating());
		
		model.addAttribute("totalResultList1", gofPointList1); // 상권유형에 따른 적합업종
		model.addAttribute("totalResultList2", gofPointList2);
		
		return "tobRecom/comparisonTobRecom";
	}
	
	/**
	* Method : excelDown
	* 작성자 : 박영춘
	* 변경이력 :
	* @param report_cd
	* @param request
	* @param response
	* @throws InvalidFormatException
	* Method 설명 : 분석결과 엑셀 다운로드
	*/
	@RequestMapping(path = "/excel", method = RequestMethod.GET)
	public void excelDown(String report_cd, HttpServletRequest request, HttpServletResponse response) throws InvalidFormatException {
		
		Map<String, Object> reportMap = tobRecomService.getTobRecomReport(report_cd); // 보고서
		logger.debug("▶ reportMap : {}", reportMap);
		
		RegionVo regionVo = (RegionVo) reportMap.get("regionVo"); // 분석 대상 지역정보

		TobRecomVo tobRecomVo = (TobRecomVo) reportMap.get("tobRecomVo"); // 업종추천 분석결과

		List<LocationaVo> oList = (List<LocationaVo>) reportMap.get("oList"); // 업종추천 업종별입지등급

		List<TobCompVo> frsList = (List<TobCompVo>) reportMap.get("frsList"); // 상권내 밀집업종

		List<JbVo> gofPointList = (List<JbVo>) reportMap.get("gofPointList"); // 중분류별 상권적합도 우수업종
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("foodPercent", tobRecomVo.getFoodPercent());
		resultMap.put("retailPercent", tobRecomVo.getRetailPercent());
		resultMap.put("servicePercent", tobRecomVo.getServicePercent());
		resultMap.put("btype", tobRecomVo.getBtype());
		
		List<TobCompVo> fList = new ArrayList<TobCompVo>();
		List<TobCompVo> rList = new ArrayList<TobCompVo>();
		List<TobCompVo> sList = new ArrayList<TobCompVo>();

		for(TobCompVo tVo : frsList) {
			if(tVo.getTob_cd().equals("Q")) fList.add(tVo);
			else if(tVo.getTob_cd().equals("D")) rList.add(tVo);
			else sList.add(tVo);
		}
		
		// 출력 형태에 맞게 Map에 추가한다
		Map<String, Object> beans = new HashMap<String, Object>();
		
		beans.put("selectAddr", tobRecomVo.getSelectAddr()); // 출력용 주소
		beans.put("stData", tobRecomVo.getStData()); // 기준데이터시점
		beans.put("grade", tobRecomVo.getGrade()); // 종합입지등급
		beans.put("resultList", oList); // 업종별 입지등급
		beans.put("resultMap", resultMap); // 1. 업종구성에 따른 상권유형
		beans.put("region_cd", regionVo.getRegion_cd()); // 선택한 지역정보
		beans.put("fList", fList); // 2. 평균 업종구성비 대비 상권 내 밀집업종
		beans.put("rList", rList);
		beans.put("sList", sList);
		beans.put("rating", tobRecomVo.getRating()); // 3. 상권규모에 따른 상권유형
		beans.put("gValue", makeGusungValue(tobRecomVo.getPopNum()).replace("<br>", " ")); // 4. 주요 고객구성에 따른 상권유형
		beans.put("spendRating", tobRecomVo.getSpendRating()); // 5. 소비수준에 따른 상권유형
		beans.put("totalResultList", gofPointList); // 상권유형에 따른 적합업종
		
		MakeExcel me = new MakeExcel();
		
		me.download(request, response, beans, me.get_Filename("tobRecom"), "tobRecom.xlsx");
	}
	
	/**
	* Method : gofList
	* 작성자 : 박영춘
	* 변경이력 :
	* @param model
	* @param pageVo
	* @return
	* Method 설명 : 업종적합도 분석기준 조회
	*/
	@RequestMapping(path = "/gofList", method = RequestMethod.GET)
	public String gofList(Model model, PageVo pageVo, String tob_name) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(tob_name == null) { // 검색어가 없을 때
			resultMap = tobRecomService.gofList(pageVo);
			
		} else { // 검색어가 있을 때
			Map<String, Object> searchMap = new HashMap<String, Object>();
			searchMap.put("page", pageVo.getPage());
			searchMap.put("pageSize", pageVo.getPageSize());
			searchMap.put("tob_name", tob_name);
			
			resultMap = tobRecomService.gofSearchList(searchMap);
			
			List<GofListVo> gofList = (List<GofListVo>) resultMap.get("gofList");
			int paginationSize = (int) resultMap.get("paginationSize");
			
			model.addAttribute("gofList", gofList);
			model.addAttribute("paginationSize", paginationSize);
			model.addAttribute("pageVo", pageVo);
			
			List<TobVo> forInsertTob = tobRecomService.getTobForInsertGof();
			model.addAttribute("forInsertTob", forInsertTob);
			
			model.addAttribute("tob_name", tob_name);
			
			return "tobRecom/gofSearchList";
		}
		
		List<GofListVo> gofList = (List<GofListVo>) resultMap.get("gofList");
		int paginationSize = (int) resultMap.get("paginationSize");
		
		model.addAttribute("gofList", gofList);
		model.addAttribute("paginationSize", paginationSize);
		model.addAttribute("pageVo", pageVo);
		
		List<TobVo> forInsertTob = tobRecomService.getTobForInsertGof(); // 분석기준에 추가할 수 있는 새 중분류 조회
		model.addAttribute("forInsertTob", forInsertTob);
		
		return "tobRecom/gofList";
	}
	
	/**
	* Method : gofModify
	* 작성자 : 박영춘
	* 변경이력 :
	* @param model
	* @param pageVo
	* @param glVo
	* @return
	* Method 설명 : 업종적합도 분석기준 수정
	*/
	@RequestMapping(path = "/updateGof", method = RequestMethod.POST)
	public String gofModify(Model model, GofListVo glVo) {
		tobRecomService.gofModify(glVo);
		
		return "redirect:/tobRecom/gofList";
	}
	
	/**
	* Method : gofInsert
	* 작성자 : 박영춘
	* 변경이력 :
	* @param model
	* @param glVo
	* @return
	* Method 설명 : 업종적합도 분석기준 추가
	*/
	@RequestMapping(path = "/insertGof", method = RequestMethod.POST)
	public String gofInsert(Model model, GofListVo glVo) {
		tobRecomService.gofInsert(glVo);
		
		return "redirect:/tobRecom/gofList";
	}
	
} // TobRecomController 끝
