package kr.or.ddit.marginAnalysis.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.or.ddit.marginAnalysis.dao.IMarginAnalysisDao;
import kr.or.ddit.marginAnalysis.model.AvgSalesVo;
import kr.or.ddit.marginAnalysis.model.ExpenseVo;
import kr.or.ddit.marginAnalysis.model.FundVo;
import kr.or.ddit.marginAnalysis.model.MarginVo;
import kr.or.ddit.marginAnalysis.model.MonthlyEpVo;
import kr.or.ddit.marginAnalysis.model.SalesGoalVo;
import kr.or.ddit.report.model.ReportVo;

@Service
public class MarginAnalysisService implements IMarginAnalysisService {
	
	@Resource(name="marginAnalysisDao")
	private IMarginAnalysisDao dao;
	
	@Override
	public FundVo getFund(String tob_cd) {
		return dao.getFund(tob_cd);
	}

	@Override
	public String insertReport(ReportVo reportVo) {
		return dao.insertReport(reportVo);
	}

	@Override
	public int insertExpense(ExpenseVo expenseVo) {
		return dao.insertExpense(expenseVo);
	}

	@Override
	public ExpenseVo getExpense(String report_cd) {
		return dao.getExpense(report_cd);
	}
	
	@Override
	public AvgSalesVo getSales(ReportVo reportVo) {
		AvgSalesVo avgSalesVo = dao.getSales(reportVo.getRegion_cd());
		avgSalesVo.setReport_cd(reportVo.getReport_cd());
		
		// 동일상권 매출현황 DB에 저장
		dao.insertAvgSales(avgSalesVo);
		return avgSalesVo;
	}
	
	@Override
	public MonthlyEpVo calculatedMonthly(String report_cd) {
		ExpenseVo expenseVo = getExpense(report_cd);
		
		MonthlyEpVo monthlyEpVo = new MonthlyEpVo();
		
		// 월세
		int rent = expenseVo.getEp_monthly();
		monthlyEpVo.setRent(rent);
		
		int fixed_pe = 0;
		int variable_pe = 0;
		if(expenseVo.getEp_personnel() != 0) {
			// 고정 인건비
			fixed_pe = (int)Math.round(expenseVo.getEp_personnel() * 0.7);
			monthlyEpVo.setFix_pe(fixed_pe);
			
			// 변동인건비
			variable_pe = (int)Math.round(expenseVo.getEp_personnel() * 0.3);
			monthlyEpVo.setVar_pe(variable_pe);
		}
		
		// 감가상각대상투자비용
		int depreciation_investment = expenseVo.getEp_premium() 
				+ expenseVo.getEp_iaf() + expenseVo.getEp_investment();
		
		// 이자비용
		int interest = 0;
		if(expenseVo.getEp_loan() != 0) {
			interest = (int)Math.round(expenseVo.getEp_loan() * expenseVo.getEp_roi() / 100 / 12);
		}
		
		// 총 투자비용
		int total_investment = expenseVo.getEp_premium() + expenseVo.getEp_deposit()
				+ expenseVo.getEp_iaf() + expenseVo.getEp_investment();
		
		// 감가상각비 : 5년
		int depreciation_cost = (int)Math.round(depreciation_investment / 5 / 12);
		
		// 초기투자비용에 대한 월 발생비용 (감가상각비 + 이자비용 + 총투자비용 * 0.002)
		int cost = depreciation_cost + interest + (int) Math.round(total_investment * 0.002);
		monthlyEpVo.setCost(cost);
		
		// 기타운영비용
		int etc = expenseVo.getEp_etc();
		monthlyEpVo.setEtc(etc);
		
		// 재료비
		int material = expenseVo.getEp_material();
		monthlyEpVo.setMaterial(material);
		
		// 고정비용 합
		int fixed = rent + fixed_pe + cost + etc;
		monthlyEpVo.setTotal_fix(fixed);
		
		// 변동비용 합
		int variable = material + variable_pe;
		monthlyEpVo.setTotal_var(variable);
		
		// 전체 합
		int total = fixed + variable;
		monthlyEpVo.setTotal(total);
		
		// 월소요비용 DB에 저장
		monthlyEpVo.setReport_cd(report_cd);
		dao.insertMonthlyEp(monthlyEpVo);
		
		return monthlyEpVo;
	}

	@Override
	public List<SalesGoalVo> calculatedSalesGoal(String report_cd) {
		List<SalesGoalVo> list = new ArrayList<SalesGoalVo>();
		
		ExpenseVo expenseVo = dao.getExpense(report_cd);
		MonthlyEpVo monthlyVo = dao.getMonthlyEp(report_cd);
		
		// 월 소요비용 합
		int total = monthlyVo.getTotal();
		
		// 객 단가
		int unit_cost = expenseVo.getEp_unit_cost();
		
		// 3년 이내 회수
		int threeProfit = getProfit(expenseVo, 36);
		SalesGoalVo three = resultSalesGoal(threeProfit, total, unit_cost);
		three.setReport_cd(report_cd);
		three.setSg_peroid(3);
		
		// DB에 저장
		dao.insertSalesGoal(three);
		list.add(three);
		
		// 2년 이내 회수
		int twoProfit = getProfit(expenseVo, 24);
		SalesGoalVo two = resultSalesGoal(twoProfit, total, unit_cost);
		two.setReport_cd(report_cd);
		two.setSg_peroid(2);
		
		// DB에 저장
		dao.insertSalesGoal(two);
		list.add(two);
		
		// 손익분기점
		SalesGoalVo zero = resultSalesGoal(0,total, unit_cost);
		zero.setReport_cd(report_cd);
		zero.setSg_peroid(0);
		
		// DB에 저장
		dao.insertSalesGoal(zero);
		list.add(zero);
		
		return list;
	}
	
	/**
	 * Method : getProfit
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return int
	 * Method 설명 : 월 추정 경상이익을 산출하는 메서드
	 */
	public int getProfit(ExpenseVo expenseVo, int month) {
		// 총 투자비
		int total_investment = expenseVo.getEp_premium() + expenseVo.getEp_deposit() + expenseVo.getEp_iaf() + expenseVo.getEp_investment();
		
		// 월 추정 경상이익 : 총 투자비 / 회수기간월수
		int profit = (int) Math.round(total_investment / month);
		
		return profit;
	}
	
	/**
	 * Method : resultSalesGoal
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return SalesGoalVo
	 * Method 설명 :  회수기간별 매출금액 등을 산출하는 메서드
	 * @param profit : 월 추정 경상이익
	 * @param total : 월 소요비용
	 * @param unit_cost : 객 단가
	 */
	public SalesGoalVo resultSalesGoal(int profit, int total, int unit_cost) {
		SalesGoalVo salesGoalVo = new SalesGoalVo();
		
		// 월 추정 경상이익
		salesGoalVo.setProfit(profit);
		
		// 0.07 == 세율
		// 세금 : ((월 소요비용 + 월 추정 경상이익) * 1.07) * 0.07
		int tax = (int)Math.round(((total + profit) * 1.07) * 0.07);
		salesGoalVo.setTax(tax);
		
		// 월 목표 매출 : 월 소요비용 + 세금 + 월 추정경상이익
		int monthly_sales = total + tax + profit;
		salesGoalVo.setM_sales(monthly_sales);
		
		// 일 평균 목표 매출 : 월 목표매출 / 24 (영업일수:고정)
		int daily_sales = (int)Math.round(monthly_sales / 24);
		salesGoalVo.setD_sales(daily_sales);
		
		// 일 평균 목표 고객 수 : 일 평균 목표매출 * 10000 / 객 단가
		// 일 평균 목표매출은 만원 단위, 객 단가는 원 단위 이므로 단위 맞춤
		int daily_customer = (int)Math.round(daily_sales * 10000 / unit_cost);
		salesGoalVo.setD_customer(daily_customer);
		
		return salesGoalVo;
	}

	@Override
	public MarginVo getInfo(String report_cd) {
		
		// 분석보고서
		ReportVo reportVo = dao.getReport(report_cd);
		
		// 분석지역
		String margin_region = dao.getRegionNames(reportVo.getRegion_cd());
		
		// 분석업종
		String margin_tob = dao.getTobNames(reportVo.getTob_cd());
		
		// 기준데이터시점
		String margin_dt = dao.getDataDt();
		
		// DB에 저장
		MarginVo marginVo = new MarginVo(report_cd, margin_region, margin_tob, margin_dt);
		dao.insertMargin(marginVo);
		
		return marginVo;
	}

	@Override
	public Map<String, Object> getInterest(String member_id) {
		return dao.getInterest(member_id);
	}

	@Override
	public ReportVo getReport(String report_cd) {
		return dao.getReport(report_cd);
	}

	@Override
	public MarginVo getMargin(String report_cd) {
		return dao.getMargin(report_cd);
	}

	@Override
	public MonthlyEpVo getMonthlyEp(String report_cd) {
		return dao.getMonthlyEp(report_cd);
	}

	@Override
	public AvgSalesVo getAvgSales(String report_cd) {
		return dao.getAvgSales(report_cd);
	}

	@Override
	public List<SalesGoalVo> getSalesGoal(String report_cd) {
		return dao.getSalesGoal(report_cd);
	}

}
