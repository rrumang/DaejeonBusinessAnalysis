<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9e96d9b8ca5bed0ac8c0a0ebf8487a10&libraries=drawing,services"></script>

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
	#staticMap{
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
	h2{
		display: inline-block;
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
	#bronze{
		background-color : #AE5E1A;
		color : white;
	}
	#sTob:hover{
		cursor: pointer;
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

<script>
	$(document).ready(function(){
		mapSetting();
		
		$("#sTob").on("click", function(){
			var regionCd = "${regionVo.region_cd}";
			$("#region_cd").val(regionCd);
			
 			$("#form2").submit();
		})
		
		// 엑셀 다운로드
		$("#edn").on("click", function(){
			$("#excel").submit();
		})
		
	}) // document ready 끝
	
	function mapSetting(){
		var MapContainer  = document.getElementById('map'),
		   MapOption = { 
		       center: new kakao.maps.LatLng(33.450701, 126.570667), // 이미지 지도의 중심좌표
		       level: 3 // 이미지 지도의 확대 레벨
		   };
		// 이미지 지도를 표시할 div와 옵션으로 이미지 지도를 생성합니다
		var map = new kakao.maps.Map(MapContainer, MapOption);
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		var region_csc = '${regionVo.region_csc}';
		
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

		        // 이미지 지도에서 마커가 표시될 위치입니다 
				var markerPosition  = new kakao.maps.LatLng(lat, lng); 
				
				// 이미지 지도에 표시할 마커입니다
				// 이미지 지도에 표시할 마커는 Object 형태입니다
				var marker = {
				    position: markerPosition
				};
				
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
	
	// PDF 저장
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
        
        doc.save('tobRecom 1page.pdf');
        console.log('Reached here?');
      });
    }
	
	function fnMove(seq){
		var offset = $("#subject" + seq).offset();
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
						<li class="active"><a href="#" id="lAppr">종합 입지평가</a></li>
						<li class=""><a href="#" id="sTob">상권적합도 우수업종</a></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="my-3">
			<span onclick="fnMove('1')" class="fnMove">1. 종합 입지등급</span>&nbsp;
			<span onclick="fnMove('2')" class="fnMove">2. 업종별 입지등급</span>&nbsp;
				
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
		<h5 class="font-weight-bold text-info text-left">분석 설정 정보</h5>
		<table class="table table-bordered dataTable dataTable" id="anaInfo">
			<thead>
				<tr role="row">
					<th style="width: 20%">분석지역</th>
					<th style="width: 20%">기준데이터시점</th>
				</tr>
			</thead>
			<tbody>
				<tr role="row">
					<td>${selectAddr}</td>
					<td>${stData}</td>
				</tr>
			</tbody>
		</table>
	</div>
	<br>

	<div id="subject1">
		<h5 class="font-weight-bold text-info text-left">1. 종합 입지등급</h5>
		<!-- 동적으로 장소를 찍어주기 위한 용도의 맵 -->
        <div id="map" class="mt-2 mb-3" style="display:none;"></div>
        <!-- 화면에 정적 이미지 지도를 출력 -->
        <div id="staticMap" class="mt-2 mb-3"></div>
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
			종합입지등급 : 선택입지에 대한 43개 표준업종 입지등급의 평균 음식,소매, 서비스업 등 표본업종별 입지의 가치(예상매출액)를<br>
			평가한 등급으로 1등급에 가까울수록 좋은 입지임을 의미합니다<br>
			[예시]전체 43개 입지등급 중 선택지역이 1등급인 표본업종의 수가 30개, 2등급인 업종이 10개, 4등급인 업종이 5개인 경우,<br>
			{(1*30) + (2*10) + (4*5)} / 45 = 1.6 → 산술평균을 반올림한 값을 이용, 종합 2등급으로 표시합니다.<br><br>
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
	
	<form id="form2" action="${pageContext.request.contextPath}/tobRecom/superbTob" method="post">
		<input type="hidden" id="region_cd" name="region_cd" />
		<input type="hidden" id="report_cd" name="report_cd" value="${report_cd}">
	</form>
	
	<form action="${pageContext.request.contextPath}/tobRecom/excel" id="excel" method="get">
		<input type="hidden" id="report_cd" name="report_cd" value="${report_cd}">
	</form>
</div>
