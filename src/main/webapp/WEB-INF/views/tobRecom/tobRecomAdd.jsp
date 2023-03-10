<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

a:hover{
	text-decoration: none;
}
#selectR{
	margin: 4.2rem 0;
}
.custom-select{
	font-size : 1.1em;
}
</style>

<!-- kakao map api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9e96d9b8ca5bed0ac8c0a0ebf8487a10&libraries=drawing,services"></script>

<script>
	$(document).ready(function(){
		// 지도에 표시된 마커 객체를 가지고 있는 배열
		markers = [];
		
		$("#gu").on("change", function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/tobRecom/inputDong",
				method : "post",
				data : "region_cd2=" + $("#gu").val(), // 구 지역코드를 전송
				success : function(data){
					var html = "";
					data.forEach(function(region){ // 구에 해당하는 동을 #dong에 생성
						html += "<option data-cd = " + region.region_cd + " value='" + region.region_csc + "'" + ">" + region.region_name + "</option>";
						
					})
					$("#dong").html(html);
				},
				error : function(){
					alert("error!!!");
				}
			});
		});
		
		$("#regionSelect").on("change", "#dong", function(){ // 동을 선택하면 지도에 출력한다
			addr = $(this).val();
			dong = $("#dong option:selected").text();
			
			hideMarkers(); // 기존 마커 삭제
			$(".iWindow").parent().parent().remove(); // 기존 인포윈도우 삭제
			
			searchAddr(addr, dong);
		});
		
		$("#btntob").on("click", "#anabtn", function(){ // 분석하기 버튼
			var d = $("#dong option:selected").data('cd'); // option의 속성값으로 준 data-cd를 읽어온다
			
			var gu = $("#gu option:selected").text();
			var dong = $("#dong option:selected").text();
			
			if(gu == "" || dong == ""){
				swal("구와 동을 선택해 주십시오");
				return;
			}
			
			$("#dongcd").val(d);
			$("#form1").submit();
			
		})
		
		$("#btntob").on("click", "#clearbtn", function(){ // 초기화 버튼
			$("#gu").val("구");
			$("#dong").val("동");
		})
		
		/* ================================kakao 지도================================ */
		
		imageSrc = '${pageContext.request.contextPath}/img/map-marker.png',
		imageSize = new kakao.maps.Size(50, 55); // 마커이미지의 크기입니다
	
		var container = document.getElementById('map');
		
		var mapOptions = {
			// 페이지 호출 시 처음으로 보여줄 좌표 설정
			center: new kakao.maps.LatLng(36.323329, 127.411299),
			level: 3
		};

		map = new kakao.maps.Map(container, mapOptions);
		
		// 주소-좌표 변환 객체를 생성합니다
		geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
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
		console.log("${interestRegion}");
		
		if(${interestRegion != null}){ // 관심지역이 있을 경우 페이지 접속 시 지도에 출력
			var ir = '${interestRegion.region_csc}';
			var dong = '${interestRegion.rn2}';
			
			searchAddr(ir, dong);
		}
		
	}); // end of document ready
	
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
		            image: markerImage
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
</script>

<div class="box-center col-lg-10 mt-5 pt-4">
	<div class="col-lg-9 w-30 float-left">

		<div class="card shadow mb-4">

			<div>
				<div class="mb-4 pt-3 border-bottom-info">
					<div class="card-body">
						<h3 class="font-weight-bold text-primary text-center">업&nbsp;종&nbsp;추&nbsp;천</h3>
					</div>
				</div>
			</div>

			<div id="selectR" class="container">
				<h5 class="font-weight-normal text-black text-wrap">1.&nbsp;지역선택</h5>

				<div id="regionSelect" class="card-body mt-3">
					<select class="custom-select w-49 nav-item dropdown show" id="gu">
						<c:if test="${interestRegion.region_name != null}"> <%-- 관심지역이 있을 경우 초기값으로 설정한다 --%>
							<option value="${interestRegion.region_cd2}" selected>${interestRegion.region_name}</option>
						</c:if>
						<c:forEach items="${regionList}" var="rList"> <%-- 나머지 구를 option으로 설정한다 --%>
							<c:if test="${rList.region_cd2 == 0 && rList.region_name != interestRegion.region_name}">
								<option value="${rList.region_cd}">${rList.region_name}</option>
							</c:if>
						</c:forEach>
					</select> 
					
					<select class="custom-select w-49" id="dong">
						<c:if test="${interestRegion.region_name != null}"> <%-- 관심지역이 있을 경우 초기값으로 설정한다 --%>
							<option data-cd="${interestRegion.region_cd}" selected>${interestRegion.rn2}</option>
						</c:if>
						<c:forEach items="${regionList}" var="rList"> <%-- 관심지역이 없을 경우 기본값을 설정한다 --%>
							<c:if test="${rList.region_cd2 == 30140}">
								<option data-cd ="${rList.region_cd}" value="${rList.region_csc}">${rList.region_name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>

				<hr>
				
				<div>
					<div id="btntob" class="card-body mt-2 text-center">
						<button id="anabtn" class="btn btn-primary mx-3 my-2" type="button">분석하기</button>
						<button id="clearbtn" class="btn btn-secondary mx-3 my-2" type="button">초기화</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- kakao map -->
	<div class="float-right figure w-70" id="map" style="width: 400px; height: 500px;"></div>
	<form id="form1" action="${pageContext.request.contextPath}/tobRecom/result" method="get">
		<input type="hidden" id="dongcd" name="dongcd" />
		<!-- <input type="hidden" id="report_cd" name="report_cd" /> -->
	</form>
</div>
