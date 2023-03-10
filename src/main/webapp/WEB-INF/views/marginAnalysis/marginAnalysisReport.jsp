<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
    
<style>
	#base {
		width : 69%;
		margin : 0 auto;
		color : black;
	}

	.span03 {
		cursor: pointer;
	}
	
	.table01 {
		width : 100%;
		cellspacing : 0;
		margin-top : 10px;
	}
	
	.table01 td {
		width : 33%;
		text-align : center;
	}
	
	.rightBox02 {
		margin-top : 10px;
	  	float: right;
	}
	
	.leftBox {
		text-align : center;
		width : 10%;
		float : left;
	}
	
	.rightBox {
		width : 90%;
		float : right;
	}
	
	hr {
		clear: both;
		border-width: 2px;
	}
	
	#div01 {
		background-color: floralwhite;
	}
	
	.card-body td:nth-child(even) {
		background-color : white;
	}
	
	#table02 {
		width : 100%;
	}
	
	#table02 td {
		text-align: center;
	}
	
	#table02 tr td:nth-child(even){
		text-align : right;
		width : 18%;
	}
	
	#table02 tr:nth-child(1) td, #table02 tr:nth-child(2) td{
		text-align: center;
	}
	
	#table02 tr td:nth-child(odd){
		width : 32%;
	}
	
	.val td:nth-child(even) {
		text-align: right;
		vertical-align: middle;
		background-color: white;
	}
	
	.val td:nth-child(odd) {
		background-color: #f8f9fc;
	}
	
	#tt {
		text-align: right;
		background-color: seashell;
	}
	
	.tip {
		background-color: rgb(245,246,241);
	}
	
	.tt2 {
		background-color: seashell;
	}
	
	.tt3 {
		background-color: white;
	}
	
	.td1 {
		width : 30%; 
	}
	
	.td2 {
		width : 20%; 
	}
	
	.table03 {
		width : 100%;
	}
	
	.table03 tr:nth-child(1) td {
		width : 16%;
		text-align: center;
	}
	
	.table03 tr:nth-child(1) td:nth-child(1){
		width : 20%;
	}
	
	.table03 td {
		text-align: center;
	}
	
	.span01 {
		color : #4e73df;
		font-size: 1.2em;
		font-weight : bold;
	}
	
	.span02 {
		font-size: 1.2em;
		font-weight : bold;
	}
	
	#infoTable tr td{
		width : 38%;
	}
	
	#infoTable tr td:nth-child(1){
		width : 24%;
	}
	
</style>

<script>
	$(document).ready(function(){
		// 수익분석에서 바로 접근한 것이 아니면 다시분석 버튼이 안 보이게 설정
		var path = "${path}";
		if(path == null || path.trim().length == 0){
			$("#reSubmit").attr("style", "display:none;");
			$("#p01").attr("style", "display:none;");
			$("#div02 input").attr("readonly", true);
		} 
		
		// 다시 분석 버튼을 클릭했을 때
		$("#reSubmit").on("click", function(e){
			e.preventDefault();
			
			var region_cd = "${reportVo.region_cd}";
			var tob_cd = "${reportVo.tob_cd}";
			
			$("#region_cd").val(region_cd);
			$("#tob_cd").val(tob_cd);

			
			// value가 없으면 placeholder,
			// placeholder 값도 없으면 기본값(0) 설정
			var idArr = ["ep_premium", "ep_deposit", "ep_loan", "ep_roi", "ep_iaf", "ep_investment", 
				"ep_monthly", "ep_personnel", "ep_material", "ep_etc", "ep_unit_cost"];
			
			for(i = 0; i < idArr.length; i++){
				var num = "0";
				if(idArr[i] == "ep_roi"){
					num = "0.0";
				}
				
				inputCheck(idArr[i], num);
			}
			
			var ep_premium = Number($("#ep_premium").val());
			var ep_deposit = Number($("#ep_deposit").val());
			var ep_iaf = Number($("#ep_iaf").val());
			var ep_investment = Number($("#ep_investment").val());
			
			$("#iv_total").val(ep_premium + ep_deposit + ep_iaf + ep_investment);
			
			var loan = Number($("#ep_loan").val());
			var roi = Number($("#ep_roi").val());
			
			// 대출금이 0이 아닌 경우 이자율도 0이 아닌 값을 입력해야 함
			if(loan != 0){
				if(roi == 0) {
					swal({
					    text: "대출금의 값이 있는 경우 이자율을 입력해주십시오.",
					    closeModal: false,
					    icon: "warning",
					}).then(function() {
				        swal.close();
				        $("#ep_roi").val("");
				        $("#ep_roi").focus();
					});
					return;
				}
			}
			
			// 이자율이 0이 아닌 경우 대출금도 0이 아닌 값을 입력해야 함
			if(roi != 0){
				if(loan == 0){
					swal({
					    text: "대출금을 입력해주십시오.",
					    closeModal: false,
					    icon: "warning",
					}).then(function() {
				        swal.close();
				        $("#ep_loan").val("");
				        $("#ep_loan").focus();
					});
					return;
				}
			}
			
			// 총 투자비용이 0이면 기타 투자비를 입력하도록 유도
			var iv = Number($("#iv_total").val());
			if(iv == 0){
				swal({
				    text: "총 투자비용이 0만원입니다. 기타투자비를 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#ep_investment").val("");
			        $("#ep_investment").focus();
				});
				return;
			}
			
			// 객단가는 필수입력값
			var unit = Number($("#ep_unit_cost").val());
			if(unit == 0){
				swal({
				    text: "객 단가를 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#ep_unit_cost").val("");
			        $("#ep_unit_cost").focus();
				});
				return;
			}
			
			$("#frm").submit();
		});
		
		// 엑셀 다운로드 버튼을 클릭했을 때
		$("#excelBtn").on("click", function(e){
			e.preventDefault();
			
			$("#form01").submit();
		});
		
		// PDF 다운로드 버튼을 클릭했을 때
		$("#pdfBtn").on("click", function(e){
			e.preventDefault();
			
			$("#pdf01").css("padding", "40px 40px 40px 20px");
			$("#pdf02").css("padding", "20px 40px 40px 20px");
			$("#pdf03").css("padding", "20px 40px 40px 20px");
			$("#result2").css("margin-top", "60px");
			$("#result4").css("margin-top", "220px");
			
	        html2canvas(document.querySelector("#base")).then(function(canvas) {
		        var imgData = canvas.toDataURL('image/png');
		        var imgWidth = 210;
		        var pageHeight = imgWidth * 1.414;
		        var imgHeight = canvas.height * imgWidth / canvas.width;
		        var heightLeft = imgHeight;
		        
		        var doc = new jsPDF({
			          'orientation': 'p',
			          'unit': 'mm',
			          'format': 'a4'
			        });
		        var position = 0;
		        
		        doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
		        heightLeft -= pageHeight;
		        
		        while (heightLeft >= 20) {
		            position = heightLeft - imgHeight;
		            doc.addPage();
		            doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
		            heightLeft -= pageHeight;
		        }

				doc.save('marginAnalysisReport.pdf');
		        
			});

			$("#pdf01").attr("style", "padding : 0px;");
			$("#pdf02").attr("style", "padding : 0px;");
			$("#pdf03").attr("style", "padding : 0px;");
			$("#result2").attr("style", "margin-top : 0px;");
			$("#result4").attr("style", "margin-top : 0px;");
	        
		});
	});

	// 스크롤 이동
	function fnMove(seq){
	    var offset = $("#result" + seq).offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	}
	
	function inputCheck(str, dv){
		var id = "#" + str;
		if($(id).val().trim().length == 0){
			var ph = $(id).attr("placeholder");
			
			if(ph.trim().length == 0){
				$(id).val(dv);
			} else {
				$(id).val(ph);
			}
		}
	}
	
</script>

<div id="base" class="col-sm-10 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<div id="pdf01">
		<h2 class="figure font-weight-bold text-left">수익분석 보고서&nbsp;</h2>
		<span class="span03" onclick="fnMove('1')">1. 목표 매출 및 고객 수&nbsp;</span>
		<span class="span03" onclick="fnMove('2')">2. 월 소요비용&nbsp;</span>
		<span class="span03" onclick="fnMove('3')">3. 동일 상권 매출현황&nbsp;</span>
		<span class="span03" onclick="fnMove('4')">4. 투자비 회수 시점별 목표매출&nbsp;</span>
		
		<div class="rightBox02">
			<a id="pdfBtn" href="#" class="btn btn-primary btn-icon-split btn-sm">
	          <span class="text">PDF다운로드</span>
	        </a>
			
			<a id="excelBtn" href="#" class="btn btn-primary btn-icon-split btn-sm">
	          <span class="text">EXCEL다운로드</span>
	        </a>
	        
	        <form id="form01" action="${pageContext.request.contextPath}/marginAnalysis/excel" method="post">
	        	<input type="hidden" name="report_cd" value="${reportVo.report_cd}"/>
	        </form>
        </div>
    
	    <hr>
		
		<br>
		
		<div class="table-responsive">
			<h5 class="font-weight-bold text-info text-left">분석 설정 정보</h5>
			
			<table id="infoTable" class="table table-bordered table01">
				<tbody>
					<tr class="bg-gray-200">
						<td>분석지역</td>
						<td>분석업종</td>
						<td>기준데이터시점</td>
					</tr>
		
					<tr class="tt3">
						<td>${marginVo.margin_region}</td>
						<td>${marginVo.margin_tob}</td>
						<td>${marginVo.margin_dt}</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<br><br>
		
		<div id="result1" class="table-responsive">
			<h5 class="figure font-weight-bold text-info text-left">1. 목표 매출 및 고객 수</h5>
			
			<span class="rightBox02">(세금 7% 납부, 월 영업일 24일 기준)</span>
			
			<table class="table table-bordered table01">
				<tbody>
					<tr class="bg-gray-200">
						<td>월평균 목표 매출</td>
						<td>일평균 목표 매출</td>
						<td>일평균 목표 고객 수</td>
					</tr>
		
					<tr class="tt2">
						<td><span class="span02" style="color:#f23065;"><fmt:formatNumber value="${sgList[0].m_sales}" pattern="#,###"/></span> 만원</td>
						<td><span class="span02" style="color:#f23065;"><fmt:formatNumber value="${sgList[0].d_sales}" pattern="#,###"/></span> 만원</td>
						<td><span class="span02" style="color:#f23065;"><fmt:formatNumber value="${sgList[0].d_customer}" pattern="#,###"/></span> 명</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<hr class="border-primary">
		
		<div>
			<div class="leftBox figure mt-4">
				<h6 class="font-weight-bold">분석결과</h6>
			</div>
			
			<div class="rightBox figure">
				<ul>
					<li> 초기투자비와 월비용(고정·변동)을 고려했을 때, 적정한 월 매출수준은 
						<span class="span01"><fmt:formatNumber value="${sgList[0].m_sales}" pattern="#,###"/></span>만원으로 분석됩니다. <br>
						이는 영업일 24일 기준으로는 일평균 <span class="span01"><fmt:formatNumber value="${sgList[0].d_sales}" pattern="#,###"/></span>만원 매출, 
						<span class="span01"><fmt:formatNumber value="${sgList[0].d_customer}" pattern="#,###"/></span>명의 고객을 유치해야 가능한 수치입니다. <br>
						* 적정 : 3년 이내 초기 투자비 회수</li>
				</ul>
			</div>
		</div>
		
		<hr class="border-primary">
		
		<div id="div01" class="card-body">
			<div class="table-responsive">
				<p>
					- 선택위치의 입지조건(평수, 층수, 전면면적, 가시성, 접근성 등) 및 점주역량에 따라 추정매출의 편차는 발생가능합니다.
				</p>
				
				<p id="p01">
					- 입력내용 (입력정보를 수정하신 후 [다시분석] 버튼을 누르시면 재분석이 가능합니다.)
				</p>
				
				<div id="div02">
					<%@include file="/WEB-INF/views/marginAnalysis/fundAdd.jsp" %>		
				</div>
				
				<div class="rightBox02">
					<a id="reSubmit" href="#" class="btn btn-primary btn-icon-split">
		                <span class="text">다시분석</span>
		            </a>
	            </div>
			</div>
		</div>
	</div>
	
	<br><br>
	
	<div id="pdf02">
		<div id="result2" class="table-responsive">
			<h5 class="font-weight-bold text-info text-left">2. 월 소요비용</h5>
			
			<table id="table02" class="table table-bordered">
				<tbody>
					<tr class="bg-gray-200">
						<td colspan="2">월 고정비용</td>
						<td colspan="2">월 변동비용</td>
					</tr>
		
					<tr class="bg-gray-100">
						<td class="td1">항목</td>
						<td class="td2">월 비용</td>
						<td class="td1">항목</td>
						<td class="td2">월 비용</td>
					</tr>
					
					<tr class="val">
						<td>
							월세<br>
							<span>(월 임차료 + 관리비 + 실비)</span>
						</td>
						<td><span class="span02"><fmt:formatNumber value="${monthlyEpVo.rent}" pattern="#,###"/></span> 만원</td>
						<td>
							재료비<br>
							<span>(매출원가)</span>
						</td>
						<td><span class="span02"><fmt:formatNumber value="${monthlyEpVo.material}" pattern="#,###"/></span> 만원</td>
					</tr>
	
					<tr class="val">
						<td>
							고정인건비<br>
							<span>(인건비의 70%로 계산)</span>
						</td>
						<td><span class="span02"><fmt:formatNumber value="${monthlyEpVo.fix_pe}" pattern="#,###"/></span> 만원</td>
						<td>
							변동인건비<br>
							<span>(인건비의 30%로 계산)</span>
						</td>
						<td><span class="span02"><fmt:formatNumber value="${monthlyEpVo.var_pe}" pattern="#,###"/></span> 만원</td>
					</tr>
	
					<tr class="val">
						<td>
							초기투자비용에 대한 월 발생비용<br>
							(감가상각비 + 대출금의 이자 + 총투자비 0.2%)
						</td>
						<td><span class="span02"><fmt:formatNumber value="${monthlyEpVo.cost}" pattern="#,###"/></span> 만원</td>
						<td></td>
						<td></td>
					</tr>
	
					<tr class="val">
						<td>
							기타운영비용<br>
							(복리후생비 + 수도광열비 + 세금과공과비 <br>
							 + 접대비 + 소모품비 + 마케팅비 <br>
							 + 교통비 + 통신비 + 지급수수료 등)
						</td>
						<td><span class="span02"><fmt:formatNumber value="${monthlyEpVo.etc}" pattern="#,###"/></span> 만원</td>
						<td></td>
						<td></td>
					</tr>
	
					<tr class="val">
						<td>소계</td>
						<td><span class="span02"><fmt:formatNumber value="${monthlyEpVo.total_fix}" pattern="#,###"/></span> 만원</td>
						<td>소계</td>
						<td><span class="span02"><fmt:formatNumber value="${monthlyEpVo.total_var}" pattern="#,###"/></span> 만원</td>
					</tr>
					
					<tr>
						<td colspan="3">총 비용(고정비용 + 변동비용)</td>
						<td id="tt"><span class="span02"><fmt:formatNumber value="${monthlyEpVo.total}" pattern="#,###"/></span> 만원</td>
					</tr>
				</tbody>
			</table>
			
			<div class="card col-12 p-0">
				<div class="card-header">
					<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-info-circle"></i> 도움말</h6>
				</div>
				<div class="card-body">
					<p>
						- 고정비용 : 판매량에 관계없이 월마다 꾸준히 지출되는 비용 <br>
						- 변동비용 : 판매량에 따라 월마다 달라지는 비용 <br>
						- 감가상각 기간 : 인테리어나 설비, 집기 등 기간이 지날수록 가치가 떨어져 교체해야 하는 시기까지의 기간 <br>
						&nbsp;&nbsp;기간은 5년, 감가상각방법은 정액법으로 일괄 적용하므로 참고하시기 바랍니다. <br>
					</p>
				</div>
			</div>
			
		</div>
		
		<br><br>
		
		<div id="result3" class="table-responsive">
			<h5 class="figure font-weight-bold text-info text-left">3. 동일 상권 매출현황</h5>
			
			<table class="table table-bordered table01">
				<tbody>
					<tr class="bg-gray-200">
						<td>월 평균 매출</td>
						<td>월 평균 결제건수</td>
						<td>1회 평균 결제금액</td>
					</tr>
		
					<tr>
						<td class="tt2"><span class="span02"><fmt:formatNumber value="${ageSalesVo.sales}" pattern="#,###"/></span> 만원</td>
						<td class="tt3"><span class="span02"><fmt:formatNumber value="${ageSalesVo.cnt}" pattern="#,###"/></span> 건</td>
						<td class="tt3"><span class="span02"><fmt:formatNumber value="${ageSalesVo.payment}" pattern="#,###"/></span> 원</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<hr class="border-primary">
		
		<div>
			<div class="leftBox figure mt-1">
				<h6 class="font-weight-bold">분석결과</h6>
			</div>
			
			<div class="rightBox figure">
				<ul>
					<li>동일 상권(동)의 매출현황은 월 평균매출 <span class="span01"><fmt:formatNumber value="${ageSalesVo.sales}" pattern="#,###"/></span>만원, 
					월 거래건수는 <span class="span01"><fmt:formatNumber value="${ageSalesVo.cnt}" pattern="#,###"/></span>건, 
					1회 평균 결제금액은 <span class="span01"><fmt:formatNumber value="${ageSalesVo.payment}" pattern="#,###"/></span>원입니다.</li>
				</ul>
			</div>
		</div>
		
		<hr class="border-primary">
		
		<div class="card col-12 p-0">
			<div class="card-header">
				<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-info-circle"></i> 도움말</h6>
			</div>
			<div class="card-body">
				<p>
					- 동일 상권(동)의 매출 등의 자료를 통해 예상 수익을 확인할 수 있습니다.
				</p>
			</div>
		</div>
	
	</div>
	
	<br><br>
	
	<div id="pdf03">
		<div id="result4" class="table-responsive">
			<h5 class="figure font-weight-bold text-info text-left">4. 투자비 회수 시점별 목표매출</h5>
			
			<span class="rightBox02">(세금 7% 납부, 월 영업일 24일 기준)</span>
			
			<table class="table table-bordered table03">
				<tbody>
					<tr class="bg-gray-200">
						<td colspan="2">투자비 회수</td>
						<td>월 목표 매출</td>
						<td>일 평균 목표 매출</td>
						<td>일 평균 목표 고객 수</td>
						<td>세금</td>
						<td>월 추정경상이익</td>
					</tr>
		
					<tr>
						<td rowspan="2" style="vertical-align: middle;">회수</td>
						<td class="tt2">3년 이내</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[0].m_sales}" pattern="#,###"/></span> 만원</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[0].d_sales}" pattern="#,###"/></span> 만원</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[0].d_customer}" pattern="#,###"/></span> 명</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[0].tax}" pattern="#,###"/></span> 만원</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[0].profit}" pattern="#,###"/></span> 만원</td>
					</tr>
	
					<tr>
						<td class="tt2">2년 이내</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[1].m_sales}" pattern="#,###"/></span> 만원</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[1].d_sales}" pattern="#,###"/></span> 만원</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[1].d_customer}" pattern="#,###"/></span> 명</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[1].tax}" pattern="#,###"/></span> 만원</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[1].profit}" pattern="#,###"/></span> 만원</td>
					</tr>
					
					<tr>
						<td>회수불가</td>
						<td class="tt2">손익분기점</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[2].m_sales}" pattern="#,###"/></span> 만원</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[2].d_sales}" pattern="#,###"/></span> 만원</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[2].d_customer}" pattern="#,###"/></span> 명</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[2].tax}" pattern="#,###"/></span> 만원</td>
						<td class="text-right tt3"><span class="span02"><fmt:formatNumber value="${sgList[2].profit}" pattern="#,###"/></span> 만원</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<hr class="border-primary">
		
		<div>
			<div class="leftBox figure mt-5 pt-3">
				<h6 class="font-weight-bold">분석결과</h6>
			</div>
			
			<div class="rightBox figure">
				<ul>
					<li>
						초기투자비와 월비용(고정·변동)을 고려했을 때, 3년 이내 초기투자비 회수가 가능하려면 월 목표매출은 
						<span class="span01"><fmt:formatNumber value="${sgList[0].m_sales}" pattern="#,###"/></span>만원 이상, <br>
						일평균 목표매출은 <span class="span01"><fmt:formatNumber value="${sgList[0].d_sales}" pattern="#,###"/></span>만원 이상, 
						일 평균 목표고객은 <span class="span01"><fmt:formatNumber value="${sgList[0].d_customer}" pattern="#,###"/></span>명 이상 유치되어야 합니다.
					</li>
					<li>
						또한 2년 이내 초기투자비를 회수하려면 월 목표매출은 <span class="span01"><fmt:formatNumber value="${sgList[1].m_sales}" pattern="#,###"/></span>만원 이상, 
						일평균 목표매출은 <span class="span01"><fmt:formatNumber value="${sgList[1].d_sales}" pattern="#,###"/></span>만원 이상, <br>
						일 평균 목표고객은 <span class="span01"><fmt:formatNumber value="${sgList[1].d_customer}" pattern="#,###"/></span>명 이상 유치되어야 합니다.
					</li>			
					<li>
						추가적으로 초기투자비 회수는 불가하나, 월비용(고정·변동) 대비 손해를 보지 않는 손익분기 기준은 월평균 
						<span class="span01"><fmt:formatNumber value="${sgList[2].m_sales}" pattern="#,###"/></span>만원 이상, <br>
						일평균 <span class="span01"><fmt:formatNumber value="${sgList[2].d_sales}" pattern="#,###"/></span>만원 이상, 
						일평균 목표고객 <span class="span01"><fmt:formatNumber value="${sgList[2].d_customer}" pattern="#,###"/></span>명 이상입니다.
					</li>			
				</ul>
			</div>
		</div>
		<hr class="border-primary">
	</div>
</div>