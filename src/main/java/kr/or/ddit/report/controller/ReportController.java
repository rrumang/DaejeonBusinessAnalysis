package kr.or.ddit.report.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.marginAnalysis.service.IMarginAnalysisService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.report.service.IReportService;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;

/**
 * 
* ReportController.java
* 분석보고서 관련 클래스
*
* @author 유민하
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
* 수정자 수정내용
* ------ ------------------------
* 유민하 최초 생성
*
* </pre>
 */
@RequestMapping("/report")
@Controller
public class ReportController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReportController.class);
	
	@Resource(name="reportService")
	private IReportService reportService;
	
	@Resource(name="marginAnalysisService")
	private IMarginAnalysisService service;
	
	
	/**
	 * 
	* Method : reportPagingList
	* 작성자 : 유민하
	* 변경이력 :
	* @param pageVo
	* @param model
	* @return
	* Method 설명 : 회원의 분석보고서 화면 요청
	 */
	@RequestMapping(path = "/reportList", method = RequestMethod.GET)
	public String reportPagingList(HttpSession session, PageVo pageVo, Model model, Integer page) {
		//---------------------------------------------------
		// 존재하지 않는 분석보고서 코드 또는 종류가 일치하지 않는 보고서코드 입력 시 message 출력
		if(session.getAttribute("MESSAGE") != null) {
			model.addAttribute("MESSAGE", session.getAttribute("MESSAGE"));
			session.removeAttribute("MESSAGE");
		}
		
		//---------------------------------------------------
		
		// 분석보고서 화면 최초 요청 시 session에서 checkbox 값 지우기
		if(page == null) {
			session.removeAttribute("checkbox");
		}
		
		MemberVo memberVo = (MemberVo)session.getAttribute("MEMBER_INFO");

		if(memberVo == null) {
			session.setAttribute("MESSAGE", "로그인이 필요한 기능입니다.");
			return "redirect:/login";
		}

		String member_id = memberVo.getMember_id();

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("page", pageVo.getPage());
		resultMap.put("pageSize", pageVo.getPageSize());
		resultMap.put("member_id", member_id);

		Map<String, Object> result =reportService.reportPagingList(resultMap);

		List<ReportVo> reportList = (List<ReportVo>) result.get("reportList");

		int paginationSize = (Integer) result.get("paginationSize");

		List<String> rList = new ArrayList<String>();
		RegionVo rVo = new RegionVo();

		for (int i = 0; i < reportList.size(); i++) {
			rVo = reportService.getRegion(reportList.get(i).getRegion_cd());
			String regionCsc = rVo.getRegion_csc();
			String sigu = regionCsc.substring(0, regionCsc.indexOf("구")+1);

			StringBuffer sb = new StringBuffer(sigu);
			sb.append(" ").append(rVo.getRegion_name());
			String addr = sb.toString();

			rList.add(addr);
		}

		List<String> tList = new ArrayList<String>();
		TobVo tVo = new TobVo();
		TobVo tVo2 = new TobVo();
		TobVo tVo3 = new TobVo();

		String big = "";
		String middle = "";
		String small = "";


		for (int i = 0; i < reportList.size(); i++) {

			if(reportList.get(i).getTob_cd()==null) {
				tList.add("");
				continue;
			}
			tVo = reportService.getTob(reportList.get(i).getTob_cd());
			String tob_cd = tVo.getTob_cd();

			if(tob_cd.length()==1) {
				String big2 = tob_cd.substring(0,1);
				tVo3 = reportService.getTob(big2);
				big = tVo3.getTob_name();
				tList.add(big);
			}else if(tob_cd.length()==3) {
				String big2 = tob_cd.substring(0,1);
				tVo3 = reportService.getTob(big2);
				big = tVo3.getTob_name();

				String middle2 = tob_cd.substring(0,3);
				tVo2 = reportService.getTob(middle2);
				middle = tVo2.getTob_name();
				tList.add(big + ">" + middle);
			}else {
				String big2 = tob_cd.substring(0,1);
				tVo3 = reportService.getTob(big2);
				big = tVo3.getTob_name();

				String middle2 = tob_cd.substring(0,3);
				tVo2 = reportService.getTob(middle2);
				middle = tVo2.getTob_name();

				small = tVo.getTob_name();
				tList.add(big + ">" + middle + ">" + small);
			}

		}

		model.addAttribute("tobList", tList);
		model.addAttribute("addrList", rList);
		model.addAttribute("reportList", reportList);
		model.addAttribute("paginationSize", paginationSize);
		model.addAttribute("pageVo", pageVo);

		return "report/reportList";
	}
	
	/**
	 * 
	* Method : reportPagingList
	* 작성자 : 유민하
	* 변경이력 :
	* @param pageVo
	* @param report_kind
	* @param model
	* @return
	* Method 설명 : 보고서 종류 선택시 해당 분석보고서 목록 조회
	 */
	@RequestMapping(path = "/reportList2", method = {RequestMethod.POST, RequestMethod.GET})
	public String reportPagingList2(HttpSession session, PageVo pageVo, int report_kind, Model model) {
		if(report_kind == 0) {
			String reportPagingList = reportPagingList(session, pageVo, model, null);
			return reportPagingList;
			
		}else {
			MemberVo memberVo = (MemberVo)session.getAttribute("MEMBER_INFO");

			if(memberVo == null) {
				session.setAttribute("MESSAGE", "로그인이 필요한 기능입니다.");
				return "redirect:/login";
			}

			String member_id = memberVo.getMember_id();
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("page", pageVo.getPage());
			resultMap.put("pageSize", pageVo.getPageSize());
			resultMap.put("report_kind", report_kind);
			resultMap.put("member_id", member_id);
			
			Map<String, Object>result = reportService.getReport(resultMap);
			List<ReportVo> reportList = (List<ReportVo>) result.get("reportList");
			
			List<String> rList = new ArrayList<String>();
			RegionVo rVo = new RegionVo();
			
			for (int i = 0; i < reportList.size(); i++) {
				rVo = reportService.getRegion(reportList.get(i).getRegion_cd());
				String regionCsc = rVo.getRegion_csc();
				String sigu = regionCsc.substring(0, regionCsc.indexOf("구")+1);
				
				StringBuffer sb = new StringBuffer(sigu);
				sb.append(" ").append(rVo.getRegion_name());
				String addr = sb.toString();
				
				rList.add(addr);
			}
			
			List<String> tList = new ArrayList<String>();
			TobVo tVo = new TobVo();
			TobVo tVo2 = new TobVo();
			TobVo tVo3 = new TobVo();
			
			String big = "";
			String middle = "";
			String small = "";
			
			for (int i = 0; i < reportList.size(); i++) {
				
				if(reportList.get(i).getTob_cd()==null) {
					tList.add("");
					continue;
				}
				
				tVo = reportService.getTob(reportList.get(i).getTob_cd());
				String tob_cd = tVo.getTob_cd();
				
				if(tob_cd.length()==1) {
					String big2 = tob_cd.substring(0,1);
					tVo3 = reportService.getTob(big2);
					big = tVo3.getTob_name();
					tList.add(big);
				}else if(tob_cd.length()==3) {
					String big2 = tob_cd.substring(0,1);
					tVo3 = reportService.getTob(big2);
					big = tVo3.getTob_name();
					
					String middle2 = tob_cd.substring(0,3);
					tVo2 = reportService.getTob(middle2);
					middle = tVo2.getTob_name();
					tList.add(big + ">" + middle);
				}else {
					String big2 = tob_cd.substring(0,1);
					tVo3 = reportService.getTob(big2);
					big = tVo3.getTob_name();
					
					String middle2 = tob_cd.substring(0,3);
					tVo2 = reportService.getTob(middle2);
					middle = tVo2.getTob_name();
					
					small = tVo.getTob_name();
					tList.add(big + ">" + middle + ">" + small);
				}
				
			}
			
			model.addAttribute("tobList", tList);
			model.addAttribute("addrList", rList);
			model.addAttribute("reportList", result.get("reportList"));
			model.addAttribute("paginationSize", result.get("paginationSize"));
			model.addAttribute("pageVo", pageVo);
			model.addAttribute("report_kind", report_kind);
			
			return "report/reportList2";
		}
	}
	
	/**
	 * 
	* Method : showReport
	* 작성자 : 유민하
	* 변경이력 :
	* @param report_cd
	* @param report_kind
	* @param model
	* @return
	* Method 설명 : 보고서 종류에 따라 해당 보고서 보기 페이지로 이동
	 */
	@RequestMapping(path = "/showReport")
	public String showReport(String report_cd, int report_kind, Model model) {
		
		  switch(report_kind){
	        case 1: 
	        	model.addAttribute("report_cd", report_cd);
	            return "redirect:/bdAnalysis/analysisReport";
	        case 2:
	        	model.addAttribute("report_cd", report_cd);
	        	return "redirect:/location/showLocationReport";
	        case 3 :
	        	model.addAttribute("report_cd", report_cd);
	        	return "redirect:/marginAnalysis/showMarginReport";
	        default :
	        	model.addAttribute("report_cd", report_cd);
	        	return "redirect:/tobRecom/resultFromReport";
	    }
		  
	}
	
	/**
	 * 
	* Method : reAnalysis
	* 작성자 : 유민하
	* 변경이력 :
	* @param report_cd
	* @param region_cd
	* @param report_kind
	* @param model
	* @return
	* Method 설명 : 보고서 종류에 따라 해당 보고서 다시분석 페이지로 이동
	 */
	@RequestMapping(path = "/reAnalysis")
	public String reAnalysis(String report_cd, long region_cd, int report_kind, Model model,
			HttpSession session) {
		
		  switch(report_kind){
	        case 1: 
	        	model.addAttribute("report_cd", report_cd);
	            return "redirect:/bdAnalysis/analysisReport";
	        case 2:
	        	model.addAttribute("dongcd", region_cd);
	        	return "redirect:/location/locationReport";
	        case 3 :
	        	model.addAttribute("report_cd", report_cd);
	        	return "redirect:/marginAnalysis/marginReport";
	        default :
	        	model.addAttribute("dongcd", region_cd);
	        	session.setAttribute("READ_TOBRECOM", "not");
	        	return "redirect:/tobRecom/result";
	    }
	}
	
	/**
	 * 
	* Method : comparison
	* 작성자 : 유민하
	* 변경이력 :
	* @param arr
	* @param model
	* @return
	* Method 설명 :보고서 종류에 따라 해당 보고서 비교분석 페이지로 이동
	 */
	@RequestMapping(path = "/comparison", method = RequestMethod.POST)
	public String comparison(String[] arr, Model model) {

		List<ReportVo> reportList = new ArrayList<ReportVo>();
		
		for (String report_cd : arr) {
			ReportVo reportVo = service.getReport(report_cd);
			reportList.add(reportVo);
		}
		
		switch(reportList.get(0).getReport_kind()){
		case 1: 
			model.addAttribute("report_cd1", reportList.get(0).getReport_cd());
			model.addAttribute("report_cd2", reportList.get(1).getReport_cd());
			return "redirect:/bdAnalysis/bdAnalysisComparison";
		case 2:
			model.addAttribute("report_cd1", reportList.get(0).getReport_cd());
			model.addAttribute("report_cd2", reportList.get(1).getReport_cd());
			return "redirect:/location/locationComparison";
		case 3 :
			model.addAttribute("report_cd1", reportList.get(0).getReport_cd());
			model.addAttribute("report_cd2", reportList.get(1).getReport_cd());
			return "redirect:/marginAnalysis/marginComparison";
		default :
			model.addAttribute("report_cd1", reportList.get(0).getReport_cd());
			model.addAttribute("report_cd2", reportList.get(1).getReport_cd());
			return "redirect:/tobRecom/tobRecomComparison";
		}

	}
	
	/**
	 * Method : getReport
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 분석보고서 코드로 분석보고서 객체를 조회하여 분석보고서종류 일치여부를 반환(ajax)
	 */
	@RequestMapping(path="/getReport", method=RequestMethod.POST)
	public String getReport(String[] reports, Model model) {
		
		List<ReportVo> reportList = new ArrayList<ReportVo>();
		for(String report_cd : reports) {
			ReportVo reportVo = service.getReport(report_cd);
			reportList.add(reportVo);
		}

		String result = "";
		if(reportList.get(0).getReport_kind() == reportList.get(1).getReport_kind()) {
			result = "true";
		} else {
			result = "false";
		}
		
		model.addAttribute("result", result);
		return "jsonView";
	}
	
	/**
	 * Method : setCheckBox
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 체크한 분석보고서 코드를 세션에 저장(ajax)
	 */
	@RequestMapping(path="/setCheckBox", method=RequestMethod.POST)
	public String setCheckBox(String[] reports, HttpSession session, Model model) {
		
		List<String> checkbox = new ArrayList<String>();
		
		if(reports == null) {
			checkbox.clear();
		}else {
			for(String str : reports) {
				if(str != "") {
					checkbox.add(str);
				}
			}
		}
		
		session.setAttribute("checkbox", checkbox);
		model.addAttribute("checkbox", checkbox);
		return "jsonView"; 
	}
}
