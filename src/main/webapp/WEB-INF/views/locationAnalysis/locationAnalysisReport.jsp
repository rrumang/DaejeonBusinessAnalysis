<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9e96d9b8ca5bed0ac8c0a0ebf8487a10&libraries=drawing,services"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
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
	.fnMove{
		cursor : pointer;
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
	
	#map{
		display: inline-block;
		width: 550px;
		height: 475px;
		float:left;
		border : 1px dashed #bcbcbc;
	}
	
	#sign{
		width : 550px;
		height: 475px;
		text-align : center;
		float:left;
		border : 1px dashed #bcbcbc;
		background :url('../img/배경이미지2.gif') no-repeat;
		background-position: center;
	}
	
	#info1{
		width : 1100px;
		height : auto;
		margin : 0 auto;
		text-align : left;
		padding-left : 0;
		padding-right : 0;
	}
	
	#subject2{
		width : 1100px;
		height : auto;
		margin : 0 auto;
		text-align : left;
	}
	
	.grade{
		margin: 5px;
		float: left;
		text-align: center;
	}

	#good{
		width : 356px;
		margin-left : 0px;
		margin-right : 10px;
	}
	
	#normal{
		width : 357px;
	}
	
	#bad{
		width : 356px;
		margin-right : 0px;
		float : right;
	}
	
	.dots{
		width: 20px;
		height: 20px;
	}
	
	#result1{
		width : 1100px;
		height : auto;
		margin : 0 auto;
		text-align : left;
	}
	
	.best{
		color : blue;
	}
	
	.worst{
		color : red;
	}
	
	#subject3{
		width : 1100px;
		height : auto;
		margin : 0 auto;
		text-align : left;
	}
	
	#population{
		width : 1100px;
		margin : 0 auto;
		text-align : center;
	}
	
	#result2{
		width : 1100px;
		height : auto;
		margin : 0 auto;
		text-align : left;
	}
	
	#info2{
		width : 1100px;
		height : auto;
		margin : 0 auto;
		text-align : left;
		padding-left : 0;
		padding-right : 0;
	}
	
	.dataTable{
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
		border-width: 2px;
	}
	
	.subject{
		font-size: 1.1em;
		margin: 0px 10px;
		color : black;
		text-decoration : none;
	}
	
	#signal{
		width: 300px;
		height: 300px;
	}
	
	#retable{
		margin: 5px;
		float: left;
		text-align: center;
	}
	
	#setable{
		margin: 5px;
		float: left;
		text-align: center;
	}
	
	.bury{
		letter-spacing: -1px;
	}
	
	#bronze{
		background-color : #AE5E1A;
		color : white;
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
	.rightBox02 {
		margin-top : 10px;
	  	float: right;
	}
	
</style>
<script>
	$(document).ready(function(){
		
		// PDF 다운로드 버튼을 클릭했을 때
		$("#pdn").on("click", function(e){
			e.preventDefault();
			
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
		        
		        doc.save('locationAnalysisReport.pdf');
			});
		});
		
		
		// 지도에 표시된 마커 객체를 가지고 있는 배열
		markers = [];
		/* ================================kakao 지도================================ */
		var container = document.getElementById('map');
		
		var mapOptions = {
			// 페이지 호출 시 처음으로 보여줄 좌표 설정
			center: new kakao.maps.LatLng(36.323329, 127.411299),
			level: 4
		};
		
		map = new kakao.maps.Map(container, mapOptions);
		
		// 마우스 드래그로 지도 이동 가능여부를 설정합니다
		map.setDraggable(false);
		
		// 주소-좌표 변환 객체를 생성합니다
		geocoder = new kakao.maps.services.Geocoder();
		
		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new kakao.maps.MapTypeControl();
		
		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
		
		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		// 도형 스타일을 변수로 설정합니다
		var strokeColor = '#39f',
			fillColor = '#cce6ff',
			fillOpacity = 0.5,
			hintStrokeStyle = 'dash';
		
		// 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수입니다
		function setMarkers(map) {
		    for (var i = 0; i < markers.length; i++) {
		        markers[i].setMap(map);
		    }            
		}
		
		// "마커 보이기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에 표시하는 함수입니다
		function showMarkers() {
		    setMarkers(map)    
		}
		
		// "마커 감추기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에서 삭제하는 함수입니다
		function hideMarkers() {
		    setMarkers(null);    
		}
		
		/* ================================kakao 지도 끝================================ */
		
		searchAddr("${region_csc}");
		
		console.log("${resultList}");
		
		$("#sTob").on("click", function(){
			var regionCd = "${region_cd}";
			$("#region_cd").val(regionCd);
			$("#form2").submit();
		})
		
		$("#edn").on("click", function(){
			$("#excel").submit();
		});
		
	}) // end of document ready
	
		function searchAddr(addr){
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(addr, function(result, status) {

		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		        
		        markers.push(marker);
		        
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
// 		        var infowindow = new kakao.maps.InfoWindow({
// 		            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+ dong +'</div>'
// 		        });
// 		        infowindow.open(map, marker);
		        
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});
		
	}
	function fnMove(seq){
		var offset = $("#subject" + seq).offset();
		$('html, body').animate({scrollTop : offset.top}, 400);
	}
	
	/* function print(printArea){
		win = window.open(); 
		self.focus(); 
		win.document.open();

		
			1. div 안의 모든 태그들을 innerHTML을 사용하여 매개변수로 받는다.
			2. window.open() 을 사용하여 새 팝업창을 띄운다.
			3. 열린 새 팝업창에 기본 <html><head><body>를 추가한다.
			4. <body> 안에 매개변수로 받은 printArea를 추가한다.
			5. window.print() 로 인쇄
			6. 인쇄 확인이 되면 팝업창은 자동으로 window.close()를 호출하여 닫힘
		
		win.document.write('<html><head><title></title><style>');
		win.document.write('div#base {width : 100%; height : auto; margin : 0 auto;}');
		win.document.write('div#subject {width : 100%; height : auto; margin : 0 auto; text-align : left;}');
		win.document.write('div#input {width : 1100px; height : auto; margin : 0 auto; text-align : left;}');
		win.document.write('table#inputTable {width : 1100px; height : auto; margin : 0 auto; text-align : left;}');
		win.document.write('div#subject1 {width : 1100px; height : auto; margin : 0 auto;}');
		win.document.write('img#signal {width : 200px; height : 200px;}');
		win.document.write('div#subject2 {width : 1100px; height : auto; margin : 0 auto; display : inline;}');
		win.document.write('table#good {width : 600px; display : inline;  margin-left : 50px;}');
		win.document.write('table#normal {width : 600px; display : inline; margin-left : 100px;}');
		win.document.write('table#bad {width : 600px; display : inline;  margin-left : 100px;}');
		win.document.write('table#population {width : 1100px; height : auto; margin : 0 auto; text-align : center;}');
		win.document.write('</style></head><body>');
		win.document.write(printArea);
 		win.document.write('</body></html>');
		win.document.close();
		win.print();
		win.close();
	} */
	
</script>
<div class="col-sm-10 col-sm-offset-3 col-md-10 col-md-offset-2 main" id="base">
	<form action="${pageContext.request.contextPath }/location/excel" id="excel" method="post">
		<input type="hidden" id="report_cd" name="report_cd" value="${report_cd}">
	</form>

	<div id="subject">
		<h2 class="figure font-weight-bold text-left">입지분석 보고서</h2>&nbsp;&nbsp;
		<span onclick="fnMove('1')" class="fnMove">1. 종합 입지등급</span>&nbsp;
		<span onclick="fnMove('2')" class="fnMove">2. 업종별 입지등급</span>&nbsp;
		<span onclick="fnMove('3')" class="fnMove">3. 잠재고객분석</span>&nbsp;
		
		<div class="rightBox02">
			<a id="pdn" href="#" class="btn btn-primary btn-icon-split btn-sm">
	          <span class="text">PDF다운로드</span>
	        </a>
			
			<a id="edn" href="#" class="btn btn-primary btn-icon-split btn-sm">
	          <span class="text">EXCEL다운로드</span>
	        </a>
		</div>
	</div>
	<hr>
	<br>
	
	<div id="input">
		<h5 class="font-weight-bold text-info text-left">분석 설정 정보</h5>
		<table class="table table-bordered dataTable dataTable" id="inputTable">
			<thead>
				<tr role="row">
					<th style="width: 20%">분석지역</th>
					<th style="width: 20%">기준데이터시점</th>
				</tr>
			</thead>
			<tbody>
				<tr role="row">
					<td>${selectAddr}</td>
					<td>2019년 04월</td>
				</tr>
			</tbody>
		</table>
	</div>
	<br>
	
	<div id="subject1">
		<h5 class="font-weight-bold text-info text-left">1. 종합 입지등급</h5>
		<div id="map" class="mt-2 mb-3"></div>
		<div id="sign" class="mt-2 mb-3"><br>
			<c:choose>
				<c:when test="${grade == 1}">
					<img id="signal" src="${pageContext.request.contextPath}/img/금.gif"><br>
					<span id="gold" class="btn btn-warning btn-icon-split">종합입지등급:1등급</span><br>
					<span>선택지역의 종합입지등급은 '1등급' 입니다.<br>종합입지등급은 43개 업종별 입지등급의 평균인 만큼<br>개별업종의 입지등급을 참고하시기바랍니다.</span>
				</c:when>
				<c:when test="${grade == 2}">
					<img id="signal" src="${pageContext.request.contextPath}/img/은.gif"><br>
					<span id="silver" class="btn btn-secondary btn-icon-split">종합입지등급:2등급</span><br>
					<span>선택지역의 종합입지등급은 '2등급' 입니다.<br>종합입지등급은 43개 업종별 입지등급의 평균인 만큼<br>개별업종의 입지등급을 참고하시기바랍니다.</span>
				</c:when>
				<c:when test="${grade == 3}">
					<img id="signal" src="${pageContext.request.contextPath}/img/동.gif"><br>
					<span id="bronze" class="btn btn-icon-split">종합입지등급:3등급</span><br>
					<span>선택지역의 종합입지등급은 '3등급' 입니다.<br>종합입지등급은 43개 업종별 입지등급의 평균인 만큼<br>개별업종의 입지등급을 참고하시기바랍니다.</span>
				</c:when>
			</c:choose>
		</div>
	</div>
	
	<div class="card col-12 p-0" id="info1">
		<div class="card-header">
			<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-info-circle"></i> 도움말</h6>
		</div>
		<div class="card-body">
			종합입지등급 : 선택입지에 대한 43개 표준업종 입지등급의 평균 음식,소매,서비스업 등 표본업종별 입지의 가치(예상매출액)를<br>
			평가한 등급으로 1등급에 가까울수록 좋은 입지임을 의미합니다<br>
			[예시]전체 43개 입지등급 중 선택지역이 1등급인 표본업종의 수가 30개, 2등급인 업종이 10개, 3등급인 업종이 5개인 경우,<br>
			{(1*30) + (2*10) + (3*5)} / 43 = 1.5 → 산술평균을 반올림한 값을 이용, 종합 2등급으로 표시합니다.<br><br>
			43개 표본업종의 매출에 영향을 미치는 X변수는 각각 다르게 추출합니다
		</div>
	</div>
	
	<br><br>
	
	<div id="subject2">
		<h5 class="font-weight-bold text-info text-left">2. 업종별 입지등급</h5>
		<table class="table table-bordered col-sm-4 grade mt-2 mb-4" id="good">
			<tr>
				<th colspan="2">좋음</th>
			</tr>
			<c:forEach begin="0" end="9" items="${resultList}" var="rList">
			<tr>
				<td>${rList.tob}</td>
				<td>
					<c:choose>
						<c:when test="${rList.grade == 1}">
							<img class="dots" src="${pageContext.request.contextPath}/img/gold_coin.gif"> ${rList.grade}등급
						</c:when>
						
						<c:when test="${rList.grade == 2}">
							<img class="dots" src="${pageContext.request.contextPath}/img/silver_coin.gif"> ${rList.grade}등급
						</c:when>
						
						<c:when test="${rList.grade == 3}">
							<img class="dots" src="${pageContext.request.contextPath}/img/copper_coin.gif"> ${rList.grade}등급
						</c:when>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</table>
		
		<table class="table table-bordered col-sm-4 grade" id="normal">
			<tr>
				<th colspan="2">보통</th>
			</tr>
			<c:forEach begin="10" end="19" items="${resultList}" var="rList">
			<tr>
				<td>${rList.tob}<br></td>
				<td>
					<c:choose>
						<c:when test="${rList.grade == 1}">
							<img class="dots" src="${pageContext.request.contextPath}/img/gold_coin.gif"> ${rList.grade}등급
						</c:when>
						
						<c:when test="${rList.grade == 2}">
							<img class="dots" src="${pageContext.request.contextPath}/img/silver_coin.gif"> ${rList.grade}등급
						</c:when>
						
						<c:when test="${rList.grade == 3}">
							<img class="dots" src="${pageContext.request.contextPath}/img/copper_coin.gif"> ${rList.grade}등급
						</c:when>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</table>
		
		<table class="table table-bordered col-sm-4 grade" id="bad">
			<tr>
				<th colspan="2">나쁨</th>
			</tr>
			<c:forEach begin="${resultList.size()-10}" end="${resultList.size()}" items="${resultList}" var="rList">
			<tr>
				<td>${rList.tob}<br></td>
				<td>
				<c:choose>
					<c:when test="${rList.grade == 1}">
						<img class="dots" src="${pageContext.request.contextPath}/img/gold_coin.gif"> ${rList.grade}등급
					</c:when>
					
					<c:when test="${rList.grade == 2}">
						<img class="dots" src="${pageContext.request.contextPath}/img/silver_coin.gif"> ${rList.grade}등급
					</c:when>
					
					<c:when test="${rList.grade == 3}">
						<img class="dots" src="${pageContext.request.contextPath}/img/copper_coin.gif"> ${rList.grade}등급
					</c:when>
				</c:choose>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	
	<hr class="border-primary">
	
	<div id="result1">
		<div class="eLeft mt-2 pt-1">
			<h6 class="font-weight-bold">분석결과</h6>
		</div>
		
		<div class="eRight">
			<ul>
				<li>
					선택하신 입지는 <c:forEach begin="0" end="2" items="${resultList}" var="rList"><strong class="best">'${rList.tob}'&nbsp;</strong></c:forEach>업종의 평가등급이 <strong class="best">높게</strong> 나타납니다<br>
				</li>
				<li>
					선택하신 입지는 <c:forEach begin="${resultList.size()-3}" end="${resultList.size()}" items="${resultList}" var="rList"><strong class="worst">'${rList.tob}'&nbsp;</strong></c:forEach>업종의 평가등급이 <strong class="worst">낮게</strong> 나타납니다<br>
				</li>
			</ul>
		</div>
	</div>
	
	<hr class="border-primary"><br>
	
	<div id="subject3">
		<h5 class="figure font-weight-bold text-info text-left">3. 잠재고객분석</h5>
		<table class="table table-bordered dataTable dataTable mt-2" id="population">
			<thead>
				<tr>
					<th>유동인구</th>
					<th>주거인구</th>
					<th>직장인구</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><fmt:formatNumber value="${move}" pattern="#,###"/>명</td>
					<td><fmt:formatNumber value="${live}" pattern="#,###"/>명</td>
					<td><fmt:formatNumber value="${job}" pattern="#,###"/>명</td>
				</tr>
			</tbody>
		</table>							
	</div>
	
	<hr class="border-primary">
	
	<div id="result2">
		<div class="eLeft">
			<h6 class="font-weight-bold">분석결과</h6>
		</div>
		
		<div class="eRight">
			<ul>
				<li>
					잠재고객이 될 가능성이 가장 <strong class="best">큰</strong> 유형은 <strong class="best">'${result}'</strong> 입니다
				</li>
			</ul>
		</div>
	</div>
	
	<hr class="border-primary">
	<div class="card col-12 p-0" id="info2">
		<div class="card-header">
			<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-info-circle"></i> 도움말</h6>
		</div>
		<div class="card-body">
			<p>
				- 유동인구는 통신사 휴대전화 통화량을 바탕으로 대전지역 행정동 단위의 해당월 평균 유동인구수를 추정한 데이터입니다
			</p>
		</div>
	</div>
</div>
<br><br><br><br><br>
