<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
.box-center {
	margin: 0px auto;
}

.w-30 {
	width: 30% !important;
}
.w-70{
	width: 70% !important;
}
.w-49{
	width: 49% !important;
}

.pl-32{
	padding-left : 32%;
}

.ml-38{
	margin-left : 40% !important;
}

a:hover{
	text-decoration: none;
}

#popup{
	border : 1px solid black;
	position: absolute;
	z-index: 99999;
	width: 900px;
	height : auto;
	background-color: #ffffff;
	border-radius : 5px;
}

#popup h3{
	padding : 15px 15px;
	margin : 0px;
	border-bottom: 1px solid black;
}

.category-tab{
	list-style : none;
}

.category-tab.depth-1{
	background-color: #66a3ff;
	padding : 4px 4px 0 4px;
	overflow : auto;	
}

.category-tab > li{
	float : left;
	position ; relative;
	display : block;
/* 	width:100px; */
/* 	align-content: center; */
	text-align : center;
	height: 50px;
}

.category-tab > li > a{
	color : #fff;
	postion: relative;
	display:block;
	letter-spacing : -1px;
	font-weight : 400;
}

.category-tab.depth-1 > li > a{
	font-size: 19px;
	margin: 1.8px 10px 0px 10px;
	padding : 10px 14px 10.5px 14px;
}
.category-tab.depth-1 > li.active > a{
	color : #66a3ff;
	background-color: #fff;
	border-bottom: 0px solid #fff;

}

.categorylist {clear:both; margin:15px 0; padding:0; height:350px; overflow-y:auto; overflow-x:hidden;}
.categorylist ul { padding:0 0 0 10px; margin:0;}
.categorylist ul li {list-style-type:none; width:100%; overflow:auto; overflow:hidden; height:auto; color:#0088e8; font-size:18px; text-align:left; font-weight:700; background:#fff url(../img/blt02.png) no-repeat 0 23px; padding:15px 0 22px 10px; border-bottom:1px solid #ddd;}
.categorylist ul li:first-child {background:#fff url(../img/blt02.png) no-repeat 0 13px; padding:5px 0 25px 12px; }
.categorylist ul li:last-child {border-bottom:0;}
.categorylist ul li ul {margin:0; padding:0;}
.categorylist ul li ul li {padding:3px 0; height:27px; background-image:none; color:#24282c; width:25%; float:left !important; font-size:16px; border-bottom:0;}
.categorylist ul li ul li:first-child {background:none; padding:3px 0;}

.custom-select{
	font-size : 1.1em;
}

</style>

<!-- kakao map 등록 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9e96d9b8ca5bed0ac8c0a0ebf8487a10&libraries=services"></script>

<script>
$(document).ready(function() {

	/* 
		카카오 맵 초기화 및 셋팅 하는 구간
	*/
	imageSrc = '${pageContext.request.contextPath}/img/map-marker.png',
	imageSize = new kakao.maps.Size(50, 55); // 마커이미지의 크기입니다
	
	markers = [];
	
	var container = document.getElementById('map');

	var mapOptions = {
		// 페이지 호출 시 처음으로 보여줄 좌표 설정
		center : new kakao.maps.LatLng(36.323329,
				127.411299),
		level : 3
	};

	map = new kakao.maps.Map(container, mapOptions);

	// 주소-좌표 변환 객체를 생성합니다
	geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	// 초기화면 지도 api의 default가 될 주소 셋팅
	geocoder.addressSearch('대전광역시 중구 대흥동 500-5',function(result, status) {

		// 정상적으로 검색이 완료됐으면 
		if (status === kakao.maps.services.Status.OK) {

			var coords = new kakao.maps.LatLng(
					result[0].y,
					result[0].x);
			
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
			
			// 결과값으로 받은 위치를 마커로 표시합니다
			var marker = new kakao.maps.Marker(
					{
						map : map,
						position : coords,
						image: markerImage
					});
			markers.push(marker);
			
			// 인포윈도우로 장소에 대한 설명을 표시합니다
			var infowindow = new kakao.maps.InfoWindow(
					{
						content : '<div class="iWindow" style="width:150px;text-align:center;padding:6px 0;">대덕인재개발원</div>'
					});
			infowindow.open(map, marker);

			// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			map.setCenter(coords);
		}
	});

	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new kakao.maps.MapTypeControl();

	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	map.addControl(mapTypeControl,
			kakao.maps.ControlPosition.TOPRIGHT);

	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl,
			kakao.maps.ControlPosition.RIGHT);

	
	// 분석보고서 요청시 사용자가 선택한 업종이 분석 지역내에서 존재하지 않을때 출력할 메시지
	<c:if test="${info_msg ne null}">
		swal("","${info_msg}","warning");
	</c:if>
	
//================================================================================

	/* 상권분석 정보입력 페이지의 동작 기능을 정의하는 구간 */
	
	// 화면 최초 요청시  시군구 박스와 동 박스에 초기화
	dongListLookUp( $("#guBox").val() );
	
	// 회원의 관심지역 값이 담길 변수
	mem_regionCd = ${MEMBER_INFO.region_cd eq null ? 0 : MEMBER_INFO.region_cd};
	mem_tobCd = '${MEMBER_INFO.tob_cd eq null ? '': MEMBER_INFO.tob_cd}';
	
	// 관심 지역 및 관심 업종을 설정한 사용자일 경우 초기 설정값을 관심지역 및 업종으로 셋팅
	if(mem_regionCd != 0){
		console.log("관심 지역이 있는 회원");
		var gu_cd = Math.floor(mem_regionCd / 100000);
		console.log(gu_cd);

		$("#guBox").val(gu_cd);
		

		dongListLookUp(gu_cd, mem_regionCd);
	}
	
	if(mem_tobCd != ''){
		upName = $(".add-contrast[value='"+mem_tobCd+"']").data("upnm");
		$("#upjongBox").val(upName);
		$("#upjongBox").attr("data-cd", mem_tobCd);
	}
	
	
	// 사용자가 구를 선택하면 해당 구의 동 리스트를 조회
	$("#guBox").on("change", function(){
		var region_cd2 = $(this).val();
		console.log(region_cd2);
		dongListLookUp(region_cd2,0);
	})

	// dong별 Select박스를 변경했을 때
	$("#dongBox").on("change", function(){
		var addr = $(this).children("option:selected").data("csc");
		var dong = $(this).children("option:selected").text();
		console.log(addr);
		console.log(dong);
		
		hideMarkers(null);
		$(".iWindow").parent().parent().remove();
		searchAddr(addr, dong);
	})
	
	// 업종 팝업창 출력하기
	$("#upjongBox").on("click", function(){
		$("#popup").attr("style", "top: 0px; left:200px; display:block;");
	})
	
	// 업종 팝업창 숨기기
	$("#hidePopup").on("click", function(){
		$("#popup").attr("style", "top: 0px; left:200px; display:none;");
	})
	
	// 업종 선택 시 체크버튼을 2개 이상 선택 못하게 막는 function
	$("input:radio").on("click",function(){
		var code = $("input:radio:checked").eq(0).parents(".mid-category").data("cd2");
		var code2 = $("input:radio:checked").eq(1).parents(".mid-category").data("cd2");
		console.log(code);
		console.log(code2);
		if( $("input:radio:checked").parents(".mid-category").length > 1 && code != code2){
			console.log("부모가다름");
			$("input:radio:checked").prop("checked",false);
			$(this).prop("checked", true);
		}
	})
	
	// 업종 선택 후 확인 버튼을 클릭했을때
	$('#choiceBtn').on("click", function(){
		var selectedUpjong = $("input:radio:checked");
		$("#upjongBox").val(selectedUpjong.data("upnm"));
		$("#upjongBox").data("cd", selectedUpjong.val());
		$("#popup").attr("style", "top: 0px; left:200px; display:none;");
	})
	
	
	$("#analysisBtn").on("click", function(){
		var region_cd = $("#dongBox").val();
		var tob_cd = $("#upjongBox").data("cd");
		
		if(region_cd == null){
			swal("","분석지역을 선택하여 주십시오.","warning");
			return;
		}
		if(tob_cd == ''){
			swal("","분석업종을 선택하여 주십시오.","warning");
			return;
		}
		console.log(region_cd);
		console.log(tob_cd);
		$("#inputRegion").val(region_cd);
		$("#inputTob").val(tob_cd);
		$("#analysisFrm").submit();
	})
	
	// 업종 정보 입력화면에서 초기화버튼을 클릭했을때
	$("#resetBtn").on("click",function(){
		$("#upjongBox").val('');
		$("#upjongBox").data('cd', '');
		$("#guBox").val('');
		$("#dongBox").val('');
	})
	
})

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

// 동 리스트를 ajax로 호출하는 function() 
function dongListLookUp(region_cd2, region_cd){
	
	// 동 리스트 가져오기
	$.ajax({
		url : "${pageContext.request.contextPath}/bdAnalysis/dongListLookUp"
	   ,data : "region_cd2=" + region_cd2
	   ,dataType : "json"
	   ,method : "get"
	   ,success : function(data){
		   console.log(data);
		  
		   var list = $('#dongBox > option');
		   
		   console.log(list);
		   for(var i=0; i < list.length; i++){
			   list[i].remove();
		   }			

		   var dongList = data.dongList;
		   var html = "";
		   $.each(dongList, function(idx, dong){
			   html += "<option class=\"dropdown-item\" id=\""+ dong.region_cd + "\" value=\""+ dong.region_cd +"\" data-csc=\""+dong.region_csc+"\">"+ dong.region_name + "</option>";

		   })
		   
		   console.log(html);
		   $('#dongBox').append(html);
	   },
	   complete: function() {
			console.log("통신 완료..");
			//통신이 완료된 후 처리
			if(region_cd != 0){
				
				$("#dongBox").val(region_cd);
				var addr = $("#dongBox").children("option:selected").data("csc");
				var dong = $("#dongBox").children("option:selected").text();
				hideMarkers();
				$(".iWindow").parent().parent().remove();
				
				console.log(addr);
				console.log(dong);
				searchAddr(addr, dong);
			}
	   }
	   ,fail : function(err){
		   console.log(err);
	   }
	})
}

function searchAddr(addr, dong){
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(addr, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords,
	            image : markerImage
	        });
	        
	        markers.push(marker);
	        
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div class="iWindow" style="width:150px;text-align:center;padding:6px 0;">'+ dong +'</div>'
	        });
	        infowindow.open(map, marker);
	        
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});  
}

function menuClick(e){
	$('.category-tab.depth-1 li').removeAttr('class');
	var tob_cd = e.getAttribute('data-code');
	console.log(tob_cd);
	e.parentElement.setAttribute('class', 'active');
	$('.tab-pane').attr('class', 'tab-pane');
	$('#category-'+ tob_cd +'').attr('class', 'tab-pane active');
	console.log('#category-'+ tob_cd);
}
</script>
<div class="box-center col-lg-10 mt-5 pt-4">
	<div class="col-lg-9 w-30 float-left">

		<div class="card shadow mb-4">

			<div>
				<div class="mb-4 pt-3 border-bottom-info">
					<div class="card-body">
						<h3 class="font-weight-bold text-primary text-center">상&nbsp;권&nbsp;분&nbsp;석</h3>
					</div>
				</div>
			</div>

			<div class="container">
				<h5 class="font-weight-normal text-black text-wrap">1.&nbsp;지역선택</h5>

				<div class="card-body mt-3">
					<select class="custom-select w-49 nav-item dropdown show" id="guBox">
						<c:forEach items="${guList }" var="gu">
						<option class="dropdown-item" value="${gu.region_cd }"
						<c:if test="${fn:substring(LOGIN_INFO.region_cd,0,5) eq gu.region_cd}">selected</c:if> >${gu.region_name }</option>						
						</c:forEach>
					</select> 
					
					<select class="custom-select w-49" id="dongBox">
					</select>
				</div>

				<hr>

				<h5 class="font-weight-normal text-black text-wrap">2.&nbsp;업종선택</h5>

				<div class="card-body mt-3">
					<input type="text" id="upjongBox" data-cd="" class="custom-select w-100 px-1 py-1" readonly/>
				</div>
				
				<!-- 업종 팝업 창 -->
				<div id="popup" style="display:none;"> 
					
					<!-- 업종박스 헤더 -->
					<h3 class="text-dark text-center">업종&nbsp;선택</h3>
					
					
					<!-- 대분류 업종 네비게이션 박스 -->
					<ul class="category-tab depth-1">
						<c:forEach items="${TopTobList }" var="topName" varStatus="status">
							<c:choose>
								<c:when test="${status.count eq 1}">
									<li class="active">
										<a href="#" data-code="${topName.tob_cd }" onclick="menuClick(this)">${topName.tob_name }</a>
									</li>								
								</c:when>
								<c:otherwise>
									<li>
										<a href="#" data-code="${topName.tob_cd }" onclick="menuClick(this)">${topName.tob_name }</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</ul>
					
					<!-- 업종 박스 body -->
					<!-- 업종 리스트 박스 -->
					<div class="tab-content">
					
						<c:forEach items="${TopTobList}" var="top" varStatus="status">
							<div <c:if test="${status.count eq 1}">class="tab-pane active"</c:if>
							class="tab-pane" id="category-${top.tob_cd}"> <!-- 업종 카테고리 출력 여부를 결정하는 박스 -->
								<div class="categorylist" id="${top.tob_cd}"><!-- 업종카테고리(대분류) 구분 중분류 리스트를 감쌀 박스-->
			             			<ul>										    
			             				<c:forEach items="${MidTobList }" var="mid">
				             				<c:if test="${mid.tob_cd2 eq top.tob_cd }">
				             				<li class="mid-category" data-cd2="${mid.tob_cd }">
				             				 ${mid.tob_name }
				             					<ul>
				             						<c:forEach items="${BotTobList}" var="bot">
				             							<c:if test="${bot.tob_cd2 eq mid.tob_cd}">
					             						<li>
						             						<label class="control checkbox">
						             							<input type="radio" class="add-contrast" name="${mid.tob_cd }"
						             								value="${bot.tob_cd }" data-upnm="${bot.tob_name }" data-click="">
						             							<span class="control-indicator"></span>
						             							${bot.tob_name}
						             						</label>
					             						</li>
					             						</c:if>
				             						</c:forEach>
				             					</ul>
				             				</li>
				             				</c:if>
			             				</c:forEach>
			             			</ul>
			             		</div>
							</div>
						
						</c:forEach>
						
					</div>	<!-- 업종 박스 body end.. -->
					
					<hr>
					
					<div class="card-body mt-0">
						<a href="#" id="choiceBtn" class="btn btn-primary my-2 ml-38">
							<span class="text">선택</span>
						</a>
							
						<a href="#" id="hidePopup" class="btn btn-secondary mx-3 my-2">
							<span class="text">취소</span>
						</a>
					</div>	

				</div> <!-- 업종 팝업 창 end -->
	
				<hr>
				
				<div>
					<div class="card-body mt-0 text-center">
						<a href="#" class="btn btn-primary mx-3 my-2">
							<span class="text" id="analysisBtn">분석하기</span>
						</a>
							
						<a href="#" class="btn btn-secondary mx-3 my-2">
							<span class="text" id="resetBtn">초기화</span>
						</a>
					</div>
				
				</div>
				
				<form id="analysisFrm" action="${pageContext.request.contextPath }/bdAnalysis/analysis"
					  method="post">
					<input type="hidden" id="inputRegion" name="region_cd"/>
					<input type="hidden" id="inputTob" name="tob_cd"/>
				</form>	
				
			</div>
				
		</div>

	</div>

	<!-- kakao map -->
	<div class="float-right figure w-70" id="map" style="width: 400px; height: 507px;"></div>

</div>