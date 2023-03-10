<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 성장성/안정성/구매력/집객력의 각 합산 점수 및 평가종합점수 셋팅 -->
<c:set var="growth" value="${evalInfo.evaluation_sales_growth + evalInfo.evaluation_important }"/>
<c:set var="stability" value="${evalInfo.evaluation_variability + evalInfo.evaluation_closure}"/>
<c:set var="purchasePower" value="${evalInfo.evaluation_sales_scale + evalInfo.evaluation_payment + evalInfo.evaluation_consumptionlevel }"/>
<c:set var="visitPower" value="${evalInfo.evaluation_pp + evalInfo.evaluation_lp + evalInfo.evaluation_wp}"/>
<c:set var="evaluation" value="${growth + stability + purchasePower + visitPower}"/>
	
<!-- chartjs cdn 등록 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.js"></script>
<!-- 카카오 맵 api 등록 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9e96d9b8ca5bed0ac8c0a0ebf8487a10&libraries=services"></script>

<script>
$(document).ready(function(){
	mapSetting();	
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

/*	상권평가 메뉴의 그래프 셋팅	 */
function bdAppraisalReportChartSetting(){
	// 지역별 평가지수 추이 그래프
	var eval = $("#flowEval");
	// 상세평가지수 월별 추이 그래프
	var line = $("#flowLine");
	// 상세평가지수 레이더 그래프
	var radar = $("#totalRadar");
	
	/* 상세평가 지수 평가항목 그래프 */
	// 1.성장성
	var growth = $("#growthChart");
	// 2.안정성
	var stability = $("#stabilityChart");
	// 3.구매력
	var purchasePower = $("#ppChart");
	// 4.집객력
	var visitPower = $("#vpChart");
	
	
	
	// 지역별 평가지수 추이 그래프
	var flowEval = new Chart(eval, {
		type : 'line',
		data :{
			labels : [
				<c:forEach items="${rosList_dong}" var="rosVo" varStatus="status">
					<c:set value="${rosVo.evaluation_dt}01000000" var="dt"/>
					<fmt:parseDate value="${dt}" var="ros_dt" pattern="yyyyMMddHHmmss"/>
					<c:choose>
						<c:when test="${status.count < rosList_dong.size()}">
							'<fmt:formatDate value="${ros_dt}" pattern="yyyy년MM월"/>',
						</c:when>
						<c:otherwise>
							'<fmt:formatDate value="${ros_dt}" pattern="yyyy년MM월"/>'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets: [{
				label: '${rosList_dong.get(0).region_name}',
				fill : false,
				borderColor: '#0080ff',
				lineTension: 0,
				spanGaps:false,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'circle',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data:[
					<c:forEach items="${rosList_dong}" var="rosVo" varStatus="status">
						${rosVo.total},
						<c:if test="${status.count eq rosList_dong.size()}">
							NaN
						</c:if>
					</c:forEach>
				]
			},{
				label: '${rosList_gu.get(0).region_name}',
				fill : false,
				borderColor: '#66ff33',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'rectRot',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data:[
					<c:forEach items="${rosList_gu}" var="rosVo" varStatus="status">
						${rosVo.total}, 
						<c:if test="${status.count eq rosList_dong.size()}">
							NaN
						</c:if>
					</c:forEach>
				]
			},{
				label: '${rosList_si.get(0).region_name}',
				fill : false,
				borderColor: '#ff1a1a',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'triangle',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data:[
					<c:forEach items="${rosList_si}" var="rosVo" varStatus="status">
						${rosVo.total}, 
						<c:if test="${status.count eq rosList_dong.size()}">
							NaN
						</c:if>
					</c:forEach>
				]
			}]
		},
		options : {
			maintainAspectRatio : false,
			responsive: true,
		 	tooltips: {
	            mode: 'x',
	            intersect:true,
	            titleFontSize: 18,
	            titleMarginBottom: 9,
	            xPadding: 10,
	            yPadding: 10,
	            bodyFontSize: 14,
	        },
			legend:{
				position:'bottom',
				labels:{
					display:true,
					usePointStyle: true,
					fontSize: 15
				},
			},
			scales : {
				xAxes: [{
					offset: true,
	                ticks: {
	                     fontSize: 15
	                }
				}],
				yAxes: [{
					ticks:{
						max: 100,
						beginAtZero:true
					}
				}]
			}
		}
		
	})
	
	
	
	var myRadar = new Chart(radar, {
		type: 'radar',   // radar차트로 지정
		data: {
			labels : ['성장성', '안정성', '구매력', '집객력'],
			datasets:[ {
				data : [
					<fmt:formatNumber value="${growth}" pattern="0.0"/>, 
					<fmt:formatNumber value="${stability}" pattern="0.0"/>, 
					<fmt:formatNumber value="${purchasePower}" pattern="0.0"/>, 
					<fmt:formatNumber value="${visitPower}" pattern="0.0"/>
				],    // 위 라벨 순서대로 데이터가 매핑된다
				borderColor : '#ff6699',
				backgroundColor : 'rgb(255, 230, 238,0.5)',
				pointRadius : 5,
				pointHoverRadius : 5,
				fill : true
			}]
		},
		options : {
			legend:{
				display : false,
			},
			maintainAspectRatio : true,
		 	tooltips: {
                enabled: true,
                callbacks: {
                    label: function(tooltipItem, data) {
                    	console.log(tooltipItem);
                    	console.log(data.datasets[tooltipItem.datasetIndex]);
                        return data.labels[tooltipItem.index] + ' : ' +data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]; 
                    }			
                }
            },
			scale : {
				pointLabels: {
				      fontSize: 12
			    },
				ticks : {
					beginAtZero : true,
					max : 25,
					fontSize: 16
				}
			}
			
		}
		
	}); 
	
	var myLine = new Chart(line, {
		type: 'line',
		data: {
			labels : [
				<c:forEach items="${evalList}" var="dt" varStatus="status">
					<c:set value="${dt.EVALUATION_DT}01000000" var="e_dt"/>
					<fmt:parseDate value="${e_dt}" var="eval_dt" pattern="yyyyMMddHHmmss"/>
					<c:choose>
						<c:when test="${status.count < evalList.size()}">
						'<fmt:formatDate value="${eval_dt}" pattern="yyyy년MM월"/>',
						</c:when>
						<c:otherwise>
						'<fmt:formatDate value="${eval_dt}" pattern="yyyy년MM월"/>'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets:[{
				label: '성장성',
				borderColor: '#ffb84d',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'circle',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				fill: false,
				data : [
					<c:forEach items="${evalList}" var="eval" varStatus="status">
						${eval.GROWPT},
						<c:if test="${status.count eq evalList.size()}">
							/* ${eval.GROWPT} */NaN
						</c:if>
					</c:forEach>
				]
			},{
				label: '안정성',
				borderColor: '#9494b8',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'rectRounded',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				fill: false,
				data : [
					<c:forEach items="${evalList}" var="eval" varStatus="status">
						${eval.STABILITY},
						<c:if test="${status.count eq evalList.size()}">
							/* ${eval.STABILITY} */NaN
						</c:if>
					</c:forEach>
				]
			},{
				label: '구매력',
				borderColor: '#ff1a1a',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'star',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				fill: false,
				data : [
					<c:forEach items="${evalList}" var="eval" varStatus="status">
						${eval.PURCHASEPOWER},
						<c:if test="${status.count eq evalList.size()}">
							/* ${eval.PURCHASEPOWER} */NaN
						</c:if>
					</c:forEach>
				]
			},{
				label: '집객력',
				borderColor: '#00ffcc',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'rect',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				fill: false,
				data : [
					<c:forEach items="${evalList}" var="eval" varStatus="status">
						${eval.VISITPOWER},
						<c:if test="${status.count eq evalList.size()}">
							/* ${eval.VISITPOWER} */NaN
						</c:if>
					</c:forEach>
				]
			}]
		},
		options: {
			maintainAspectRatio : true,
			responsive: true,
		 	tooltips: {
	            mode: 'x',
	            intersect:true,
	            titleFontSize: 18,
	            titleMarginBottom: 9,
	            xPadding: 10,
	            yPadding: 10,
	            bodyFontSize: 14,
	        },
			legend:{
				position : 'bottom',
				labels:{
					display:true,
					usePointStyle: true,
					fontSize: 15
				},
			},
			scales : {
				xAxes: [{
					offset: true,
	                ticks: {
	                     fontSize: 15
	                }
				}],
				yAxes: [{
					ticks:{
						max: 25,
						beginAtZero:true
					}
				}]
			}
		}
	}); 
	
	
	
	var growthChart = new Chart(growth, {
		type: 'polarArea',
		data:{
			labels: ['매출증감률','상권 매출비중'],
			datasets:[{
				backgroundColor: [
					'rgb(26, 209, 255,0.3)',
					'rgb(92, 214, 92, 0.3)'
				],
				data:[${evalInfo.evaluation_sales_growth},${evalInfo.evaluation_important}]
			}]
		},
		options: {
			scale : {
				ticks : {
					beginAtZero : true,
					max: 20,
					stepSize: 5,
					fontSize: 13,
				}
			}
		}
	
	});
	
	var stabilityChart = new Chart(stability, {
		type: 'polarArea',
		data:{
			labels: ['변동성','휴/폐업률'],
			datasets:[{
				backgroundColor: [
					'rgb(26, 209, 255,0.3)',
					'rgb(92, 214, 92, 0.3)'
				],
				data:[${evalInfo.evaluation_variability},${evalInfo.evaluation_closure}]
			}]
		},
		options : {
			scale : {
				ticks : {
					beginAtZero : true,
					max: 15,
					stepSize: 3,
					fontSize: 13,
				}
			}
		}
	});
	
	var ppChart = new Chart(purchasePower, {
		type: 'polarArea',
		data:{
			labels: ['상권 매출규모','건당 결제금액','소비 수준'],
			datasets:[{
				backgroundColor: [
					'rgb(26, 209, 255,0.3)',
					'rgb(92, 214, 92, 0.3)',
					'rgb(255, 255, 51,0.3)'
				],
				data:[${evalInfo.evaluation_sales_scale},
					  ${evalInfo.evaluation_payment},
					  ${evalInfo.evaluation_consumptionlevel}
				]
			}]
		},
		options : {
			scale : {
				ticks : {
					beginAtZero : true,
					max: 10,
					fontSize: 13,
				}
			}
		}
	});
	
	var vpChart = new Chart(visitPower, {
		type: 'polarArea',
		data:{
			labels: ['유동인구','주거인구','직장인구'],
			datasets:[{
				backgroundColor: [
					'rgb(26, 209, 255,0.3)',
					'rgb(92, 214, 92, 0.3)',
					'rgb(255, 255, 51,0.3)'
				],
				data:[${evalInfo.evaluation_pp},
					  ${evalInfo.evaluation_lp},
					  ${evalInfo.evaluation_wp}]
			}]
		},
		options : {
			scale : {
				ticks : {
					beginAtZero : true,
					max: 10,
					fontSize: 13,
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
		type: 'line',
		data: {
			labels : [
				<c:forEach items="${topCntRos}" var="item" varStatus="status">
					<c:set value="${item.bd_dt}01000000" var="dt"/>
					<fmt:parseDate value="${dt}" var="topCntRos_dt" pattern="yyyyMMddHHmmss"/>
					<c:choose>
						<c:when test="${status.count < topCntRos.size()}">
							'<fmt:formatDate value="${topCntRos_dt}" pattern="yyyy년MM월"/>',
						</c:when>
						<c:otherwise>
							'<fmt:formatDate value="${topCntRos_dt}" pattern="yyyy년MM월"/>'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets:[
			// 분석지역 내 해당 업종이 없을 시에 예외처리
			<c:if test="${botCntRos.size() > 0}">
			{
				label: '${tobNames.BOT}',
				fill: false,
				borderColor: '#0080ff',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'circle',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data : [
					<c:forEach items="${botCntRos}" var="botItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < botCntRos.size()}">
								${botItem.cnt},
							</c:when>
							<c:otherwise>
								${botItem.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},
			</c:if>
			// 분석지역 내 해당 업종이 없을 시에 예외처리
			<c:if test="${midCntRos.size() > 0}">
			{
				label: '${tobNames.MID}',
				fill: false,
				borderColor: '#66ff33',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'rect',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data : [
					<c:forEach items="${midCntRos}" var="midItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < midCntRos.size()}">
								${midItem.cnt},
							</c:when>
							<c:otherwise>
								${midItem.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},
			</c:if>
			// 분석지역 내 해당 업종이 없을 시에 예외처리
			<c:if test="${topCntRos.size() > 0}">
			{
				label:'${tobNames.TOP}',
				fill: false,
				borderColor: '#ff1a1a',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'triangle',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data : [
					<c:forEach items="${topCntRos}" var="topItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < topCntRos.size()}">
								${topItem.cnt},
							</c:when>
							<c:otherwise>
								${topItem.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			}</c:if>]
		},
		options: {
			maintainAspectRatio : false,
			responsive: true,
		 	tooltips: {
	            mode: 'x',
	            intersect:true,
	            titleFontSize: 18,
	            titleMarginBottom: 9,
	            xPadding: 10,
	            yPadding: 10,
	            bodyFontSize: 14,
	        },
			legend:{
				position:'bottom',
				labels:{
					display:true,
					usePointStyle: true,
					fontSize: 15
				},
			},
			scales : {
				xAxes: [{
					offset: true,
	                ticks: {
	                     fontSize: 15
	                }
				}],
				yAxes: [{
					ticks:{
						beginAtZero:true
					}
				}]
			}
		}
		
	}) 
	
	var regTrendsChart = new Chart(regTobTrends,{
		type: 'line',
		data: {
			labels : [
				<c:forEach items="${tobCntList_Si}" var="item" varStatus="status">
					<c:set value="${item.bd_dt}01000000" var="dt"/>
					<fmt:parseDate value="${dt}" var="tobCntRos_dt" pattern="yyyyMMddHHmmss"/>
					<c:choose>
						<c:when test="${status.count < tobCntList_Si.size()}">
							'<fmt:formatDate value="${tobCntRos_dt}" pattern="yyyy년MM월"/>',
						</c:when>
						<c:otherwise>
							'<fmt:formatDate value="${tobCntRos_dt}" pattern="yyyy년MM월"/>'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets:[
			// 분석지역 내 해당 업종이 없을 시에 예외처리
			<c:if test="${tobCntList_Dong.size() > 0}">
			{
				label:'${regNames.DONG}',
				fill: false,
				borderColor: '#0080ff',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'circle',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data:[
					<c:forEach items="${tobCntList_Dong}" var="dongVo" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobCntList_Dong.size()}">
								${dongVo.cnt},
							</c:when>
							<c:otherwise>
								${dongVo.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},
			</c:if>
			// 분석지역 내 해당 업종이 없을 시에 예외처리
			<c:if test="${tobCntList_Gu.size() > 0}">
			{
				label:'${regNames.GU}',
				fill: false,
				borderColor: '#66ff33',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'rect',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data:[
					<c:forEach items="${tobCntList_Gu}" var="guVo" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobCntList_Gu.size()}">
								${guVo.cnt},
							</c:when>
							<c:otherwise>
								${guVo.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},
			</c:if>
			// 분석지역 내 해당 업종이 없을 시에 예외처리
			<c:if test="${tobCntList_Si.size() > 0}">
			{
				label:'${regNames.SI}',
				fill: false,
				borderColor: '#ff1a1a',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'triangle',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data:[
					<c:forEach items="${tobCntList_Si}" var="siVo" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobCntList_Si.size()}">
								${siVo.cnt},
							</c:when>
							<c:otherwise>
								${siVo.cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			}
			</c:if>]
		},
		options : {
			maintainAspectRatio : false,
			responsive: true,
		 	tooltips: {
	            mode: 'x',
	            intersect:true,
	            titleFontSize: 18,
	            titleMarginBottom: 9,
	            xPadding: 10,
	            yPadding: 10,
	            bodyFontSize: 14,
	        },
			legend:{
				position:'bottom',
				labels:{
					display:true,
					usePointStyle: true,
					fontSize: 15
				},
			},
			scales : {
				xAxes: [{
					offset: true,
	                ticks: {
	                     fontSize: 15
	                }
				}],
				yAxes: [{
					ticks:{
						beginAtZero:true
					}
				}]
			}
		}
	})
	
	var tob_sales = ${tobLC_Sale.CHANGERATE};
	var tob_cnt = ${tobLC_Cnt.CHANGERATE};
	
	var backgroundColor = '#4db8ff';
	var pointBackgroundColor = '#4db8ff';
	

	if(tob_cnt > 0.0 && tob_sales > 0.0){	//성장 업종
		backgroundColor = '#66ff33';
		pointBackgroundColor = '#66ff33';
	}else if(tob_cnt <= 0.0 && tob_sales > 0.0){	//집중 업종
		backgroundColor = '#0099ff';
		pointBackgroundColor = '#0099ff';
	}else if(tob_cnt >= 0.0 && tob_sales <= 0.0){	//경쟁업종
		backgroundColor = '#ff6600';
		pointBackgroundColor = '#ff6600';
	} else if(tob_cnt < 0.0 && tob_sales < 0.0){	//침체업종
		backgroundColor = '#ff0000';
		pointBackgroundColor = '#ff0000';
	}
	
	var tobLcChart = new Chart(tobLC, {
		type: 'scatter',
		data : {
			<c:if test="${tobLC_Cnt ne null}">
			datasets:[{
				label : '${tobNames.BOT}',
				data : [
				<c:if test="${tobLC_Sale.CHANGERATE ne null && tobLC_Cnt.CHANGERATE ne null}">
				{
					x: ${tobLC_Sale.CHANGERATE},
					y: ${tobLC_Cnt.CHANGERATE}
				}</c:if>],
				backgroundColor: backgroundColor,
				pointRadius : 10,
				pointHoverRadius : 12,
				pointBackgroundColor : pointBackgroundColor
			}]
			</c:if>
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
		type: 'line',
		data: {
			labels : [
				<c:forEach items="${tobSac_Top}" var="item" varStatus="status">
					<c:set value="${item.sales_dt}01000000" var="dt"/>
					<fmt:parseDate value="${dt}" var="tobSac_Top_dt" pattern="yyyyMMddHHmmss"/>
					<c:choose>
						<c:when test="${status.count < tobSac_Top.size()}">
							'<fmt:formatDate value="${tobSac_Top_dt}" pattern="yyyy년MM월"/>',
						</c:when>
						<c:otherwise>
							'<fmt:formatDate value="${tobSac_Top_dt}" pattern="yyyy년MM월"/>'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets:[
			// 분석지역 내 해당 업종이 없을 시에 예외처리
			<c:if test="${tobSac_Bot.size() > 0}">
			{
				label:'${tobNames.BOT}',
				fill: false,
				borderColor: '#0080ff',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'circle',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data : [
					<c:forEach items="${tobSac_Bot}" var="botItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobSac_Bot.size()}">
								${botItem.curSale},
							</c:when>
							<c:otherwise>
								${botItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},
			</c:if>
			// 분석지역 내 해당 업종이 없을 시에 예외처리
			<c:if test="${tobSac_Mid.size() > 0}">
			{
				label:'${tobNames.MID}',
				fill: false,
				borderColor: '#66ff33',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'rect',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data : [
					<c:forEach items="${tobSac_Mid}" var="midItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobSac_Mid.size()}">
								${midItem.curSale},
							</c:when>
							<c:otherwise>
								${midItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},
			</c:if>
			// 분석지역 내 해당 업종이 없을 시에 예외처리
			<c:if test="${tobSac_Top.size() > 0}">
			{
				label:'${tobNames.TOP}',
				fill: false,
				borderColor: '#ff1a1a',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'triangle',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data : [
					<c:forEach items="${tobSac_Top}" var="topItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < tobSac_Top.size()}">
								${topItem.curSale},
							</c:when>
							<c:otherwise>
								${topItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			}</c:if>]
		},
		options:{
			maintainAspectRatio : false,
			responsive: true,
		 	tooltips: {
	            mode: 'x',
	            intersect:true,
	            titleFontSize: 18,
	            titleMarginBottom: 9,
	            xPadding: 10,
	            yPadding: 10,
	            bodyFontSize: 14,
	        },
			legend:{
				position:'bottom',
				labels:{
					display:true,
					usePointStyle: true,
					fontSize: 15
				},
			},
			scales : {
				xAxes: [{
					offset: true,
	                ticks: {
	                     fontSize: 15
	                }
				}],
				yAxes: [{
					ticks:{
						beginAtZero:true
					}
				}]
			}
		}
	})
	
	var regSacRosChart = new Chart(flowReg,{
		type: 'line',
		data: {
			labels : [
				<c:forEach items="${regSac_Si}" var="item" varStatus="status">
					<c:set value="${item.sales_dt}01000000" var="dt"/>
					<fmt:parseDate value="${dt}" var="regSac_Si_dt" pattern="yyyyMMddHHmmss"/>
					<c:choose>
						<c:when test="${status.count < regSac_Si.size()}">
							'<fmt:formatDate value="${regSac_Si_dt}" pattern="yyyy년MM월"/>',
						</c:when>
						<c:otherwise>
							'<fmt:formatDate value="${regSac_Si_dt}" pattern="yyyy년MM월"/>'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets:[
			// 분석지역 내 해당 업종이 없을 시에 예외처리
			<c:if test="${regSac_Dong.size() > 0}">
			{
				label:'${regNames.DONG}',
				fill: false,
				borderColor: '#0080ff',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'circle',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data : [
					<c:forEach items="${regSac_Dong}" var="dongItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < regSac_Dong.size()}">
								${dongItem.curSale},
							</c:when>
							<c:otherwise>
								${dongItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},
			</c:if>
			// 분석지역 내 해당 업종이 없을 시에 예외처리
			<c:if test="${regSac_Gu.size() > 0}">
			{
				label:'${regNames.GU}',
				fill: false,
				borderColor: '#66ff33',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'rect',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data : [
					<c:forEach items="${regSac_Gu}" var="guItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < regSac_Gu.size()}">
								${guItem.curSale},
							</c:when>
							<c:otherwise>
								${guItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			},
			</c:if>
			// 분석지역 내 해당 업종이 없을 시에 예외처리
			<c:if test="${regSac_Si.size() > 0}">
			{
				label:'${regNames.SI}',
				fill: false,
				borderColor: '#ff1a1a',
				lineTension: 0,
				pointRadius:7,
				pointHoverRadius:7,
				pointStyle: 'triangle',
				backgroundColor : 'rgb(255, 255, 255,0.5)',
				data : [
					<c:forEach items="${regSac_Si}" var="siItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < regSac_Si.size()}">
								${siItem.curSale},
							</c:when>
							<c:otherwise>
								${siItem.curSale}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				]
			}</c:if>]
		},
		options:{
			maintainAspectRatio : false,
			responsive: true,
		 	tooltips: {
	            mode: 'x',
	            intersect:true,
	            titleFontSize: 18,
	            titleMarginBottom: 9,
	            xPadding: 10,
	            yPadding: 10,
	            bodyFontSize: 14,
	        },
			legend:{
				position:'bottom',
				labels:{
					display:true,
					usePointStyle: true,
					fontSize: 15
				},
			},
			scales : {
				xAxes: [{
					offset: true,
	                ticks: {
	                     fontSize: 15
	                }
				}],
				yAxes: [{
					ticks:{
						beginAtZero:true
					}
				}]
			}
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
		type: 'doughnut',
		data: {
			labels : [
				'${ppgList.get(0).PPG_GENDER eq 1 ? "남성" : "여성"}',
				'${ppgList.get(1).PPG_GENDER eq 1 ? "남성" : "여성"}'
			],
			datasets:[{
				data : [
					${ppgList.get(0).PPG_GENDER eq 1 ? ppgList.get(0).RATIO : ppgList.get(1).RATIO},
					${ppgList.get(1).PPG_GENDER eq 1 ? ppgList.get(0).RATIO : ppgList.get(1).RATIO}
				],
				backgroundColor :['#6699ff', '#ff0066']
			}]
		},
		options : {
			legend:{
				position:'bottom'
			}
		}
		
	})
	
	var ppaChart = new Chart(ppa,{
		type: 'bar',
		data:{
			labels:[
				<c:forEach items="${ppaList}" var="item" varStatus="status">
					<c:choose>
						<c:when test="${status.count < ppaList.size()}">
							'${item.ppa_age_group}대',
						</c:when>
						<c:otherwise>
							'${item.ppa_age_group}대'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets:[{
				data:[
					<c:forEach items="${ppaList}" var="ppaItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < ppaList.size()}">
								${ppaItem.ppa_cnt},	
							</c:when>
							<c:otherwise>
								${ppaItem.ppa_cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				],
				backgroundColor :[
					'rgb(255, 99, 132, 1)',
					'rgb(102, 102, 153, 1)',
					'rgb(255, 206, 66, 1)',
					'rgb(75, 192, 192, 1)',
					'rgb(153, 102, 255, 1)',
					'rgb(255, 159, 64, 1)'
				]
			
			}]
		},
		options : {		
			legend:{
				display : false
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
		type: 'doughnut',
		data: {
			labels : [
				'${lpGenderList.get(0).lp_gender eq 1 ? "남성" : "여성"}',
				'${lpGenderList.get(1).lp_gender eq 1 ? "남성" : "여성"}'
			],
			datasets:[{
				data : [
					${lpGenderList.get(0).lp_gender eq 1 ? lpGenderList.get(0).lp_ratio : lpGenderList.get(1).lp_ratio},
					${lpGenderList.get(1).lp_gender eq 1 ? lpGenderList.get(0).lp_ratio : lpGenderList.get(1).lp_ratio}
				],
				backgroundColor :['#6699ff', '#ff0066']
			}]
		},
		options : {
			legend:{
				position:'bottom'
			}
		}
		
	})
	
	var lpAgeChart = new Chart(lpAge,{
		type: 'bar',
		data:{
			labels:[
				<c:forEach items="${lpAgeList}" var="item" varStatus="status">
					<c:choose>
						<c:when test="${status.count < lpAgeList.size()}">
							'${item.lp_age_group}대',
						</c:when>
						<c:otherwise>
							'${item.lp_age_group}대'
						</c:otherwise>
					</c:choose>
				</c:forEach>
			],
			datasets:[{
				data:[
					<c:forEach items="${lpAgeList}" var="lpItem" varStatus="status">
						<c:choose>
							<c:when test="${status.count < lpAgeList.size()}">
								${lpItem.lp_cnt},	
							</c:when>
							<c:otherwise>
								${lpItem.lp_cnt}
							</c:otherwise>
						</c:choose>
					</c:forEach>
				],
				backgroundColor :[
					'rgb(255, 99, 132, 1)',
					'rgb(102, 102, 153, 1)',
					'rgb(255, 206, 66, 1)',
					'rgb(75, 192, 192, 1)',
					'rgb(153, 102, 255, 1)',
					'rgb(255, 159, 64, 1)'
				]
			
			}]
		},
		options : {		
			legend:{
				display : false
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


function mapSetting(){
	imageSrc = '${pageContext.request.contextPath}/img/map-marker.png',
	imageSize = new kakao.maps.Size(50, 55); // 마커이미지의 크기입니다
	
	var MapContainer  = document.getElementById('map'), // 이미지 지도를 표시할 div  
	   MapOption = { 
	       center: new kakao.maps.LatLng(33.450701, 126.570667), // 이미지 지도의 중심좌표
	       level: 3 // 이미지 지도의 확대 레벨
	   };
	// 이미지 지도를 표시할 div와 옵션으로 이미지 지도를 생성합니다
	var map = new kakao.maps.Map(MapContainer, MapOption);
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	
	var region_csc = '${regionVo.region_csc}';
	console.log(region_csc);
	
	
	// 주소로 좌표를 검색합니다
	// 분석지역의 상세 주소를 DB에서 조회하여 아래 메서드에 인자로 넣어준다.
	geocoder.addressSearch(region_csc, function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			console.log(coords);
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);

	        var center = map.getCenter();	// 좌표값 얻어오기
			var lat = center.getLat();		// 위도
			var lng = center.getLng();		// 경도

	        console.log("center:"+center);
			console.log("lat:"+lat);
			console.log("lng:"+lng);

	        // 이미지 지도에서 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(lat, lng); 
			
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
			
			// 이미지 지도에 표시할 마커입니다
			// 이미지 지도에 표시할 마커는 Object 형태입니다
			var marker = new kakao.maps.Marker ({
			    position: markerPosition,
			    image: markerImage
			});
			
			var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
			   staticMapOption = { 
			       center: new kakao.maps.LatLng(lat, lng), // 이미지 지도의 중심좌표
			       level: 3, // 이미지 지도의 확대 레벨
			       marker : marker
			   };
			
			// 이미지 지도를 표시할 div와 옵션으로 이미지 지도를 생성합니다
			var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);

			
	    } 
	});
	
}

function apartmentMap(){
	
	markers = [];
	
	var MapContainer_apt  = document.getElementById('aptMap'), // 이미지 지도를 표시할 div  
		MapOption_apt = { 
	       center: new kakao.maps.LatLng(33.450701, 126.570667), // 이미지 지도의 중심좌표
	       level: 5 // 이미지 지도의 확대 레벨
	   };
	// 이미지 지도를 표시할 div와 옵션으로 이미지 지도를 생성합니다
	var aptMap = new kakao.maps.Map(MapContainer_apt, MapOption_apt);
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder_apt = new kakao.maps.services.Geocoder();
	
	
	var region_csc_res = '${regionVo.region_csc}';
	console.log(region_csc_res);
	
	// 주소로 좌표를 검색합니다
	// 분석지역의 상세 주소를 DB에서 조회하여 아래 메서드에 인자로 넣어준다.
	geocoder_apt.addressSearch(region_csc_res, function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	    	 var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			aptMap.setCenter(coords);
			
	    } 
	});
	
	
	$.ajax({
		url : "${pageContext.request.contextPath}/bdAnalysis/aptListLookUp",
		data : "region_cd=${regionVo.region_cd}",
		dataType : "json",
		method: "GET",
		success : function(data){
			console.log(data);
			
			var aptList = data.aptList;
			
			$.each(aptList, function(idx, vo){
				
				var region_csc_apt = vo.apartment_addr;
				// 주소로 좌표를 검색합니다
				// 분석지역의 상세 주소를 DB에서 조회하여 아래 메서드에 인자로 넣어준다.
				geocoder_apt.addressSearch(region_csc_apt, function(result, status) {
				
				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {
				
				    	var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

// 				    	var imageSrc = '${pageContext.request.contextPath}/img/map-marker.png',
// 					    	 imageSize = new kakao.maps.Size(50, 55); // 마커이미지의 크기입니다
						    
					    // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
					    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
						   
						
						    // 결과값으로 받은 위치를 마커로 표시합니다
						var marker = new kakao.maps.Marker({
							map : aptMap,
							position : coords,
							image: markerImage
						});
						
						
						 // 인포윈도우로 장소에 대한 설명을 표시합니다
				        var infowindow = new kakao.maps.InfoWindow({
				            content: '<div style="width:330px;overflow-y:auto;text-align:center;padding:6px;">'+
				            	"<table class='table table-bordered'>"+
				            	"<tr><th>공동주택</th><th>세대수</th></tr>"+
				           		'<tr><td>'+vo.apartment_name+'</td><td>'+
				           		vo.apartment_cnt.toLocaleString()+'</td></tr>'+
				           		"</table>"
				            +'</div>'
				        });
				      
				        // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
				        // 이벤트 리스너로는 클로저를 만들어 등록합니다 
				        // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
				        kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(aptMap, marker, infowindow));
				        kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
						
				    } 
				});
				
			})
		},
		fail:function(err){
			console.log(err);
		}
		
	})
	
}

//인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
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
		apartmentMap();
	}
	
}

// excel 다운로드 버튼 클릭 시 excel 다운로딩
function excelBtn(){
	$("#excelFrm").submit();
}

// pdf 다운로드 버튼 클릭 시 실행될 function
function pdfBtn(e){
	// PDF 다운로드 버튼을 클릭했을 때
	
    html2canvas(document.querySelector("#resultAnalysisForm"),{
    	 useCORS: true,
    	 allowTaint : false
    }).then(function(canvas) {
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

     		doc.save('bdAnalysisReport.pdf');
        
       
        
	});
    

	$("#resultAnalysisForm").attr("style", "padding : 0px;");
        
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

.eSpan, td{
	font-size : 0.9em;
	color : black;
}

.eSpan {
	cursor: pointer;
}

.eTable {
	text-align: center;
 	width : 100%;
 	cellspacing : 0; 
	margin-top : 10px;
	font-size : 0.9em;
}

.eTable td {
	text-align : center;
	vertical-align: middle;
}

.eText{
	font-size : 0.6em !important;
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
	font-size : 0.9em;
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
	border-width: 2px;
}

.eSpan2 {
	font-size : 0.8em;
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
	height: 475px;
	text-align : center;
	float:left;
	background :url('../img/배경이미지2.gif') no-repeat;
	background-position: center;
}
/* 상권 평가 등급 메달 이미지 크기 지정 */
#signal{
	width: 300px;
	height: 300px;
}
/* 정적 지도 이미지 크기 지정 */
#staticMap{
	width: 100%;
	height : 475px;
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

/* 분석결과의 텍스트 강조 */
.res-text{
	font-size: 1.1em;
	color: #ff1a75;
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
			<h2 id="eH4" class="font-weight-bold text-left mt-3">상권분석 보고서</h2>  
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
			<span onclick="fnMove(this)" data-no="2" data-kind="info">2. 지역별 평가지수 추이&nbsp;&nbsp;</span>
			<span onclick="fnMove(this)" data-no="3" data-kind="info">3. 상세평가지수&nbsp;&nbsp;</span>
			
			<div class="right-box">
				<a href="#" class="btn btn-primary btn-icon-split btn-sm" onclick="pdfBtn(this)">
		          <span class="text">PDF다운로드</span>
		        </a>
				<a href="#" class="btn btn-primary btn-icon-split btn-sm" onclick="excelBtn()">
		          <span class="text">EXCEL다운로드</span>
		        </a>
				<form id="excelFrm" action="${pageContext.request.contextPath }/bdAnalysis/excel" 
						method="post">
					<input type="hidden" name="report_cd" value="${reportVo.report_cd }"/>
					<input type="hidden" name="evaluation" value="${evaluation}"/>
					<input type="hidden" name="growth" value="${growth }"/>
					<input type="hidden" name="stability" value="${stability }"/>
					<input type="hidden" name="purchasePower" value="${purchasePower }"/>
					<input type="hidden" name="visitPower" value="${visitPower }"/>
				</form>
	        </div>
	        <hr>
		</div>
	</div>
	<!-- 업종분석 가이드라인 -->
	<div id="guideLineupjong" class="guideBar d-none">
		<div class="container mt-3">
			<span onclick="fnMove(this)" data-no="1" data-kind="tob">1. 업종별 추이&nbsp;&nbsp;</span>
			<span onclick="fnMove(this)" data-no="2" data-kind="tob">2. 지역별 추이&nbsp;&nbsp;</span>
			<span onclick="fnMove(this)" data-no="3" data-kind="tob">3. 업종 생애주기&nbsp;&nbsp;</span>
			
			<div class="right-box">
				<a href="#" class="btn btn-primary btn-icon-split btn-sm" onclick="pdfBtn(this)">
		          <span class="text">PDF다운로드</span>
		        </a>
				<a href="#" class="btn btn-primary btn-icon-split btn-sm" onclick="excelBtn()">
		          <span class="text">EXCEL다운로드</span>
		        </a>
				
	        </div>
	        <hr>
		</div>
	</div>
	<!-- 매출분석 가이드라인 -->
	<div id="guideLinesales" class="guideBar d-none">
		<div class="container mt-3">
			<span onclick="fnMove(this)" data-no="1" data-kind="sales">1. 업종별 매출추이&nbsp;&nbsp;</span>
			<span onclick="fnMove(this)" data-no="2" data-kind="sales">2. 지역별 매출추이&nbsp;&nbsp;</span>
			
			<div class="right-box">
				<a href="#" class="btn btn-primary btn-icon-split btn-sm" onclick="pdfBtn(this)">
		          <span class="text">PDF다운로드</span>
		        </a>
				<a href="#" class="btn btn-primary btn-icon-split btn-sm" onclick="excelBtn()">
		          <span class="text">EXCEL다운로드</span>
		        </a>
				
	        </div>
	        <hr>
		</div>
	</div>
	<!-- 인구분석 가이드라인 -->
	<div id="guideLinepop" class="guideBar d-none">
		<div class="container mt-3">
			<span onclick="fnMove(this)" data-no="1" data-kind="pop">1. 유동인구&nbsp;&nbsp;</span>
			<span onclick="fnMove(this)" data-no="2" data-kind="pop">2. 주거인구&nbsp;&nbsp;</span>
			<span onclick="fnMove(this)" data-no="3" data-kind="pop">3. 직장인구&nbsp;&nbsp;</span>
			<span onclick="fnMove(this)" data-no="4" data-kind="pop">4. 공동주택&nbsp;&nbsp;</span>
			
			<div class="right-box">
				<a href="#" class="btn btn-primary btn-icon-split btn-sm" onclick="pdfBtn(this)">
		          <span class="text">PDF다운로드</span>
		        </a>
				<a href="#" class="btn btn-primary btn-icon-split btn-sm" onclick="excelBtn()">
		          <span class="text">EXCEL다운로드</span>
		        </a>
				
	        </div>
	        <hr>
		</div>
	</div>
		
	<div class="tab-content mheight" id="result">
		<div class="tab-pane active">
            <!-- 탭(2차) -->
            <!-- /탭(2차) -->
            
            <div class="container"> 
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
                <th>분석지역</th>
                <th>분석업종</th>
                <th>분석시점</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>${region_full_name}</td>
                <td>${tob_full_name }</td>
                <c:set var="now" value="<%=new Date()%>"/>
                <td><fmt:formatDate value="${now }" pattern="yyyy년 MM월 dd일"/></td>
            </tr>
        </tbody>
    </table>
    
    <h5 class="text-info text-left font-weight-bold mt-5">
    	상권 주요정보
	    <span class="text-gray-700 right-box eText mt-2">                                 
	        (단위 : 개, 명) 
	    </span>                             
    </h5>
    
    <table class="table table-bordered eTable">
        <thead>
            <tr class="bg-gray-200">
                <th rowspan="2">지역</th>
                <th rowspan="2">면적</th>
                <th colspan="5">업소수</th>
                <th colspan="2">선택업종 총매출/건수</th>
                <th colspan="3">인구</th>
            </tr>
            <tr class="bg-gray-200">
                <th>전체</th>
                <th>음식</th>
                <th>서비스</th>
                <th>소매</th>
                <th>선택업종</th>
                <th>총액(만원)</th>
                <th>건수</th>
                <th>주거</th>
                <th>직장</th>
                <th>유동</th>
            </tr>
        </thead>
        <tbody>
            
            <tr>
                <td class="font-weight-bold">${region_full_name}</td>
                <td><fmt:formatNumber value="${bdInfo.region_extent }" pattern="#,###" /></td>
                <td>
                <fmt:formatNumber value="${bdInfo.storeCnt_Food + bdInfo.storeCnt_Service
               							+ bdInfo.storeCnt_Retail + bdInfo.storeCnt.SelectedTob }"
               					pattern="#,###"/>
                
               	</td>
                <td>
                <fmt:formatNumber value="${bdInfo.storeCnt_Food }" pattern="#,###"/> 
                </td>
                
                <td>
                <fmt:formatNumber value="${bdInfo.storeCnt_Service }" pattern="#,###"/> 
                </td>
                
                <td>
                <fmt:formatNumber value="${bdInfo.storeCnt_Retail }" pattern="#,###"/> 
                </td>
                <td>
                  <strong>
	                <fmt:formatNumber value="${bdInfo.storeCnt_SelectedTob }" pattern="#,###"/> 
                  </strong>
                </td>
                
                <td>
                	<strong>
                	<fmt:formatNumber value="${bdInfo.selectedTob_SalesVo.sales_monthly
               								 eq null ? 0 : bdInfo.selectedTob_SalesVo.sales_monthly}" 
                					  pattern="#,###"/>
                	</strong>
                </td>
                <td>
                	<strong>
                	<fmt:formatNumber value="${bdInfo.selectedTob_SalesVo.sales_cnt 
                							  eq null ? 0 : bdInfo.selectedTob_SalesVo.sales_monthly }" 
               					      pattern="#,###"/>
            		</strong>
                </td>
                <td>
                	<fmt:formatNumber value="${bdInfo.lpCnt }" pattern="#,###"/>
                </td>
                <td>
                	<fmt:formatNumber value="${bdInfo.wpCnt }" pattern="#,###"/>
                </td>
                <td>
                	<strong>
                		<fmt:formatNumber value="${bdInfo.ppgCnt }" pattern="#,###"/>
                	</strong>
                </td>
            </tr>
            
        </tbody>
    </table>
    
    <div class="card">
	    <div class="card-header">
	    	<h6 class="m-0 font-weight-bold text-primary">
	    		<i class="fas fa-info-circle"></i> 도움말
	    	</h6>
	    </div>
	    <div class="card-body">
	        <ul>
	            <li>분석지역에 분석업종이 없는 경우 매출분석결과가 없을 수 있습니다.</li>
	            <li>매출분석의 표본 분석이므로 매출 분석 결과가 없을 수 있습니다.</li>
	            <li>유동인구는 1년 통계를 산출한 데이터입니다.</li>
	        </ul> 
	    </div>
	</div><!-- 도움말 end -->
	
	<br>
	
	
    <h5 id="info1" class="text-info text-left font-weight-bold mt-5">1. 평가종합</h5>

    <h6 class="text-secondary mt-4">분석지역&nbsp;:&nbsp;${region_full_name }</h6>
    
    <div>
        <div class="float-left w-50">
            <!-- 동적으로 장소를 찍어주기 위한용도의 맵 -->
            <div id="map" style="display:none;"></div>
            <!-- 화면에 정적 이미지 지도를 출력 -->
           	<div id="staticMap" class="border-gray"></div>
        </div>
        
       	<div id="sign" class="w-50 border-gray">
       		<c:choose>
       			<c:when test="${evaluation >= 65.5 }">
		       		<img id="signal" src="${pageContext.request.contextPath}/img/금.gif"><br>
		       		<span id="gold" class="btn btn-warning btn-icon-split mb-3">평가종합등급:1등급</span><br>
		       		<span>선택지역의 평가종합등급은 <strong>'1등급'</strong>입니다.<br>
		       		평가종합등은 '성장성','안정성','구매력','집객력'점수를 합산해 산출합니다<br>
		       		등급을 나누는 기준은 아래 등급안내표가 있으니 참고하십시오.<br>
		       		상세평가지수는 아래 상세평가지수에서 확인하실 수 있습니다 .</span>
       			</c:when>
       			<c:when test="${evaluation >= 40 && evaluation < 65.5}">
		       		<img id="signal" src="${pageContext.request.contextPath}/img/은.gif"><br>
		       		<span id="silver" class="btn btn-secondary btn-icon-split mb-3">평가종합등급:2등급</span><br>
		       		<span>선택지역의 평가종합등급은 <strong>'2등급'</strong>입니다.<br>
		       		평가종합등은 '성장성','안정성','구매력','집객력'점수를 합산해 산출합니다<br>
		       		등급을 나누는 기준은 아래 등급안내표가 있으니 참고하십시오.<br>
		       		상세평가지수는 아래 상세평가지수에서 확인하실 수 있습니다 .</span>
       			</c:when>
       			<c:otherwise>
		       		<img id="signal" src="${pageContext.request.contextPath}/img/동.gif"><br>
		       		<span id="bronze" class="btn btn-icon-split mb-3">평가종합등급:3등급</span><br>
		       		<span>선택지역의 평가종합등급은 <strong>'3등급'</strong>입니다.<br>
		       		평가종합등은 '성장성','안정성','구매력','집객력'점수를 합산해 산출합니다<br>
		       		등급을 나누는 기준은 아래 등급안내표가 있으니 참고하십시오.<br>
		       		상세평가지수는 아래 상세평가지수에서 확인하실 수 있습니다 .</span>
       			</c:otherwise>
       		</c:choose>
       	</div>
    </div>  
          
    <p class="clearfix"></p>
                
    <table class="table table-bordered eTable mt-4">
    <thead>
        <tr class="bg-gray-200">
            <th rowspan="2">구분</th>
            <th colspan="3">상권평가지수(100점 만점)</th>
            <th rowspan="2">성장성</th>
            <th rowspan="2">안정성</th>
            <th rowspan="2">구매력</th>
            <th rowspan="2">집객력</th>
        </tr>
        <tr class="bg-gray-200">
            <th>전월</th>
            <th>현재</th>
            <th>증감률</th>
        </tr>
    </thead>
    <tbody>

        <tr>
            <td>내용</td>                                         
            <td>
            	<fmt:formatNumber value="${rosList_dong.get(rosList_dong.size()-2).total }" pattern="0.0"/>
            </td>
            <td>
            	<fmt:formatNumber value="${evaluation }" pattern="0.0"/>
            </td>
            <td>
                <strong>
                	<fmt:formatNumber value="${rosList_dong.get(rosList_dong.size()-1).growpt }" pattern="0.0"/>%
                <c:choose>
	                <c:when test="${rosList_dong.get(rosList_dong.size()-1).growpt > 0 }">
	        	        <span class="up">▲</span>
	                </c:when>	
	                <c:when test="${rosList_dong.get(rosList_dong.size()-1).growpt < 0 }">
	        	        <span class="down">▼</span>
	                </c:when>
                </c:choose>
                
                </strong>
            </td>
            
            <td>
            	<strong class="largenum">
            	<fmt:formatNumber value="${growth}" pattern="0.0"/>
        		</strong>점
            </td>
            <td>
	            <strong class="largenum">
	            	<fmt:formatNumber value="${stability}" pattern="0.0"/>
	            </strong>점
            </td>
            <td>
            	<strong class="largenum">
            		<fmt:formatNumber value="${purchasePower}" pattern="0.0"/>
            	</strong>점
            </td>
            <td>
            <strong class="largenum">
				<fmt:formatNumber value="${visitPower}" pattern="0.0"/>
            </strong>점
            </td>
        </tr>
    </tbody>
    </table>
    
    <div>
    	<hr class="border-primary">
	    <div class="float-left col-1 mt-2 pt-1"><strong>분석결과</strong></div>
	    <div class="float-left col-11">                                       
	        <ul>
	        	
	            <li>상권평가지수는 
	            <strong class="res-text"><fmt:formatNumber value="${rosList_dong.get(rosList_dong.size()-2).total }" pattern="0.0"/></strong>
	                        점에서 <strong class="res-text"><fmt:formatNumber value="${evaluation }" pattern="0.0"/></strong>
	                        점으로 전월 대비
	            <c:choose>
	            	<c:when test="${rosList_dong.get(rosList_dong.size()-1).growpt > 0}">
			            <strong class="res-text">
			            	<fmt:formatNumber value="${rosList_dong.get(rosList_dong.size()-1).growpt }" pattern="0.0"/> 
			            </strong>% <strong>상승</strong>하였습니다. 
	            	</c:when>
	            	<c:otherwise>
			            <strong class="res-text">
			            	<fmt:formatNumber value="${rosList_dong.get(rosList_dong.size()-1).growpt }" pattern="0.0"/> 
			            </strong>% <strong class="res-text">하락</strong>하였습니다. 
	            	</c:otherwise>
	            </c:choose> 
	            </li>
	            <li>분석지역은 
	            <strong class="res-text">
	            <c:choose>
	            	<c:when test="${growth > stability && growth > purchasePower && growth > visitPower }">
	            		성장성이 높고
	            	</c:when>
	            	<c:when test="${stability > growth && stability > purchasePower && stability > visitPower }">
	            		안정성이 높고
	            	</c:when>
	            	<c:when test="${purchasePower > stability && purchasePower > growth && purchasePower > visitPower }">
	            		구매력이 높고
	            	</c:when>
	            	<c:when test="${visitPower > stability && visitPower > purchasePower && visitPower > growth }">
	            		집객력이 높고
	            	</c:when>
	            	<c:otherwise>
	            		정렬실패
	            	</c:otherwise>
	            </c:choose>
	            </strong>, 상대적으로 
	            <strong class="res-text">
	            <c:choose>
	            	<c:when test="${growth < stability && growth < purchasePower && growth < visitPower }">
	            		성장성이 낮음
	            	</c:when>
	            	<c:when test="${stability < growth && stability < purchasePower && stability < visitPower }">
	            		안정성이 낮음
	            	</c:when>
	            	<c:when test="${purchasePower < stability && purchasePower < growth && purchasePower < visitPower }">
	            		구매력이 낮음
	            	</c:when>
	            	<c:when test="${visitPower < stability && visitPower < purchasePower && visitPower < growth }">
	            		집객력이 낮음
	            	</c:when>
	            	<c:otherwise>
	            		정렬실패
	            	</c:otherwise>
	            </c:choose>		
            	</strong> 으로 분석된다.</li>
	        </ul>
	    </div><!-- 분석결과list end -->
	    <hr class="border-primary">
    </div><!-- 분석결과 end -->
    
	<!-- 지역별 평가지수 추이 도움말 -->
    <div class="card">
        <div class="card-header">
            <h6 class="m-0 font-weight-bold text-primary">
	    		<i class="fas fa-info-circle"></i> 도움말
	    	</h6>
        </div><!-- /.help -->
	    <div class="card-body">
            <ul>
                <li>
                    <strong>상권평가등급</strong> : 상권 내 음식, 소매, 서비스업의 전반적인 업종경기와 상권의 인구 수, 교통시설, 집객시설 등을 종합하여 산출한 등급으로서,
                                        점수가 1등급에 가까울수록 상권이 활성화되어 있음을 의미(1~3등급)
                    <p class="clearfix"></p>
				</li>
				<li>
                    <strong>상권평가등급표</strong>
                    <table class="table table-bordered eTable">
                    <colgroup>
                        <col style="width:25%">
                        <col style="width:15%">
                        <col style="width:15%">
                        <col style="width:15%">
                        <col style="width:15%">
                        <col style="width:15%">
                    </colgroup>
                    <thead>
                        <tr class="bg-gray-200">
                            <th>기준</th>
                            <th>
	                         	<img class="dots" 
	                         		src="${pageContext.request.contextPath}/img/gold_coin.gif"> 
	                            1등급
                            </th>
                            <th>
	                         	<img class="dots" 
	                         		src="${pageContext.request.contextPath}/img/silver_coin.gif"> 
	                            2등급
                            </th>
                            <th>
	                         	<img class="dots" 
	                         		src="${pageContext.request.contextPath}/img/copper_coin.gif"> 
                            3등급
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>상권평가지수</strong></td>
                            <td>65.5점 이상</td>
                            <td>40~65.5</td>
                            <td>40미만</td>
                        </tr>
                    </tbody>
                    </table>
                    <p class="clearfix"></p>
                </li>
            </ul>
         </div>
    </div><!-- /.helpwrap -->
	
    <br>
    
    <h5 id="info2" class="text-info text-left font-weight-bold mt-5">2. 지역별 평가지수 추이</h5>
    
    <div class="my-3">
    	<!-- 평가지수 증감 추이 그래프를 넣을 박스 -->
    	<div class="col-12 p-2">
	    	<canvas id="flowEval" width="100%" height="300px"></canvas>
    	</div>
    	
    </div>
    
    <!-- 지역별 평가지수 테이블 조회 -->
    <table class="table table-bordered eTable">
        <thead style="font-size:small;">
            <tr class="bg-gray-200">
                <th rowspan="2">구분</th>
                <th rowspan="2">지역</th>
                <th>2018년 11월</th>
                <th colspan="2">2018년 12월</th>
                <th colspan="2">2019년 01월</th>
                <th colspan="2">2019년 02월</th>
                <th colspan="2">2019년 03월</th>
                <th colspan="2">2019년 04월</th>
            </tr>
            <tr class="bg-gray-200">
                <th>평가지수</th>
                <th>평가지수</th>
                <th>증감률</th>
                <th>평가지수</th>
                <th>증감률</th>
                <th>평가지수</th>
                <th>증감률</th>
                <th>평가지수</th>
                <th>증감률</th>
                <th>평가지수</th>
                <th>증감률</th>
            </tr>
        </thead>
        <tbody>
            
            <tr>
				<td><strong>행정동</strong></td>
				
                <td><strong>${rosList_dong.get(0).region_name }</strong></td>
                <c:forEach items="${rosList_dong }" var="dong" varStatus="status">
                	<c:choose>
                 		<c:when test="${status.count == 1 }">
                			<td class="text-right">
                				<fmt:formatNumber value="${dong.total }" pattern="0.0"/> 
                			</td>
                		</c:when> 
                 		<c:otherwise> 
                			<td class="text-right">
	                			<fmt:formatNumber value="${dong.total }" pattern="0.0"/> 
                			</td>
                			<td class="text-right">
                				<strong>
                				<c:choose>
                					<c:when test="${dong.growpt > 0 }">
			                			<fmt:formatNumber value="${dong.growpt }" pattern="0.0"/>% 
	                					<span class="up">▲</span>
                					</c:when>
                					<c:when test="${dong.growpt < 0 }">
			                			<fmt:formatNumber value="${dong.growpt }" pattern="0.0"/>% 
		                				<span class="down">▼</span>
                					</c:when>
                					<c:otherwise>
                						<fmt:formatNumber value="${dong.growpt }" pattern="0.0"/>% 
                					</c:otherwise>
                				</c:choose>
                				</strong>
                			</td>
                		</c:otherwise> 
                	</c:choose> 
                	
                </c:forEach> 
               
            </tr>
            <tr>

				<td><strong>시군구</strong></td>
				
                <td><strong>${rosList_gu.get(0).region_name }</strong></td>
                 <c:forEach items="${rosList_gu }" var="gu" varStatus="status">
                	<c:choose>
                		<c:when test="${status.count eq 1 }">
                			<td class="text-right">
        			        	<fmt:formatNumber value="${gu.total }" pattern="0.0"/> 
                			</td>
                		</c:when>
                		<c:otherwise>
                			<td class="text-right">
        			        	<fmt:formatNumber value="${gu.total }" pattern="0.0"/> 
                			</td>
                			<td class="text-right">
                				<strong>
                				<c:choose>
                					<c:when test="${gu.growpt > 0 }">
            							<fmt:formatNumber value="${gu.growpt }" pattern="0.0"/>% 
	                					<span class="up">▲</span>
                					</c:when>
                					<c:when test="${gu.growpt < 0 }">
            							<fmt:formatNumber value="${gu.growpt }" pattern="0.0"/>% 
		                				<span class="down">▼</span>
                					</c:when>
                					<c:otherwise>
            							<fmt:formatNumber value="${gu.growpt }" pattern="0.0"/>% 
                					</c:otherwise>
                				</c:choose>
                				</strong>
                			</td>
                		</c:otherwise>
                	</c:choose> 
                	
                </c:forEach>
            
            </tr>
            <tr>
				
				<td  class="sm-txt"><strong>광역시도</strong></td>
				
                <td class="sm-txt"><strong>${rosList_si.get(0).region_name }</strong></td>
                <c:forEach items="${rosList_si }" var="si" varStatus="status">
                	<c:choose>
                		<c:when test="${status.count eq 1 }">
                			<td class="text-right">
              			    	<fmt:formatNumber value="${si.total }" pattern="0.0"/> 
                			</td>
                		</c:when>
                		<c:otherwise>
                			<td class="text-right">
              			    	<fmt:formatNumber value="${si.total }" pattern="0.0"/> 
                			</td>
                			<td class="text-right">
                				<strong>
                				<c:choose>
                					<c:when test="${si.growpt > 0 }">
              					    	<fmt:formatNumber value="${si.growpt }" pattern="0.0"/>% 
	                					<span class="up">▲</span>
                					</c:when>
                					<c:when test="${si.growpt < 0 }">
              					    	<fmt:formatNumber value="${si.growpt }" pattern="0.0"/>% 
		                				<span class="down">▼</span>
                					</c:when>
                					<c:otherwise>
              					    	<fmt:formatNumber value="${si.growpt }" pattern="0.0"/>% 
                					</c:otherwise>
                				</c:choose>
                				</strong>
                			</td>
                		</c:otherwise>
                	</c:choose> 
                </c:forEach>
                
        	</tr>
        	
        </tbody>
    </table>
    
    <!-- 지역별 평가지수 분석결과 -->
    <div>
    	<hr class="border-primary mt-3">
        <div class="float-left col-1"><strong>분석결과</strong></div>
        <div class="float-left col-11">                                       
            <ul>
                <li>
                	<strong class="res-text">${rosList_dong.get(0).region_name }</strong>
                 	의 상권평가지수는 전월 대비 
                 	
                 	<strong class="res-text">
                 		<fmt:formatNumber value="${rosList_dong.get(rosList_dong.size()-1).growpt}" pattern="0.0"/>
                 	</strong>% 
                 	
                 	<strong class="res-text">
                    <c:choose>
                    	<c:when test="${rosList_dong.get(rosList_dong.size()-1).growpt > 0}">
                    		상승
                    	</c:when>
                    	<c:when test="${rosList_dong.get(rosList_dong.size()-1).growpt < 0}">
                    		하락
                    	</c:when>
                    	<c:otherwise>
                    		동률
                    	</c:otherwise>
                    </c:choose>
                    </strong>이며 
                    <strong class="res-text">
                   		<fmt:formatNumber value="${evaluation }" pattern="0.0"/>
                    </strong>점입니다.
                                        이는 상권의 
                    <strong class="res-text">
                    <c:choose>
                    	<c:when test="${rosList_dong.get(rosList_dong.size()-1).growpt > 0}">
                    		전반적인 경기가 높아지고 있음
                    	</c:when>
                    	<c:when test="${rosList_dong.get(rosList_dong.size()-1).growpt < 0}">
                    		전반적인 경기가 낮아지고 있음
                    	</c:when>
                    	<c:otherwise>
                    		전반적인 경기가 안정적임
                    	</c:otherwise>
                   	</c:choose>
                    </strong>을 의미합니다.
                </li>
            </ul>
        </div><!-- 분석결과list end -->
        <hr class="border-primary">
    </div><!-- 분석결과 end -->
	
	<br>  
    
    
    <!-- 3. 상세평가지수 조회 기능 -->
    <h5 id="info3" class="text-info text-left font-weight-bold mt-5">3. 상세평가지수 </h5>
    <h6 class="text-secondary mt-4">분석지역&nbsp;:&nbsp;${region_full_name }</h6>
    
    <!-- 상세평가지수에 대한 그래프 -->
    <div class="my-4">
    	<!-- 레이더 차트 및 곡선 그래프를 넣을 box -->
		<div class="col-4 d-inline-block m-2 border-gray">
			<div class="p-2">
				<canvas id="totalRadar" width="100%" height="100%"></canvas>    	
			</div>
		</div>
		<div  class="w-63 d-inline-block m-2 border-gray">
			<div class="p-2">
				<canvas id="flowLine" width="100%" height="50px"></canvas>		
			</div>
		</div>
		
    </div>
    
    <!-- 상세평가지수 조회 분석결과 -->
    <div>
    	<hr class="border-primary">
        <div class="float-left col-1 mt-2 pt-1"><strong>분석결과</strong></div>
        <div class="float-left col-11">
            <ul>
                <li>5개 평가지수 항목 중 
                <strong class="res-text">
                	<c:choose>
	            	<c:when test="${growth > stability && growth > purchasePower && growth > visitPower }">
	            		성장성
	            	</c:when>
	            	<c:when test="${stability > growth && stability > purchasePower && stability > visitPower }">
	            		안정성
	            	</c:when>
	            	<c:when test="${purchasePower > stability && purchasePower > growth && purchasePower > visitPower }">
	            		구매력
	            	</c:when>
	            	<c:when test="${visitPower > stability && visitPower > purchasePower && visitPower > growth }">
	            		집객력
	            	</c:when>
	            	<c:otherwise>
	            		정렬실패
	            	</c:otherwise>
	            </c:choose>
	           	이 높고
                </strong>, 상대적으로 
               	<strong class="res-text">
               	
					<c:choose>
					<c:when test="${growth < stability && growth < purchasePower && growth < visitPower }">
	            		성장성이 
	            	</c:when>
	            	<c:when test="${stability < growth && stability < purchasePower && stability < visitPower }">
	            		안정성이 
	            	</c:when>
	            	<c:when test="${purchasePower < stability && purchasePower < growth && purchasePower < visitPower }">
	            		구매력이 
	            	</c:when>
	            	<c:when test="${visitPower < stability && visitPower < purchasePower && visitPower < growth }">
	            		집객력이 
	            	</c:when>
	            	<c:otherwise>
	            		정렬실패
	            	</c:otherwise>
					</c:choose>
					낮은
               	</strong>것으로 분석됩니다.</li>
               	<li>
               	직전월 대비, 성장성 지수는&nbsp;
	           		<c:choose>
	           			<c:when test="${evalRateOfChange.GROWCHANGE > 0}">
	           				<strong class="res-text">
	           				<fmt:formatNumber value="${evalRateOfChange.GROWCHANGE }" pattern="0.0"/>
	           				</strong>
	           				%<strong class="res-text">상승</strong>
	           			</c:when>
	           			<c:when test="${evalRateOfChange.GROWCHANGE < 0}">
	           				<strong class="res-text">
	           				<fmt:formatNumber value="${evalRateOfChange.GROWCHANGE }" pattern="0.0"/>
	           				</strong>
	           				%<strong class="res-text">하락</strong>
	           			</c:when>
	           			<c:otherwise>
	           				<strong class="res-text">
	           				<fmt:formatNumber value="${evalRateOfChange.GROWCHANGE }" pattern="0.0"/>
	           				</strong>
	           				%<strong class="res-text">동일</strong>
	           			</c:otherwise>
	           		</c:choose>
				,안정성성 지수는&nbsp;
	           		<c:choose>
	           			<c:when test="${evalRateOfChange.STCHANGE > 0}">
	           				<strong class="res-text">
	           				<fmt:formatNumber value="${evalRateOfChange.STCHANGE }" pattern="0.0"/>
	           				</strong>
	           				%<strong class="res-text">상승</strong>
	           			</c:when>
	           			<c:when test="${evalRateOfChange.STCHANGE < 0}">
	           				<strong class="res-text">
	           				<fmt:formatNumber value="${evalRateOfChange.STCHANGE }" pattern="0.0"/>
	           				</strong>
	           				%<strong class="res-text">하락</strong>
	           			</c:when>
	           			<c:otherwise>
	           				<strong class="res-text">
	           				<fmt:formatNumber value="${evalRateOfChange.STCHANGE }" pattern="0.0"/>
	           				</strong>
	           				%<strong class="res-text">동일</strong>
	           			</c:otherwise>
	           		</c:choose>
				,구매력 지수는&nbsp;
	           		<c:choose>
	           			<c:when test="${evalRateOfChange.PPCHANGE > 0}">
	           				<strong class="res-text">
	           				<fmt:formatNumber value="${evalRateOfChange.PPCHANGE }" pattern="0.0"/>
	           				</strong>
	           				%<strong class="res-text">상승</strong>
	           			</c:when>
	           			<c:when test="${evalRateOfChange.PPCHANGE < 0}">
	           				<strong class="res-text">
	           				<fmt:formatNumber value="${evalRateOfChange.PPCHANGE }" pattern="0.0"/>
	           				</strong>
	           				%<strong class="res-text">하락</strong>
	           			</c:when>
	           			<c:otherwise>
	           				<strong class="res-text">
	           				<fmt:formatNumber value="${evalRateOfChange.PPCHANGE }" pattern="0.0"/>
	           				</strong>
	           				%<strong class="res-text">동일</strong>
	           			</c:otherwise>
	           		</c:choose>
				,집객력 지수는&nbsp;
	           		<c:choose>
	           			<c:when test="${evalRateOfChange.VISITCHANGE > 0}">
	           				<strong class="res-text">
	           				<fmt:formatNumber value="${evalRateOfChange.VISITCHANGE }" pattern="0.0"/>
	           				</strong>
	           				%<strong class="res-text">상승</strong>
	           			</c:when>
	           			<c:when test="${evalRateOfChange.VISITCHANGE < 0}">
	           				<strong class="res-text">
	           				<fmt:formatNumber value="${evalRateOfChange.VISITCHANGE }" pattern="0.0"/>
	           				</strong>
	           				%<strong class="res-text">하락</strong>
	           			</c:when>
	           			<c:otherwise>
	           				<strong class="res-text">
	           				<fmt:formatNumber value="${evalRateOfChange.VISITCHANGE }" pattern="0.0"/>
	           				</strong>
	           				%<strong class="res-text">동일</strong>
	           			</c:otherwise>
	           		</c:choose>
               	</li>
           </ul>
        </div><!-- 분석결과 list end -->
        
        <hr class="border-primary">
    </div><!-- 분석결과 end -->

	<!-- 상세평가지수 조회 테이블 -->
    <table class="table table-bordered evalTable">
        <colgroup>
            <col style="width:7%">
            <col style="width:7%">
            <col style="width:35%">
            <col style="width:12%">
            <col style="width:7%">
            <col>
        </colgroup>
        <tbody>
            <tr class="bg-gray-200">
                <th colspan="2">구분</th>
                <th colspan="4">내용</th>
            </tr>
            <tr>
                <th rowspan="3"><strong>성장성</strong><br><small>(25점)</small></th>
                <td rowspan="3">
                <strong>
                <fmt:formatNumber value="${growth}" pattern="0.0"/>
                </strong>점
                </td>
                <td rowspan="3">
					<!-- polar차트 넣기 -->
                	<canvas id="growthChart" width="100%" height="100%"></canvas>
                
                </td>
                <th>매출증감률<br><small class="nmal">(20점)</small></th>
                <td>
                <strong class="largenum">
                	<fmt:formatNumber value="${evalInfo.evaluation_sales_growth }" pattern="0.0"/>
                </strong>점
                </td>
                <td class="text-left">
                    - 전월대비 전체매출규모 증감률 <small class="nmal">(20점)</small><br>
                </td>
            </tr>
            <tr>
                <th>상권 매출비중<br><small class="nmal">(5점)</small></th>
                <td>
                <strong class="largenum">
                	<fmt:formatNumber value="${evalInfo.evaluation_important }" pattern="0.0"/>
                </strong>점
                </td>
                <td class="text-left">전월 대비 대전시 내 선택지역 매출비중 증감률</td>
            </tr>
            <tr>
                <td colspan="3" class="text-left">     
               		성장성 지수 산출항목 중 
               		<strong>
               		<c:choose>
						<c:when test="${evalInfo.evaluation_sales_growth >= evalInfo.evaluation_important }">매출증감률</c:when>
						<c:otherwise>상권 매출비중</c:otherwise>
               		</c:choose> 
               		</strong>
               		의 비중이 상대적으로 높습니다.
                </td>
            </tr>
            
            <tr>
                <th rowspan="3"><strong class="largenum">안정성</strong><br><small class="nmal">(25점)</small></th>
                <td rowspan="3">
                <strong class="largenum blue">
                <fmt:formatNumber value="${stability}" pattern="0.0"/>
                </strong>점
                </td>
                <td rowspan="3">
					<!-- polar차트 넣기 -->
                	<canvas id="stabilityChart" width="100%" height="100%"></canvas>
                
                </td>
                <th>변동성<br><small class="nmal">(15점)</small></th>
                <td>
                <strong class="largenum">
                <fmt:formatNumber value="${evalInfo.evaluation_variability }" pattern="0.0"/> 
                </strong>점</td>
                <td class="text-left">
                    - 최근월 포함 1년 분기별 점포수변동률 평균&nbsp;<small class="nmal">(7.5점)</small><br>
                    - 최근월 포함 반년 월별 매출변동률 평균&nbsp;<small class="nmal">(7.5점)</small>
                </td>
            </tr>
            <tr>
                <th>휴/폐업률<br><small class="nmal">(10점)</small></th>
                <td>
                <strong class="largenum">
                <fmt:formatNumber value="${evalInfo.evaluation_closure } " pattern="0.0"/> 
                </strong>점
                </td>
                <td class="text-left">최근 1년간 휴/폐업 점포 비율</td>
            </tr>
            <tr>
                <td colspan="3" class="text-left">   
                   	안정성 지수 산출항목 중 
                   	<strong> 
                   	<c:choose>
                   		<c:when test="${evalInfo.evaluation_closure > evalInfo.evaluation_variability }">
                   			휴/폐업률
                   		</c:when>
                   		<c:otherwise>
                   			변동성
                   		</c:otherwise>
                   	</c:choose>
                   	</strong>의 비중이 상대적으로 높습니다.
                </td>
            </tr>

            <tr>
                <th rowspan="4"><strong class="largenum">구매력</strong><br><small class="nmal">(25점)</small></th>
                <td rowspan="4">
                <strong class="largenum blue">
                	<fmt:formatNumber value="${purchasePower}" 
                						pattern="0.0"/>
                </strong>점
                </td>
                <td rowspan="4">
					<!-- polar차트 넣기 -->
                	<canvas id="ppChart" width="100%" height="100%"></canvas>
					
                </td>
                <th>상권 매출규모<br><small class="nmal">(10점)</small></th>
                <td>
                <strong class="largenum">
                	<fmt:formatNumber value="${evalInfo.evaluation_sales_scale }" pattern="0.0"/>
                </strong>점
                </td>
                <td class="text-left">선택지역 면적당 매출액</td>
            </tr>
            <tr>
                <th>건당 결제금액<br><small class="nmal">(10점)</small></th>
                <td>
                <strong class="largenum">
                	<fmt:formatNumber value="${evalInfo.evaluation_payment }" pattern="0.0"/>
                </strong>
                                점</td>
                <td class="text-left">선택지역의 평균 건당 결제금액</td>
            </tr>
            <tr>
                <th>소비 수준<br><small class="nmal">(5점)</small></th>
                <td>
                <strong class="largenum">
                	<fmt:formatNumber value="${evalInfo.evaluation_consumptionlevel }"/>
                </strong>점
                </td>
                <td class="text-left">주거인구, 직장인구 월평균소비규모</td>
            </tr>
            <tr>
                <td colspan="3" class="text-left">
					구매력 지수 산출항목 중 
					<strong>
						<c:choose>
							<c:when test="${evalInfo.evaluation_sales_scale > evalInfo.evaluation_payment && evalInfo.evaluation_sales_scale > evalInfo.evaluation_consumptionlevel}">
								상권 매출규모
							</c:when>
							<c:when test="${evalInfo.evaluation_payment > evalInfo.evaluation_sales_scale && evalInfo.evaluation_payment > evalInfo.evaluation_consumptionlevel}">
								건당 결제금액
							</c:when>
							<c:when test="${evalInfo.evaluation_consumptionlevel > evalInfo.evaluation_sales_scale && evalInfo.evaluation_consumptionlevel > evalInfo.evaluation_payment}">
								소비 수준
							</c:when>
							<c:otherwise>
								정렬 실패
							</c:otherwise>
						</c:choose> 
					</strong>
					의 비중이 상대적으로 높습니다.
                </td>
            </tr>

            <tr>
                <th rowspan="4"><strong class="largenum">집객력</strong><br><small class="nmal">(25점)</small></th>
                <td rowspan="4">
                <strong class="largenum blue">
                	<fmt:formatNumber value="${visitPower}" pattern="0.0"/>
                </strong>점
                </td>
                <td rowspan="4">
					<!-- polar차트 넣기 -->
					<canvas id="vpChart" width="100%" height="100%"></canvas>
					
                </td>
                <th>유동인구<br><small class="nmal">(10점)</small></th>
                <td>
                <strong class="largenum">
                	<fmt:formatNumber value="${evalInfo.evaluation_pp }" pattern="0.0"/>
                </strong>점
                </td>
                <td class="text-left">선택지역 내 면적당 유동인구 수</td>
            </tr>
            <tr>
                <th>주거인구<br><small class="nmal">(7.5점)</small></th>
                <td>
                <strong class="largenum">
					<fmt:formatNumber value="${evalInfo.evaluation_lp }" pattern="0.0"/>
                </strong>점
                </td>
                <td class="text-left">선택지역 내 면적당 주거인구 수</td>
            </tr>
            <tr>
                <th>직장인구<br><small class="nmal">(7.5점)</small></th>
                <td>
                <strong class="largenum">
					<fmt:formatNumber value="${evalInfo.evaluation_wp }" pattern="0.0"/>
                </strong>점
                </td>
                <td class="text-left">선택지역 내 면적당 직장인구 수</td>
            </tr>
            <tr>
                <td colspan="3" class="text-left">   
					집객력 지수 산출항목 중 
					<strong>
						<c:choose>
							<c:when test="${evalInfo.evaluation_pp > evalInfo.evaluation_lp && evalInfo.evaluation_pp > evalInfo.evaluation_wp }">
								유동인구
							</c:when>
							<c:when test="${evalInfo.evaluation_lp > evalInfo.evaluation_pp && evalInfo.evaluation_lp > evalInfo.evaluation_wp }">
								주거인구
							</c:when>
							<c:when test="${evalInfo.evaluation_wp > evalInfo.evaluation_pp && evalInfo.evaluation_wp > evalInfo.evaluation_lp }">
								직장인구
							</c:when>
							<c:otherwise>
								정렬실패
							</c:otherwise>
						</c:choose>
					</strong>
					의 비중이 상대적으로 높습니다.
                </td>
            </tr>
            <tr>
                <th>합계</th>
                <td>
                <strong class="largenum blue">
                	<fmt:formatNumber value="${evaluation }" pattern="0.0"/>
                </strong>점
                </td>
                <td colspan="4"></td>
            </tr>
        </tbody>
    </table>
    <p class="clearfix"><br></p>
    <p class="clearfix"><br></p>   

                                                          
</div><!-- /.container end.. -->

		</div> <!-- 상권평가 보고서 결과 div 박스 end... -->

<!-- ========================== 업종분석 보고서의 contents 영역 ========================== -->		
				<div id="analysisResultupjong" class="menuTab d-none">
				
<div id="resultUpjong">
	
	<h5 id="tob1" class="text-info text-left font-weight-bold mt-5">1.업종별 추이</h5>
    <h6 class="text-secondary mt-4">분석지역&nbsp;:&nbsp;${region_full_name }</h6>
	
	<div class="col-12 p-2 my-3" style="height:300px;">
			<!-- 업종별 추이의 그래프 넣기 -->
			<canvas id="flowUpjong" width="100%"></canvas>
	</div>
	
	<table class="table table-bordered eTable">
	    <thead>
	        <tr class="bg-gray-200">
	            <th rowspan="2">구분</th>
	            <th rowspan="2">업종</th>
	            <th>2018년03월</th>
	            <th colspan="2">2018년06월</th>
	            <th colspan="2">2018년09월</th>
	            <th colspan="2">2018년12월</th>
	            <th colspan="2">2019년03월</th>
	        </tr>
	        <tr class="bg-gray-200">
	            <th>업소수</th>
	            <th>업소수</th>
	            <th>증감률</th>
	            <th>업소수</th>
	            <th>증감률</th>
	            <th>업소수</th>
	            <th>증감률</th>
	            <th>업소수</th>
	            <th>증감률</th>
	        </tr>
	    </thead>
	    <tbody>
	    	<!-- temp1 -->
	    	<!-- 
       			!!!예외 처리!!!
       			분석 보고서 페이지 조회 시 사용자가 선택한 업종이 상권 내에 없을때
       			예외 처리를 함
       		-->
	        <c:if test="${botCntRos.size() > 0 }">
	        <tr>
	        	<td rowspan="1"><strong>소분류</strong></td>
	            <td class="bgpoint3"><strong>${tobNames.BOT}</strong></td>
				 <c:forEach items="${botCntRos }" var="botVo" varStatus="status">
	            	<c:choose>
	            		<c:when test="${status.count eq 1}">
	            			<td class="text-right">
	            			<fmt:formatNumber value="${botVo.cnt }" pattern="#,###"/>
	            			</td>
	            		</c:when>
	            		<c:otherwise>
	            			<td class="text-right">
	            			<fmt:formatNumber value="${botVo.cnt }" pattern="#,###"/>
	            			</td>
	            			<td class="text-right">
	            			<strong>${botVo.ros }%
	            			<c:choose>
	            				<c:when test="${botVo.ros > 0 }">
									<span class="up">▲</span>	
	            				</c:when>
	            				<c:when test="${botVo.ros < 0 }">
									<span class="down">▼</span>	            				
	            				</c:when>
	            			</c:choose>
	            			</strong>
	            			</td>
	            		</c:otherwise>
	            	</c:choose>
	            </c:forEach>
	        </tr>
	        </c:if>
	        
	        <!-- 
       			!!!예외 처리!!!
       			분석 보고서 페이지 조회 시 사용자가 선택한 업종이 상권 내에 없을때
       			예외 처리를 함
       		-->
	        <c:if test="${midCntRos.size() > 0 }">
	        <tr>
	        	<td rowspan="1"><strong>중분류</strong></td>
	        	
	            <td class="bgpoint3"><strong>${tobNames.MID }</strong></td>
	            <c:forEach items="${midCntRos }" var="midVo" varStatus="status">
	            	<c:choose>
	            		<c:when test="${status.count eq 1}">
	            			<td class="text-right">
	            			<fmt:formatNumber value="${midVo.cnt }" pattern="#,###"/>
	            			</td>
	            		</c:when>
	            		<c:otherwise>
	            			<td class="text-right">
	            			<fmt:formatNumber value="${midVo.cnt }" pattern="#,###"/>
	            			</td>
	            			<td class="text-right">
	            			<strong>${midVo.ros }%
	            			<c:choose>
	            				<c:when test="${midVo.ros > 0 }">
									<span class="up">▲</span>	
	            				</c:when>
	            				<c:when test="${midVo.ros < 0 }">
									<span class="down">▼</span>	            				
	            				</c:when>
	            			</c:choose>
	            			</strong>
	            			</td>
	            		</c:otherwise>
	            	</c:choose>
	            </c:forEach>
	        </tr>
	        </c:if>
	        
	         <!-- 
       			!!!예외 처리!!!
       			분석 보고서 페이지 조회 시 사용자가 선택한 업종이 상권 내에 없을때
       			예외 처리를 함
       		-->
	        <c:if test="${topCntRos.size() > 0 }">
	        <tr>
	        	<td rowspan="1"><strong>대분류</strong></td>
	            <td class="bgpoint3"><strong>${tobNames.TOP }</strong></td>
	            <c:forEach items="${topCntRos }" var="topVo" varStatus="status">
	            	<c:choose>
	            		<c:when test="${status.count eq 1}">
	            			<td class="text-right">
	            			<fmt:formatNumber value="${topVo.cnt }" pattern="#,###"/>
	            			</td>
	            		</c:when>
	            		<c:otherwise>
	            			<td class="text-right">
	            			<fmt:formatNumber value="${topVo.cnt }" pattern="#,###"/>
	            			</td>
	            			<td class="text-right">
	            			<strong>${topVo.ros }%
	            			<c:choose>
	            				<c:when test="${topVo.ros > 0 }">
									<span class="up">▲</span>	
	            				</c:when>
	            				<c:when test="${topVo.ros < 0 }">
									<span class="down">▼</span>	            				
	            				</c:when>
	            			</c:choose>
	            			</strong>
	            			</td>
	            		</c:otherwise>
	            	</c:choose>
	            </c:forEach>
	        </tr>
	        </c:if>
	        
	    </tbody>
	</table>
	
	<!-- 분석결과 -->
	<div>
    	<hr class="border-primary mt-3">

        <div class="float-left col-1 mt-4"><strong>분석결과</strong></div>
        <div class="float-left col-11">                                       
            <ul>
         		<!-- temp1 -->
         		<!-- 
         			!!!예외 처리!!!
         			분석 보고서 페이지 조회 시 사용자가 선택한 업종이 상권 내에 없을때
         			예외 처리를 함
         		-->
				<c:if test="${botCntRos.size() > 0 }">            	
               
                <li>
                <strong class="res-text">${region_full_name }</strong>에서 <strong>${tobNames.BOT }</strong>
                                업종의 업소추이는 전월 대비 <strong>${botCntRos.get(botCntRos.size()-1).ros }</strong>%
              	<strong class="res-text">
                <c:choose>
                	<c:when test="${botCntRos.get(botCntRos.size()-1).ros > 0 }">증가</c:when>
                	<c:when test="${botCntRos.get(botCntRos.size()-1).ros < 0 }">감소</c:when>
                	<c:otherwise>동일</c:otherwise>
                </c:choose>
               	</strong>
				</li>               	
				
            	</c:if>
            	
            	<!-- 
         			!!!예외 처리!!!
         			분석 보고서 페이지 조회 시 사용자가 선택한 업종이 상권 내에 없을때
         			예외 처리를 함
         		-->
				<c:if test="${midCntRos.size() > 0 }">            	
            	<li>
	               	중분류인 <strong class="res-text">${tobNames.MID }</strong>업종은 
	               	<strong class="res-text">${midCntRos.get(midCntRos.size()-1).ros }</strong>%
	              	<strong class="res-text">
	                <c:choose>
	                	<c:when test="${midCntRos.get(midCntRos.size()-1).ros > 0 }">증가</c:when>
	                	<c:when test="${midCntRos.get(midCntRos.size()-1).ros < 0 }">감소</c:when>
	                	<c:otherwise>동일</c:otherwise>
	                </c:choose>
	               	</strong>
	            </li>
	            </c:if>

				<!-- 
         			!!!예외 처리!!!
         			분석 보고서 페이지 조회 시 사용자가 선택한 업종이 상권 내에 없을때
         			예외 처리를 함
         		-->
				<c:if test="${topCntRos.size() > 0 }">     
	            <li>
	               	대분류인 <strong class="res-text">${tobNames.TOP }</strong>업종은 
	               	<strong class="res-text">${topCntRos.get(topCntRos.size()-1).ros }</strong>%
	               	<strong class="res-text">
	                <c:choose>
	                	<c:when test="${topCntRos.get(topCntRos.size()-1).ros > 0 }">증가</c:when>
	                	<c:when test="${topCntRos.get(topCntRos.size()-1).ros < 0 }">감소</c:when>
	                	<c:otherwise>동일</c:otherwise>
	                </c:choose>
	               	</strong>
                </li>
                </c:if>
                
            </ul>
        </div><!-- 분석결과list end -->

        <hr class="border-primary">
    </div><!-- 분석결과 end -->
	
	<!-- 업종별 추이 도움말 -->
	<div class="card">
        <div class="card-header">
            <h6 class="m-0 font-weight-bold text-primary">
	    		<i class="fas fa-info-circle"></i> 도움말
	    	</h6>
        </div><!-- /.help -->
	    
	    <div class="card-body">
            <ul>
                <li>
				업소수 추이는 업종에 대한 시장의 선호도를 반영하는 만큼 창업의사결정이나 점포 운영기간 결정 시 참조할 수 있습니다.
				</li>
				<li>
				또한 업종에 따라 집중으로 인한 밀집효과가 있을 수 있으므로, 동일 업종이 많다고 해서 반드시 창업여건이 나쁜 지역은 아닙니다. 
				(예, 감자탕골목, 순대골목, 전문상가 등은 긍정적인 밀집효과, 편의점, 소매점 등은 부정적인 밀집효과)
				</li>
            </ul>
        </div>
    </div><!-- 도움말 end -->
	
	<h5 id="tob2" class="text-info text-left font-weight-bold mt-5">2.지역별 추이</h5>
    <h6 class="text-secondary mt-4">분석업종&nbsp;:&nbsp; ${tobNames.BOT }</h6>
	
	<div class="col-12 my-4 p-2" style="height:300px;">
		<!-- 분석업종의 지역별 추이 그래프 넣기 -->
		<canvas id="RegionalTrends"></canvas>
	</div>
		
	<!-- 지역별 추이 분석 테이블 -->
	<table class="table table-bordered eTable">
	    <thead>
	    	<tr class="bg-gray-200">
	    		<th>업종</th>
	    		<th rowspan="2" colspan="2">2018년03월</th>
	    		<th rowspan="2" colspan="2">2018년06월</th>
	            <th rowspan="2" colspan="2">2018년09월</th>
	            <th rowspan="2" colspan="2">2018년12월</th>
	            <th rowspan="2" colspan="2">2019년03월</th>
	    	</tr>
	        <tr class="bg-gray-200">
	            <th>${tobNames.BOT }</th>
	        </tr>
	        <tr class="bg-gray-200">
	        	<th>지역</th>
	            <th colspan="2">업소수</th>
	            <th>업소수</th>
	            <th>증감률</th>
	            <th>업소수</th>
	            <th>증감률</th>
	            <th>업소수</th>
	            <th>증감률</th>
	            <th>업소수</th>
	            <th>증감률</th>
	        </tr>
	    </thead>
	    <tbody>
	    	<!-- temp2 -->
	    	<!-- 
       			!!!예외 처리!!!
       			분석 보고서 페이지 조회 시 사용자가 선택한 업종이 상권 내에 없을때
       			예외 처리를 함
       		-->
	    	<c:if test="${tobCntList_Dong.size() > 0}">
	        
	        <tr>
	            <td><strong>${regNames.DONG }</strong></td>
	            <c:forEach items="${tobCntList_Dong }" var="dongVo" varStatus="status">
		           	<c:choose>
		           		<c:when test="${status.count eq 1 }">
		           			<td class="text-right" colspan="2">
		           			<fmt:formatNumber value="${dongVo.cnt }" pattern="#,###"/>
		           			</td>
		           		</c:when>
		           		<c:otherwise>
		           			<td class="text-right">
		           			<fmt:formatNumber value="${dongVo.cnt }" pattern="#,###"/>
		           			</td>
		           			<td class="text-right">
		           			<strong>
		           			${dongVo.ros }%
							<c:choose>
								<c:when test="${dongVo.ros > 0 }">
									<span class="up">▲</span>
								</c:when>
								<c:when test="${dongVo.ros < 0 }">
									<span class="down">▼</span>
								</c:when>
							</c:choose>	            			
		           			</strong>
		           			</td>
		           		</c:otherwise>
		           	</c:choose>
		         </c:forEach>
	        </tr>
	        
	        </c:if>
	        
	        <!-- 
       			!!!예외 처리!!!
       			분석 보고서 페이지 조회 시 사용자가 선택한 업종이 상권 내에 없을때
       			예외 처리를 함
       		-->
       		<c:if test="${tobCntList_Gu.size() > 0}">
	        <tr>
	            <td><strong>${regNames.GU }</strong></td>
	            <c:forEach items="${tobCntList_Gu }" var="guVo" varStatus="status">
		           	<c:choose>
		           		<c:when test="${status.count eq 1 }">
		           			<td class="text-right" colspan="2">
		           			<fmt:formatNumber value="${guVo.cnt }" pattern="#,###"/>
		           			</td>
		           		</c:when>
		           		<c:otherwise>
		           			<td class="text-right">
		           			<fmt:formatNumber value="${guVo.cnt }" pattern="#,###"/>
		           			</td>
		           			<td class="text-right">
		           			<strong>
		           			${guVo.ros }%
							<c:choose>
								<c:when test="${guVo.ros > 0 }">
									<span class="up">▲</span>
								</c:when>
								<c:when test="${guVo.ros < 0 }">
									<span class="down">▼</span>
								</c:when>
							</c:choose>	            			
		           			</strong>
		           			</td>
		           		</c:otherwise>
		           	</c:choose>
		         </c:forEach>
	        </tr>
	        </c:if>
	        
	         <!-- 
       			!!!예외 처리!!!
       			분석 보고서 페이지 조회 시 사용자가 선택한 업종이 상권 내에 없을때
       			예외 처리를 함
       		-->
       		<c:if test="${tobCntList_Si.size() > 0}">
	        <tr>
	            <td><strong>${regNames.SI }</strong></td>
	            <c:forEach items="${tobCntList_Si }" var="siVo" varStatus="status">
		           	<c:choose>
		           		<c:when test="${status.count eq 1 }">
		           			<td class="text-right" colspan="2">
		           			<fmt:formatNumber value="${siVo.cnt }" pattern="#,###"/>
		           			</td>
		           		</c:when>
		           		<c:otherwise>
		           			<td class="text-right">
		           			<fmt:formatNumber value="${siVo.cnt }" pattern="#,###"/>
		           			</td>
		           			<td class="text-right">
		           			<strong>
		           			${siVo.ros }%
							<c:choose>
								<c:when test="${siVo.ros > 0 }">
									<span class="up">▲</span>
								</c:when>
								<c:when test="${siVo.ros < 0 }">
									<span class="down">▼</span>
								</c:when>
							</c:choose>	            			
		           			</strong>
		           			</td>
		           		</c:otherwise>
		           	</c:choose>
		         </c:forEach>
	        </tr>
	        </c:if>
	        
	    </tbody>
	</table>
	
	<!-- 분석결과 -->
	<div>
    	<hr class="border-primary mt-3">

        <div class="float-left col-1 mt-4"><strong>분석결과</strong></div>
        <div class="float-left col-11">                                       
            <ul>
            	<!-- temp2 -->
            	<!-- 
         			!!!예외 처리!!!
         			분석 보고서 페이지 조회 시 사용자가 선택한 업종이 상권 내에 없을때
         			예외 처리를 함
         		-->
                <c:if test="${tobCntList_Dong.size() > 0 }">
	                <li>
						<strong class="res-text">${regNames.DONG }</strong>의 업소수는 
						<strong class="res-text">
						${tobCntList_Dong.get(tobCntList_Dong.size()-1).cnt }
						</strong>
						건으로 전월 대비
						<strong class="res-text">
						${tobCntList_Dong.get(tobCntList_Dong.size()-1).ros }%	
						<c:choose>
							<c:when test="${tobCntList_Dong.get(tobCntList_Dong.size()-1).ros > 0 }">
								증가
							</c:when>
							<c:when test="${tobCntList_Dong.get(tobCntList_Dong.size()-1).ros < 0 }">
								감소
							</c:when>
							<c:otherwise>
								동일
							</c:otherwise>
						</c:choose>
						</strong>
	                </li>
				</c:if>
                
                <!-- 
         			!!!예외 처리!!!
         			분석 보고서 페이지 조회 시 사용자가 선택한 업종이 상권 내에 없을때
         			예외 처리를 함
         		-->
                <c:if test="${tobCntList_Gu.size() > 0 }">
	                <li>
		                <strong class="res-text">${regNames.GU }</strong>의 업소수는 
						<strong class="res-text">
						${tobCntList_Gu.get(tobCntList_Gu.size()-1).cnt }
						</strong>
						건으로 전월 대비
						<strong class="res-text">
						${tobCntList_Gu.get(tobCntList_Gu.size()-1).ros }%	
						<c:choose>
							<c:when test="${tobCntList_Gu.get(tobCntList_Gu.size()-1).ros > 0 }">
								증가
							</c:when>
							<c:when test="${tobCntList_Gu.get(tobCntList_Gu.size()-1).ros < 0 }">
								감소
							</c:when>
							<c:otherwise>
								동일
							</c:otherwise>
						</c:choose>
						</strong>
	                </li>
                </c:if>
                
                <!-- 
         			!!!예외 처리!!!
         			분석 보고서 페이지 조회 시 사용자가 선택한 업종이 상권 내에 없을때
         			예외 처리를 함
         		-->
                <c:if test="${tobCntList_Si.size() > 0 }">
	                <li>
		                <strong class="res-text">${regNames.SI }</strong>의 업소수는 
						<strong class="res-text">
						${tobCntList_Si.get(tobCntList_Si.size()-1).cnt }
						</strong>
						건으로 전월 대비
						<strong class="res-text">
						${tobCntList_Si.get(tobCntList_Si.size()-1).ros }%	
						<c:choose>
							<c:when test="${tobCntList_Si.get(tobCntList_Si.size()-1).ros > 0 }">
								증가
							</c:when>
							<c:when test="${tobCntList_Si.get(tobCntList_Si.size()-1).ros < 0 }">
								감소
							</c:when>
							<c:otherwise>
								동일
							</c:otherwise>
						</c:choose>
						</strong>
	                </li>
                </c:if>
            </ul>
        </div><!-- 분석결과list end -->

        <hr class="border-primary">
    </div><!-- 분석결과 end -->
	
	<!-- 지역별 추이 도움말 -->
	<div class="card">
        <div class="card-header">
            <h6 class="m-0 font-weight-bold text-primary">
	    		<i class="fas fa-info-circle"></i> 도움말
	    	</h6>
        </div><!-- /.help -->
	    
	    <div class="card-body">
            <ul>
                <li>
			광역지역의 업소수 추이는 업종에 대한 시장의 선호도를 반영하는 만큼 창업의사결정이나 점포 운영기간 결정 시 참조할 수 있습니다.
				</li>
            </ul>
        </div>
    </div><!-- 도움말 end -->
	
	<!-- 3. 업종 생애주기  -->
	<h5 id="tob3" class="text-info text-left font-weight-bold mt-5">3.업종 생애주기</h5>
    <h6 class="text-secondary mt-4">분석업종&nbsp;:&nbsp; ${tobNames.BOT }</h6>
	
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
                		<c:when test="${tobLC_Cnt.CHANGERATE > 0.0 && tobLC_Sale.CHANGERATE > 0.0}">
 							${tobNames.BOT }              		
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
                		<c:when test="${tobLC_Cnt.CHANGERATE <= 0.0 && tobLC_Sale.CHANGERATE > 0.0}">
 							${tobNames.BOT }              		
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
                		<c:when test="${tobLC_Cnt.CHANGERATE < 0.0 && tobLC_Sale.CHANGERATE < 0.0}">
 							${tobNames.BOT }              		
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
                		<c:when test="${tobLC_Cnt.CHANGERATE >= 0.0 && tobLC_Sale.CHANGERATE <= 0.0}">
 							${tobNames.BOT }              		
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
    <h6 class="text-secondary mt-4">분석지역&nbsp;:&nbsp;${tobNames.BOT }</h6>
	
	<div class="col-12 mt-4 p-2" style="height:300px;">
		<!-- 업종별 매출추이의 그래프 넣기 -->
		<canvas id="tobSacRos" width="100%"></canvas>
	</div>
	
	<h5>
	<span class="text-gray-700 eText font-weight-bold right-box my-3">                                 
        (단위 : 만원, 건) 
    </span>
    </h5>
    
	<table class="table table-bordered eTable">
	    <thead>
	        <tr class="bg-gray-200">
	            <th rowspan="2">구분</th>
	            <th rowspan="2" colspan="2">업종</th>
	            <th>2018년11월</th>
	            <th colspan="2">2018년12월</th>
	            <th colspan="2">2019년01월</th>
	            <th colspan="2">2019년02월</th>
	            <th colspan="2">2019년03월</th>
	            <th colspan="2">2019년04월</th>
	        </tr>
	        <tr class="bg-gray-200">
	            <th>액/건</th>
	            <th>액/건</th>
	            <th>증감률</th>
	            <th>액/건</th>
	            <th>증감률</th>
	            <th>액/건</th>
	            <th>증감률</th>
	            <th>액/건</th>
	            <th>증감률</th>
	            <th>액/건</th>
	            <th>증감률</th>
	        </tr>
	    </thead>
	    <tbody>
	    	<!-- temp3 -->
	    	<!-- 
       			!!!예외 처리!!!
       			분석 보고서 페이지 조회 시 사용자가 선택한 업종이 상권 내에 없을때
       			예외 처리를 함
       		-->
	    	<c:if test="${tobSac_Bot.size() > 0 }">
	      
	        <tr>
	            <td rowspan="2"><strong>선택업종</strong></td>
	            <td rowspan="2"><strong>${tobNames.BOT }</strong></td>
	            <td><strong>매출액</strong></td>
	            <c:forEach items="${tobSac_Bot }" var="botVo" varStatus="status">
		           	<c:choose>
		           		<c:when test="${status.count eq 1 }">
		           			<td class="text-right">
		           			<fmt:formatNumber value="${botVo.curSale }" pattern="#,###"/>
		           			</td>
		           		</c:when>
		           		<c:otherwise>
		           			<td class="text-right">
		           			<fmt:formatNumber value="${botVo.curSale }" pattern="#,###"/>
		           			</td>
		           			<td class="text-right">
		           			<strong>
		           			${botVo.saleRos }%
							<c:choose>
								<c:when test="${botVo.saleRos > 0 }">
									<span class="up">▲</span>
								</c:when>
								<c:when test="${botVo.saleRos < 0 }">
									<span class="down">▼</span>
								</c:when>
							</c:choose>	            			
		           			</strong>
		           			</td>
		           		</c:otherwise>
		           	</c:choose>
		         </c:forEach>
	        </tr>
	        <tr>
	            <td><strong>건수</strong></td>
	           <c:forEach items="${tobSac_Bot }" var="botVo" varStatus="status">
		           	<c:choose>
		           		<c:when test="${status.count eq 1 }">
		           			<td class="text-right">
		           			<fmt:formatNumber value="${botVo.curCnt }" pattern="#,###"/>
		           			</td>
		           		</c:when>
		           		<c:otherwise>
		           			<td class="text-right">
		           			<fmt:formatNumber value="${botVo.curCnt }" pattern="#,###"/>
		           			</td>
		           			<td class="text-right">
		           			<strong>
		           			${botVo.cntRos }%
							<c:choose>
								<c:when test="${botVo.cntRos > 0 }">
									<span class="up">▲</span>
								</c:when>
								<c:when test="${botVo.cntRos < 0 }">
									<span class="down">▼</span>
								</c:when>
							</c:choose>	            			
		           			</strong>
		           			</td>
		           		</c:otherwise>
		           	</c:choose>
		         </c:forEach>
	        </tr>  
	           
	        </c:if>
	        
	        <tr>
	            <td rowspan="2"><strong>중분류</strong></td>
	            
	            <td rowspan="2"><strong>${tobNames.MID }</strong></td>
	            <td><strong>매출액</strong></td>
	           <c:forEach items="${tobSac_Mid }" var="midVo" varStatus="status">
		           	<c:choose>
		           		<c:when test="${status.count eq 1 }">
		           			<td class="text-right">
		           			<fmt:formatNumber value="${midVo.curSale }" pattern="#,###"/>
		           			</td>
		           		</c:when>
		           		<c:otherwise>
		           			<td class="text-right">
		           			<fmt:formatNumber value="${midVo.curSale }" pattern="#,###"/>
		           			</td>
		           			<td class="text-right">
		           			<strong>
		           			${midVo.saleRos }%
							<c:choose>
								<c:when test="${midVo.saleRos > 0 }">
									<span class="up">▲</span>
								</c:when>
								<c:when test="${midVo.saleRos < 0 }">
									<span class="down">▼</span>
								</c:when>
							</c:choose>	            			
		           			</strong>
		           			</td>
		           		</c:otherwise>
		           	</c:choose>
		         </c:forEach>
	        </tr>
	        <tr>
	            <td><strong>건수</strong></td>
	            <c:forEach items="${tobSac_Mid }" var="midVo" varStatus="status">
		           	<c:choose>
		           		<c:when test="${status.count eq 1 }">
		           			<td class="text-right">
		           			<fmt:formatNumber value="${midVo.curCnt }" pattern="#,###"/>
		           			</td>
		           		</c:when>
		           		<c:otherwise>
		           			<td class="text-right">
		           			<fmt:formatNumber value="${midVo.curCnt }" pattern="#,###"/>
		           			</td>
		           			<td class="text-right">
		           			<strong>
		           			${midVo.cntRos }%
							<c:choose>
								<c:when test="${midVo.cntRos > 0 }">
									<span class="up">▲</span>
								</c:when>
								<c:when test="${midVo.cntRos < 0 }">
									<span class="down">▼</span>
								</c:when>
							</c:choose>	            			
		           			</strong>
		           			</td>
		           		</c:otherwise>
		           	</c:choose>
		         </c:forEach>
	        </tr>     
	        
	        <tr>
	        	
	            <td rowspan="2"><strong>대분류</strong></td>
	            <td rowspan="2"><strong>${tobNames.TOP }</strong></td>
	            <td><strong>매출액</strong></td>
	            <c:forEach items="${tobSac_Top }" var="topVo" varStatus="status">
		           	<c:choose>
		           		<c:when test="${status.count eq 1 }">
		           			<td class="text-right">
		           			<fmt:formatNumber value="${topVo.curSale }" pattern="#,###"/>
		           			</td>
		           		</c:when>
		           		<c:otherwise>
		           			<td class="text-right">
		           			<fmt:formatNumber value="${topVo.curSale }" pattern="#,###"/>
		           			</td>
		           			<td class="text-right">
		           			<strong>
		           			${topVo.saleRos }%
							<c:choose>
								<c:when test="${topVo.saleRos > 0 }">
									<span class="up">▲</span>
								</c:when>
								<c:when test="${topVo.saleRos < 0 }">
									<span class="down">▼</span>
								</c:when>
							</c:choose>	            			
		           			</strong>
		           			</td>
		           		</c:otherwise>
		           	</c:choose>
		         </c:forEach>
	        </tr>
	        <tr>
	            <td><strong>건수</strong></td>
	             <c:forEach items="${tobSac_Top }" var="topVo" varStatus="status">
		           	<c:choose>
		           		<c:when test="${status.count eq 1 }">
		           			<td class="text-right">
		           			<fmt:formatNumber value="${topVo.curCnt }" pattern="#,###"/>
		           			</td>
		           		</c:when>
		           		<c:otherwise>
		           			<td class="text-right">
		           			<fmt:formatNumber value="${topVo.curCnt }" pattern="#,###"/>
		           			</td>
		           			<td class="text-right">
		           			<strong>
		           			${topVo.cntRos }%
							<c:choose>
								<c:when test="${topVo.cntRos > 0 }">
									<span class="up">▲</span>
								</c:when>
								<c:when test="${topVo.cntRos < 0 }">
									<span class="down">▼</span>
								</c:when>
							</c:choose>	            			
		           			</strong>
		           			</td>
		           		</c:otherwise>
		           	</c:choose>
		         </c:forEach>
	        </tr>     
	         
	    </tbody>
	</table>

	
	<!-- 업종별 매출추이 도움말 -->
	<div class="card">
        <div class="card-header">
            <h6 class="m-0 font-weight-bold text-primary">
	    		<i class="fas fa-info-circle"></i> 도움말
	    	</h6>
        </div><!-- /.help -->
	    
	    <div class="card-body">
            <ul>
                <li>
				최근 6개월간 매출액 현황 추이를 통해 업종의 계절적 변동성, 성장성 등을 판단할 수 있으며,
				업소수 변화추이와 비교하여 경쟁관계의 변화 등을 가늠해볼 수 있습니다.
				</li>
            </ul>
        </div>
    </div><!-- 도움말 end -->
	
	<h5 id="sales2" class="text-info text-left font-weight-bold mt-5">2.지역별 매출추이</h5>
    <h6 class="text-secondary mt-4">분석업종&nbsp;:&nbsp;${tobNames.BOT }</h6>
	
	<div class="col-12 p-2 mt-4" style="height:300px;">
		<!-- 지역별 매출추이의 그래프 넣기 -->
		<canvas id="regSacRos" width="100%"></canvas>
	</div>
	
	<h5>
	<span class="text-gray-700 eText font-weight-bold right-box my-3">                                 
        (단위 : 만원, 건) 
    </span>
    </h5>
	
	<!-- 지역별 매출추이 테이블 -->
	<table class="table table-bordered eTable">
	    <thead>
	    	<tr class="bg-gray-200">
	    		<th colspan="2">업종</th>
	    		<th rowspan="2">2018년11월</th>
	    		<th rowspan="2" colspan="2">2018년12월</th>
	            <th rowspan="2" colspan="2">2019년01월</th>
	            <th rowspan="2" colspan="2">2019년02월</th>
	            <th rowspan="2" colspan="2">2019년03월</th>
	            <th rowspan="2" colspan="2">2019년04월</th>
	    	</tr>
	        <tr class="bg-gray-200">
	            <th colspan="2">${tobNames.BOT }</th>
	        </tr>
	        <tr class="bg-gray-200">
	        	<th colspan="2">지역</th>
	            <th>액/건</th>
	            <th>액/건</th>
	            <th>증감률</th>
	            <th>액/건</th>
	            <th>증감률</th>
	            <th>액/건</th>
	            <th>증감률</th>
	            <th>액/건</th>
	            <th>증감률</th>
	            <th>액/건</th>
	            <th>증감률</th>
	        </tr>
	    </thead>
	    <tbody>
	    
	    	<!-- 
	    		예외 처리
	    	 -->
	    	<c:if test="${regSac_Dong.size() > 0 }">
		        <tr>
		            <td rowspan="2"><strong>${regNames.DONG }</strong></td>
		            <td><strong>매출액</strong></td>
		            <c:forEach items="${regSac_Dong }" var="dongVo" varStatus="status">
		            	<c:choose>
		            		<c:when test="${status.count eq 1 }">
		            			<td class="text-right">
			           			<fmt:formatNumber value="${dongVo.curSale }" pattern="#,###"/>
			           			</td>
		            		</c:when>
		            		<c:otherwise>
			           			<td class="text-right">
			           			<fmt:formatNumber value="${dongVo.curSale }" pattern="#,###"/>
			           			</td>
			           			<td class="text-right">
			           			<strong>
			           			${dongVo.saleRos }%
								<c:choose>
									<c:when test="${dongVo.saleRos > 0 }">
										<span class="up">▲</span>
									</c:when>
									<c:when test="${dongVo.saleRos < 0 }">
										<span class="down">▼</span>
									</c:when>
								</c:choose>	            			
			           			</strong>
			           			</td>
			           		</c:otherwise>
		            	</c:choose>
		            </c:forEach>
		        </tr>
		        <tr>
		            <td><strong>건수</strong></td>
		            <c:forEach items="${regSac_Dong }" var="dongVo" varStatus="status">
		            	<c:choose>
		            		<c:when test="${status.count eq 1 }">
		            			<td class="text-right">
			           			<fmt:formatNumber value="${dongVo.curCnt }" pattern="#,###"/>
			           			</td>
		            		</c:when>
		            		<c:otherwise>
			           			<td class="text-right">
			           			<fmt:formatNumber value="${dongVo.curCnt }" pattern="#,###"/>
			           			</td>
			           			<td class="text-right">
			           			<strong>
			           			${dongVo.cntRos }%
								<c:choose>
									<c:when test="${dongVo.cntRos > 0 }">
										<span class="up">▲</span>
									</c:when>
									<c:when test="${dongVo.cntRos < 0 }">
										<span class="down">▼</span>
									</c:when>
								</c:choose>	            			
			           			</strong>
			           			</td>
			           		</c:otherwise>
		            	</c:choose>
		            </c:forEach>
		        </tr>
	        </c:if>
	        
	        <!-- 
	    		예외 처리
	    	 -->
	    	<c:if test="${regSac_Gu.size() > 0 }">
		        <tr>
		            <td rowspan="2"><strong>${regNames.GU }</strong></td>
		            <td><strong>매출액</strong></td>
		            <c:forEach items="${regSac_Gu }" var="guVo" varStatus="status">
		            	<c:choose>
		            		<c:when test="${status.count eq 1 }">
		            			<td class="text-right">
			           			<fmt:formatNumber value="${guVo.curSale }" pattern="#,###"/>
			           			</td>
		            		</c:when>
		            		<c:otherwise>
			           			<td class="text-right">
			           			<fmt:formatNumber value="${guVo.curSale }" pattern="#,###"/>
			           			</td>
			           			<td class="text-right">
			           			<strong>
			           			${guVo.saleRos }%
								<c:choose>
									<c:when test="${guVo.saleRos > 0 }">
										<span class="up">▲</span>
									</c:when>
									<c:when test="${guVo.saleRos < 0 }">
										<span class="down">▼</span>
									</c:when>
								</c:choose>	            			
			           			</strong>
			           			</td>
			           		</c:otherwise>
		            	</c:choose>
		            </c:forEach>
		        </tr>
		        <tr>
		            <td><strong>건수</strong></td>
		            <c:forEach items="${regSac_Gu }" var="guVo" varStatus="status">
		            	<c:choose>
		            		<c:when test="${status.count eq 1 }">
		            			<td class="text-right">
			           			<fmt:formatNumber value="${guVo.curCnt }" pattern="#,###"/>
			           			</td>
		            		</c:when>
		            		<c:otherwise>
			           			<td class="text-right">
			           			<fmt:formatNumber value="${guVo.curCnt }" pattern="#,###"/>
			           			</td>
			           			<td class="text-right">
			           			<strong>
			           			${guVo.cntRos }%
								<c:choose>
									<c:when test="${guVo.cntRos > 0 }">
										<span class="up">▲</span>
									</c:when>
									<c:when test="${guVo.cntRos < 0 }">
										<span class="down">▼</span>
									</c:when>
								</c:choose>	            			
			           			</strong>
			           			</td>
			           		</c:otherwise>
		            	</c:choose>
		            </c:forEach>
		        </tr>
	        </c:if>
	        
             <!-- 
	    		예외 처리
	    	 -->
	    	<c:if test="${regSac_Si.size() > 0 }">
		        <tr>
		            <td rowspan="2"><strong>${regNames.SI }</strong></td>
		            <td><strong>매출액</strong></td>
		            <c:forEach items="${regSac_Si }" var="siVo" varStatus="status">
		            	<c:choose>
		            		<c:when test="${status.count eq 1 }">
		            			<td class="text-right">
			           			<fmt:formatNumber value="${siVo.curSale }" pattern="#,###"/>
			           			</td>
		            		</c:when>
		            		<c:otherwise>
			           			<td class="text-right">
			           			<fmt:formatNumber value="${siVo.curSale }" pattern="#,###"/>
			           			</td>
			           			<td class="text-right">
			           			<strong>
			           			${siVo.saleRos }%
								<c:choose>
									<c:when test="${siVo.saleRos > 0 }">
										<span class="up">▲</span>
									</c:when>
									<c:when test="${siVo.saleRos < 0 }">
										<span class="down">▼</span>
									</c:when>
								</c:choose>	            			
			           			</strong>
			           			</td>
			           		</c:otherwise>
		            	</c:choose>
		            </c:forEach>
		        </tr>
		        <tr>
		            <td><strong>건수</strong></td>
		            <c:forEach items="${regSac_Si }" var="siVo" varStatus="status">
		            	<c:choose>
		            		<c:when test="${status.count eq 1 }">
		            			<td class="text-right">
			           			<fmt:formatNumber value="${siVo.curCnt }" pattern="#,###"/>
			           			</td>
		            		</c:when>
		            		<c:otherwise>
			           			<td class="text-right">
			           			<fmt:formatNumber value="${siVo.curCnt }" pattern="#,###"/>
			           			</td>
			           			<td class="text-right">
			           			<strong>
			           			${siVo.cntRos }%
								<c:choose>
									<c:when test="${siVo.cntRos > 0 }">
										<span class="up">▲</span>
									</c:when>
									<c:when test="${siVo.cntRos < 0 }">
										<span class="down">▼</span>
									</c:when>
								</c:choose>	            			
			           			</strong>
			           			</td>
			           		</c:otherwise>
		            	</c:choose>
		            </c:forEach>
		        </tr>
			</c:if>

	    </tbody>
	</table>
	
	<!-- 지역별 매출추이 분석결과 -->
	<div>
    	<hr class="border-primary mt-3">

        <div class="float-left col-1 mt-4"><strong>분석결과</strong></div>
        <div class="float-left col-11">                                       
            <ul>
                <!-- temp3 -->
                <!-- 
		    		예외 처리
		    	 -->
            	<c:if test="${regSac_Dong.size() > 0 }">
	                <li>
	                <strong class="res-text">${regNames.DONG }</strong>의 매출액 및 건수는 
	                <strong class="res-text">
	                <fmt:formatNumber value="${regSac_Dong.get(regSac_Dong.size()-1).curSale }"
	                				pattern="#,###"/>
	                </strong>만원과
	                <strong class="res-text">
	                <fmt:formatNumber value="${regSac_Dong.get(regSac_Dong.size()-1).curCnt }"
	                				pattern="#,###"/>
	                </strong>건으로 
	                                전반기 대비<strong class="res-text">${regSac_Dong.get(regSac_Dong.size()-1).saleRos }</strong>%
					<strong class="res-text">                           
	                <c:choose>
	                	<c:when test="${regSac_Dong.get(regSac_Dong.size()-1).saleRos > 0}">
	                		증가
	                	</c:when>
	                	<c:when test="${regSac_Dong.get(regSac_Dong.size()-1).saleRos < 0 }">
	                		감소
	                	</c:when>
	                	<c:otherwise>
	                		동일
	                	</c:otherwise>
	                </c:choose>
	                </strong>,
	                <strong class="res-text">${regSac_Dong.get(regSac_Dong.size()-1).cntRos }</strong>%
	                <strong class="res-text"> 
	                <c:choose>
	                	<c:when test="${regSac_Dong.get(regSac_Dong.size()-1).cntRos > 0}">
	                		증가
	                	</c:when>
	                	<c:when test="${regSac_Dong.get(regSac_Dong.size()-1).cntRos < 0 }">
	                		감소
	                	</c:when>
	                	<c:otherwise>
	                		동일
	                	</c:otherwise>
	                </c:choose>
	                </strong>입니다.
	                </li>
                </c:if>
                
                 <!-- 
		    		예외 처리
		    	 -->
            	<c:if test="${regSac_Gu.size() > 0 }">
	                <li>
	                <strong class="res-text">${regNames.GU }</strong>의 매출액 및 건수는 
	                <strong class="res-text">
	                <fmt:formatNumber value="${regSac_Gu.get(regSac_Gu.size()-1).curSale }"
	                				pattern="#,###"/>
	                </strong>만원과
	                <strong class="res-text">
	                <fmt:formatNumber value="${regSac_Gu.get(regSac_Gu.size()-1).curCnt }"
	                				pattern="#,###"/>
	                </strong>건으로 
	                                전반기 대비<strong class="res-text">${regSac_Gu.get(regSac_Gu.size()-1).saleRos }</strong>%
					<strong class="res-text">                           
	                <c:choose>
	                	<c:when test="${regSac_Gu.get(regSac_Gu.size()-1).saleRos > 0}">
	                		증가
	                	</c:when>
	                	<c:when test="${regSac_Gu.get(regSac_Gu.size()-1).saleRos < 0 }">
	                		감소
	                	</c:when>
	                	<c:otherwise>
	                		동일
	                	</c:otherwise>
	                </c:choose>
	                </strong>,
	                <strong class="res-text">${regSac_Gu.get(regSac_Gu.size()-1).cntRos }</strong>%
	                <strong class="res-text">
	                <c:choose>
	                	<c:when test="${regSac_Gu.get(regSac_Gu.size()-1).cntRos > 0}">
	                		증가
	                	</c:when>
	                	<c:when test="${regSac_Gu.get(regSac_Gu.size()-1).cntRos < 0 }">
	                		감소
	                	</c:when>
	                	<c:otherwise>
	                		동일
	                	</c:otherwise>
	                </c:choose>
	                </strong>입니다.
	                </li>
                </c:if>
                
               	<!-- 
		    		예외 처리
	    	 	-->
            	<c:if test="${regSac_Si.size() > 0 }">
	                <li>
	                <strong class="res-text">${regNames.SI }</strong>의 매출액 및 건수는 
	                <strong class="res-text">
	                <fmt:formatNumber value="${regSac_Si.get(regSac_Si.size()-1).curSale }"
	                				pattern="#,###"/>
	                </strong>만원과
	                <strong class="res-text">
	                <fmt:formatNumber value="${regSac_Si.get(regSac_Si.size()-1).curCnt }"
	                				pattern="#,###"/>
	                </strong>건으로 
	                                전반기 대비<strong class="res-text">${regSac_Si.get(regSac_Si.size()-1).saleRos }</strong>%
					<strong class="res-text">                            
	                <c:choose>
	                	<c:when test="${regSac_Si.get(regSac_Si.size()-1).saleRos > 0}">
	                		증가
	                	</c:when>
	                	<c:when test="${regSac_Si.get(regSac_Si.size()-1).saleRos < 0 }">
	                		감소
	                	</c:when>
	                	<c:otherwise>
	                		동일
	                	</c:otherwise>
	                </c:choose>
	                </strong>,
	                <strong class="res-text">${regSac_Si.get(regSac_Si.size()-1).cntRos }</strong>%
	                <strong class="res-text">
	                <c:choose>
	                	<c:when test="${regSac_Si.get(regSac_Si.size()-1).cntRos > 0}">
	                		증가
	                	</c:when>
	                	<c:when test="${regSac_Si.get(regSac_Si.size()-1).cntRos < 0 }">
	                		감소
	                	</c:when>
	                	<c:otherwise>
	                		동일
	                	</c:otherwise>
	                </c:choose>
	                </strong>입니다.
	                </li>
                </c:if>
            </ul>
        </div><!-- 분석결과list end -->

        <hr class="border-primary">
    </div><!-- 분석결과 end -->
	
	<!-- 지역별 매출추이 도움말 -->
	<div class="card">
        <div class="card-header">
            <h6 class="m-0 font-weight-bold text-primary">
	    		<i class="fas fa-info-circle"></i> 도움말
	    	</h6>
        </div><!-- /.help -->
	    
	    <div class="card-body">
            <ul>
                <li>
	                 매출 현황과 이용건수, 건당 매출액은 창업하실 점포의 매출액을 스스로 추정해보는데 도움되는 정보이며,
	                  추정 매출액에 따른 투자규모를 결정하셔야 창업 실패를 줄일 수 있습니다.
				</li>
            </ul>
        </div>
    </div><!-- 도움말 end -->
	
</div>
					
				</div>	<!-- 매출분석 보고서 결과 div 박스 end... -->

<!-- ========================== 인구분석 보고서의 contents 영역 ========================== -->		
				<div id="analysisResultpop" class="menuTab d-none">
				
<div id="resultPop">
	
	<!-- 1. 유동인구 기능 -->
	<h5 id="pop1" class="text-info text-left font-weight-bold mt-5">1.유동인구</h5>
	
	<div class="mt-5">
		<!-- 유동인구의 성별 및 연령별그래프 넣기 -->
		<div class="col-4 d-inline-block m-2 p-2 border-gray">
			<!-- 성별 -->
			<canvas id="ppgChart" width="100%" height="100%"></canvas>
		</div>
		<div class="w-63 d-inline-block m-2 p-2 border-gray">
			<!-- 연령별 -->
			<canvas id="ppaChart" width="100%"></canvas>
		</div>
	</div>
	
	<h5>
	<span class="text-gray-700 eText font-weight-bold right-box my-3">                                 
        (단위 : 명) 
    </span>
    </h5>
	
	<!-- 유동인구 성별 및 연령대 테이블 -->
	<table class="table table-bordered eTable">
	    <thead>
	        <tr class="bg-gray-200">
	            <th rowspan="2">지역</th>
	            <th rowspan="2">구분</th>
	            <th colspan="2">성별</th>
	            <th colspan="6">연령별</th>
	        </tr>
	        <tr class="bg-gray-200">
	            <th>남성</th>
	            <th>여성</th>
	            <th>10대</th>
	            <th>20대</th>
	            <th>30대</th>
	            <th>40대</th>
	            <th>50대</th>
	            <th>60대이상</th>
	        </tr>
	    </thead>
	    <tbody>
	        <tr>
	            <td rowspan="2">
					<strong>${regNames.DONG }</strong>
				</td>
	            <td><strong>명</strong></td>
	            <c:forEach items="${ppgList }" var="ppgVo">
	            	<td class="text-right">
	            	<fmt:formatNumber value="${ppgVo.PPG_CNT }" pattern="#,###"/>
	            	</td>
	            </c:forEach>
	            <c:forEach items="${ppaList }" var="ppaVo">
	            	<td class="text-right">
	            	<fmt:formatNumber value="${ppaVo.ppa_cnt }" pattern="#,###"/>
	            	</td>
	            </c:forEach>
	        </tr>
	        <tr>
	            <td><strong>비율</strong></td>
	            <c:forEach items="${ppgList }" var="ppgVo">
	            	<td class="text-right">${ppgVo.RATIO }%</td>
	            </c:forEach>
	            <c:forEach items="${ppaList }" var="ppaVo">
	            	<td class="text-right">${ppaVo.ppa_ratio }%</td>
	            </c:forEach>
	        </tr>
	    </tbody>
	</table>
	
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
		<div class="col-4 d-inline-block m-2 p-2 border-gray">
			<!-- 성별 -->
			<canvas id="lpGender" width="100%" height="100%"></canvas>
		</div>
		<div class="w-63 d-inline-block m-2 p-2 border-gray">
			<!-- 연령별 -->
			<canvas id="lpAge" width="100%" ></canvas>
		</div>
	</div>
	
	<h5>
	<span class="text-gray-700 eText font-weight-bold right-box my-3">                                 
        (단위 : 명) 
    </span>
    </h5>
    
	<!-- 주거인구 분석의 테이블 -->
	<table class="table table-bordered eTable">
	    <thead>
	        <tr class="bg-gray-200">
	        	<th rowspan="2">지역</th>
	            <th rowspan="2">구분</th>
	            <th rowspan="2">가구수</th>
	            <th rowspan="2">전체</th>
	            <th colspan="2">성별</th>
	            <th colspan="7">연령별</th>
	        </tr>
	        <tr class="bg-gray-200">
	            <th>남성</th>
	            <th>여성</th>
	            <th>10대</th>
	            <th>20대</th>
	            <th>30대</th>
	            <th>40대</th>
	            <th>50대</th>
	            <th style="width:95px;">60대이상</th>
	        </tr>
	    </thead>
	    <tbody>
	        <tr>
	        	<td rowspan="2"><strong>${regNames.DONG }</strong></td>
	            <td><strong>수</strong></td>
	            <td class="text-right">
	            <fmt:formatNumber value="${hhCnt.CNT }" pattern="#,###"/>
	            </td><!-- 가구수 -->
	            <td class="text-right">
	            <fmt:formatNumber value="${lpTotal.TOTAL }" pattern="#,###"/>
	            </td><!-- 전체 명수 -->
	            <c:forEach items="${lpGenderList }" var="lpGenderVo">
	            	<td class="text-right">
	            	<fmt:formatNumber value="${lpGenderVo.lp_cnt }" pattern="#,###"/>
	            	</td>
	            </c:forEach>
	            <c:forEach items="${lpAgeList }" var="lpAgeVo">
	            	<td class="text-right">
	            	<fmt:formatNumber value="${lpAgeVo.lp_cnt }" pattern="#,###"/>
	            	</td>
	            </c:forEach>
	        </tr>
	        <tr>
	            <td><strong>비율</strong></td>
	            <td class="text-right">${hhCnt.RATIO }</td><!-- 가구수 -->
	            <td class="text-right">${lpTotal.RATIO }</td><!-- 전체 명수 -->
	            <c:forEach items="${lpGenderList }" var="lpGenderVo">
	            	<td class="text-right">${lpGenderVo.lp_ratio }%</td>
	            </c:forEach>
	            <c:forEach items="${lpAgeList }" var="lpAgeVo">
	            	<td class="text-right">${lpAgeVo.lp_ratio }%</td>
	            </c:forEach>
	        </tr>
	    </tbody>
	</table>
	
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
	<span class="text-gray-700 eText font-weight-bold right-box my-3">                                 
        (단위 : 명) 
    </span>
    </h5>
	
	<table class="table table-bordered eTable">
	    <thead>
	        <tr class="bg-gray-200">
	        	<th rowspan="2">지역</th>
	            <th rowspan="2">구분</th>
	            <th rowspan="2">전체</th>
	            <th colspan="2">성별</th>
	        </tr>
	        <tr class="bg-gray-200">
	            <th>남</th>
	            <th>여</th>
	        </tr>
	    </thead>
	    <tbody>
	        <tr>
	        	<td rowspan="2"><strong>${regNames.DONG }</strong></td>
	            <td><strong>수</strong></td>
	            <td>
	            <fmt:formatNumber value="${wpTotal.TOTAL }" pattern="#,###"/>
	            </td>
	            <td>
	            <fmt:formatNumber value="${wpList.get(0).wp_cnt }" pattern="#,###"/>
	            </td>
	            <td>
	            <fmt:formatNumber value="${wpList.get(1).wp_cnt }" pattern="#,###"/>
	            </td>
	        </tr>
	        <tr>
	            <td><strong>비율</strong></td>
				<td>${wpTotal.RATIO }</td>
				<td>${wpList.get(0).wp_ratio }</td>
				<td>${wpList.get(1).wp_ratio }</td>
	        </tr>
	    </tbody>
	</table>
	
	
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
	
	
	<h5 id="pop4" class="text-info text-left font-weight-bold mt-5">4.공동주택</h5>
    <h6 class="text-secondary mt-4">분석지역&nbsp;:&nbsp;${region_full_name }</h6>
	
	<!-- 해당 분석지역에 대한 공동주택 현황을 확인하기 위한 map 출력 -->
	<div class="p-2 my-4 border-gray">
		<!-- 지도 api를 이곳에 넣는다 -->
		<div class="col-12" id="aptMap" style="width: 100%; height: 600px;"></div>
	</div>
	
</div>

				</div>  <!-- 인구분석 보고서 결과 div 박스 end... -->
	         
            </div>	<!-- container end.. -->
		</div> <!-- tab-pane active end.. -->
	</div> <!-- tab-content mheight end.. -->
    
	
</div>


</div>