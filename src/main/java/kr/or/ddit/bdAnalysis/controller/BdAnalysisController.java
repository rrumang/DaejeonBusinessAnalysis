package kr.or.ddit.bdAnalysis.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import kr.or.ddit.bdAnalysis.model.EvaluationVo;
import kr.or.ddit.bdAnalysis.model.RateOfChangeVo;
import kr.or.ddit.bdAnalysis.model.SalesAndCntRosVo;
import kr.or.ddit.bdAnalysis.model.UpjongCntRosVo;
import kr.or.ddit.bdAnalysis.service.IBdAnalysisService;
import kr.or.ddit.data.model.LpVo;
import kr.or.ddit.data.model.PpaVo;
import kr.or.ddit.data.model.WpVo;
import kr.or.ddit.locationAnalysis.controller.MakeExcel;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import net.sf.jxls.exception.ParsePropertyException;

@RequestMapping("/bdAnalysis")
@Controller
public class BdAnalysisController {
	
	private static final Logger logger = LoggerFactory.getLogger(BdAnalysisController.class);
	
	@Resource(name = "bdAnalysisService")
	private IBdAnalysisService bdAnalysisService;
	
	
	/**
	* Method : bdAnalysisInput
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 상권분석 정보입력 페이지 요청
	*/
	@RequestMapping(path = "/input" , method = RequestMethod.GET)
	public String bdAnalysisInput(Model model, HttpSession session, String tobCntZero) {
		
		MemberVo memVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		if(memVo == null) {
			session.setAttribute("MESSAGE", "로그인이 필요한 기능입니다.");
			return "redirect:/login";
		}
		
		// 시군구 리스트 가져오기
		List<RegionVo> guList = bdAnalysisService.getGuList();
		model.addAttribute("guList", guList);
		
		// 업종별(대/중/소) 리스트 넘겨주기
		model.addAttribute("TopTobList", bdAnalysisService.getAllTopTobList());
		model.addAttribute("MidTobList", bdAnalysisService.getAllMidTobList());
		model.addAttribute("BotTobList", bdAnalysisService.getAllBotTobList());
		
		if("Y".equals(tobCntZero)) {
			model.addAttribute("info_msg", "분석지역 내 선택하신 업종이 없어 분석할 수 없습니다!");
		}
		
		logger.debug("topTobList : {}", bdAnalysisService.getAllTopTobList());
		logger.debug("midTobList : {}", bdAnalysisService.getAllMidTobList());
		logger.debug("botTobList : {}", bdAnalysisService.getAllBotTobList());
		return "bdAnalysis/bdAnalysisAdd";
	}
	
	
	
	/**
	* Method : bdAnalysis
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 상권분석 보고서 페이지 요청
	*/
	@RequestMapping(path = "/analysis", method = RequestMethod.POST)
	public String bdAnalysis(String region_cd, String tob_cd, Model model, HttpSession session) {
		
		// 분석 이력 저장
		ReportVo reportVo = new ReportVo();
		
		MemberVo memVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		
		if(memVo == null) {
			return "redirect:/login";
		}else {
			reportVo.setMember_id(memVo.getMember_id());
			reportVo.setRegion_cd(Long.parseLong(region_cd));
			reportVo.setTob_cd(tob_cd);
			reportVo.setReport_kind(1);
		}
		
		
		String report_cd = bdAnalysisService.insert_BdAnalysisReport(reportVo);
		logger.debug("@@@@@ report_cd : {}", report_cd);
		if( report_cd== null) {
			return "redirect:/bdAnalysis/input";
		}
		
		// 이력을 저장한 보고서 정보 불러오기
		ReportVo lookUpReportVo = bdAnalysisService.getReportVo(report_cd);
		
		
		/* =================== 상권 평가 메뉴 =================== */
		// 지역의 풀 네임을 받기 위해 매개인자를 셋팅할 map
		Map<String, Object> region = new HashMap<String, Object>();
		// 업종의 풀 네임을 받기 위해 매개인자를 셋팅할 map
		Map<String, Object> tob = new HashMap<String, Object>();
		
		logger.debug("@@@@@@@@region_cd : {} / tob_cd : {}", region_cd, tob_cd);
		// parameter로 넣기 위해서 코드를 일정하게 잘라내기
		String gu = region_cd.substring(0,5); // 시군구 코드번호
		String topTob = tob_cd.substring(0,1); // 대분류 코드번호
		String midTob = tob_cd.substring(0, 3); // 중분류 코드번호
		logger.debug("@@@@@ convert after -- gu : {}, dong : {}", gu, region_cd);
		logger.debug("@@@@@ convert after -- top : {}, mid : {}, bot : {}", topTob, midTob, tob_cd);
		
		// db로 보낼 map 객체에 매개인자를 셋팅
		// 지역 
		region.put("gu", Integer.parseInt(gu));
		region.put("dong", Long.parseLong(region_cd));
		// 업종
		tob.put("topTob", topTob);
		tob.put("midTob", midTob);
		tob.put("botTob", tob_cd);
		
		// 상권 주요정보 테이블에 셋팅할 데이터들을 조회
		Map<String, Object> bdInfomation = bdAnalysisService.getBdInformation(Long.parseLong(region_cd), tob_cd);
		// 상권 평가지수의 데이터 모음
//		Map<String, Object> bdRatioIndex = bdAnalysisService.getBdRatingIndex(Long.parseLong(region_cd), tob_cd);
		
		model.addAttribute("reportVo", lookUpReportVo);
		model.addAttribute("region_full_name", bdAnalysisService.getRegionFullName(region));
		model.addAttribute("tob_full_name", bdAnalysisService.getTobFullName(tob));
		model.addAttribute("bdInfo", bdInfomation);
//		model.addAttribute("bdRatioIndex", bdRatioIndex);
		
		// 지역정보 상세 조회 vo
		model.addAttribute("regionVo", bdAnalysisService.getRegionInfo(Long.parseLong(region_cd)) );
		// 분석 지역의 상권평가지수 상세 조회
		model.addAttribute("evalInfo", 
				(EvaluationVo)bdAnalysisService.getEvaluationInfo( Long.parseLong(region_cd)).get("evalInfo") );
		// 분석지역의 상권평가지수의 최신 데이터의 월이 직전월과의 증감률을 조회
		model.addAttribute("evalRateOfChange", 
				bdAnalysisService.getEvaluationInfo(Long.parseLong(region_cd)).get("evalRateOfChange"));
		
		
		// 분석지역의 상권평가지수 월별 리스트 조회
		model.addAttribute("evalList", 
				(List<Map<String, Object>>)bdAnalysisService.evaluation_rateOfChange(Long.parseLong(region_cd)).get("evalList"));
		// 종합평가지수 추이 - 동단위
		model.addAttribute("rosList_dong", 
				(List<RateOfChangeVo>)bdAnalysisService.evaluation_rateOfChange(Long.parseLong(region_cd)).get("rosList_dong"));
		// 종합평가지수 추이 - 구단위
		model.addAttribute("rosList_gu", 
				(List<RateOfChangeVo>)bdAnalysisService.evaluation_rateOfChange(Long.parseLong(region_cd)).get("rosList_gu"));
		// 종합평가지수 추이 - 시전체
		model.addAttribute("rosList_si", 
				(List<RateOfChangeVo>)bdAnalysisService.evaluation_rateOfChange(Long.parseLong(region_cd)).get("rosList_si"));
		
		
		/* =================== 업종분석 메뉴 =================== */
		
		// 대분류 업종의 업소수 및 증감률
		List<UpjongCntRosVo> topCntRos 
		= (List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd), tob_cd).get("topCntRos");
		
		// 중분류 업종의 업소수 및 증감률
		List<UpjongCntRosVo> midCntRos 
		= (List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd), tob_cd).get("midCntRos");
		
		// 소분류 업종의 업소수 및 증감률
		List<UpjongCntRosVo> botCntRos 
		= (List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd), tob_cd).get("botCntRos");
		
		if(topCntRos.size() == 0 && midCntRos.size() == 0 && botCntRos.size() == 0
				|| midCntRos.size() == 0 && botCntRos.size() == 0) {
			model.addAttribute("tobCntZero", "Y");
			return "redirect:/bdAnalysis/input";
		}
		
		// 1. 업종별 추이
		// 분석업종의 대/중/소분류 업종명을 조회 
		model.addAttribute("tobNames", 
				(Map<String, Object>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd), tob_cd).get("tobNames"));
		model.addAttribute("topCntRos", topCntRos);
		model.addAttribute("midCntRos", midCntRos);
		model.addAttribute("botCntRos", botCntRos);

		//--------------------------------------정체 구간

		// 2. 지역별 추이
		// 분석지역 동/구/시단위 지역명을 조회
		model.addAttribute("regNames", 
				(Map<String, Object>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd), tob_cd).get("regNames"));
		
		// 분석지역(동단위)내에서 분석업종 업소수 및 증감률 조회
		model.addAttribute("tobCntList_Dong", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd), tob_cd).get("tobCntList_Dong"));
		// 분석지역(구단위)내에서 분석업종 업소수 및 증감률 조회
		model.addAttribute("tobCntList_Gu", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd), tob_cd).get("tobCntList_Gu"));
		// 분석지역(대전시 전체)내에서 분석업종 업소수 및 증감률 조회
		model.addAttribute("tobCntList_Si", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd), tob_cd).get("tobCntList_Si"));
		
		//-------------------------------------------------------------------
		
		logger.debug("@@@@@@ middle");
		
		/* =================== 매출분석 메뉴 =================== */
		
		// 1. 업종별 매출추이
		
		// 분석지역 내 소분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		model.addAttribute("tobSac_Bot",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("tobSac_Bot"));
		// 분석지역 내  중분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		model.addAttribute("tobSac_Mid",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("tobSac_Mid"));
		// 분석지역 내 대분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		model.addAttribute("tobSac_Top",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("tobSac_Top"));
		
		//2. 지역별 매출추이
		// 선택업종의 분석지역(동단위) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		model.addAttribute("regSac_Dong", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("regSac_Dong"));
		// 선택업종의 분석지역(구단위) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		model.addAttribute("regSac_Gu", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("regSac_Gu"));
		// 선택업종의 분석지역(대전 전체) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		model.addAttribute("regSac_Si", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("regSac_Si"));
		
		
		
		//3. 업종 생애주기
		// 분석지역 내에서 해당 업종의 업소수 증감률 데이터 조회
		model.addAttribute("tobLC_Cnt",
				(Map<String, Object>)bdAnalysisService.getTobLC_Total(Long.parseLong(region_cd), tob_cd).get("tobLC_Cnt") ) ;
		//분석지역 내에서 해당 업종의 매출액 증감률 데이터 조회
		model.addAttribute("tobLC_Sale", 
				(Map<String, Object>)bdAnalysisService.getTobLC_Total(Long.parseLong(region_cd), tob_cd).get("tobLC_Sale") );
		
		
		
		/* =================== 인구분석 메뉴 =================== */

		// 1. 유동인구
		
		// 선택지역의 성별로 나눈 유동인구 데이터 조회
		model.addAttribute("ppgList",
				(List<Map<String, Object>>)bdAnalysisService.getPpaAndPpg(Long.parseLong(region_cd)).get("ppgList") );
		// 선택지역의 연령대별로 나눈 유동인구 데이터 조회
		model.addAttribute("ppaList", 
				(List<PpaVo>)bdAnalysisService.getPpaAndPpg(Long.parseLong(region_cd)).get("ppaList"));
		
		// 2. 주거인구
		
		// 선택한 지역 내에서 주거인구를 성별로 나눈 데이터 조회
		model.addAttribute("lpGenderList", 
				(List<LpVo>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd)).get("lpGenderList"));
		// 선택한 지역 내에서 주거인구를 연령별로 나눈 데이터 조회
		model.addAttribute("lpAgeList", 
				(List<LpVo>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd)).get("lpAgeList"));
		// 선택한 지역 내에서 주거인구 가구수와 비율 조회
		model.addAttribute("hhCnt", 
				(Map<String, Object>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd)).get("hhCnt"));
		// 선택한 지역 내에서 주거인구 전체 수와 비율 조회
		model.addAttribute("lpTotal", 
				(Map<String, Object>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd)).get("lpTotal"));
		
		
		// 3. 직장인구
		
		// 해당 지역의 직장인구 수를 조회 (성별로 구분)
		model.addAttribute("wpList", 
				(List<WpVo>)bdAnalysisService.getWpList_Total(Long.parseLong(region_cd)).get("wpList"));
		// 직장인구 전체수 및 비율(=100.0%) 조회
		model.addAttribute("wpTotal", 
				(Map<String, Object>)bdAnalysisService.getWpList_Total(Long.parseLong(region_cd)).get("wpTotal") );
		
		logger.debug("@@@@@@@ End....");
		
		
		return "bdAnalysis/tobAnalysis";
	}
	
	
	/**
	* Method : guListLookUp
	* 작성자 : hs
	* 변경이력 :
	* @return
	* Method 설명 : 상권분석 정보 입력페이지에서 대전시의 동 리스트를 조회하기 위한 jsonView
	*/
	@RequestMapping(path = "/dongListLookUp", method = RequestMethod.GET)
	public String guListLookUp(Model model, int region_cd2) {
		List<RegionVo> dongList = bdAnalysisService.getDongList(region_cd2);
		model.addAttribute("dongList", dongList);
		
		return "jsonView";
	}
	
	
	@RequestMapping(path = "/aptListLookUp", method = RequestMethod.GET)
	public String aptListLookUp(Model model, long region_cd) {
		// 4. 공동주택 현황
		// 해당 분석지역 내 공동주택 현황 리스트를 조회
		model.addAttribute("aptList", bdAnalysisService.getAptList(region_cd) );
		
		return "jsonView";
	}
	
	
	@RequestMapping(path = "/analysisReport", method = RequestMethod.GET)
	public String analysisReport(Model model, String report_cd) {
		// 요청한 보고서의 정보 조회
		ReportVo reportVo = bdAnalysisService.getReportVo(report_cd);
		
		if(reportVo == null) {
			return "redirect:/report/reportList";
		}
		
		String region_cd = String.valueOf(reportVo.getRegion_cd());
		String tob_cd = reportVo.getTob_cd();
		
		/* =================== 상권 평가 메뉴 =================== */
		// 지역의 풀 네임을 받기 위해 매개인자를 셋팅할 map
		Map<String, Object> region = new HashMap<String, Object>();
		// 업종의 풀 네임을 받기 위해 매개인자를 셋팅할 map
		Map<String, Object> tob = new HashMap<String, Object>();
		
		logger.debug("@@@@@@@@region_cd : {} / tob_cd : {}", region_cd, tob_cd);
		// parameter로 넣기 위해서 코드를 일정하게 잘라내기
		String gu = region_cd.substring(0,5); // 시군구 코드번호
		String topTob = tob_cd.substring(0,1); // 대분류 코드번호
		String midTob = tob_cd.substring(0, 3); // 중분류 코드번호
		logger.debug("@@@@@ convert after -- gu : {}, dong : {}", gu, region_cd);
		logger.debug("@@@@@ convert after -- top : {}, mid : {}, bot : {}", topTob, midTob, tob_cd);
		
		// db로 보낼 map 객체에 매개인자를 셋팅
		// 지역 
		region.put("gu", Integer.parseInt(gu));
		region.put("dong", Long.parseLong(region_cd));
		// 업종
		tob.put("topTob", topTob);
		tob.put("midTob", midTob);
		tob.put("botTob", tob_cd);
		
		// 상권 주요정보 테이블에 셋팅할 데이터들을 조회
		Map<String, Object> bdInfomation = bdAnalysisService.getBdInformation(Long.parseLong(region_cd), tob_cd);
		// 상권 평가지수의 데이터 모음
//		Map<String, Object> bdRatioIndex = bdAnalysisService.getBdRatingIndex(Long.parseLong(region_cd), tob_cd);
		
		model.addAttribute("region_full_name", bdAnalysisService.getRegionFullName(region));
		model.addAttribute("tob_full_name", bdAnalysisService.getTobFullName(tob));
		model.addAttribute("bdInfo", bdInfomation);
//		model.addAttribute("bdRatioIndex", bdRatioIndex);
		
		// 지역정보 상세 조회 vo
		model.addAttribute("regionVo", bdAnalysisService.getRegionInfo(Long.parseLong(region_cd)) );
		// 분석 지역의 상권평가지수 상세 조회
		model.addAttribute("evalInfo", 
				(EvaluationVo)bdAnalysisService.getEvaluationInfo( Long.parseLong(region_cd)).get("evalInfo") );
		// 분석지역의 상권평가지수의 최신 데이터의 월이 직전월과의 증감률을 조회
		model.addAttribute("evalRateOfChange", 
				bdAnalysisService.getEvaluationInfo(Long.parseLong(region_cd)).get("evalRateOfChange"));
		
		
		// 분석지역의 상권평가지수 월별 리스트 조회
		model.addAttribute("evalList", 
				(List<Map<String, Object>>)bdAnalysisService.evaluation_rateOfChange(Long.parseLong(region_cd)).get("evalList"));
		// 종합평가지수 추이 - 동단위
		model.addAttribute("rosList_dong", 
				(List<RateOfChangeVo>)bdAnalysisService.evaluation_rateOfChange(Long.parseLong(region_cd)).get("rosList_dong"));
		// 종합평가지수 추이 - 구단위
		model.addAttribute("rosList_gu", 
				(List<RateOfChangeVo>)bdAnalysisService.evaluation_rateOfChange(Long.parseLong(region_cd)).get("rosList_gu"));
		// 종합평가지수 추이 - 시전체
		model.addAttribute("rosList_si", 
				(List<RateOfChangeVo>)bdAnalysisService.evaluation_rateOfChange(Long.parseLong(region_cd)).get("rosList_si"));
		

		
		/* =================== 업종분석 메뉴 =================== */
		
		// 1. 업종별 추이
		// 분석업종의 대/중/소분류 업종명을 조회 
		model.addAttribute("tobNames", 
				(Map<String, Object>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd), tob_cd).get("tobNames"));
		// 대분류 업종의 업소수 및 증감률
		model.addAttribute("topCntRos", 
				(List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd), tob_cd).get("topCntRos"));
		// 중분류 업종의 업소수 및 증감률
		model.addAttribute("midCntRos",
				(List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd), tob_cd).get("midCntRos"));
		// 소분류 업종의 업소수 및 증감률
		model.addAttribute("botCntRos",
				(List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd), tob_cd).get("botCntRos"));

		// 2. 지역별 추이
		// 분석지역 동/구/시단위 지역명을 조회
		model.addAttribute("regNames", 
				(Map<String, Object>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd), tob_cd).get("regNames"));
		// 분석지역(동단위)내에서 분석업종 업소수 및 증감률 조회
		model.addAttribute("tobCntList_Dong", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd), tob_cd).get("tobCntList_Dong"));
		// 분석지역(구단위)내에서 분석업종 업소수 및 증감률 조회
		model.addAttribute("tobCntList_Gu", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd), tob_cd).get("tobCntList_Gu"));
		// 분석지역(대전시 전체)내에서 분석업종 업소수 및 증감률 조회
		model.addAttribute("tobCntList_Si", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd), tob_cd).get("tobCntList_Si"));
		

		//3. 업종 생애주기
		// 분석지역 내에서 해당 업종의 업소수 증감률 데이터 조회
		model.addAttribute("tobLC_Cnt",
				(Map<String, Object>)bdAnalysisService.getTobLC_Total(Long.parseLong(region_cd), tob_cd).get("tobLC_Cnt") ) ;
		//분석지역 내에서 해당 업종의 매출액 증감률 데이터 조회
		model.addAttribute("tobLC_Sale", 
				(Map<String, Object>)bdAnalysisService.getTobLC_Total(Long.parseLong(region_cd), tob_cd).get("tobLC_Sale") );
		
		
		
		/* =================== 업종분석 메뉴 =================== */
		
		// 1. 업종별 매출추이
		
		// 분석지역 내 소분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		model.addAttribute("tobSac_Bot",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("tobSac_Bot"));
		// 분석지역 내  중분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		model.addAttribute("tobSac_Mid",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("tobSac_Mid"));
		// 분석지역 내 대분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		model.addAttribute("tobSac_Top",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("tobSac_Top"));
		
		//2. 지역별 매출추이
		// 선택업종의 분석지역(동단위) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		model.addAttribute("regSac_Dong", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("regSac_Dong"));
		// 선택업종의 분석지역(구단위) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		model.addAttribute("regSac_Gu", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("regSac_Gu"));
		// 선택업종의 분석지역(대전 전체) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		model.addAttribute("regSac_Si", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("regSac_Si"));
		
		
		
		/* =================== 인구분석 메뉴 =================== */

		// 1. 유동인구
		
		// 선택지역의 성별로 나눈 유동인구 데이터 조회
		model.addAttribute("ppgList",
				(List<Map<String, Object>>)bdAnalysisService.getPpaAndPpg(Long.parseLong(region_cd)).get("ppgList") );
		// 선택지역의 연령대별로 나눈 유동인구 데이터 조회
		model.addAttribute("ppaList", 
				(List<PpaVo>)bdAnalysisService.getPpaAndPpg(Long.parseLong(region_cd)).get("ppaList"));
		
		// 2. 주거인구
		
		// 선택한 지역 내에서 주거인구를 성별로 나눈 데이터 조회
		model.addAttribute("lpGenderList", 
				(List<LpVo>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd)).get("lpGenderList"));
		// 선택한 지역 내에서 주거인구를 연령별로 나눈 데이터 조회
		model.addAttribute("lpAgeList", 
				(List<LpVo>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd)).get("lpAgeList"));
		// 선택한 지역 내에서 주거인구 가구수와 비율 조회
		model.addAttribute("hhCnt", 
				(Map<String, Object>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd)).get("hhCnt"));
		// 선택한 지역 내에서 주거인구 전체 수와 비율 조회
		model.addAttribute("lpTotal", 
				(Map<String, Object>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd)).get("lpTotal"));
		
		
		// 3. 직장인구
		
		// 해당 지역의 직장인구 수를 조회 (성별로 구분)
		model.addAttribute("wpList", 
				(List<WpVo>)bdAnalysisService.getWpList_Total(Long.parseLong(region_cd)).get("wpList"));
		// 직장인구 전체수 및 비율(=100.0%) 조회
		model.addAttribute("wpTotal", 
				(Map<String, Object>)bdAnalysisService.getWpList_Total(Long.parseLong(region_cd)).get("wpTotal") );
		
		
		return "bdAnalysis/tobAnalysis";
	}
	
	
	@RequestMapping(path = "/bdAnalysisComparison", method = RequestMethod.GET)
	public String comparisonReport(Model model, String report_cd1, String report_cd2) {
		
		// 요청한 보고서의 정보 조회 -- 1번
		ReportVo reportVo1 = bdAnalysisService.getReportVo(report_cd1);
		// 요청한 보고서의 정보 조회 -- 2번
		ReportVo reportVo2 = bdAnalysisService.getReportVo(report_cd2);
		
		if(reportVo1 == null || reportVo2 == null) {
			return "redirect:/report/reportList";
		}
		
		// 1번 보고서 - 지역코드, 업종코드 셋팅
		String region_cd1 = String.valueOf(reportVo1.getRegion_cd());
		String tob_cd1 = reportVo1.getTob_cd();
		// 2번 보고서 - 지역코드, 업종코드 셋팅
		String region_cd2 = String.valueOf(reportVo2.getRegion_cd());		
		String tob_cd2 = reportVo2.getTob_cd();
		
		/* 1번 보고서의 데이터 모음 셋팅 */

		/* =================== 상권 평가 메뉴 =================== */
		// 지역의 풀 네임을 받기 위해 매개인자를 셋팅할 map
		Map<String, Object> region = new HashMap<String, Object>();
		// 업종의 풀 네임을 받기 위해 매개인자를 셋팅할 map
		Map<String, Object> tob = new HashMap<String, Object>();
		
		// parameter로 넣기 위해서 코드를 일정하게 잘라내기
		String gu = region_cd1.substring(0,5); // 시군구 코드번호
		String topTob = tob_cd1.substring(0,1); // 대분류 코드번호
		String midTob = tob_cd1.substring(0, 3); // 중분류 코드번호
		
		// db로 보낼 map 객체에 매개인자를 셋팅
		// 지역 
		region.put("gu", Integer.parseInt(gu));
		region.put("dong", Long.parseLong(region_cd1));
		// 업종
		tob.put("topTob", topTob);
		tob.put("midTob", midTob);
		tob.put("botTob", tob_cd1);
		
		model.addAttribute("region_full_name_1", bdAnalysisService.getRegionFullName(region));
		model.addAttribute("tob_full_name_1", bdAnalysisService.getTobFullName(tob));
		
		// 분석 지역의 상권평가지수 상세 조회
		model.addAttribute("evalInfo1", 
				(EvaluationVo)bdAnalysisService.getEvaluationInfo( Long.parseLong(region_cd1)).get("evalInfo") );
		
		/* =================== 업종분석 메뉴 =================== */
		
		// 1. 업종별 추이
		// 분석업종의 대/중/소분류 업종명을 조회 
		model.addAttribute("tobNames1", 
				(Map<String, Object>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd1), tob_cd1).get("tobNames"));
		// 대분류 업종의 업소수 및 증감률
		model.addAttribute("topCntRos1", 
				(List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd1), tob_cd1).get("topCntRos"));
		// 중분류 업종의 업소수 및 증감률
		model.addAttribute("midCntRos1",
				(List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd1), tob_cd1).get("midCntRos"));
		// 소분류 업종의 업소수 및 증감률
		model.addAttribute("botCntRos1",
				(List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd1), tob_cd1).get("botCntRos"));

		// 2. 지역별 추이
		// 분석지역 동/구/시단위 지역명을 조회
		model.addAttribute("regNames1", 
				(Map<String, Object>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd1), tob_cd1).get("regNames"));
		// 분석지역(동단위)내에서 분석업종 업소수 및 증감률 조회
		model.addAttribute("tobCntList_Dong1", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd1), tob_cd1).get("tobCntList_Dong"));
		// 분석지역(구단위)내에서 분석업종 업소수 및 증감률 조회
		model.addAttribute("tobCntList_Gu1", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd1), tob_cd1).get("tobCntList_Gu"));
		// 분석지역(대전시 전체)내에서 분석업종 업소수 및 증감률 조회
		model.addAttribute("tobCntList_Si1", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd1), tob_cd1).get("tobCntList_Si"));
		
		//3. 업종 생애주기
		// 분석지역 내에서 해당 업종의 업소수 증감률 데이터 조회
		model.addAttribute("tobLC_Cnt1",
				(Map<String, Object>)bdAnalysisService.getTobLC_Total(Long.parseLong(region_cd1), tob_cd1).get("tobLC_Cnt") ) ;
		//분석지역 내에서 해당 업종의 매출액 증감률 데이터 조회
		model.addAttribute("tobLC_Sale1", 
				(Map<String, Object>)bdAnalysisService.getTobLC_Total(Long.parseLong(region_cd1), tob_cd1).get("tobLC_Sale") );
		
		/* =================== 매출분석 메뉴 =================== */
		
		// 1. 업종별 매출추이
		
		// 분석지역 내 소분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		model.addAttribute("tobSac_Bot1",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd1), tob_cd1).get("tobSac_Bot"));
		// 분석지역 내  중분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		model.addAttribute("tobSac_Mid1",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd1), tob_cd1).get("tobSac_Mid"));
		// 분석지역 내 대분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		model.addAttribute("tobSac_Top1",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd1), tob_cd1).get("tobSac_Top"));
		
		//2. 지역별 매출추이
		// 선택업종의 분석지역(동단위) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		model.addAttribute("regSac_Dong1", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd1), tob_cd1).get("regSac_Dong"));
		// 선택업종의 분석지역(구단위) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		model.addAttribute("regSac_Gu1", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd1), tob_cd1).get("regSac_Gu"));
		// 선택업종의 분석지역(대전 전체) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		model.addAttribute("regSac_Si1", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd1), tob_cd1).get("regSac_Si"));
		
		
		/* =================== 인구분석 메뉴 =================== */

		// 1. 유동인구
		
		// 선택지역의 성별로 나눈 유동인구 데이터 조회
		model.addAttribute("ppgList1",
				(List<Map<String, Object>>)bdAnalysisService.getPpaAndPpg(Long.parseLong(region_cd1)).get("ppgList") );
		// 선택지역의 연령대별로 나눈 유동인구 데이터 조회
		model.addAttribute("ppaList1", 
				(List<PpaVo>)bdAnalysisService.getPpaAndPpg(Long.parseLong(region_cd1)).get("ppaList"));
		
		// 2. 주거인구
		
		// 선택한 지역 내에서 주거인구를 성별로 나눈 데이터 조회
		model.addAttribute("lpGenderList1", 
				(List<LpVo>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd1)).get("lpGenderList"));
		// 선택한 지역 내에서 주거인구를 연령별로 나눈 데이터 조회
		model.addAttribute("lpAgeList1", 
				(List<LpVo>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd1)).get("lpAgeList"));
		// 선택한 지역 내에서 주거인구 가구수와 비율 조회
		model.addAttribute("hhCnt1", 
				(Map<String, Object>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd1)).get("hhCnt"));
		// 선택한 지역 내에서 주거인구 전체 수와 비율 조회
		model.addAttribute("lpTotal1", 
				(Map<String, Object>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd1)).get("lpTotal"));
		
		
		// 3. 직장인구
		
		// 해당 지역의 직장인구 수를 조회 (성별로 구분)
		model.addAttribute("wpList1", 
				(List<WpVo>)bdAnalysisService.getWpList_Total(Long.parseLong(region_cd1)).get("wpList"));
		// 직장인구 전체수 및 비율(=100.0%) 조회
		model.addAttribute("wpTotal1", 
				(Map<String, Object>)bdAnalysisService.getWpList_Total(Long.parseLong(region_cd1)).get("wpTotal") );
		
		
		
		
		/* 2번 보고서의 데이터 모음 셋팅 */

		/* =================== 상권 평가 메뉴 =================== */
		
		// parameter로 넣기 위해서 코드를 일정하게 잘라내기
		gu = region_cd2.substring(0,5); // 시군구 코드번호
		topTob = tob_cd2.substring(0,1); // 대분류 코드번호
		midTob = tob_cd2.substring(0, 3); // 중분류 코드번호
		
		// db로 보낼 map 객체에 매개인자를 셋팅
		// 지역 
		region.put("gu", Integer.parseInt(gu));
		region.put("dong", Long.parseLong(region_cd2));
		// 업종
		tob.put("topTob", topTob);
		tob.put("midTob", midTob);
		tob.put("botTob", tob_cd2);
		
		model.addAttribute("region_full_name_2", bdAnalysisService.getRegionFullName(region));
		model.addAttribute("tob_full_name_2", bdAnalysisService.getTobFullName(tob));
		
		// 분석 지역의 상권평가지수 상세 조회
		model.addAttribute("evalInfo2", 
				(EvaluationVo)bdAnalysisService.getEvaluationInfo( Long.parseLong(region_cd2)).get("evalInfo") );
		
		/* =================== 업종분석 메뉴 =================== */
		
		// 1. 업종별 추이
		// 분석업종의 대/중/소분류 업종명을 조회 
		model.addAttribute("tobNames2", 
				(Map<String, Object>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd2), tob_cd2).get("tobNames"));
		// 대분류 업종의 업소수 및 증감률
		model.addAttribute("topCntRos2", 
				(List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd2), tob_cd2).get("topCntRos"));
		// 중분류 업종의 업소수 및 증감률
		model.addAttribute("midCntRos2",
				(List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd2), tob_cd2).get("midCntRos"));
		// 소분류 업종의 업소수 및 증감률
		model.addAttribute("botCntRos2",
				(List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd2), tob_cd2).get("botCntRos"));

		// 2. 지역별 추이
		// 분석지역 동/구/시단위 지역명을 조회
		model.addAttribute("regNames2", 
				(Map<String, Object>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd2), tob_cd2).get("regNames"));
		// 분석지역(동단위)내에서 분석업종 업소수 및 증감률 조회
		model.addAttribute("tobCntList_Dong2", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd2), tob_cd2).get("tobCntList_Dong"));
		// 분석지역(구단위)내에서 분석업종 업소수 및 증감률 조회
		model.addAttribute("tobCntList_Gu2", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd2), tob_cd2).get("tobCntList_Gu"));
		// 분석지역(대전시 전체)내에서 분석업종 업소수 및 증감률 조회
		model.addAttribute("tobCntList_Si2", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd2), tob_cd2).get("tobCntList_Si"));
		
		
		//3. 업종 생애주기
		// 분석지역 내에서 해당 업종의 업소수 증감률 데이터 조회
		model.addAttribute("tobLC_Cnt2",
				(Map<String, Object>)bdAnalysisService.getTobLC_Total(Long.parseLong(region_cd2), tob_cd1).get("tobLC_Cnt") ) ;
		//분석지역 내에서 해당 업종의 매출액 증감률 데이터 조회
		model.addAttribute("tobLC_Sale2", 
				(Map<String, Object>)bdAnalysisService.getTobLC_Total(Long.parseLong(region_cd2), tob_cd1).get("tobLC_Sale") );
		
		
		/* =================== 매출분석 메뉴 =================== */
		
		// 1. 업종별 매출추이
		
		// 분석지역 내 소분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		model.addAttribute("tobSac_Bot2",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd2), tob_cd2).get("tobSac_Bot"));
		// 분석지역 내  중분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		model.addAttribute("tobSac_Mid2",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd2), tob_cd2).get("tobSac_Mid"));
		// 분석지역 내 대분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		model.addAttribute("tobSac_Top2",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd2), tob_cd2).get("tobSac_Top"));
		
		//2. 지역별 매출추이
		// 선택업종의 분석지역(동단위) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		model.addAttribute("regSac_Dong2", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd2), tob_cd1).get("regSac_Dong"));
		// 선택업종의 분석지역(구단위) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		model.addAttribute("regSac_Gu2", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd1), tob_cd1).get("regSac_Gu"));
		// 선택업종의 분석지역(대전 전체) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		model.addAttribute("regSac_Si2", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd2), tob_cd1).get("regSac_Si"));
		
		
		
		/* =================== 인구분석 메뉴 =================== */

		// 1. 유동인구
		
		// 선택지역의 성별로 나눈 유동인구 데이터 조회
		model.addAttribute("ppgList2",
				(List<Map<String, Object>>)bdAnalysisService.getPpaAndPpg(Long.parseLong(region_cd2)).get("ppgList") );
		// 선택지역의 연령대별로 나눈 유동인구 데이터 조회
		model.addAttribute("ppaList2", 
				(List<PpaVo>)bdAnalysisService.getPpaAndPpg(Long.parseLong(region_cd2)).get("ppaList"));
		
		
		// 2. 주거인구
		
		// 선택한 지역 내에서 주거인구를 성별로 나눈 데이터 조회
		model.addAttribute("lpGenderList2", 
				(List<LpVo>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd2)).get("lpGenderList"));
		// 선택한 지역 내에서 주거인구를 연령별로 나눈 데이터 조회
		model.addAttribute("lpAgeList2", 
				(List<LpVo>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd2)).get("lpAgeList"));
		// 선택한 지역 내에서 주거인구 가구수와 비율 조회
		model.addAttribute("hhCnt2", 
				(Map<String, Object>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd2)).get("hhCnt"));
		// 선택한 지역 내에서 주거인구 전체 수와 비율 조회
		model.addAttribute("lpTotal2", 
				(Map<String, Object>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd2)).get("lpTotal"));
		
		
		// 3. 직장인구
		
		// 해당 지역의 직장인구 수를 조회 (성별로 구분)
		model.addAttribute("wpList2", 
				(List<WpVo>)bdAnalysisService.getWpList_Total(Long.parseLong(region_cd2)).get("wpList"));
		// 직장인구 전체수 및 비율(=100.0%) 조회
		model.addAttribute("wpTotal2", 
				(Map<String, Object>)bdAnalysisService.getWpList_Total(Long.parseLong(region_cd2)).get("wpTotal") );
		
		
		return "bdAnalysis/comparisonBdAnalysis";
	}
	
	/**
	* Method : excelDown
	* 작성자 : hs
	* 변경이력 :
	* @param report_cd
	* @param request
	* @param response
	* @throws ParsePropertyException
	* @throws InvalidFormatException
	* @throws IOException
	* Method 설명 : 상권분석 보고서 Excel 다운로드
	*/
	@RequestMapping(path="/excel", method=RequestMethod.POST)
	public void excelDown(String report_cd, double evaluation, double growth,
						double stability,double purchasePower, double visitPower,
				HttpServletRequest request, HttpServletResponse response) 
			throws ParsePropertyException, InvalidFormatException, IOException {
		
		ReportVo reportVo = bdAnalysisService.getReportVo(report_cd);
		String region_cd = String.valueOf(reportVo.getRegion_cd());
		String tob_cd = reportVo.getTob_cd();
		
		//맵에 가져온 정보를 넣어준다
		Map<String, Object> beans = new HashMap<String, Object>();
		
		// 지역의 풀 네임을 받기 위해 매개인자를 셋팅할 map
		Map<String, Object> region = new HashMap<String, Object>();
		// 업종의 풀 네임을 받기 위해 매개인자를 셋팅할 map
		Map<String, Object> tob = new HashMap<String, Object>();
		
		// parameter로 넣기 위해서 코드를 일정하게 잘라내기
		String gu = region_cd.substring(0,5); // 시군구 코드번호
		String topTob = tob_cd.substring(0,1); // 대분류 코드번호
		String midTob = tob_cd.substring(0, 3); // 중분류 코드번호
		
		// db로 보낼 map 객체에 매개인자를 셋팅
		// 지역 
		region.put("gu", Integer.parseInt(gu));
		region.put("dong", Long.parseLong(region_cd));
		// 업종
		tob.put("topTob", topTob);
		tob.put("midTob", midTob);
		tob.put("botTob", tob_cd);
		
		// 상권 주요정보 테이블에 셋팅할 데이터들을 조회
		Map<String, Object> bdInfomation = bdAnalysisService.getBdInformation(Long.parseLong(region_cd), tob_cd);

		
		beans.put("region_full_name", bdAnalysisService.getRegionFullName(region));
		beans.put("tob_full_name", bdAnalysisService.getTobFullName(tob));
		
		Date dt = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일");
		beans.put("bdAnalysisTime", sdf.format(dt));

		beans.put("bdInfo", bdInfomation);
		
		// 지역정보 상세 조회 vo
		beans.put("regionVo", bdAnalysisService.getRegionInfo(Long.parseLong(region_cd)) );
		// 분석 지역의 상권평가지수 상세 조회
		beans.put("evalInfo", 
				(EvaluationVo)bdAnalysisService.getEvaluationInfo( Long.parseLong(region_cd)).get("evalInfo") );
		// 분석지역의 상권평가지수의 최신 데이터의 월이 직전월과의 증감률을 조회
		beans.put("evalRateOfChange", 
				bdAnalysisService.getEvaluationInfo(Long.parseLong(region_cd)).get("evalRateOfChange"));
		
		
		// 상권의 평가지수 항목들의 평가항목들의 점수 산출
		beans.put("evaluation", Math.floor(evaluation*10)/10);
		beans.put("growth", Math.floor(growth*10)/10);
		beans.put("stability", Math.floor(stability*10)/10);
		beans.put("purchasePower", Math.floor(purchasePower*10)/10);
		beans.put("visitPower", Math.floor(visitPower*10)/10);
		
		List<RateOfChangeVo> rosList_dong 
		= (List<RateOfChangeVo>)bdAnalysisService.evaluation_rateOfChange(Long.parseLong(region_cd)).get("rosList_dong");
		beans.put("prevEval", Math.floor(rosList_dong.get(rosList_dong.size()-2).getTotal() * 10)/10);
		beans.put("evalRos", Math.floor(rosList_dong.get(rosList_dong.size()-1).getGrowpt() *10 ) /10);
		
		// 분석지역의 상권평가지수 월별 리스트 조회
		beans.put("evalList", 
				(List<Map<String, Object>>)bdAnalysisService.evaluation_rateOfChange(Long.parseLong(region_cd)).get("evalList"));
		// 종합평가지수 추이 - 동단위
		beans.put("rosList_dong", rosList_dong);
		// 종합평가지수 추이 - 구단위
		beans.put("rosList_gu", 
				(List<RateOfChangeVo>)bdAnalysisService.evaluation_rateOfChange(Long.parseLong(region_cd)).get("rosList_gu"));
		// 종합평가지수 추이 - 시전체
		beans.put("rosList_si", 
				(List<RateOfChangeVo>)bdAnalysisService.evaluation_rateOfChange(Long.parseLong(region_cd)).get("rosList_si"));
		

		
		/* =================== 업종분석 메뉴 =================== */
		
		// 1. 업종별 추이
		// 분석업종의 대/중/소분류 업종명을 조회 
		beans.put("tobNames", 
				(Map<String, Object>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd), tob_cd).get("tobNames"));
		// 대분류 업종의 업소수 및 증감률
		beans.put("topCntRos", 
				(List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd), tob_cd).get("topCntRos"));
		// 중분류 업종의 업소수 및 증감률
		beans.put("midCntRos",
				(List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd), tob_cd).get("midCntRos"));
		// 소분류 업종의 업소수 및 증감률
		beans.put("botCntRos",
				(List<UpjongCntRosVo>)bdAnalysisService.getUpjongCntRos_Total(Long.parseLong(region_cd), tob_cd).get("botCntRos"));

		// 2. 지역별 추이
		// 분석지역 동/구/시단위 지역명을 조회
		beans.put("regNames", 
				(Map<String, Object>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd), tob_cd).get("regNames"));
		// 분석지역(동단위)내에서 분석업종 업소수 및 증감률 조회
		beans.put("tobCntList_Dong", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd), tob_cd).get("tobCntList_Dong"));
		// 분석지역(구단위)내에서 분석업종 업소수 및 증감률 조회
		beans.put("tobCntList_Gu", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd), tob_cd).get("tobCntList_Gu"));
		// 분석지역(대전시 전체)내에서 분석업종 업소수 및 증감률 조회
		beans.put("tobCntList_Si", 
				(List<UpjongCntRosVo>)bdAnalysisService.getTobCntList_Total(Long.parseLong(region_cd), tob_cd).get("tobCntList_Si"));
		

		//3. 업종 생애주기
		// 분석지역 내에서 해당 업종의 업소수 증감률 데이터 조회
		beans.put("tobLC_Cnt",
				(Map<String, Object>)bdAnalysisService.getTobLC_Total(Long.parseLong(region_cd), tob_cd).get("tobLC_Cnt") ) ;
		//분석지역 내에서 해당 업종의 매출액 증감률 데이터 조회
		beans.put("tobLC_Sale", 
				(Map<String, Object>)bdAnalysisService.getTobLC_Total(Long.parseLong(region_cd), tob_cd).get("tobLC_Sale") );
		
		
		
		/* =================== 업종분석 메뉴 =================== */
		
		// 1. 업종별 매출추이
		
		// 분석지역 내 소분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		beans.put("tobSac_Bot",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("tobSac_Bot"));
		// 분석지역 내  중분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		beans.put("tobSac_Mid",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("tobSac_Mid"));
		// 분석지역 내 대분류 업종의 매출액, 매출건수, 각 요소들의 월별 증감률 조회
		beans.put("tobSac_Top",
				(List<SalesAndCntRosVo>)bdAnalysisService.getTobSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("tobSac_Top"));
		
		//2. 지역별 매출추이
		// 선택업종의 분석지역(동단위) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		beans.put("regSac_Dong", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("regSac_Dong"));
		// 선택업종의 분석지역(구단위) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		beans.put("regSac_Gu", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("regSac_Gu"));
		// 선택업종의 분석지역(대전 전체) 내에서 매출액, 매출건수, 각 요소들의 월별증감률 조회
		beans.put("regSac_Si", 
				(List<SalesAndCntRosVo>)bdAnalysisService.getRegSaleAndCnt_Total(Long.parseLong(region_cd), tob_cd).get("regSac_Si"));
		
		
		
		/* =================== 인구분석 메뉴 =================== */

		// 1. 유동인구
		
		// 선택지역의 성별로 나눈 유동인구 데이터 조회
		beans.put("ppgList",
				(List<Map<String, Object>>)bdAnalysisService.getPpaAndPpg(Long.parseLong(region_cd)).get("ppgList") );
		// 선택지역의 연령대별로 나눈 유동인구 데이터 조회
		beans.put("ppaList", 
				(List<PpaVo>)bdAnalysisService.getPpaAndPpg(Long.parseLong(region_cd)).get("ppaList"));
		
		// 2. 주거인구
		
		// 선택한 지역 내에서 주거인구를 성별로 나눈 데이터 조회
		beans.put("lpGenderList", 
				(List<LpVo>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd)).get("lpGenderList"));
		// 선택한 지역 내에서 주거인구를 연령별로 나눈 데이터 조회
		beans.put("lpAgeList", 
				(List<LpVo>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd)).get("lpAgeList"));
		// 선택한 지역 내에서 주거인구 가구수와 비율 조회
		beans.put("hhCnt", 
				(Map<String, Object>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd)).get("hhCnt"));
		// 선택한 지역 내에서 주거인구 전체 수와 비율 조회
		beans.put("lpTotal", 
				(Map<String, Object>)bdAnalysisService.getLpList_Total(Long.parseLong(region_cd)).get("lpTotal"));
		
		
		// 3. 직장인구
		
		// 해당 지역의 직장인구 수를 조회 (성별로 구분)
		beans.put("wpList", 
				(List<WpVo>)bdAnalysisService.getWpList_Total(Long.parseLong(region_cd)).get("wpList"));
		// 직장인구 전체수 및 비율(=100.0%) 조회
		beans.put("wpTotal", 
				(Map<String, Object>)bdAnalysisService.getWpList_Total(Long.parseLong(region_cd)).get("wpTotal") );

		//엑셀 다운로드 메소드가 담겨 있는 객체
		MakeExcel me = new MakeExcel();
		
		//인자로 request, response, Map Collection 객체, 다운시 파일명, 견본파일을 받음
		me.download(request, response, beans, me.get_Filename("bdAnalysis"), "bdAnalysis.xlsx");
		
	}
	
	
}
