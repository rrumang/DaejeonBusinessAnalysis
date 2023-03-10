<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 카카오 맵 api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9e96d9b8ca5bed0ac8c0a0ebf8487a10&libraries=drawing,services,clusterer"></script>
	
<style>
.modes {position: absolute;top: 20px;left: 20px;z-index: 1;}
#eH4 {
    display: inline-block;
    color: black;
}
.border-black{
	border : 1.25px solid black;
}
.parent:after { 
	content: ""; 
	display:block; 
	clear:both; 
}
.w-30 {width: 30% !important;}
#resultBox{ display: none; }
#loadingIcon{ 
    position: absolute;
    top: 40%;
}
</style>

<script>
$(document).ready(function(){

	// db에서 select한 상가리스트의 상가명과,상가좌표가 담길 객체들이 담겨질 배열변수
	positions = [];
	
	infos = new Array();
	// marker객체들이 담길 배열
	markers = [];
	
	// 지도 주소 검색시 사용할 marker객체들의 배열
	markings = [];
	
	// 화면 최초 요청시  시군구 박스와 동 박스에 초기화
	dongListLookUp( $("#guBox").val() );
	// 카카오 map을 셋팅
	mapSetting();
	
	
	// 사용자가 구를 선택하면 해당 구의 동 리스트를 조회
	$("#guBox").on("change", function(){
		var region_cd2 = $(this).val();
		console.log(region_cd2);
		dongListLookUp(region_cd2);
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
	
	
	$("#requestResult").on("click",function(){
		
		// 테이블 감추기
		$("#resultBox").hide();
		
		// 도형의 data 추출
		var datas = manager.getData();
		
		// 로딩화면 box
		var loading = '<div id="loading"';
		loading += 'style="position:absolute;width: 100%;height: 100%;background:  #fff; opacity: 0.8;';
		loading += 'z-index: 9999;vertical-align: middle;text-align: center;">';
		loading += '<img id="loadingIcon" src="${pageContext.request.contextPath }/img/ajax-로딩4.gif"/>';
		loading += '</div>';
		
		if(datas.polygon.length > 0){
			positions = [];
			markers = [];
			clusterer.clear();
			
			var points  = datas.polygon[0].points;
			console.log(points)
			
			var points = JSON.stringify(points);
			$.ajax({
				url : "${pageContext.request.contextPath}/bdPrsct/getStoreList",
				method : "post",
				data : points,
				traditional : true,
				contentType: "application/json",
				dataType : "json",
				beforeSend: function() {
					console.log("통신 시작..");
					//통신을 시작할때 처리
					$('#wrapper').append(loading);
				},
				success : function(data){
					console.log(data);

					$.each(data, function(idx, vo){

						var info = {
							st_name : vo.store_name,
							tob_name : vo.tob_name
						}
						
						var marker = new kakao.maps.Marker({
				    		map: map,
				    		position: new kakao.maps.LatLng(vo.store_lon,vo.store_lat),
				    		title : vo.store_cd,
				    		image: markerImage
				    	})
						
						// 상가 코드값을 키값으로 가지는 배열에 해당 상가정보가 담긴 info객체를 저장
						infos[vo.store_cd] = info;
						
						// 단일 마커에 인포윈도우를 보여주기 위한 이벤트 등록
					 	kakao.maps.event.addListener(marker, 'click', function(){
						 	// 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
							var iwContent = "<div style='padding:8px; width:650px; height: 250px; overflow:auto;'>";
							iwContent += "<div class='text-center border-bottom border-dark parent mb-1 p-1'>";
							iwContent += "<span class='close' onclick='closeOverlay()' title='닫기'>X</span>";
							iwContent += "</div>";
							
							iwContent += "<table class='table table-bordered border-dark'>";
							iwContent += "<thead class='bg-gray-200'>";
							iwContent += "<tr><th colspan='2' class='text-center'>업종 목록</th></tr>"
							iwContent += "<tr class='text-center'><th>상가명</th><th>업종</th></tr>";
							iwContent += "</thead>";
							iwContent += "<tbody>";
							iwContent += "<tr class='text-center'>"
							iwContent += "<td>"+ infos[marker.getTitle()].st_name +"</td>"
							iwContent += "<td>"+ infos[marker.getTitle()].tob_name +"</td>";
							iwContent += "</tr>";
							iwContent += "</tbody>";
							iwContent += "</table>";
							iwContent += "</div>";
							
							
							infowindow.setContent(iwContent);
					     
					        // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
					        infowindow.open(map, marker);
					 	});
						
						// 마커들을 저장할 배열에 마커 1개씩 추가
				    	markers.push(marker);
					})
				  
					// 클러스터러에 마커들을 추가
			        clusterer.addMarkers(markers);
					
					// 상가의 업소분류별 통계를 조회
					$.ajax({
						url : "${pageContext.request.contextPath}/bdPrsct/getStoreCnt_Polygon",
						method : "post",
						data : points,
						traditional : true,
						contentType: "application/json",
						dataType : "json",
						success : function(cntList){
							console.log(cntList);
							
							$("#resBody").empty();
							
							var res = '';
							
							$.each(cntList, function(idx, vo){
								res += "<tr>";
								res += "<td>"+vo.top_name +"</td>";
								res += "<td>"+vo.mid_name +"</td>";
								res += "<td>"+vo.bot_name +"</td>";
								res += "<td>"+vo.cnt +"</td>";
								res += "<tr>";
							})
							
							$("#resBody").append(res);
						},
						complete: function() {
							console.log("통신 완료..");
						    //통신이 완료된 후 처리
							$('#loading').remove();
						},
						fail:function(error){
							console.log(error);
						}
					})
					
				},
				fail:function(err){
					console.log(err);
				}
				
			})
		}
		
		if(datas.circle.length > 0){
			positions = [];
			markers = [];
			clusterer.clear();
			
			var data  = datas.circle[0];
			
			data_cl = JSON.stringify(data);
			
			$.ajax({
				url : "${pageContext.request.contextPath}/bdPrsct/getStoreList_Circle",
				method : "post",
				data : data_cl,
				contentType: "application/json",
				dataType : "json",
				beforeSend: function() {
					//통신을 시작할때 처리
					console.log("통신 시작..");
					//통신을 시작할때 처리
					$('#wrapper').append(loading);
				},
				success : function(data){
					console.log(data);
					
					$.each(data, function(idx, vo){
						
						var info = {
							st_name : vo.store_name,
							tob_name : vo.tob_name
						}
						
						var marker = new kakao.maps.Marker({
				    		map: map,
				    		position: new kakao.maps.LatLng(vo.store_lon,vo.store_lat),
				    		title : vo.store_cd,
				    		image: markerImage
				    	})
						// 상가 코드값을 키값으로 가지는 배열에 해당 상가정보가 담긴 info객체를 저장
						infos[vo.store_cd] = info;
						
						
						// 단일 마커에 인포윈도우를 보여주기 위한 이벤트 등록
					 	kakao.maps.event.addListener(marker, 'click', function(){
						 	// 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
							var iwContent = "<div style='padding:8px; width:650px; height: 250px; overflow:auto;'>";
							iwContent += "<div class='text-center border-bottom border-dark parent mb-1 p-1'>";
							iwContent += "<span class='close' onclick='closeOverlay()' title='닫기'>X</span>";
							iwContent += "</div>";
							
							iwContent += "<table class='table table-bordered border-dark'>";
							iwContent += "<thead class='bg-gray-200'>";
							iwContent += "<tr><th colspan='2' class='text-center'>업종 목록</th></tr>"
							iwContent += "<tr class='text-center'><th>상가명</th><th>업종</th></tr>";
							iwContent += "</thead>";
							iwContent += "<tbody>";
							iwContent += "<tr class='text-center'>"
							iwContent += "<td>"+ infos[marker.getTitle()].st_name +"</td>"
							iwContent += "<td>"+ infos[marker.getTitle()].tob_name +"</td>";
							iwContent += "</tr>"
							iwContent += "</tbody>";
							iwContent += "</table>";
							iwContent += "</div>";
							
							infowindow.setContent(iwContent);
					     
					        // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
					        infowindow.open(map, marker);
					 	});
						
						// 마커들을 저장할 배열에 마커 1개씩 추가
				    	markers.push(marker);
					})
				    	
					
			    	// 클러스터러에 마커들을 추가
			        clusterer.addMarkers(markers);
			  
					// 상가의 업소분류별 통계를 조회
					$.ajax({
						url : "${pageContext.request.contextPath}/bdPrsct/getStoreCnt_Circle",
						method : "post",
						data : data_cl,
						contentType: "application/json",
						dataType : "json",
						success : function(cntList){
							console.log(cntList);
							
							$("#resBody").empty();
							var res = '';
							
							$.each(cntList, function(idx, vo){
								res += "<tr>";
								res += "<td>"+vo.top_name +"</td>";
								res += "<td>"+vo.mid_name +"</td>";
								res += "<td>"+vo.bot_name +"</td>";
								res += "<td>"+vo.cnt +"</td>";
								res += "<tr>";
							})
							
							$("#resBody").append(res);
						},
						complete: function() {
							console.log('통신완료 ');
						    //통신이 완료된 후 처리
							$('#loading').remove();
						},
						fail: function(error){
							console.log(error);
						}
					})
					
				},
				fail:function(err){
					console.log(err);
				}
			})
			
		}
		
		
		if(datas.circle.length == 0 && datas.polygon.length == 0){
			swal("","조사할 영역을 설정하여 주십시오.","warning");
			return;
		}
		
	})
	
	
	// 현황보기 버튼 클릭시
	$('#showTableBtn').on('click', function(){
		var leng = $("#resBody").children().length;
		if(leng == 0){
			swal("","조사한 데이터가 없습니다.","warning");
			return;
		}
		$('#resultBox').show();
	})
	
	
})

function mapSetting(){
	var container = document.getElementById('map');

	// 마커 이미지 셋팅
	var imageSrc = '${pageContext.request.contextPath}/img/map-marker.png';
	var imageSize = new kakao.maps.Size(50, 55); // 마커이미지의 크기입니다
    markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
	
	// 페이지 호출 시 처음으로 보여줄 좌표 설정(대덕인재개발원)
	var center = new kakao.maps.LatLng(36.324847, 127.419938);

	var mapOptions = {
		// 좌표 정보 매핑
		center : center,
		level : 3
	};
	
	map = new kakao.maps.Map(container, mapOptions);
	
	// 결과값으로 받은 위치를 마커로 표시합니다
	var marker = new kakao.maps.Marker({
		map : map,
		position : center,
		image: markerImage
	});
	markings.push(marker);
	
	startIw = new kakao.maps.InfoWindow({
        content: '<div class="iWindow" style="width:150px;text-align:center;padding:6px 0;">대덕인재개발원</div>'
    });

	// 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
    startIw.open(map, markings[0]);
	
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
	
	var options = { // Drawing Manager를 생성할 때 사용할 옵션입니다
	    map: map, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
	    drawingMode: [ // Drawing Manager로 제공할 그리기 요소 모드입니다
	        kakao.maps.drawing.OverlayType.RECTANGLE,
	        kakao.maps.drawing.OverlayType.CIRCLE,
	        kakao.maps.drawing.OverlayType.POLYGON
	    ],
	    // 사용자에게 제공할 그리기 가이드 툴팁입니다
	    // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
	    guideTooltip: ['draw', 'drag', 'edit'], 
	    circleOptions: {
	        draggable: false,
	        removable: false,
	        editable: false,
	        strokeColor: '#33cc33',
	        fillColor: '#aaff80',
	        fillOpacity: 0.5
	    },
	    polygonOptions: {
	        draggable: false,
	        removable: false,
	        editable: false,
	        strokeColor: '#33cc33',
	        fillColor: '#aaff80',
	        fillOpacity: 0.5,
	        hintStrokeStyle: 'dash',
	        hintStrokeOpacity: 0.5
	    }
	};
	
	// 마커 클러스터러를 생성합니다 
    clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 1, // 클러스터 할 최소 지도 레벨 
        disableClickZoom : true
    });
 
	
	// 위에 작성한 옵션으로 Drawing Manager를 생성합니다
	manager = new kakao.maps.drawing.DrawingManager(options);
	
	// 다각형 그리기 시 점의 좌표가 저장될 배열
	path = [];
	
	// drawing객체를 그리기 시작 했을 때 발생하는 이벤트 등록
	manager.addListener('drawstart', function(data) {
		var overlays = manager.getOverlays();
		
	    if( overlays.circle.length > 0 || overlays.rectangle.length > 0
	    		|| overlays.polygon.length > 0){
	    	
	    	alert("영역 선택은 1개만 가능합니다.");
	    	manager.cancel();
	    	return;		
	 	} else{
	 		if(data.overlayType == "polygon"){
	 			path.push(data.point);
								
	 		}
	 	}
	    
	});

	// drawing객체를 그리기 시작 후 그리는 중인 상태일 때 발생하는 이벤트 등록
	manager.addListener('drawnext', function(data) {

		if(data.overlayType == "polygon"){
	    	path.push(data.point);
	    }
	    
	});
	
	// drawing객체를 그리기를 마쳤을 때 발생하는 이벤트 등록
	manager.addListener('drawend', function(mouseEvent) {
	   if(mouseEvent.overlayType == "polygon"){
		  	console.log(path)
			if(path.length < 3){
				swal("","다각형은 반드시 점을 3개 이상 찍어줘야합니다.","warning");
				path = [];
				manager.clear();
			}		   
		   
	   }
	   
	});
	
	
	// 인포윈도우를 생성합니다
    infowindow = new kakao.maps.InfoWindow({
    });
	
	// Clusterer에 마우스 over이벤트 등록
	kakao.maps.event.addListener( clusterer, 'clusterclick', function( cluster ) {
	    console.log(cluster.getMarkers());
        var getMarkers = cluster.getMarkers(); 
        
    	 // 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
		var iwContent = "<div style='padding:8px; width:650px; height: 250px; overflow:auto;'>";
		iwContent += "<div class='text-center border-bottom border-dark parent mb-1 p-1'>";
		iwContent += "<span class='close' onclick='closeOverlay()' title='닫기'>X</span>";
		iwContent += "</div>";
		
		iwContent += "<table class='table table-bordered border-dark'>";
		iwContent += "<thead class='bg-gray-200'>";
		iwContent += "<tr><th colspan='2' class='text-center'>업종 목록</th></tr>"
		iwContent += "<tr class='text-center'><th>상가명</th><th>업종</th></tr>";
		iwContent += "</thead>";
		iwContent += "<tbody>";
		for(var i=0; i < getMarkers.length; i++){
			iwContent += "<tr class='text-center'>"
			iwContent += "<td>"+ infos[getMarkers[i].getTitle()].st_name +"</td>"
			iwContent += "<td>"+ infos[getMarkers[i].getTitle()].tob_name +"</td>";
			iwContent += "</tr>"
		}
		iwContent += "</tbody>";
		iwContent += "</table>"
		iwContent += "</div>";
		
		
		infowindow.setContent(iwContent);
     
        // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
        infowindow.open(map, getMarkers[0]);
        
	});
	
}

/* 카카오 map api에 적용할 function 모음 */
function searchAddr(addr, dong){
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(addr, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	    	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords,
	    		image: markerImage
	        });
	        
	        markings.push(marker);
	        
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

//배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수입니다
function setMarkers(map) {
    for (var i = 0; i < markings.length; i++) {
        markings[i].setMap(map);
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

//버튼 클릭 시 호출되는 핸들러 입니다
function selectOverlay(type) {
    // 그리기 중이면 그리기를 취소합니다
    manager.cancel();
	manager.clear();
	
	clearMapAndData();
	
    // 클릭한 그리기 요소 타입을 선택합니다
    manager.select(kakao.maps.drawing.OverlayType[type]);
}

function clearMapAndData(){
	manager.clear();
	for(var i=0; i < markers.length; i++){
		markers[i].setMap(null);
	}
	path = [];
	markers = [];
	clusterer.clear();
}

//선과 다각형의 꼭지점 정보를 kakao.maps.LatLng객체로 생성하고 배열로 반환하는 함수입니다 
function pointsToPath(points) {
    var len = points.length, 
        path = [], 
        i = 0;

    for (; i < len; i++) { 
        var latlng = new kakao.maps.LatLng(points[i].y, points[i].x);
        path.push(latlng); 
    }

    return path;
}

// Drawing매니저 명령 뒤로가기 버튼
function undo(){
	path = [];
	manager.undo();
}

// infoWindow창 닫기
function closeOverlay(){
	infowindow.close();
}

//동 리스트를 ajax로 호출하는 function() 
function dongListLookUp(region_cd2){
	
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
			   html += "<option id=\""+ dong.region_cd + "\" value=\""+ dong.region_cd +"\" data-csc=\""+dong.region_csc+"\">"+ dong.region_name + "</option>";
		   })
		   
		   console.log(html);
		   $('#dongBox').append(html);
	   }
	   ,fail : function(err){
		   console.log(err);
	   }
	})
}

</script>

<div class="container">

	
	
	<div class="page-header">
		<h2 id="eH4" class="font-weight-bold text-left mt-3">상권조사</h2>  
	</div>
	
	<!-- contents 영역 -->
	<div class="py-2"> 
		
		<!-- 지도 api를 위치할 div박스 -->
		<div class="w-100 position-relative my-3 border-black">
			<div id="map" style="width:100%; height:700px;"></div>
			<p class="modes">
				<button type="button" class="btn btn-light border-dark" onclick="selectOverlay('CIRCLE')">
					<img src="${pageContext.request.contextPath }/img/oval.png"/>				
				</button>
				<button type="button" class="btn btn-light border-dark" onclick="selectOverlay('POLYGON')">
					<img src="${pageContext.request.contextPath }/img/polygon.png"/>				
				</button>
				<button type="button" class="btn btn-light border-dark" onclick="selectOverlay('POLYGON')">
					<img src="${pageContext.request.contextPath }/img/undo_24px.png"/>
				</button>
			</p>
		</div>
		
		<hr class="border-primary">
			<div class="parent">
				<div class="offset-3 float-left text-right">
					<span class="text-dark">지역</span>&emsp;
					
					<!-- 시군구 리스트 박스 -->
					<select class="custom-select nav-item dropdown show" style="width:150px;" id="guBox">
						<c:forEach items="${guList }" var="gu">
							<option class="dropdown-item" value="${gu.region_cd }"
							<c:if test="${fn:substring(LOGIN_INFO.region_cd,0,5) eq gu.region_cd}">selected</c:if> >${gu.region_name }</option>						
						</c:forEach>
					</select>
					
					<!-- 동별 리스트 박스 -->
					<select class="custom-select nav-item dropdown show" style="width:150px;" id="dongBox">
					</select>
					
					<button id="requestResult" type="button" title="조사하기" class="btn btn-light border-dark ml-3">
						<img src="${pageContext.request.contextPath }/img/조사button2_24px.png"/>
					</button>

					<button class="btn btn-primary ml-3" type="button" id="showTableBtn">현황보기</button>
				</div>
			</div>
		<hr class="border-primary">
		
		<div id="resultBox" class="my-4 col-12 p-2">
			<table class="table table-bordered">
				 <thead>
				    <tr class="bg-gray-200">
				        <th>대분류</th>
				        <th>중분류</th>
				        <th>소분류</th>
				        <th>업소수</th>
				    </tr>
				 </thead>
  				 <tbody id="resBody">
  				 
 				 </tbody>
			</table>		
			
		</div>
		
		
	</div>
	
		
	
	
</div>
