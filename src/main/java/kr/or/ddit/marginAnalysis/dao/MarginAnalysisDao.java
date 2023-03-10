package kr.or.ddit.marginAnalysis.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.marginAnalysis.model.AvgSalesVo;
import kr.or.ddit.marginAnalysis.model.ExpenseVo;
import kr.or.ddit.marginAnalysis.model.FundVo;
import kr.or.ddit.marginAnalysis.model.MarginVo;
import kr.or.ddit.marginAnalysis.model.MonthlyEpVo;
import kr.or.ddit.marginAnalysis.model.SalesGoalVo;
import kr.or.ddit.report.model.ReportVo;

@Repository
public class MarginAnalysisDao implements IMarginAnalysisDao {

	@Resource(name="sqlSession")
	private SqlSessionTemplate sqlSession;
	
	@Override
	public FundVo getFund(String tob_cd) {
		return sqlSession.selectOne("margin.getFund", tob_cd);
	}

	@Override
	public String insertReport(ReportVo reportVo) {
		sqlSession.insert("margin.insertReport", reportVo);
		return reportVo.getReport_cd();
	}

	@Override
	public int insertExpense(ExpenseVo expenseVo) {
		return sqlSession.insert("margin.insertExpense", expenseVo);
	}

	@Override
	public ExpenseVo getExpense(String report_cd) {
		return sqlSession.selectOne("margin.getExpense", report_cd);
	}

	@Override
	public AvgSalesVo getSales(long region_cd) {
		return sqlSession.selectOne("margin.getSales", region_cd);
	}

	@Override
	public String getTobNames(String tob_cd) {
		return sqlSession.selectOne("margin.getTobNames", tob_cd);
	}

	@Override
	public String getRegionNames(long region_cd) {
		return sqlSession.selectOne("margin.getRegionNames", region_cd);
	}

	@Override
	public String getDataDt() {
		return sqlSession.selectOne("margin.getDataDt");
	}

	@Override
	public ReportVo getReport(String report_cd) {
		return sqlSession.selectOne("margin.getReport", report_cd);
	}

	@Override
	public Map<String, Object> getInterest(String member_id) {
		return sqlSession.selectOne("margin.getInterest", member_id);
	}

	@Override
	public int insertMargin(MarginVo marginVo) {
		return sqlSession.insert("margin.insertMargin", marginVo);
	}

	@Override
	public int insertMonthlyEp(MonthlyEpVo monthlyEpVo) {
		return sqlSession.insert("margin.insertMonthlyEp", monthlyEpVo);
	}

	@Override
	public int insertAvgSales(AvgSalesVo avgSalesVo) {
		return sqlSession.insert("margin.insertAvgSales", avgSalesVo);
	}

	@Override
	public int insertSalesGoal(SalesGoalVo salesGoalVo) {
		return sqlSession.insert("margin.insertSalesGoal", salesGoalVo);
	}

	@Override
	public MarginVo getMargin(String report_cd) {
		return sqlSession.selectOne("margin.getMargin", report_cd);
	}

	@Override
	public MonthlyEpVo getMonthlyEp(String report_cd) {
		return sqlSession.selectOne("margin.getMonthlyEp", report_cd);
	}

	@Override
	public AvgSalesVo getAvgSales(String report_cd) {
		return sqlSession.selectOne("margin.getAvgSales", report_cd);
	}

	@Override
	public List<SalesGoalVo> getSalesGoal(String report_cd) {
		return sqlSession.selectList("margin.getSalesGoal", report_cd);
	}

}
