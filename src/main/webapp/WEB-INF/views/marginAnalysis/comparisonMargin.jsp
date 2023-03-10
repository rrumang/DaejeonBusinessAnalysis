<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<style>
	tr{
		background-color : white;
	}

	#div01 {
		width : 69%;
		margin : 0 auto;
		color : black;
	}

	.span01 {
		cursor: pointer;
	}
	
	#table01 tr td {
		width: 38%;
		vertical-align: middle;
	}
	
	#table01 tr td:nth-child(1){
		width : 24%;
	}
	
	#table02 tr td, #table03 tr td, #table05 tr td{
		width : 33%;
		vertical-align: middle;
	}
	
	#table04 tr td {
		width : 25%;
		vertical-align: middle;
	}
	
	#table04 tr td:nth-child(1){
		width : 50%;
	}
	
	.tt {
		background-color: seashell;
	}
	
</style>

<script>
	$(document).ready(function(){
		var region01 = "${marginVo1.margin_region}";
		var region02 = "${marginVo2.margin_region}";
		
		region01 = region01.substring(region01.lastIndexOf(" ")+1);
		region02 = region02.substring(region02.lastIndexOf(" ")+1);
		
		var tob01 = "${marginVo1.margin_tob}";
		var tob02 = "${marginVo2.margin_tob}";

		tob01 = tob01.substring(tob01.lastIndexOf(" ")+1);
		tob02 = tob02.substring(tob02.lastIndexOf(" ")+1);
		
	    $(".report01").each(function(){
			$(this).append(region01 + "<br>" + tob01);
	    });

	    $(".report02").each(function(){
			$(this).append(region02 + "<br>" + tob02);
	    });
	});

	// 스크롤 이동
	function fnMove(seq){
	    var offset = $("#result" + seq).offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	}
	
</script>

<div id="div01" class="col-sm-10 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<div>
		<h2 class="figure font-weight-bold text-left">수익분석 비교 보고서&nbsp;</h2>
		<span class="span01" onclick="fnMove('1')">1. 목표 매출 및 고객 수&nbsp;</span>
		<span class="span01" onclick="fnMove('2')">2. 월 소요비용&nbsp;</span>
		<span class="span01" onclick="fnMove('3')">3. 동일 상권 매출현황&nbsp;</span>
		<span class="span01" onclick="fnMove('4')">4. 투자비 회수 시점별 목표매출&nbsp;</span>
		
	</div>
	
    <hr>
    
	<br>
	
	<div class="table-responsive">
		<h5 class="font-weight-bold text-info text-left">분석 설정 정보</h5>
		
		<table id="table01" class="table table-bordered text-center table01">
			<tbody>
				<tr class="bg-gray-200">
					<td>구분</td>
					<td>No.${fn:substring(marginVo1.report_cd,6,fn:length(marginVo1.report_cd))}</td>
					<td>No.${fn:substring(marginVo2.report_cd,6,fn:length(marginVo2.report_cd))}</td>
				</tr>
	
				<tr>
					<td class="bg-gray-100">분석지역</td>
					<td>${marginVo1.margin_region}</td>
					<td>${marginVo2.margin_region}</td>
				</tr>

				<tr>
					<td class="bg-gray-100">분석업종</td>
					<td>${marginVo1.margin_tob}</td>
					<td>${marginVo2.margin_tob}</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<br><br>
	
	<div id="result1" class="table-responsive">
		<h5 class="figure font-weight-bold text-info text-left">1. 목표 매출 및 고객 수</h5>
		
		<table id="table02" class="table table-bordered text-right">
			<tbody>
				<tr class="bg-gray-200 text-center">
					<td>구분</td>
					<td class="report01"></td>
					<td class="report02"></td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">월평균 목표 매출</td>
					<td class="tt"><span><fmt:formatNumber value="${sgList1[0].m_sales}" pattern="#,###"/></span> 만원</td>
					<td class="tt"><span><fmt:formatNumber value="${sgList2[0].m_sales}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">일평균 목표 매출</td>
					<td class="tt"><span><fmt:formatNumber value="${sgList1[0].d_sales}" pattern="#,###"/></span> 만원</td>
					<td class="tt"><span><fmt:formatNumber value="${sgList2[0].d_sales}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">일평균 목표 고객 수</td>
					<td class="tt"><span><fmt:formatNumber value="${sgList1[0].d_customer}" pattern="#,###"/></span> 명</td>
					<td class="tt"><span><fmt:formatNumber value="${sgList2[0].d_customer}" pattern="#,###"/></span> 명</td>
				</tr>
			</tbody>
		</table>
		
		<hr>
		
		<table id="table03" class="table table-bordered text-right">
			<tbody>
				<tr class="bg-gray-200 text-center">
					<td>구분</td>
					<td class="report01"></td>
					<td class="report02"></td>
				</tr>
				
				<tr class="bg-gray-100 text-center">
					<td colspan="3">초기투자비용</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">권리금</td>
					<td><span><fmt:formatNumber value="${expenseVo1.ep_premium}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${expenseVo2.ep_premium}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">보증금</td>
					<td><span><fmt:formatNumber value="${expenseVo1.ep_deposit}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${expenseVo2.ep_deposit}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">대출금</td>
					<td><span><fmt:formatNumber value="${expenseVo1.ep_loan}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${expenseVo2.ep_loan}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">이자율</td>
					<td><span>${expenseVo1.ep_roi}</span> %</td>
					<td><span>${expenseVo2.ep_roi}</span> %</td>
				</tr>
				
				<tr>
					<td colspan="3" class="bg-gray-100 text-center">기타투자비용</td>				
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">인테리어 및 설비비</td>
					<td><span><fmt:formatNumber value="${expenseVo1.ep_iaf}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${expenseVo2.ep_iaf}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">기타투자비</td>
					<td><span><fmt:formatNumber value="${expenseVo1.ep_investment}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${expenseVo2.ep_investment}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">총 투자비용</td>
					<td class="tt"><span><fmt:formatNumber value="${expenseVo1.ep_premium + expenseVo1.ep_deposit + expenseVo1.ep_iaf + expenseVo1.ep_investment}" pattern="#,###"/></span> 만원</td>
					<td class="tt"><span><fmt:formatNumber value="${expenseVo2.ep_premium + expenseVo2.ep_deposit + expenseVo2.ep_iaf + expenseVo2.ep_investment}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">감가상각 대상 투자비용</td>
					<td class="tt"><span><fmt:formatNumber value="${expenseVo1.ep_premium + expenseVo1.ep_iaf + expenseVo1.ep_investment}" pattern="#,###"/></span> 만원</td>
					<td class="tt"><span><fmt:formatNumber value="${expenseVo2.ep_premium + expenseVo2.ep_iaf + expenseVo2.ep_investment}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr class="bg-gray-100 text-center">
					<td colspan="3">운영비용</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">월세</td>
					<td><span><fmt:formatNumber value="${expenseVo1.ep_monthly}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${expenseVo2.ep_monthly}" pattern="#,###"/></span> 만원</td>
				</tr>

				<tr>
					<td class="bg-gray-100 text-center">인건비</td>
					<td><span><fmt:formatNumber value="${expenseVo1.ep_personnel}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${expenseVo2.ep_personnel}" pattern="#,###"/></span> 만원</td>
				</tr>

				<tr>
					<td class="bg-gray-100 text-center">재료비</td>
					<td><span><fmt:formatNumber value="${expenseVo1.ep_material}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${expenseVo2.ep_material}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">기타운영비</td>
					<td><span><fmt:formatNumber value="${expenseVo1.ep_etc}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${expenseVo2.ep_etc}" pattern="#,###"/></span> 만원</td>	
				</tr>

				<tr>
					<td class="bg-gray-100 text-center">총 운영비용</td>
					<td class="tt"><span><fmt:formatNumber value="${expenseVo1.ep_monthly + expenseVo1.ep_personnel + expenseVo1.ep_material + expenseVo1.ep_etc}" pattern="#,###"/></span> 만원</td>
					<td class="tt"><span><fmt:formatNumber value="${expenseVo2.ep_monthly + expenseVo2.ep_personnel + expenseVo2.ep_material + expenseVo2.ep_etc}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">객 단가</td>
					<td class="tt"><span><fmt:formatNumber value="${expenseVo1.ep_unit_cost}" pattern="#,###"/></span> 원</td>
					<td class="tt"><span><fmt:formatNumber value="${expenseVo2.ep_unit_cost}" pattern="#,###"/></span> 원</td>
				</tr>
				
			</tbody>
		</table>
	</div>
	
	<br><br>
	
	<div id="result2" class="table-responsive">
		<h5 class="font-weight-bold text-info text-left">2. 월 소요비용</h5>
		
		<table id="table04" class="table table-bordered text-right">
			<tbody>
				<tr class="bg-gray-200 text-center">
					<td>구분</td>
					<td class="report01"></td>
					<td class="report02"></td>
				</tr>
			
				<tr>
					<td class="bg-gray-100 text-center">
						월세<br>
						<span>(월 임차료 + 관리비 + 실비)</span>
					</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo1.rent}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo2.rent}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">
						고정인건비<br>
						<span>(인건비의 70%로 계산)</span>
					</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo1.fix_pe}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo2.fix_pe}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">
						초기투자비용에 대한 월 발생비용<br>
						(감가상각비 + 대출금의 이자 + 총투자비 0.2%)
					</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo1.cost}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo2.cost}" pattern="#,###"/></span> 만원</td>
				</tr>

				<tr>
					<td class="bg-gray-100 text-center">
						기타운영비용<br>
						(복리후생비 + 수도광열비 + 세금과공과비 + 접대비 + 소모품비 <br>
						 + 마케팅비 + 교통비 + 통신비 + 지급수수료 등)
					</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo1.etc}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo2.etc}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr class="bg-gray-100">
					<td class="text-center">월 고정비용 소계</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo1.total_fix}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo2.total_fix}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">
						재료비<br>
						<span>(매출원가)</span>
					</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo1.material}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo2.material}" pattern="#,###"/></span> 만원</td>
				</tr>

				<tr>
					<td class="bg-gray-100 text-center">
						변동인건비<br>
						<span>(인건비의 30%로 계산)</span>
					</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo1.var_pe}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo2.var_pe}" pattern="#,###"/></span> 만원</td>
				</tr>

				<tr class="bg-gray-100">
					<td class="text-center">월 변동비용 소계</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo1.total_var}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${monthlyEpVo2.total_var}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">총 비용(고정비용 + 변동비용)</td>
					<td class="tt"><span><fmt:formatNumber value="${monthlyEpVo1.total}" pattern="#,###"/></span> 만원</td>
					<td class="tt"><span><fmt:formatNumber value="${monthlyEpVo2.total}" pattern="#,###"/></span> 만원</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<br><br>
	
	<div id="result3" class="table-responsive">
		<h5 class="figure font-weight-bold text-info text-left">3. 동일 상권 매출현황</h5>
		
		<table id="table05" class="table table-bordered text-right">
			<tbody>
				<tr class="bg-gray-200 text-center">
					<td>구분</td>
					<td class="report01"></td>
					<td class="report02"></td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">월 평균 매출</td>
					<td class="tt"><span><fmt:formatNumber value="${ageSalesVo1.sales}" pattern="#,###"/></span> 만원</td>
					<td class="tt"><span><fmt:formatNumber value="${ageSalesVo2.sales}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">월 평균 결제건수</td>
					<td><span><fmt:formatNumber value="${ageSalesVo1.cnt}" pattern="#,###"/></span> 건</td>
					<td><span><fmt:formatNumber value="${ageSalesVo2.cnt}" pattern="#,###"/></span> 건</td>
				</tr>
	
				<tr>
					<td class="bg-gray-100 text-center">1회 평균 결제금액</td>
					<td><span><fmt:formatNumber value="${ageSalesVo1.payment}" pattern="#,###"/></span> 원</td>
					<td><span><fmt:formatNumber value="${ageSalesVo2.payment}" pattern="#,###"/></span> 원</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<br><br>
	
	<div id="result4" class="table-responsive">
		<h5 class="figure font-weight-bold text-info text-left">4. 투자비 회수 시점별 목표매출</h5>
		
		<table id="table06" class="table table-bordered text-right">
			<tbody>
				<tr class="bg-gray-200 text-center">
					<td>구분</td>
					<td class="report01" colspan="3"></td>
					<td class="report02" colspan="3"></td>
				</tr>
				
				<tr class="bg-gray-100 text-center">
					<td rowspan="2" style="vertical-align: middle;">투자비 회수</td>
					<td colspan="2">회수</td>
					<td>회수불가</td>
					<td colspan="2">회수</td>
					<td>회수불가</td>
				</tr>
				
				<tr class="text-center tt">
					<td>3년 이내</td>
					<td>2년 이내</td>
					<td>손익분기점</td>
					<td>3년 이내</td>
					<td>2년 이내</td>
					<td>손익분기점</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">월 목표 매출</td>
					<td><span><fmt:formatNumber value="${sgList1[0].m_sales}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList1[1].m_sales}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList1[2].m_sales}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList2[0].m_sales}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList2[1].m_sales}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList2[2].m_sales}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">일 평균 목표 매출</td>
					<td><span><fmt:formatNumber value="${sgList1[0].d_sales}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList1[1].d_sales}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList1[2].d_sales}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList2[0].d_sales}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList2[1].d_sales}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList2[2].d_sales}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">일 평균 목표 고객 수</td>
					<td><span><fmt:formatNumber value="${sgList1[0].d_customer}" pattern="#,###"/></span> 명</td>
					<td><span><fmt:formatNumber value="${sgList1[1].d_customer}" pattern="#,###"/></span> 명</td>
					<td><span><fmt:formatNumber value="${sgList1[2].d_customer}" pattern="#,###"/></span> 명</td>
					<td><span><fmt:formatNumber value="${sgList2[0].d_customer}" pattern="#,###"/></span> 명</td>
					<td><span><fmt:formatNumber value="${sgList2[1].d_customer}" pattern="#,###"/></span> 명</td>
					<td><span><fmt:formatNumber value="${sgList2[2].d_customer}" pattern="#,###"/></span> 명</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">세금</td>
					<td><span><fmt:formatNumber value="${sgList1[0].tax}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList1[1].tax}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList1[2].tax}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList2[0].tax}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList2[1].tax}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList2[2].tax}" pattern="#,###"/></span> 만원</td>
				</tr>
				
				<tr>
					<td class="bg-gray-100 text-center">월 추정경상이익</td>
					<td><span><fmt:formatNumber value="${sgList1[0].profit}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList1[1].profit}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList1[2].profit}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList2[0].profit}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList2[1].profit}" pattern="#,###"/></span> 만원</td>
					<td><span><fmt:formatNumber value="${sgList2[2].profit}" pattern="#,###"/></span> 만원</td>
				</tr>
			</tbody>
		</table>
	</div>
	
</div>
<br><br>