<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	#base{
		width : 100%;
		height : auto;
		margin : 0 auto;
		color : black;
	}
	#subject{
		width : 1100px;
		height : auto;
		margin : 0 auto;
		text-align : left;	
	}
	#input{
		width : 1100px;
		height : auto;
		margin : 0 auto;
		text-align : left;
	}
	#subject1{
		width : 1100px;
		height : auto;
		margin : 0 auto;
	}
	h2{
		display: inline-block;
	}
	#dataTable{
		text-align: center;
		margin: 15px 0px 30px 0px;
	}
	th{
		background-color: #eaecf4;
	}
	td{
		background-color : white;
	}
	hr{
		clear: both;
		width : 1100px;
		border-width: 3px;
	}
	#lAppr:hover{
		cursor: pointer;
	}
	#tmenu2:hover{
		cursor: pointer;
	}
	#smenu{
		text-align: center;
		font-size: 1.2em;
		color: black;
		background-color: linen;
		font-weight: bold;
	}
	#tmenu1{
		height: 1.5em;
	}
	#yu{
		width: 50%;
	}
	#gyumo, #gusung{
		font-size: 1.2em;
		text-align: center;
		width: 100%;
		margin: 0px 0px 15px 0px;
	}
	#gyumo td, #gusung td{
		width:10%;
		border: solid 0.1px;
		color : lightgray;
	}
	#gyumocell1, #gusungcell1, #sobicell1{
		height: 90px;
	}
	#sobi {
		font-size: 1.2em;
		text-align: center;
		width: 50%;
		margin: 0px 0px 15px 0px;
	}
	#sobi td{
		width : 20%;
		border: solid 0.1px;
		color : lightgray;
	}
	#info1{
		padding-left: 0;
		padding-right: 0;
	}
	#info2{
		padding-left: 0;
		padding-right: 0;
	}
	#info3{
		padding-left: 0;
		padding-right: 0;
	}
	.up{
		text-align: center;
		font-size: 1.2em;
		color: brown;
	}
	.typePrint{
		font-size: 1.2em;
		font-weight: bold;
		color: #f23065;
	}
	.flabel{
		margin: 0 0 0 2em;
	}
	.rightBox02 {
	  	float: right;
	}
	
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
	.fnMove{
		cursor : pointer;
	}

</style>

<!-- Chart.js -->
<script src="${pageContext.request.contextPath}/ex_img/vendor/chart.js/Chart.js"></script>

<script>
	$(document).ready(function(){
		var cd = ${region_cd};
		
		// 상권규모, 인구(고객)구성, 소비수준에 따른 상권유형 출력
		var rating = "gyumocell" + ${rating};
		var popNum = "gusungcell" + ${popNum};
		var spendRating = "sobicell" + ${spendRating};
		$("#" + rating).css('background-color', 'bisque').css('color', 'black');
		$("#" + popNum).css('background-color', 'bisque').css('color', 'black');
		$("#" + spendRating).css('background-color', 'bisque').css('color', 'black');
		
		// 고객구성 읽어서 대입
		var gVal = $("#" + popNum).html();
		$("#gusungV").val(gVal);
		
		// 1. 종합 입지평가 페이지로 이동
		$("#lAppr").on("click", function(){
			$("#dongcd").val(cd);
			$("#form3").submit();
		})
		
		// 2-2. 상권유형에 따른 적합업종 페이지로 이동
		$("#tmenu2").on("click", function(){
			$("#regionCd").val(cd);
			$("#formtR").submit();
		})
		
		/* 음식업 차트 */
		var canvas1 = $("#myChart1");
		var data1 = {
				labels: [
					<c:forEach items="${fList}" var="food" begin="0" end="4" varStatus="status">
						<c:choose>
							<c:when test="${status.index < 4}">
								"${food.tob_name}",
							</c:when>
							<c:otherwise>
								"${food.tob_name}"
							</c:otherwise>
						</c:choose>
					</c:forEach>
				],
		   datasets: [{
		      label: "상권 내 비율",
		      backgroundColor: "rgba(0,0,255,0.3)",
		      borderColor: "rgba(216,255,207,1)",
		      borderWidth: 2,
		      hoverBackgroundColor: "rgba(0,0,255,0.5)",
		      hoverBorderColor: "rgba(216,255,207,1)",
		      data: [
		    	  <c:forEach items="${fList}" var="food" begin="0" end="4" varStatus="status">
					<c:choose>
						<c:when test="${status.index < 4}">
							"<fmt:formatNumber value="${food.inRegion}" pattern="0.0"/>",
						</c:when>
						<c:otherwise>
							"<fmt:formatNumber value="${food.inRegion}" pattern="0.0"/>"
						</c:otherwise>
					</c:choose>
				</c:forEach>
		      ],
		      xAxisID: 'x1',
		   }, {
		      label: "대전 평균 비율",
		      backgroundColor: "rgba(55,99,132,0.3)",
		      borderColor: "rgba(216,255,207,1)",
		      borderWidth: 1,
		      hoverBackgroundColor: "rgba(55,99,132,0.5)",
		      hoverBorderColor: "rgba(216,255,207,1)",
		      data: [
		    	  <c:forEach items="${fList}" var="food" begin="0" end="4" varStatus="status">
					<c:choose>
						<c:when test="${status.index < 4}">
							"<fmt:formatNumber value="${food.inDaejeon}" pattern="0.0"/>",
						</c:when>
						<c:otherwise>
							"<fmt:formatNumber value="${food.inDaejeon}" pattern="0.0"/>"
						</c:otherwise>
					</c:choose>
				</c:forEach>
		      ],
		   }]
		};
		var option1 = {
			title: {
				display: true,
				fontSize: 22,
				fontColor: "black",
				fontStyle: "bold",
				text: "음식업"
			},
			legend: {
				labels: {
					fontSize: 16,
					fontColor: "black",
					fontStyle: "bold",
				}
			},
		   scales: {
		      yAxes: [{
		    	 afterFit: function(scaleInstance) {
		    	       scaleInstance.width = 178; // sets the width to 100px
		    	     },
		         gridLines: {
		            display: true,
		            color: "rgba(255,99,132,0.2)"
		         },
		         ticks: {
		        	 fontSize: 16,
					 fontColor: "black",
					 fontStyle: "bold"
		         }
		      }],
		      xAxes: [{
		         id: 'x1',
		         gridLines: {
		            display: false
		         },
		         ticks: {
		        	 fontSize: 16,
					 fontColor: "black",
					 fontStyle: "bold"
		         }
		      }]
		   }
		};
		var ctx1 = document.getElementById("myChart1").getContext('2d');

		var myBarChart1 = new Chart(ctx1, {
		   type: 'horizontalBar',
		   data: data1,
		   options: option1
		});
		/* 음식업 차트 끝 */
		
		/* 소매업 차트 */
		var canvas2 = $("#myChart2");
		var data2 = {
				labels: [
					<c:forEach items="${rList}" var="retail" begin="0" end="4" varStatus="status">
						<c:choose>
							<c:when test="${status.index < 4}">
								"${retail.tob_name}",
							</c:when>
							<c:otherwise>
								"${retail.tob_name}"
							</c:otherwise>
						</c:choose>
					</c:forEach>
				],
		   datasets: [{
		      label: "상권 내 비율",
		      backgroundColor: "rgba(0,0,255,0.3)",
		      borderColor: "rgba(216,255,207,1)",
		      borderWidth: 2,
		      hoverBackgroundColor: "rgba(0,0,255,0.5)",
		      hoverBorderColor: "rgba(216,255,207,1)",
		      data: [
		    	  <c:forEach items="${rList}" var="retail" begin="0" end="4" varStatus="status">
					<c:choose>
						<c:when test="${status.index < 4}">
							"<fmt:formatNumber value="${retail.inRegion}" pattern="0.0"/>",
						</c:when>
						<c:otherwise>
							"<fmt:formatNumber value="${retail.inRegion}" pattern="0.0"/>"
						</c:otherwise>
					</c:choose>
				</c:forEach>
		      ],
		      xAxisID: 'x1',
		   }, {
		      label: "대전 평균 비율",
		      backgroundColor: "rgba(55,99,132,0.3)",
		      borderColor: "rgba(216,255,207,1)",
		      borderWidth: 1,
		      hoverBackgroundColor: "rgba(55,99,132,0.5)",
		      hoverBorderColor: "rgba(216,255,207,1)",
		      data: [
		    	  <c:forEach items="${rList}" var="retail" begin="0" end="4" varStatus="status">
					<c:choose>
						<c:when test="${status.index < 4}">
							"<fmt:formatNumber value="${retail.inDaejeon}" pattern="0.0"/>",
						</c:when>
						<c:otherwise>
							"<fmt:formatNumber value="${retail.inDaejeon}" pattern="0.0"/>"
						</c:otherwise>
					</c:choose>
				</c:forEach>
		      ],
		   }]
		};
		var option2 = {
			title: {
				display: true,
				fontSize: 22,
				fontColor: "black",
				fontStyle: "bold",
				text: "소매업"
			},
			legend: {
				labels: {
					fontSize: 16,
					fontColor: "black",
					fontStyle: "bold"
				}
			},
		   scales: {
		      yAxes: [{
		    	 afterFit: function(scaleInstance) {
		    	       scaleInstance.width = 178; // sets the width to 100px
		    	     },
		         gridLines: {
		            display: true,
		            color: "rgba(255,99,132,0.2)"
		         },
		         ticks: {
		        	 fontSize: 16,
					 fontColor: "black",
					 fontStyle: "bold"
		         }
		      }],
		      xAxes: [{
		         id: 'x1',
		         gridLines: {
		            display: false
		         },
		         ticks: {
		        	 fontSize: 16,
					 fontColor: "black",
					 fontStyle: "bold"
		         }
		      }]
		   }
		};
		var ctx2 = document.getElementById("myChart2").getContext('2d');

		var myBarChart2 = new Chart(ctx2, {
		   type: 'horizontalBar',
		   data: data2,
		   options: option2
		});
		/* 소매업 차트 끝 */
		
		/* 서비스업 차트 */
		var canvas3 = $("#myChart3");
		var data3 = {
				labels: [
					<c:forEach items="${sList}" var="service" begin="0" end="4" varStatus="status">
						<c:choose>
							<c:when test="${status.index < 4}">
								"${service.tob_name}",
							</c:when>
							<c:otherwise>
								"${service.tob_name}"
							</c:otherwise>
						</c:choose>
					</c:forEach>
				],
		   datasets: [{
		      label: "상권 내 비율",
		      backgroundColor: "rgba(0,0,255,0.3)",
		      borderColor: "rgba(216,255,207,1)",
		      borderWidth: 2,
		      hoverBackgroundColor: "rgba(0,0,255,0.5)",
		      hoverBorderColor: "rgba(216,255,207,1)",
		      data: [
		    	  <c:forEach items="${sList}" var="service" begin="0" end="4" varStatus="status">
					<c:choose>
						<c:when test="${status.index < 4}">
							"<fmt:formatNumber value="${service.inRegion}" pattern="0.0"/>",
						</c:when>
						<c:otherwise>
							"<fmt:formatNumber value="${service.inRegion}" pattern="0.0"/>"
						</c:otherwise>
					</c:choose>
				</c:forEach>
		      ],
		      xAxisID: 'x1',
		   }, {
		      label: "대전 평균 비율",
		      backgroundColor: "rgba(55,99,132,0.3)",
		      borderColor: "rgba(216,255,207,1)",
		      borderWidth: 1,
		      hoverBackgroundColor: "rgba(55,99,132,0.5)",
		      hoverBorderColor: "rgba(216,255,207,1)",
		      data: [
		    	  <c:forEach items="${sList}" var="service" begin="0" end="4" varStatus="status">
					<c:choose>
						<c:when test="${status.index < 4}">
							"<fmt:formatNumber value="${service.inDaejeon}" pattern="0.0"/>",
						</c:when>
						<c:otherwise>
							"<fmt:formatNumber value="${service.inDaejeon}" pattern="0.0"/>"
						</c:otherwise>
					</c:choose>
				</c:forEach>
		      ],
		   }]
		};
		var option3 = {
			title: {
				display: true,
				fontSize: 22,
				fontColor: "black",
				fontStyle: "bold",
				text: "서비스업"
			},
			legend: {
				labels: {
					fontSize: 16,
					fontColor: "black",
					fontStyle: "bold"
				}
			},
		   scales: {
		      yAxes: [{
		    	 afterFit: function(scaleInstance) {
		    	       scaleInstance.width = 178; // sets the width to 100px
		    	     },
		         gridLines: {
		            display: true,
		            color: "rgba(255,99,132,0.2)"
		         },
		         ticks: {
		        	 fontSize: 16,
					 fontColor: "black",
					 fontStyle: "bold"
		         }
		      }],
		      xAxes: [{
		         id: 'x1',
		         gridLines: {
		            display: false
		         },
		         ticks: {
		        	 fontSize: 16,
					 fontColor: "black",
					 fontStyle: "bold"
		         }
		      }]
		   }
		};
		var ctx3 = document.getElementById("myChart3").getContext('2d');

		var myBarChart3 = new Chart(ctx3, {
		   type: 'horizontalBar',
		   data: data3,
		   options: option3
		});
		/* 서비스업 차트 끝 */
		
		// 엑셀 다운로드
		$("#edn").on("click", function(){
			$("#excel").submit();
		})
		
	}) // document ready 끝
	
	function fnSaveAsPdf() {
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
          
          doc.save('tobRecom 2-1page.pdf');
          console.log('Reached here?');
        });
      }
	
	// 스크롤 이동
	function fnMove(seq){
	    var offset = $("#result" + seq).offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	}
</script>


<div class="col-sm-10 col-sm-offset-3 col-md-10 col-md-offset-2 main" id="base">
	<div id="subject">
		<h2 class="figure font-weight-bold text-left">업종추천 보고서</h2>&nbsp;&nbsp;
		
		<div class="mt-3">
			<div class="row fulltab">
				<div class="col-12">
					<ul class="nav nav-tabs depth-1 fl" role="tablist">
						<li class=""><a href="#" id="lAppr">종합 입지평가</a></li>
						<li class="active"><a href="#" id="sTob">상권적합도 우수업종</a></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="my-3">
			<span onclick="fnMove('1')" class="fnMove">1. 업종구성</span>&nbsp;
			<span onclick="fnMove('2')" class="fnMove">2. 상권 내 밀집업종</span>&nbsp;
			<span onclick="fnMove('3')" class="fnMove">3. 상권규모</span>&nbsp;
			<span onclick="fnMove('4')" class="fnMove">4. 주요 고객구성</span>&nbsp;
			<span onclick="fnMove('5')" class="fnMove">5. 소비수준</span>&nbsp;
				
			<div class="rightBox02">
				<a id="pdn" href="#" onclick="fnSaveAsPdf();" class="btn btn-primary btn-icon-split btn-sm">
		          <span class="text">PDF다운로드</span>
		        </a>
				
				<a id="edn" href="#" class="btn btn-primary btn-icon-split btn-sm">
		          <span class="text">EXCEL다운로드</span>
		        </a>
			</div>
		</div>
		
	</div>
	<hr>
	<br>
	
	<div id="input">
	<table class="table table-bordered dataTable" id="smenu">
		<tr>
			<td style="width: 50%; background-color:lightsteelblue;" id="tmenu1">상권유형 판별</td>
			<td style="width: 50%; background-color:aliceblue; opacity: 0.8;" id="tmenu2">상권유형에 따른 적합업종</td>
		</tr>
	</table>
	</div>
	
	<br>
	
	<div id="subject1">
		<h5 id="result1" class="font-weight-bold text-info text-left">1. 업종구성에 따른 상권유형</h5>
		<table class="table table-bordered dataTable" id="dataTable">
			<thead>
				<tr role="row">
					<th id="yu">상권유형</th>
					<th colspan="3">상권구성</th>
				</tr>
			</thead>
			<tbody>
				<tr role="row">
					<td class="typePrint" rowspan="2" style="background-color : linen;"><br>${resultMap.btype }</td>
					<td class="bg-gray-100">음식업</td>
					<td class="bg-gray-100">소매업</td>
					<td class="bg-gray-100">서비스업</td>
				</tr>
				<tr role="row">
					<td class="typePrint">${resultMap.foodPercent }%</td>
					<td class="typePrint">${resultMap.retailPercent }%</td>
					<td class="typePrint">${resultMap.servicePercent }%</td>
				</tr>
			</tbody>
		</table>
		
		<h5 class="font-weight-bold text-info text-left">상권유형 설명</h5>
		<table class="table table-bordered dataTable text-center" id="uh">
			<tr role="row">
				<th>유형구분</th>
				<th>설명</th>
			</tr>
			<tr>
				<td class="bg-gray-100">일반형</td>
				<td class="text-left">전체 업종구성비 기준 음식:소매:서비스업 비중이 4:3:3 정도로 형성된 일반 상권</td>
			</tr>
			<tr>
				<td class="bg-gray-100">음식형</td>
				<td class="text-left">전체 업종구성비 기준 음식업 비중이 45% 이상인 지역으로써 음식업 위주의 상권</td>
			</tr>
			<tr>
				<td class="bg-gray-100">복합형</td>
				<td class="text-left">전체 업종구성비 기준 소매업 비중이 35% 정도이면서 서비스업을 강화한 유형</td>
			</tr>
			<tr>
				<td class="bg-gray-100">유통형</td>
				<td class="text-left">전체 업종구성비 기준 소매업 비중이 45% 이상인 지역으로써 소매업 특수 유형</td>
			</tr>
			<tr>
				<td class="bg-gray-100">교육형</td>
				<td class="text-left">교육업 비중이 15% 이상으로써 특화서비스업 비중이 높은 지역</td>
			</tr>
		</table>
		
		<br>
		
		<h5 id="result2" class="font-weight-bold text-info text-left">2. 평균 업종구성비 대비 상권 내 밀집업종</h5>
		
		<canvas id="myChart1" style="width:80vw;height:60vh"></canvas><br>
		
		<canvas id="myChart2" style="width:80vw;height:60vh"></canvas><br>
		
		<canvas id="myChart3" style="width:80vw;height:60vh"></canvas><br>
		
		<br><br>
		
		<h5 id="result3" class="font-weight-bold text-info text-left">3. 상권규모에 따른 상권유형</h5>
		<table class="my-3" id="gyumo" style="border : none;">
			<tr>
				<td id="gyumocell1">1등급</td>
				<td id="gyumocell2">2등급</td>
				<td id="gyumocell3">3등급</td>
				<td id="gyumocell4">4등급</td>
				<td id="gyumocell5">5등급</td>
				<td id="gyumocell6">6등급</td>
				<td id="gyumocell7">7등급</td>
				<td id="gyumocell8">8등급</td>
				<td id="gyumocell9">9등급</td>
				<td id="gyumocell10">10등급</td>
			</tr>
		</table>
		<div class="card col-12" id="info1">
			<div class="card-header">
				<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-info-circle"></i> 도움말</h6>
			</div>
			<div class="card-body">
				분석하는 상권의 총매출액이 대전광역시 전체 상권 매출액 상위 몇%에 속하는지 나타내는 등급입니다
			</div>
		</div>
		
		<br><br>
		
		<h5 id="result4" class="font-weight-bold text-info text-left">4. 주요 고객구성에 따른 상권유형</h5>
		<table class="my-3" id="gusung">
			<tr>
				<td id="gusungcell1">20대<br>남성</td>
				<td id="gusungcell2">20대<br>여성</td>
				<td id="gusungcell3">30대<br>남성</td>
				<td id="gusungcell4">30대<br>여성</td>
				<td id="gusungcell5">40대<br>남성</td>
				<td id="gusungcell6">40대<br>여성</td>
				<td id="gusungcell7">50대<br>남성</td>
				<td id="gusungcell8">50대<br>여성</td>
				<td id="gusungcell9">60대이상<br>남성</td>
				<td id="gusungcell10">60대이상<br>여성</td>
			</tr>
		</table>
		<div class="card col-12" id="info2">
			<div class="card-header">
				<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-info-circle"></i> 도움말</h6>
			</div>
			<div class="card-body">
				분석하는 상권의 주거인구, 유동인구를 바탕으로 상권유형에 가장 큰 영향을 주는 연령/성별집단을 표시합니다 
			</div>
		</div>
		
		<br><br>
		
		<h5 id="result5" class="font-weight-bold text-info text-left">5. 소비수준에 따른 상권유형</h5>
		<table class="my-3" id="sobi">
			<tr>
				<td id="sobicell1">1등급</td>
				<td id="sobicell2">2등급</td>
				<td id="sobicell3">3등급</td>
				<td id="sobicell4">4등급</td>
				<td id="sobicell5">5등급</td>
			</tr>
		</table>
		<div class="card col-12" id="info3">
			<div class="card-header">
				<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-info-circle"></i> 도움말</h6>
			</div>
			<div class="card-body">
				분석하는 상권의 소비수준이 대전광역시 전체 소비수준 대비 어느 정도인지 나타내는 등급입니다
			</div>
		</div>
		<br>
	</div>
</div>
<form id="form3" action="${pageContext.request.contextPath}/tobRecom/result" method="get">
	<input type="hidden" id="dongcd" name="dongcd" />
	<input type="hidden" name="checkRe" value="y">
	<input type="hidden" id="report_cd" name="report_cd" value="${report_cd}">
</form>

<form id="formtR" action="${pageContext.request.contextPath}/tobRecom/totalResult" method="post">
	<input type="hidden" id="btype" name="btype" value="${resultMap.btype}"/>
	<input type="hidden" id="gyumoV" name="gyumoV" value="${rating}"/>
	<input type="hidden" id="gusungV" name="gusungV"/>
	<input type="hidden" id="sobiV" name="sobiV" value="${spendRating}"/>
	<input type="hidden" id="regionCd" name="regionCd"/>
	<input type="hidden" id="report_cd" name="report_cd"  value="${report_cd}"/>
</form>

<form action="${pageContext.request.contextPath}/tobRecom/excel" id="excel" method="get">
	<input type="hidden" id="report_cd" name="report_cd" value="${report_cd}">
</form>
