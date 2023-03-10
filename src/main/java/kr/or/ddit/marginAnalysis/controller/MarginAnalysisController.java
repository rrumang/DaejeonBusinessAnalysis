package kr.or.ddit.marginAnalysis.controller;

import java.io.IOException;
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

import kr.or.ddit.bdAnalysis.controller.BdAnalysisController;
import kr.or.ddit.bdAnalysis.service.IBdAnalysisService;
import kr.or.ddit.locationAnalysis.controller.MakeExcel;
import kr.or.ddit.locationAnalysis.controller.locationCompare;
import kr.or.ddit.locationAnalysis.model.LocationAnalysisVo;
import kr.or.ddit.locationAnalysis.model.LocationaVo;
import kr.or.ddit.marginAnalysis.model.AvgSalesVo;
import kr.or.ddit.marginAnalysis.model.ExpenseVo;
import kr.or.ddit.marginAnalysis.model.FundVo;
import kr.or.ddit.marginAnalysis.model.MarginVo;
import kr.or.ddit.marginAnalysis.model.MonthlyEpVo;
import kr.or.ddit.marginAnalysis.model.SalesGoalVo;
import kr.or.ddit.marginAnalysis.service.IMarginAnalysisService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import net.sf.jxls.exception.ParsePropertyException;

/**
 * MarginAnalysisController.java
 * 수익분석 화면 요청, 처리등을 하는 클래스
 *
 * @author CHOEUNJU
 * @version 1.0
 * @see 
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 * 수정자 수정내용
 * ------ ------------------------
 * CHOEUNJU 최초 생성
 *
 * </pre>
 */
@Controller
@RequestMapping("/marginAnalysis")
public class MarginAnalysisController {
private static final Logger logger = LoggerFactory.getLogger(BdAnalysisController.class);
	
	@Resource(name = "bdAnalysisService")
	private IBdAnalysisService bdAnalysisService;
	
	@Resource(name = "marginAnalysisService")
	private IMarginAnalysisService service;
	
	/**
	 * Method : marginAdd
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 수익분석 입력화면 요청
	 */
	@RequestMapping(path="/input", method = RequestMethod.GET)
	public String marginInput(Model model, HttpSession session) {
		// 시군구 리스트 가져오기
		List<RegionVo> guList = bdAnalysisService.getGuList();
		model.addAttribute("guList", guList);
		
		// 업종별(대/중/소) 리스트 넘겨주기
		model.addAttribute("TopTobList", bdAnalysisService.getAllTopTobList());
		model.addAttribute("MidTobList", bdAnalysisService.getAllMidTobList());
		model.addAttribute("BotTobList", bdAnalysisService.getAllBotTobList());
		
		// 회원의 관심지역, 관심업종 조회
		MemberVo memberVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		
		if(memberVo == null) {
			session.setAttribute("MESSAGE", "로그인이 필요한 기능입니다.");
			return "redirect:/login";
		} else {
			Map<String, Object> interest = service.getInterest(memberVo.getMember_id());
			if(interest != null) {
				model.addAttribute("interest", interest);
			}
		}
		
		return "marginAnalysis/marginAnalysisAdd";
	}
	
	/**
	 * Method : getFund
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 수익분석 비용입력 초기값 세팅을 위해 창업기금자금투입현황 조회
	 */
	@RequestMapping(path="/fund", method = RequestMethod.GET)
	public String getFund(Model model, String tob_cd) {
		FundVo fundVo = service.getFund(tob_cd);
		model.addAttribute("fundVo", fundVo);
		
		return "jsonView";
	}
	
	/**
	 * Method : analysis
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 수익분석 결과를 산출하고 수익분석 결과 페이지로 이동
	 */
	@RequestMapping(path="/analysis", method = RequestMethod.POST)
	public String analysis(Model model, ExpenseVo inputExpenseVo, long region_cd, String tob_cd, HttpSession session) {
		logger.debug("▶ MEMBER_INFO : {}", ((MemberVo) session.getAttribute("MEMBER_INFO")).getMember_id());
		logger.debug("▶ region_cd : {}", region_cd);
		logger.debug("▶ tob_cd : {}", tob_cd);

		if(session.getAttribute("MEMBER_INFO") == null) {
			session.setAttribute("MESSAGE", "로그인이 필요한 기능입니다.");
			return "redirect:/login";
		} else {
			MemberVo memberVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		
			// ---------------------------------------------------------------------
			
			ReportVo reportVo = new ReportVo(memberVo.getMember_id(), tob_cd, region_cd, 3);
			
			// 분석보고서 추가
			String report_cd = service.insertReport(reportVo);
			
			// ---------------------------------------------------------------------
			
			// 분석보고서
			ReportVo reportVo2 = service.getReport(report_cd);
			
			// 0. 분석설정 정보
			MarginVo marginVo = service.getInfo(report_cd);
			
			// 소요비용 추가
			inputExpenseVo.setReport_cd(report_cd);
			service.insertExpense(inputExpenseVo);
	
			// 1. 입력정보
			ExpenseVo expenseVo = service.getExpense(report_cd);
			
			// 2. 월 소요비용
			MonthlyEpVo monthlyEpVo = service.calculatedMonthly(report_cd);
			
			// 3. 매출현황
			AvgSalesVo ageSalesVo = service.getSales(reportVo2);
			
			// 4. 투자비 회수 시점별 목표매출
			List<SalesGoalVo> sgList = service.calculatedSalesGoal(report_cd);
			
			// ---------------------------------------------------------------------
			
			model.addAttribute("reportVo", reportVo2);
			model.addAttribute("marginVo", marginVo);
			model.addAttribute("expenseVo", expenseVo);
			model.addAttribute("monthlyEpVo", monthlyEpVo);
			model.addAttribute("ageSalesVo", ageSalesVo);
			model.addAttribute("sgList", sgList);
			model.addAttribute("path", "수익분석");
			
			return "marginAnalysis/marginAnalysisReport";
		
		}
	}
	
	/**
	 * Method : showMarginReport
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 분석이력 조회
	 */
	@RequestMapping(path="/showMarginReport", method = RequestMethod.GET)
	public String showMarginReport(String report_cd, Model model, HttpSession session) {
		ReportVo reportVo = service.getReport(report_cd);
		
		// 분석보고서가 존재하지 않으면 분석이력 화면으로 이동 후 알림창 출력
		if(reportVo == null) {
			session.setAttribute("MESSAGE", "존재하지 않는 보고서입니다.");
			return "redirect:/report/reportList";
		
		} else {
			
			// 분석보고서
			model.addAttribute("reportVo", reportVo);
			
			// 0. 분석설정 정보
			model.addAttribute("marginVo", service.getMargin(report_cd));
			
			// 1. 입력정보
			model.addAttribute("expenseVo", service.getExpense(report_cd));
			
			// 2. 월 소요비용
			model.addAttribute("monthlyEpVo", service.getMonthlyEp(report_cd));
			
			// 3. 매출현황 
			model.addAttribute("ageSalesVo", service.getAvgSales(report_cd));
			
			// 4. 투자비 회수 시점별 목표매출
			model.addAttribute("sgList", service.getSalesGoal(report_cd));
			
			return "marginAnalysis/marginAnalysisReport";
		}
		
	}
	
	/**
	 * Method : marginReport
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 분석이력에서 다시분석
	 */
	@RequestMapping(path="/marginReport", method=RequestMethod.GET)
	public String marginReport(String report_cd, Model model, HttpSession session) {
		ReportVo reportVo = service.getReport(report_cd);
		ExpenseVo expenseVo = service.getExpense(report_cd);
		long region_cd = reportVo.getRegion_cd();
		String tob_cd = reportVo.getTob_cd();
		
		return analysis(model, expenseVo, region_cd, tob_cd, session);
	}
	
	/**
	 * Method : marginComparison
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 분석이력에서 비교분석
	 */
	@RequestMapping(path="/marginComparison", method=RequestMethod.GET)
	public String marginComparison(String report_cd1, String report_cd2, Model model, HttpSession session) {
		
		ReportVo reportVo1 = service.getReport(report_cd1);
		ReportVo reportVo2 = service.getReport(report_cd2);
		
		if(reportVo1 == null || reportVo2 == null) {
			session.setAttribute("MESSAGE", "존재하지 않는 보고서입니다.");
			return "redirect:/report/reportList";
		} else if(reportVo1.getReport_kind() != 3 || reportVo2.getReport_kind() != 3){
			session.setAttribute("MESSAGE", "수익분석 보고서가 아닙니다.");
			return "redirect:/report/reportList";
		} else if(reportVo1.getReport_kind() != reportVo2.getReport_kind()){
			session.setAttribute("MESSAGE", "같은 종류의 보고서만 비교 가능합니다.");
			return "redirect:/report/reportList";
		}else {
			
			// 0. 분석설정 정보
			model.addAttribute("marginVo1", service.getMargin(report_cd1));
			model.addAttribute("marginVo2", service.getMargin(report_cd2));
			
			// 1. 입력정보
			model.addAttribute("expenseVo1", service.getExpense(report_cd1));
			model.addAttribute("expenseVo2", service.getExpense(report_cd2));
			
			// 2. 월 소요비용
			model.addAttribute("monthlyEpVo1", service.getMonthlyEp(report_cd1));
			model.addAttribute("monthlyEpVo2", service.getMonthlyEp(report_cd2));
			
			// 3. 매출현황 
			model.addAttribute("ageSalesVo1", service.getAvgSales(report_cd1));
			model.addAttribute("ageSalesVo2", service.getAvgSales(report_cd2));
			
			// 4. 투자비 회수 시점별 목표매출
			model.addAttribute("sgList1", service.getSalesGoal(report_cd1));
			model.addAttribute("sgList2", service.getSalesGoal(report_cd2));
			
			return "marginAnalysis/comparisonMargin";
		}
		
	}
	
	
	/**
	 * Method : excelDown
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return void
	 * Method 설명 : 수익분석 보고서 엑셀 다운로드
	 */
	@RequestMapping(path="/excel", method=RequestMethod.POST)
	public void excelDown(String report_cd, HttpServletRequest request, HttpServletResponse response) 
			throws ParsePropertyException, InvalidFormatException, IOException {
		
		//맵에 가져온 정보를 넣어준다
		Map<String, Object> beans = new HashMap<String, Object>();
		beans.put("marginVo", service.getMargin(report_cd));		// 0. 분석설정 정보
		beans.put("expenseVo", service.getExpense(report_cd));		// 1. 입력정보
		beans.put("monthlyEpVo", service.getMonthlyEp(report_cd));	// 2. 월 소요비용
		beans.put("ageSalesVo", service.getAvgSales(report_cd));	// 3. 매출현황 
		beans.put("sgList", service.getSalesGoal(report_cd));		// 4. 투자비 회수 시점별 목표매출
		
		//엑셀 다운로드 메소드가 담겨 있는 객체
		MakeExcel me = new MakeExcel();
		
		//인자로 request, response, Map Collection 객체, 다운시 파일명, 견본파일을 받음
		me.download(request, response, beans, me.get_Filename("marginAnalysis"), "marginAnalysis.xlsx");
	}
		
}
