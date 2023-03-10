<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 성장성/안정성/구매력/집객력의 각 합산 점수 및 평가종합점수 셋팅 -->
<!-- 1번 보고서 -->
<c:set var="growth1" value="${evalInfo1.evaluation_sales_growth + evalInfo1.evaluation_important }"/>
<c:set var="stability1" value="${evalInfo1.evaluation_variability + evalInfo1.evaluation_closure}"/>
<c:set var="purchasePower1" value="${evalInfo1.evaluation_sales_scale + evalInfo1.evaluation_payment + evalInfo1.evaluation_consumptionlevel }"/>
<c:set var="visitPower1" value="${evalInfo1.evaluation_pp + evalInfo1.evaluation_lp + evalInfo1.evaluation_wp}"/>
<c:set var="evaluation1" value="${growth1 + stability1 + purchasePower1 + visitPower1}"/>

<!-- 2번 보고서 -->
<c:set var="growth2" value="${evalInfo2.evaluation_sales_growth + evalInfo2.evaluation_important }"/>
<c:set var="stability2" value="${evalInfo2.evaluation_variability + evalInfo2.evaluation_closure}"/>
<c:set var="purchasePower2" value="${evalInfo2.evaluation_sales_scale + evalInfo2.evaluation_payment + evalInfo2.evaluation_consumptionlevel }"/>
<c:set var="visitPower2" value="${evalInfo2.evaluation_pp + evalInfo2.evaluation_lp + evalInfo2.evaluation_wp}"/>
<c:set var="evaluation2" value="${growth2 + stability2 + purchasePower2 + visitPower2}"/>
	
<!-- chartjs cdn 등록 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.js"></script>
<!-- 카카오 맵 api 등록 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9e96d9b8ca5bed0ac8c0a0ebf8487a10&libraries=services"></script>

<script>
$(document).ready(function(){
	bdAppraisalReportChartSetting();
	
})
/* 스크롤 이동 */
function fnMove(node){
	console.log($(node).data('no'));
	console.log($(node).data('kind'));
	var kind = $(node).data('kind');
	var no = $(node).data('no');
	
    var offset = $("#"+kind+no).offset();
    $('html, body').animate({scrollTop : offset.top}, 400);
}

function bdAppraisalReportChartSetting(){
	/*	상권평가 메뉴의 그래프 셋팅	 */
	var radar = $("#totalRadar");
	
	var myRadar = new Chart(radar, {
		type: 'radar',   // radar차트로 지정
		data: {
			labels : ['성장성', '안정성', '구매력', '집객력'],
			datasets:[ {
				label : '${regNames1.DONG}',
				data : [${growth1}, ${stability1},${purchasePower1},${visitPower1}],    // 위 라벨 순서대로 데이터가 매핑된다
				borderColor : 'rgb(92, 92, 138)',
				borderWidth: 4,
				fill:false
			},{
				label : '${regNames2.DONG}',
				data : [${growth2}, ${stability2},${purchasePower2},${visitPower2}],    // 위 라벨 순서대로 데이터가 매핑된다
				borderColor : 'rgb(255, 133, 51)',		
				borderWidth: 4,
				fill:false
			}]
		},
		options : {
			legend:{
				position : "bottom"
			},
			maintainAspectRatio : true,
			scale : {
				ticks : {
					beginAtZero : true,
					max : 25
				}
			}
			
		}
		
	}); 
	
}

function tobReportChartSetting(){
	/*	업종분석 메뉴의 그래프 셋팅	 */
	// 1. 업종별 추이 그래프
	var upjongCnt = $("#flowUpjong");
	// 2. 지역별 추이 그래프
	var regTobTrends = $("#RegionalTrends");
	// 3. 업종 생애주기 그래프
	var tobLC = $("#tobLC");
	
	var upjongCntChart = new Chart(upjongCnt, {
		type: 'bar',
		data: {
			labels : [
				<c:forEach items="${topCntRos1}" var="item" varStatus="status">
					<c:set value="${item.bd_dt}01000000" var="dt"/>
					<fmt:parseDate value="${dt}" var="topCntRos1_dt" pattern="yyyyMMddHHmmss"/>
					<c:choose>
						<c:when test="${status.count < topCntRos1.size()}">
							'<fmt:formatDate value="${topCntRos1_dt}" pattern="yyyy년MM월"/>',
						</c:when>
						<c:otherwise>
							'<fmt:formatDate value="${topCntRos1_dt}" pattern="yyyy년MM월"/>'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets:[
				<c:if test="${midCntRos1.size() > 0}">
				{
				label: '${tobNames1.MID}(${regNames1.DONG})',
				stack: 'Stack 0',
				fill: false,
				backgroundColor : '#ff0055',
				data : [
					<c:forEach items="${midCntRos1}" var="midItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < midCntRos1.size()}">
								${midItem.cnt},
							</c:when>
							<c:otherwise>
								${midItem.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},</c:if>
				<c:if test="${botCntRos1.size() > 0}">
				{
				label: '${tobNames1.BOT}(${regNames1.DONG})',
				stack: 'Stack 0',
				fill: false,
				backgroundColor : '#ff9900',
				data : [
					<c:forEach items="${botCntRos1}" var="botItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < botCntRos1.size()}">
								${botItem.cnt},
							</c:when>
							<c:otherwise>
								${botItem.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},</c:if>
				<c:if test="${midCntRos2.size() > 0}">
				{
				label: '${tobNames2.MID}(${regNames2.DONG})',
				stack: 'Stack 1',
				fill: false,
				backgroundColor : '#bf80ff',
				data : [
					<c:forEach items="${midCntRos2}" var="midItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < midCntRos2.size()}">
								${midItem.cnt},
							</c:when>
							<c:otherwise>
								${midItem.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},</c:if>
				<c:if test="${botCntRos2.size() > 0}">
				{
				label: '${tobNames2.BOT}(${regNames2.DONG})',
				stack: 'Stack 1',
				fill: false,
				backgroundColor : '#80bfff',
				data : [
					<c:forEach items="${botCntRos2}" var="botItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < botCntRos2.size()}">
								${botItem.cnt},
							</c:when>
							<c:otherwise>
								${botItem.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			}</c:if>]
		},
		options: {
			legend:{
				position: 'bottom'
			},
			maintainAspectRatio : false,
			scales:{
				xAxes: [{
					stacked: true
				}],
				yAxes: [{
					stacked: true
				}]
			}
		}
		
	}) 
	
	var regTrendsChart = new Chart(regTobTrends,{
		type: 'bar',
		data: {
			labels : [
				<c:forEach items="${tobCntList_Dong1}" var="item" varStatus="status">
					<c:set value="${item.bd_dt}01000000" var="dt"/>
					<fmt:parseDate value="${dt}" var="topCntList_Dong1_dt" pattern="yyyyMMddHHmmss"/>
					<c:choose>
						<c:when test="${status.count < tobCntList_Dong1.size()}">
							'<fmt:formatDate value="${topCntList_Dong1_dt}" pattern="yyyy년MM월"/>',
						</c:when>
						<c:otherwise>
							'<fmt:formatDate value="${topCntList_Dong1_dt}" pattern="yyyy년MM월"/>'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets:[
				<c:if test="${tobCntList_Gu1.size() > 0}">
				{
				label:'${regNames1.GU}(${tobNames1.BOT})',
				fill : false,
				backgroundColor : '#ff0055',
				stack: 'Stack 0',
				data:[
					<c:forEach items="${tobCntList_Gu1}" var="guVo" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobCntList_Gu1.size()}">
								${guVo.cnt},
							</c:when>
							<c:otherwise>
								${guVo.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},</c:if>
				<c:if test="${tobCntList_Dong1.size() > 0}">
				{
				label:'${regNames1.DONG}(${tobNames1.BOT})',
				fill : false,
				backgroundColor : '#ff9900',
				stack: 'Stack 0',
				data:[
					<c:forEach items="${tobCntList_Dong1}" var="dongVo" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobCntList_Dong1.size()}">
								${dongVo.cnt},
							</c:when>
							<c:otherwise>
								${dongVo.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},</c:if>
				<c:if test="${tobCntList_Gu2.size() > 0}">
				{
				label:'${regNames2.GU}(${tobNames2.BOT})',
				fill : false,
				backgroundColor : '#bf80ff',
				stack: 'Stack 1',
				data:[
					<c:forEach items="${tobCntList_Gu2}" var="guVo" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobCntList_Gu2.size()}">
								${guVo.cnt},
							</c:when>
							<c:otherwise>
								${guVo.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},</c:if>
				<c:if test="${tobCntList_Dong2.size() > 0}">
				{
				label:'${regNames2.DONG}(${tobNames2.BOT})',
				fill : false,
				backgroundColor : '#80bfff',
				stack: 'Stack 1',
				data:[
					<c:forEach items="${tobCntList_Dong2}" var="dongVo" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobCntList_Dong2.size()}">
								${dongVo.cnt},
							</c:when>
							<c:otherwise>
								${dongVo.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			}</c:if>]
		},
		options : {
			legend:{
				position: 'bottom'
			},
			maintainAspectRatio : false,
			scales:{
				xAxes: [{
					stacked: true
				}],
				yAxes: [{
					stacked: true
				}]
			}
		}
	})
	
	// 분석보고서 1 
	var tob_sales1 = ${tobLC_Sale1.CHANGERATE};
	var tob_cnt1 = ${tobLC_Cnt1.CHANGERATE};
	var backgroundColor1 = '#4db8ff';
	var pointBackgroundColor1 = '#4db8ff';
	
	if(tob_cnt1 > 0.0 && tob_sales1 > 0.0){	//성장 업종
		backgroundColor1 = '#66ff33';
		pointBackgroundColor1 = '#66ff33';
	}else if(tob_cnt1 <= 0.0 && tob_sales1 > 0.0){	//집중 업종
		backgroundColor1 = '#0099ff';
		pointBackgroundColor1 = '#0099ff';
	}else if(tob_cnt1 >= 0.0 && tob_sales1 <= 0.0){	//경쟁업종
		backgroundColor1 = '#ff6600';
		pointBackgroundColor1 = '#ff6600';
	} else if(tob_cnt1 < 0.0 && tob_sales1 < 0.0){	//침체업종
		backgroundColor1 = '#ff0000';
		pointBackgroundColor1 = '#ff0000';
	}
	// 분석보고서2
	var tob_sales2 = ${tobLC_Sale2.CHANGERATE};
	var tob_cnt2 = ${tobLC_Cnt2.CHANGERATE};
	var backgroundColor2 = '#4db8ff';
	var pointBackgroundColor2 = '#4db8ff';
	
	if(tob_cnt2 > 0.0 && tob_sales2 > 0.0){	//성장 업종
		backgroundColor2 = '#66ff33';
		pointBackgroundColor2 = '#66ff33';
	}else if(tob_cnt2 <= 0.0 && tob_sales2 > 0.0){	//집중 업종
		backgroundColor2 = '#0099ff';
		pointBackgroundColor2 = '#0099ff';
	}else if(tob_cnt2 >= 0.0 && tob_sales2 <= 0.0){	//경쟁업종
		backgroundColor2 = '#ff6600';
		pointBackgroundColor2 = '#ff6600';
	} else if(tob_cnt2 < 0.0 && tob_sales2 < 0.0){	//침체업종
		backgroundColor2 = '#ff0000';
		pointBackgroundColor2 = '#ff0000';
	}
	
	// 업종의 라이프 사이클 그래프
	var tobLcChart = new Chart(tobLC, {
		type: 'scatter',
		data : {
			datasets:[
				<c:if test="${tobLC_Cnt1 ne null}">
				{
				label : '${tobNames1.BOT}(${regNames1.DONG})',
				data : [{
					x: ${tobLC_Sale1.CHANGERATE},
					y: ${tobLC_Cnt1.CHANGERATE}
						
				}],
				backgroundColor: backgroundColor1,
				pointRadius : 10,
				pointHoverRadius : 12,
				pointBackgroundColor : pointBackgroundColor1
			}</c:if>
				<c:choose>
				
				<c:when test="${tobLC_Cnt2 ne null && tobLC_Cnt1 ne null}">
				,{
				label : '${tobNames2.BOT}(${regNames2.DONG})',
				data : [{
					x: ${tobLC_Sale2.CHANGERATE},
					y: ${tobLC_Cnt2.CHANGERATE}
						
				}],
				backgroundColor: backgroundColor2,
				pointRadius : 10,
				pointHoverRadius : 12,
				pointBackgroundColor : pointBackgroundColor2
				}</c:when>
				
				<c:when test="${tobLC_Cnt2 ne null&& tobLC_Cnt1 eq null}">
				{
				label : '${tobNames2.BOT}(${regNames2.DONG})',
				data : [{
					x: ${tobLC_Sale2.CHANGERATE},
					y: ${tobLC_Cnt2.CHANGERATE}
						
				}],
				backgroundColor: backgroundColor2,
				pointRadius : 10,
				pointHoverRadius : 12,
				pointBackgroundColor : pointBackgroundColor2
				}</c:when>
			</c:choose>]
		},
		options : {
			legend : {
				position : 'bottom'
			},
			scales:{
				xAxes:[{
				 	display: true,
		            ticks: {
		                suggestedMin: -5,    // minimum will be 0, unless there is a lower value.
		                suggestedMax: 5   
		            }
				}],
				yAxes:[{
				 	display: true,
		            ticks: {
		                suggestedMin: -5,    // minimum will be 0, unless there is a lower value.
		                suggestedMax: 5
		            }
				}]
			},
			maintainAspectRatio : false
		}
		
	})
}


function salesReportChartSetting(){
	/* 매출분석 보고서의 그래프 셋팅 */	
 	// 1. 업종별 매출추이 그래프
	var flowTob = $("#tobSacRos");
	// 2. 지역별 매출추이 그래프
	var flowReg = $("#regSacRos");	
	
	
	var tobSacRosChart = new Chart(flowTob, {
		type: 'bar',
		data: {
			labels : [
				<c:forEach items="${tobSac_Mid1}" var="item" varStatus="status">
					<c:set value="${item.sales_dt}01000000" var="dt"/>
					<fmt:parseDate value="${dt}" var="topSac_Mid1_dt" pattern="yyyyMMddHHmmss"/>
					<c:choose>
						<c:when test="${status.count < tobSac_Mid1.size()}">
							'<fmt:formatDate value="${topSac_Mid1_dt}" pattern="yyyy년MM월"/>',
						</c:when>
						<c:otherwise>
							'<fmt:formatDate value="${topSac_Mid1_dt}" pattern="yyyy년MM월"/>'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets:[
				<c:if test="${tobSac_Mid1.size() > 0}">
				{
				label:'${tobNames1.MID}(${regNames1.DONG})',
				fill: false,
				backgroundColor : '#ff0055',
				stack: 'Stack 0',
				data : [
					<c:forEach items="${tobSac_Mid1}" var="midItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobSac_Mid1.size()}">
								${midItem.curSale},
							</c:when>
							<c:otherwise>
								${midItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},</c:if>
				<c:if test="${tobSac_Bot1.size() > 0}">
				{
				label:'${tobNames1.BOT}(${regNames1.DONG})',
				fill: false,
				backgroundColor : '#ff9900',
				stack: 'Stack 0',
				data : [
					<c:forEach items="${tobSac_Bot1}" var="botItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobSac_Bot1.size()}">
								${botItem.curSale},
							</c:when>
							<c:otherwise>
								${botItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},</c:if>
				<c:if test="${tobSac_Mid2.size() > 0}">
				{
				label:'${tobNames2.MID}(${regNames2.DONG})',
				fill: false,
				backgroundColor : '#bf80ff',
				stack: 'Stack 1',
				data : [
					<c:forEach items="${tobSac_Mid2}" var="midItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobSac_Mid2.size()}">
								${midItem.curSale},
							</c:when>
							<c:otherwise>
								${midItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},</c:if>
				<c:if test="${tobSac_Bot2.size() > 0}">
				{
				label:'${tobNames2.BOT}(${regNames2.DONG})',
				fill: false,
				backgroundColor : '#80bfff',
				stack: 'Stack 1',
				data : [
					<c:forEach items="${tobSac_Bot2}" var="botItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobSac_Bot2.size()}">
								${botItem.curSale},
							</c:when>
							<c:otherwise>
								${botItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			}</c:if>]
		},
		options:{
			legend:{
				position: 'bottom'
			},
			maintainAspectRatio : false
		}
	})
	
	var regSacRosChart = new Chart(flowReg,{
		type: 'bar',
		data: {
			labels : [
				<c:forEach items="${regSac_Gu1}" var="item" varStatus="status">
					<c:set value="${item.sales_dt}01000000" var="dt"/>
					<fmt:parseDate value="${dt}" var="regSac_Gu1_dt" pattern="yyyyMMddHHmmss"/>
					<c:choose>
						<c:when test="${status.count < regSac_Gu1.size()}">
							'<fmt:formatDate value="${regSac_Gu1_dt}" pattern="yyyy년MM월"/>',
						</c:when>
						<c:otherwise>
							'<fmt:formatDate value="${regSac_Gu1_dt}" pattern="yyyy년MM월"/>'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets:[
				<c:if test="${regSac_Gu1.size() > 0}">
				{
				label:'${regNames1.GU}(${tobNames1.BOT})',
				fill: false,
				backgroundColor : '#ff0055',
				stack: 'Stack 0',
				data : [
					<c:forEach items="${regSac_Gu1}" var="guItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < regSac_Gu1.size()}">
								${guItem.curSale},
							</c:when>
							<c:otherwise>
								${guItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},</c:if>
				<c:if test="${regSac_Dong1.size() > 0}">
				{
				label:'${regNames1.DONG}(${tobNames1.BOT})',
				fill: false,
				backgroundColor : '#ff9900',
				stack: 'Stack 0',
				data : [
					<c:forEach items="${regSac_Dong1}" var="dongItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < regSac_Dong1.size()}">
								${dongItem.curSale},
							</c:when>
							<c:otherwise>
								${dongItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},</c:if>
				<c:if test="${regSac_Gu2.size() > 0}">
				{
				label:'${regNames2.GU}(${tobNames2.BOT})',
				fill: false,
				backgroundColor : '#bf80ff',
				stack: 'Stack 1',
				data : [
					<c:forEach items="${regSac_Gu2}" var="guItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < regSac_Gu2.size()}">
								${guItem.curSale},
							</c:when>
							<c:otherwise>
								${guItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},</c:if>
				<c:if test="${regSac_Dong2.size() > 0}">
				{
				label:'${regNames2.DONG}(${tobNames2.BOT})',
				fill: false,
				backgroundColor : '#80bfff',
				stack: 'Stack 1',
				data : [
					<c:forEach items="${regSac_Dong2}" var="dongItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < regSac_Dong2.size()}">
								${dongItem.curSale},
							</c:when>
							<c:otherwise>
								${dongItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			}</c:if>]
		},
		options:{
			legend:{
				position: 'bottom'
			},
			maintainAspectRatio : false
		}
	})
}


function popReportChartSetting(){
	/* 인구분석 보고서 그래프 셋팅 */
	
	// 1. 유동인구

	// 유동인구 - 성별
	var ppg = $("#ppgChart");
	// 유동인구 - 연령별
	var ppa = $("#ppaChart");
	
	var ppgChart = new Chart(ppg,{
		type: 'bar',
		data: {
			labels : [
				'${ppgList1.get(0).PPG_GENDER eq 1 ? "남성" : "여성"}',
				'${ppgList1.get(1).PPG_GENDER eq 1 ? "남성" : "여성"}'
			],
			datasets:[{
				label:'${regNames1.DONG}',
				data : [
					${ppgList1.get(0).PPG_GENDER eq 1 ? ppgList1.get(0).RATIO : ppgList1.get(1).RATIO},
					${ppgList1.get(1).PPG_GENDER eq 1 ? ppgList1.get(0).RATIO : ppgList1.get(1).RATIO}
				],
				backgroundColor :'#009999'
			},{
				label:'${regNames2.DONG}',
				data : [
					${ppgList2.get(0).PPG_GENDER eq 1 ? ppgList2.get(0).RATIO : ppgList2.get(1).RATIO},
					${ppgList2.get(1).PPG_GENDER eq 1 ? ppgList2.get(0).RATIO : ppgList2.get(1).RATIO}
				],
				backgroundColor :'#ff471a'
			}]
		},
		options : {
			legend:{
				position:'bottom'
			},
			scales:{
				yAxes: [{
					ticks:{
						max: 100,
						beginAtZero:true
					}
				}]
			}
		}
		
	})
		
	var ppaChart = new Chart(ppa,{
		type: 'bar',
		data:{
			labels:[
				<c:forEach items="${ppaList1}" var="item" varStatus="status">
					<c:choose>
						<c:when test="${status.count < ppaList1.size()}">
							'${item.ppa_age_group}대',
						</c:when>
						<c:otherwise>
							'${item.ppa_age_group}대'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets:[{
				label:'${regNames1.DONG}',
				data:[
					<c:forEach items="${ppaList1}" var="ppaItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < ppaList1.size()}">
								${ppaItem.ppa_cnt},	
							</c:when>
							<c:otherwise>
								${ppaItem.ppa_cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				],
				backgroundColor : '#009999'
				
			
			},{
				label:'${regNames2.DONG}',
				data:[
					<c:forEach items="${ppaList2}" var="ppaItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < ppaList2.size()}">
								${ppaItem.ppa_cnt},	
							</c:when>
							<c:otherwise>
								${ppaItem.ppa_cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				],
				backgroundColor : '#ff471a'
				
			
			}]
		},
		options : {		
			legend:{
				position: "bottom"
			},
			scales : {
				display : false,
				yAxes : [{	// y축 기준
					ticks : {	
						beginAtZero : true
					}
				}]
			}
		}
	})

	// 2. 주거인구
		
	// 주거인구 - 성별
	var lpGender = $("#lpGender");
	// 주거인구 - 연령별
	var lpAge = $("#lpAge");
	
	
	var lpGenderChart = new Chart(lpGender,{
		type: 'bar',
		data: {
			labels : [
				'${lpGenderList1.get(0).lp_gender eq 1 ? "남성" : "여성"}',
				'${lpGenderList1.get(1).lp_gender eq 1 ? "남성" : "여성"}'
			],
			datasets:[{
				label: '${regNames1.DONG}',
				data : [
					${lpGenderList1.get(0).lp_gender eq 1 ? lpGenderList1.get(0).lp_ratio : lpGenderList1.get(1).lp_ratio},
					${lpGenderList1.get(1).lp_gender eq 1 ? lpGenderList1.get(0).lp_ratio : lpGenderList1.get(1).lp_ratio}
				],
				backgroundColor : '#009999'
			},{
				label: '${regNames2.DONG}',
				data : [
					${lpGenderList2.get(0).lp_gender eq 1 ? lpGenderList2.get(0).lp_ratio : lpGenderList2.get(1).lp_ratio},
					${lpGenderList2.get(1).lp_gender eq 1 ? lpGenderList2.get(0).lp_ratio : lpGenderList2.get(1).lp_ratio}
				],
				backgroundColor : '#ff471a'
			}]
		},
		options : {
			legend:{
				position:'bottom'
			},
			scales:{
				yAxes: [{
					ticks:{
						max: 100,
						beginAtZero:true
					}
				}]
			}
		}
		
	})
	
	var lpAgeChart = new Chart(lpAge,{
		type: 'bar',
		data:{
			labels:[
				<c:forEach items="${lpAgeList1}" var="item" varStatus="status">
					<c:choose>
						<c:when test="${status.count < lpAgeList1.size()}">
							'${item.lp_age_group}대',
						</c:when>
						<c:otherwise>
							'${item.lp_age_group}대'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets:[{
				label: '${regNames1.DONG}',
				data:[
					<c:forEach items="${lpAgeList1}" var="lpItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < lpAgeList1.size()}">
								${lpItem.lp_cnt},	
							</c:when>
							<c:otherwise>
								${lpItem.lp_cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				],
				backgroundColor : '#009999',
			
			},{
				label: '${regNames2.DONG}',
				data:[
					<c:forEach items="${lpAgeList2}" var="lpItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < lpAgeList2.size()}">
								${lpItem.lp_cnt},	
							</c:when>
							<c:otherwise>
								${lpItem.lp_cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				],
				backgroundColor : '#ff471a'
			
			}]
		},
		options : {		
			legend:{
				position : 'bottom'
			},
			scales : {
				display : false,
				yAxes : [{	// y축 기준
					ticks : {	
						beginAtZero : true
					}
				}]
			}
		}
	})
		
}

/* menu tab을 클릭시 해당 보고서를 조회 하기 위한 function */
function changeMenu(e){
	// 모든 형제 요소중에서 지정한 선택자에 해당하는 요소를 모두 선택
	$(e).parent().siblings('li').attr('class','');
	$(e).parent().attr('class', 'active');
	
	var menuRole = $(e).data('role');
	console.log(menuRole);
	
	$('.menuTab').attr('class', 'menuTab d-none');
	$('.guideBar').attr('class', 'guideBar d-none');
	
	$('#guideLine'+menuRole).attr('class','guideBar active');
	$('#analysisResult'+menuRole).attr('class', 'menuTab active');
	
	if($("#analysisResultinfo").attr('class') == 'menuTab active'){
		console.log("상권평가 메뉴 on..");
		bdAppraisalReportChartSetting();
	}
	if($("#analysisResultupjong").attr('class') == 'menuTab active'){
		console.log("업종분석 메뉴 on..");
		tobReportChartSetting();
	}
	if($("#analysisResultsales").attr('class') == 'menuTab active'){
		console.log("매출분석 메뉴 on..");
		salesReportChartSetting();
	}
	if($("#analysisResultpop").attr('class') == 'menuTab active'){
		console.log("인구분석 메뉴 on..");
		popReportChartSetting();
	}
	
	
}
	
</script>

<style>
/* 상단 navigation바의 css 효과 지정  */
a:hover{
	text-decoration: none;
}
.nav-tabs {
  padding-left: 0;
  margin-bottom: 0;
  list-style: none;
}
.nav-tabs > li {
  float: left;
  position: relative;
  display: block;
	text-align:center;
}
.nav-tabs > li > a {
	border-bottom: 1px solid #e3e3e6;
	font-size:13px;
	color:#777;
	position: relative;
	display: block;
	padding:8px 20px 10px 20px;
	letter-spacing:-1px;
	font-weight:400;
}
.nav-tabs > li > a .fa {
	font-weight:400;
	margin-right:5px;
}
.nav-tabs > li > a:hover {
}
.nav-tabs > li.active > a,
.nav-tabs > li.active > a:hover,
.nav-tabs > li.active > a:focus {
  color: #66a3ff;
  cursor: default;
	font-weight:700;
  background-color: #fff;
	border-bottom: 1px solid #0088e8;
}
.nav-tabs.depth-1 {	
  background-color: #66a3ff;
	padding:4px 4px 0 4px;
	overflow:auto;
}
.nav-tabs.depth-1 > li {
	border-bottom: 0px solid #fff;
}
.nav-tabs.depth-1 > li > a {
	border-bottom: 0px solid #fff;
	color: #fff;
	font-size:1.2rem;
	padding:8px 30px 8px 30px;
}
.nav-tabs.depth-1 > li.active > a,
.nav-tabs.depth-1 > li.active > a:hover,
.nav-tabs.depth-1 > li.active > a:focus {
  color: #66a3ff;
  background-color: #fff;
	border-bottom: 0px solid #fff;
}
/* 테이블 및 기타 텍스트들에 효과를 주는 css */
.box-center {
	margin : 0 auto;	
}

#eH4{
	display: inline-block;
	color : black;
}

.eSpan {
	cursor: pointer;
}

.eTable {
	text-align: center;
 	width : 100%;
 	cellspacing : 0; 
}

.eTable td {
	text-align : center;
	vertical-align: middle;
}

.eH5 {
	display: inline-block;
}

.right-box {
  	float: right;
}


.evalTable{
	text-align: center;
}
.evalTable th{
	color : black;
	background-color: #eaecf4; 
	vertical-align: middle;
}

.evalTable td{
	vertical-align: middle;
}


.eLeft {
	display : inline-block;
	text-align : center;
	width : 10%;
	float : left;
}

.eRight {
	display : inline-block;
	width : 90%;
	float : right;
}

hr {
	clear: both;
}

.eTable2 {
	width : 100%;
}

.eTable2 td {
	text-align: center;
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
	background-color: rgb(254,254,238);
}

.tip {
	background-color: rgb(245,246,241);
}

.tt2 {
	background-color: rgb(254,254,238);
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

.eTable3 {
	width : 100%;
}

.eTable3 tr:nth-child(1) td {
	width : 16%;
	text-align: center;
}

.eTable3 tr:nth-child(1) td:nth-child(1){
	width : 20%;
}

.eTable3 td {
	text-align: center;
}

.table-bordered thead th{
	text-align: center;
	color : black;
	vertical-align: inherit;
	border-bottom-width: 2px;
}

.bg-table{
	background-color: #e6f2ff;
}
/* 
상권평가등급 이미지를 감싸는 box에 크기 및 기타 option 지정
배경에는 폭죽 이미지를 넣음
*/
#sign{
	width : 500px;
	height: 430px;
	text-align : center;
	float:left;
	background :url('../img/배경이미지2.gif') no-repeat;
	background-position: center;
}
/* 상권 평가 등급 메달 이미지 크기 지정 */
.parent:after { 
	content: ""; 
	display:block; 
	clear:both; 
}

#signal{
	width: 300px;
	height: 300px;
	margin-top: 20px;
}

.border-gray{
	border : 1px solid #bcbcbc;
}

/* 증감률 상승 : up / 하락 : down  기호에 색깔 지정 */
.up{
	color : #ff4d4d;
}
.down{
	color : #3333ff;
}


.chartBox{
	padding : 5px;
}


/* 작은 메달 이미지 크기 지정 */
.dots{
		width: 20px;
		height: 20px;
}

.w-63{
	width: 61%;
}

#life1{ color : #66ff33}
#life2{ color : #0099ff}
#life3{ color : #ff0000}
#life4{ color : #ff6600}

.container{padding-left:1.2rem; padding-right:1.2rem;}
#resultAnalysisForm{color:black;}
table tbody{background:white;}
</style>


<div id="resultAnalysisForm" style="width:100%;height:100%; margin-top:-15px;" class="ng-scope">
<div class="ng-scope">
	
	<div class="container">
		<div class="page-header">
			<h2 id="eH4" class="font-weight-bold text-left mt-3">상권분석 비교 보고서</h2>  
		</div>
	</div>

	<div class="container mt-3">
		<div class="row fulltab">
			<div class="col-12">
				<!-- 탭(1차) -->
				<ul class="nav nav-tabs depth-1 fl" role="tablist">
					<li class="active"><a href="#" onclick="changeMenu(this)" data-role="info" role="tab" title="상권평가 탭 버튼">상권평가</a></li>
					<li><a href="#" role="tab" onclick="changeMenu(this)" data-role="upjong" title="업종분석 탭 버튼">업종분석</a></li>
					<li><a href="#" role="tab" onclick="changeMenu(this)" data-role="sales" title="매출분석 탭 버튼">매출분석</a></li>
					<li><a href="#" role="tab" onclick="changeMenu(this)" data-role="pop" title="인구분석 탭 버튼">인구분석</a></li>
				</ul><!-- 탭(1차) -->
			</div><!-- /.col-6 -->
		</div><!-- /.fulltab -->
	</div><!-- /.container -->
	
	<!-- 가이드 라인 영역의 모음 -->
	<!-- 상권평가 가이드라인 -->
	<div id="guideLineinfo" class="guideBar active">
		<div class="container mt-3">
			<span onclick="fnMove(this)" data-no="1" data-kind="info">1. 평가종합&nbsp;&nbsp;</span>
			<span onclick="fnMove(this)" data-no="2" data-kind="info">2. 상세평가지수&nbsp;&nbsp;</span>
			
	        <hr>
		</div>
	</div>
	<!-- 업종분석 가이드라인 -->
	<div id="guideLineupjong" class="guideBar d-none">
		<div class="container mt-3">
			<span onclick="fnMove(this)" data-no="1" data-kind="tob">1. 업종별 추이&nbsp;&nbsp;</span>
			<span onclick="fnMove(this)" data-no="2" data-kind="tob">2. 지역별 추이&nbsp;&nbsp;</span>
			<span onclick="fnMove(this)" data-no="3" data-kind="tob">3. 업종 생애주기&nbsp;&nbsp;</span>

	        <hr>
		</div>
	</div>
	<!-- 매출분석 가이드라인 -->
	<div id="guideLinesales" class="guideBar d-none">
		<div class="container mt-3">
			<span onclick="fnMove(this)" data-no="1" data-kind="sales">1. 업종별 매출추이&nbsp;&nbsp;</span>
			<span onclick="fnMove(this)" data-no="2" data-kind="sales">2. 지역별 매출추이&nbsp;&nbsp;</span>
			
  		    <hr>
		</div>
	</div>
	<!-- 인구분석 가이드라인 -->
	<div id="guideLinepop" class="guideBar d-none">
		<div class="container mt-3">
			<span onclick="fnMove(this)" data-no="1" data-kind="pop">1. 유동인구&nbsp;&nbsp;</span>
			<span onclick="fnMove(this)" data-no="2" data-kind="pop">2. 주거인구&nbsp;&nbsp;</span>
			<span onclick="fnMove(this)" data-no="3" data-kind="pop">3. 직장인구&nbsp;&nbsp;</span>
			
	        <hr>
		</div>
	</div>
	
<!-- ======================= 가이드 라인 end ======================= -->
		
	<div class="tab-content mheight" id="result">
		<div class="tab-pane active">
            <!-- 탭(2차) -->
            <!-- /탭(2차) -->
            
            <div class="container"> 
            
            	<!-- 상권평가 보고서의 박스 시작 -->
				<div id="analysisResultinfo" class="menuTab active">

<div>     
    <h5 class="text-info text-left font-weight-bold mt-5">분석 설정 정보</h5>
    <table class="table table-bordered eTable">
        <colgroup>
            <col style="width:20%">
            <col style="width:20%">
            <col style="width:20%">
            <col style="width:20%">
            <col style="width:20%">
        </colgroup>
        <thead>
            <tr class="bg-gray-200">
                <th colspan="2">분석지역</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>${region_full_name_1}</td>
                <td>${region_full_name_2}</td>
            </tr>
        </tbody>
        <thead>
            <tr class="bg-gray-200">
                <th colspan="2">분석업종</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>${tob_full_name_1 }</td>
                <td>${tob_full_name_2 }</td>
            </tr>
        </tbody>
    </table>
	
	<br>
	
    <h5 id="info1" class="text-info text-left font-weight-bold mt-5">1. 평가종합</h5>
    
    <div class="parent mt-4">
       	<div id="sign" class="w-50 border-gray">
       		<c:choose>
       			<c:when test="${evaluation1 >= 65.5 }">
		       		<img id="signal" src="${pageContext.request.contextPath}/img/금.gif"><br>
		       		<span id="gold" class="btn btn-warning btn-icon-split mb-3">평가종합등급:1등급</span><br>
       			</c:when>
       			<c:when test="${evaluation1 >= 40 && evaluation1 < 65.5}">
		       		<img id="signal" src="${pageContext.request.contextPath}/img/은.gif"><br>
		       		<span id="silver" class="btn btn-secondary btn-icon-split mb-3">평가종합등급:2등급</span><br>
       			</c:when>
       			<c:otherwise>
		       		<img id="signal" src="${pageContext.request.contextPath}/img/동.gif"><br>
		       		<span id="bronze" class="btn btn-icon-split mb-3">평가종합등급:3등급</span><br>
       			</c:otherwise>
       		</c:choose>
       	</div>
       	<div id="sign" class="w-50 border-gray">
       		<c:choose>
       			<c:when test="${evaluation2 >= 65.5 }">
		       		<img id="signal" src="${pageContext.request.contextPath}/img/금.gif"><br>
		       		<span id="gold" class="btn btn-warning btn-icon-split mb-3">평가종합등급:1등급</span><br>
       			</c:when>
       			<c:when test="${evaluation2 >= 40 && evaluation2 < 65.5}">
		       		<img id="signal" src="${pageContext.request.contextPath}/img/은.gif"><br>
		       		<span id="silver" class="btn btn-secondary btn-icon-split mb-3">평가종합등급:2등급</span><br>
       			</c:when>
       			<c:otherwise>
		       		<img id="signal" src="${pageContext.request.contextPath}/img/동.gif"><br>
		       		<span id="bronze" class="btn btn-icon-split mb-3">평가종합등급:3등급</span><br>
       			</c:otherwise>
       		</c:choose>
       	</div>
    </div>  
    
    <div class="parent">      
	    <table class="table table-bordered eTable w-50 float-left mt-3">
	    <thead>
	        <tr class="bg-gray-200">
	            <th rowspan="2">성장성</th>
	            <th rowspan="2">안정성</th>
	            <th rowspan="2">구매력</th>
	            <th rowspan="2">집객력</th>
	        </tr>
	    </thead>
	    <tbody>
	        <tr>
	            <td>
	            	<strong class="largenum">
	            	<fmt:formatNumber value="${growth1}" pattern="0.0"/>
	        		</strong>점
	            </td>
	            <td>
		            <strong class="largenum">
		            	<fmt:formatNumber value="${stability1}" pattern="0.0"/>
		            </strong>점
	            </td>
	            <td>
	            	<strong class="largenum">
	            		<fmt:formatNumber value="${purchasePower1}" pattern="0.0"/>
	            	</strong>점
	            </td>
	            <td>
	            <strong class="largenum">
					<fmt:formatNumber value="${visitPower1}" pattern="0.0"/>
	            </strong>점
	            </td>
	        </tr>
	        <tr>
	        	<th class="bg-gray-200">합계</th>
	        	<td colspan="3">
	        		<fmt:formatNumber value="${evaluation1 }" pattern="0.0"/>
	        	</td>
	        </tr>
	    </tbody>
	    </table>
	    <table class="table table-bordered eTable w-50 float-left mt-3">
	    <thead>
	        <tr class="bg-gray-200">
	            <th rowspan="2">성장성</th>
	            <th rowspan="2">안정성</th>
	            <th rowspan="2">구매력</th>
	            <th rowspan="2">집객력</th>
	        </tr>
	    </thead>
	    <tbody>
	        <tr>
	            <td>
	            	<strong class="largenum">
	            	<fmt:formatNumber value="${growth2}" pattern="0.0"/>
	        		</strong>점
	            </td>
	            <td>
		            <strong class="largenum">
		            	<fmt:formatNumber value="${stability2}" pattern="0.0"/>
		            </strong>점
	            </td>
	            <td>
	            	<strong class="largenum">
	            		<fmt:formatNumber value="${purchasePower2}" pattern="0.0"/>
	            	</strong>점
	            </td>
	            <td>
	            <strong class="largenum">
					<fmt:formatNumber value="${visitPower2}" pattern="0.0"/>
	            </strong>점
	            </td>
	        </tr>
	        <tr>
	        	<th class="bg-gray-200">합계</th>
	        	<td colspan="3">
	        		<fmt:formatNumber value="${evaluation2 }" pattern="0.0"/>
	        	</td>
	        </tr>
	    </tbody>
	    </table>
    </div>
    
	<br><br>    
    
    <!-- 3. 상세평가지수 조회 기능 -->
    <h5 id="info2" class="text-info text-left font-weight-bold mt-4">2. 상세평가지수 </h5>
    
    <!-- 상세평가지수에 대한 그래프 -->
    <div class="my-4">
    	<!-- 레이더 차트 및 곡선 그래프를 넣을 box -->
		<div class="col-12">
			<div class="p-2">
				<canvas id="totalRadar" width="100%" height="50%"></canvas>    	
			</div>
		</div>
    </div>

                                                          
</div><!-- /.container end.. -->

		</div> <!-- 상권평가 보고서 결과 div 박스 end... -->

<!-- ========================== 업종분석 보고서의 contents 영역 ========================== -->		
				<div id="analysisResultupjong" class="menuTab d-none">
				
<div id="resultUpjong">
	
	<h5 id="tob1" class="text-info text-left font-weight-bold mt-5">1.업종별 추이</h5>
	
	<div class="col-12 p-2 my-3" style="height:300px;">
			<!-- 업종별 추이의 그래프 넣기 -->
			<canvas id="flowUpjong" width="100%"></canvas>
	</div>
	
	
	
	<h5 id="tob2" class="text-info text-left font-weight-bold mt-5">2.지역별 추이</h5>
	
	<div class="col-12 my-4 p-2" style="height:300px;">
		<!-- 분석업종의 지역별 추이 그래프 넣기 -->
		<canvas id="RegionalTrends"></canvas>
	</div>
		
	
	<!-- 3. 업종 생애주기  -->
	<h5 id="tob3" class="text-info text-left font-weight-bold mt-5">3.업종 생애주기</h5>
	
	<div class="col-12 my-4 p-2" style="height: 300px;">
		<!-- 분석업종의 생애주기 그래프 넣기 -->
		<canvas id="tobLC" width="100%"></canvas>
	</div>
	
	<table class="table table-bordered ng-scope">
        <thead>
            <tr class="bg-gray-200">
                <th colspan="2">성장유형</th>
                <th>업종</th>
                <th>설명</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th class="text-center">성장업종</th>
                <td><strong class="largenum"><span id="life1">●</span>&nbsp;성장</strong><br>(점포 수 증가/ 매출 증가)</td>
                <td class="text-center">
                	<c:choose>
                		<c:when test="${ (tobLC_Cnt1.CHANGERATE > 0.0 && tobLC_Sale1.CHANGERATE > 0.0 )&&
                					(tobLC_Cnt2.CHANGERATE > 0.0 && tobLC_Sale2.CHANGERATE > 0.0 )}">
 							${tobNames1.BOT }&nbsp;,&nbsp;${tobNames2.BOT }             		
                		</c:when>
                		<c:when test="${ (tobLC_Cnt1.CHANGERATE > 0.0 && tobLC_Sale1.CHANGERATE > 0.0 )&&
                					(tobLC_Cnt2.CHANGERATE > 0.0 && tobLC_Sale2.CHANGERATE > 0.0 ) eq false }">
                			${tobNames1.BOT }			
         				</c:when>
                		<c:when test="${ (tobLC_Cnt1.CHANGERATE > 0.0 && tobLC_Sale1.CHANGERATE > 0.0 ) eq false&&
                					(tobLC_Cnt2.CHANGERATE > 0.0 && tobLC_Sale2.CHANGERATE > 0.0 )}">
                			${tobNames2.BOT }			
         				</c:when>
                		<c:otherwise>
                			선택사항&nbsp;없음
                		</c:otherwise>
                	</c:choose>
                </td>
                <td class="text-left">매출과 점포 수가 모두 증가하여 당분간 호황이 예상되는 업종</td>
            </tr>
            <tr>
                <th class="text-center">집중업종</th>
                <td><strong class="largenum"><span id="life2">●</span>&nbsp;집중</strong><br>(점포 수 유지·감소/ 매출 증가)</td>
                <td class="text-center">
                	<c:choose>
                		<c:when test="${ (tobLC_Cnt1.CHANGERATE <= 0.0 && tobLC_Sale1.CHANGERATE > 0.0 )&&
                					(tobLC_Cnt2.CHANGERATE <= 0.0 && tobLC_Sale2.CHANGERATE > 0.0 )}">
 							${tobNames1.BOT }&nbsp;,&nbsp;${tobNames2.BOT }             		
                		</c:when>
                		<c:when test="${ (tobLC_Cnt1.CHANGERATE <= 0.0 && tobLC_Sale1.CHANGERATE > 0.0 )&&
                					(tobLC_Cnt2.CHANGERATE <= 0.0 && tobLC_Sale2.CHANGERATE > 0.0 ) eq false}">
                			${tobNames1.BOT }			
         				</c:when>
                		<c:when test="${ (tobLC_Cnt1.CHANGERATE <= 0.0 && tobLC_Sale1.CHANGERATE > 0.0 ) eq false&&
                					(tobLC_Cnt2.CHANGERATE <= 0.0 && tobLC_Sale2.CHANGERATE > 0.0 )}">
                			${tobNames2.BOT }
               			</c:when>
                		<c:otherwise>
                			선택사항&nbsp;없음
                		</c:otherwise>
                	</c:choose>
                </td>
                <td class="text-left">점포 수는 유지 및 감소하고 매출은 증가하여 매출이 집중되는 업종</td>
            </tr>
            <tr>
                <th class="text-center">침체업종</th>
                <td><strong class="largenum"><span id="life3">●</span>&nbsp;침체</strong><br>(점포 수 감소/ 매출 감소)</td>
                <td class="text-center">
                	<c:choose>
                		<c:when test="${ (tobLC_Cnt1.CHANGERATE < 0.0 && tobLC_Sale1.CHANGERATE < 0.0) && 
                						(tobLC_Cnt2.CHANGERATE < 0.0 && tobLC_Sale2.CHANGERATE < 0.0)}">
 							${tobNames1.BOT }&nbsp;,&nbsp;${tobNames2.BOT }              		
                		</c:when>
                		<c:when test="${ (tobLC_Cnt1.CHANGERATE < 0.0 && tobLC_Sale1.CHANGERATE < 0.0) && 
                						(tobLC_Cnt2.CHANGERATE < 0.0 && tobLC_Sale2.CHANGERATE < 0.0) eq false}">
                			${tobNames1.BOT }
                		</c:when>
                		<c:when test="${(tobLC_Cnt1.CHANGERATE < 0.0 && tobLC_Sale1.CHANGERATE < 0.0) eq false && 
                						(tobLC_Cnt2.CHANGERATE < 0.0 && tobLC_Sale2.CHANGERATE < 0.0) }">
                			${tobNames2.BOT }			
                		</c:when>
                		<c:otherwise>
                			선택사항&nbsp;없음
                		</c:otherwise>
                	</c:choose>
                </td>
                <td class="text-left">매출과 점포 수가 모두 감소하여 침체기에 해당하는 업종</td>
            </tr>
            <tr>
                <th class="text-center">경쟁업종</th>
                <td><strong class="largenum"><span id="life4">●</span>&nbsp;경쟁심화</strong><br>(점포 수 유지·증가/ 매출 유지·감소)</td>
                <td class="text-center">
                	<c:choose>
                		<c:when test="${ (tobLC_Cnt1.CHANGERATE >= 0.0 && tobLC_Sale1.CHANGERATE <= 0.0) &&
                						(tobLC_Cnt1.CHANGERATE >= 0.0 && tobLC_Sale1.CHANGERATE <= 0.0)}">
 							${tobNames1.BOT }&nbsp;,&nbsp;${tobNames2.BOT }              		
                		</c:when>
                		<c:when test="${ !(tobLC_Cnt1.CHANGERATE >= 0.0 && tobLC_Sale1.CHANGERATE <= 0.0) &&
                						(tobLC_Cnt1.CHANGERATE >= 0.0 && tobLC_Sale1.CHANGERATE <= 0.0)}">
 							${tobNames1.BOT }       		
                		</c:when>
                		<c:when test="${ (tobLC_Cnt1.CHANGERATE >= 0.0 && tobLC_Sale1.CHANGERATE <= 0.0) &&
                						(tobLC_Cnt1.CHANGERATE >= 0.0 && tobLC_Sale1.CHANGERATE <= 0.0)}">
 							${tobNames2.BOT }           		
                		</c:when>
                		<c:otherwise>
                			선택사항&nbsp;없음
                		</c:otherwise>
                	</c:choose>
                </td>
                <td class="text-left">점포 수가 유지 및 증가하고 매출은 유지 및 감소해 경쟁이 심화되는 업종</td>
            </tr>
        </tbody>
    </table>
	
</div>

				</div>  <!-- 업종분석 보고서 결과 div 박스 end... -->
	
<!-- ========================== 매출분석 보고서의 contents 영역 ========================== -->		
				<div id="analysisResultsales" class="menuTab d-none">
				
<div id="resultSales">
	
	<h5 id="sales1" class="text-info text-left font-weight-bold mt-5">1.업종별 매출추이</h5>
	
	<div class="col-12 mt-4 p-2" style="height:300px;">
		<!-- 업종별 매출추이의 그래프 넣기 -->
		<canvas id="tobSacRos" width="100%"></canvas>
	</div>
	

	
	<h5 id="sales2" class="text-info text-left font-weight-bold mt-5">2.지역별 매출추이</h5>
	
	<div class="col-12 p-2 mt-4" style="height:300px;">
		<!-- 지역별 매출추이의 그래프 넣기 -->
		<canvas id="regSacRos" width="100%"></canvas>
	</div>
	
    
</div><!-- 분석결과 end -->
					
</div>	<!-- 매출분석 보고서 결과 div 박스 end... -->

<!-- ========================== 인구분석 보고서의 contents 영역 ========================== -->		
				<div id="analysisResultpop" class="menuTab d-none">
				
<div id="resultPop">
	
	<!-- 1. 유동인구 기능 -->
	<h5 id="pop1" class="text-info text-left font-weight-bold mt-5">1.유동인구</h5>
	
	<div class="mt-5">
		<!-- 유동인구의 성별 및 연령별그래프 넣기 -->
		<div class="col-4 d-inline-block m-2">
			<!-- 성별 -->
			<canvas id="ppgChart" width="100%" height="100%"></canvas>
		</div>
		<div class="w-63 d-inline-block m-2">
			<!-- 연령별 -->
			<canvas id="ppaChart" width="100%" ></canvas>
		</div>
	</div>
	
	
	<!-- 유동인구 분석 도움말 -->
	<div class="card">
        <div class="card-header">
            <h6 class="m-0 font-weight-bold text-primary">
	    		<i class="fas fa-info-circle"></i> 도움말
	    	</h6>
        </div><!-- /.help -->
	    
	    <div class="card-body">
            <ul>
                <li>
				유동인구는 대전시 2018년도 누적 데이터를 사용하였습니다.
				</li>
            </ul>
        </div>
    </div><!-- 도움말 end -->
	
	<!-- 2. 주거인구 기능 -->
	
	<h5 id="pop2" class="text-info text-left font-weight-bold mt-5">2.주거인구</h5>
	
	<div class="mt-5">
		<!-- 주거인구의 성별 및 연령별그래프 넣기 -->
		<div class="col-4 d-inline-block m-2">
			<!-- 성별 -->
			<canvas id="lpGender" width="100%" height="100%"></canvas>
		</div>
		<div class="w-63 d-inline-block m-2">
			<!-- 연령별 -->
			<canvas id="lpAge" width="100%" ></canvas>
		</div>
	</div>
	
	
	<!-- 주거인구 분석 도움말 -->
	<div class="card">
        <div class="card-header">
            <h6 class="m-0 font-weight-bold text-primary">
	    		<i class="fas fa-info-circle"></i> 도움말
	    	</h6>
        </div><!-- /.help -->
	    
	    <div class="card-body">
            <ul>
                <li>
			주거인구는 2019년도 전반기 누적데이터를 참고했습니다.
				</li>
            </ul>
        </div>
    </div><!-- 도움말 end -->
	
	
	<h5 id="pop3" class="text-info text-left font-weight-bold mt-5">3.직장인구</h5>
	
	<h5>
	<span class="text-gray-700 font-weight-bold right-box my-3" style="font-size: small;">                                 
        (단위 : 명) 
    </span>
    </h5>
	
	<table class="table table-bordered eTable mb-0">
	    <thead>
	    	<tr class="bg-gray-200">
	    		<th colspan="2">분석지역</th>
	    	</tr>
	    </thead>
	    <tbody>
	    	<tr>
	    		<td class="w-50">${regNames1.DONG }</td>
	    		<td class="w-50">${regNames2.DONG }</td>
	    	</tr>
	    </tbody>
	</table>
	<div class="parent"> 
		<table class="table table-bordered eTable w-50 float-left">
			<thead>
				<tr class="bg-gray-200">
				    <th rowspan="2">전체</th>
				    <th colspan="3">성별</th>
				</tr>
				<tr class="bg-gray-200">
				    <th>남</th>
				    <th>여</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				    <td>${wpTotal1.TOTAL }</td>
					<td>${wpList1.get(0).wp_cnt }</td>
					<td>${wpList1.get(1).wp_cnt }</td>
				</tr>
			</tbody>
		</table>
		<table class="table table-bordered eTable w-50 float-left">
			<thead>
				<tr class="bg-gray-200">
				    <th rowspan="2">전체</th>
				    <th colspan="3">성별</th>
				</tr>
				<tr class="bg-gray-200">
				    <th>남</th>
				    <th>여</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				    <td>${wpTotal2.TOTAL }</td>
					<td>${wpList2.get(0).wp_cnt }</td>
					<td>${wpList2.get(1).wp_cnt }</td>
				</tr>
			</tbody>
		</table>
	</div>

	
	<!-- 직장인구 분석 도움말 -->
	<div class="card">
        <div class="card-header">
            <h6 class="m-0 font-weight-bold text-primary">
	    		<i class="fas fa-info-circle"></i> 도움말
	    	</h6>
        </div><!-- /.help -->
	    
	    <div class="card-body">
            <ul>
                <li>
				직장인구 통계를 통해 예상고객 규모를 추정하실 수 있습니다
				</li>
            </ul>
        </div>
    </div><!-- 도움말 end -->
	
</div>

				</div>  <!-- 인구분석 보고서 결과 div 박스 end... -->
	         
            </div>	<!-- container end.. -->
		</div> <!-- tab-pane active end.. -->
	</div> <!-- tab-content mheight end.. -->
 
   </div>
</div> <!-- resultAnalysisForm end... -->

<br><br>
