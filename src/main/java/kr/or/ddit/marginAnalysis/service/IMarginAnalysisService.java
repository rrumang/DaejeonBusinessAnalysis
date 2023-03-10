package kr.or.ddit.marginAnalysis.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.marginAnalysis.model.AvgSalesVo;
import kr.or.ddit.marginAnalysis.model.ExpenseVo;
import kr.or.ddit.marginAnalysis.model.FundVo;
import kr.or.ddit.marginAnalysis.model.MarginVo;
import kr.or.ddit.marginAnalysis.model.MonthlyEpVo;
import kr.or.ddit.marginAnalysis.model.SalesGoalVo;
import kr.or.ddit.report.model.ReportVo;

public interface IMarginAnalysisService {
	/**
	 * Method : getFund
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return FundVo
	 * Method 설명 : 업종 소분류 코드를 인자로 창업기금 자금투입현황 값을 가져오는 메서드
	 */
	FundVo getFund(String tob_cd);
	
	/**
	 * Method : insertReport
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 분석보고서 추가 후 분석보고서 코드를 가져오는 메서드
	 */
	String insertReport(ReportVo reportVo);
	
	/**
	 * Method : insertExpense
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return int
	 * Method 설명 : 소요비용을 추가하는 메서드
	 */
	int insertExpense(ExpenseVo expenseVo);
	
	/**
	 * Method : getExpense
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return ExpenseVo
	 * Method 설명 : 분석보고서 코드로 소요비용객체를 가져오는 메서드
	 */
	ExpenseVo getExpense(String report_cd);
	
	/**
	 * Method : getSales
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return AvgSalesVo
	 * Method 설명 : 분석보고서의 지역코드로 최신 매출현황 값을 가져오는 메서드
	 */
	AvgSalesVo getSales(ReportVo reportVo);
	
	/**
	 * Method : calculatedMonthly
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return MonthlyVo
	 * Method 설명 : 월 소요비용을 산출하는 메서드
	 */
	MonthlyEpVo calculatedMonthly(String report_cd);
	
	/**
	 * Method : calculatedSalesGoal
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return List<SalesGoalVo>
	 * Method 설명 : 투자비 회수 시점별 목표매출을 산출하는 메서드
	 */
	List<SalesGoalVo> calculatedSalesGoal(String report_cd);
	
	/**
	 * Method : getInfo
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return MarginVo
	 * Method 설명 : 분석 설정 정보를 가져오는 메서드
	 */
	MarginVo getInfo(String report_cd);
	
	/**
	 * Method : getInterest
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return Map<String,Object>
	 * Method 설명 : 회원 아이디로 관심지역의 구, 동코드, 관심업종코드를 가져오는 메서드
	 */
	Map<String, Object> getInterest(String member_id);
	
	/**
	 * Method : getReport
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return ReportVo
	 * Method 설명 : 분석보고서 코드로 분석보고서 객체를 가져오는 메서드
	 */
	ReportVo getReport(String report_cd);
	
	/**
	 * Method : getMargin
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return MarginVo
	 * Method 설명 : 분석보고서 코드로 분석설정정보를 가져오는 메서드
	 */
	MarginVo getMargin(String report_cd);
	
	/**
	 * Method : getMonthlyEp
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return MonthlyEpVo
	 * Method 설명 : 분석보고서 코드로 월소요비용을 가져오는 메서드
	 */
	MonthlyEpVo getMonthlyEp(String report_cd);
	
	/**
	 * Method : getAvgSales
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return AvgSalesVo
	 * Method 설명 : 분석보고서 코드로 동일상권 매출현황을 가져오는 메서드
	 */
	AvgSalesVo getAvgSales(String report_cd);
	
	/**
	 * Method : getSalesGoal
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return List<SalesGoalVo>
	 * Method 설명 : 분석보고서 코드로 목표매출 리스트를 가져오는 메서드
	 */
	List<SalesGoalVo> getSalesGoal(String report_cd);
}
