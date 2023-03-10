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
.categorylist ul li {list-style-type:none; width:100%; overflow:auto; overflow:hidden; height:auto; color:#0088e8; font-size:18px; text-align:left; font-weight:700; background:#fff no-repeat 0 23px; padding:15px 0 22px 10px; border-bottom:1px solid #ddd;}
.categorylist ul li:first-child {background:#fff no-repeat 0 13px; padding:5px 0 25px 12px; }
.categorylist ul li:last-child {border-bottom:0;}
.categorylist ul li ul {margin:0; padding:0;}
.categorylist ul li ul li {padding:3px 0; height:27px; background-image:none; color:#24282c; width:25%; float:left !important; font-size:16px; border-bottom:0;}
.categorylist ul li ul li:first-child {background:none; padding:3px 0;}

#cost_popup{
	border : 1px solid black;
	position: absolute;
	z-index: 10;
	width: 1100px;
	height : auto;
	background-color: #ffffff;
	border-radius : 5px;
}

#div1 {
	text-align: center;
	padding: 20px 0px;
}

#div1 .btn {
	margin-right : 10px;
}

#dataReset {
	float : right;
	margin : 5px 0px;
	padding : 5px
}

.custom-select{
	font-size : 1.1em;
}

</style>

<!-- kakao map 등록 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9e96d9b8ca5bed0ac8c0a0ebf8487a10&libraries=drawing,services"></script>
<script>
	// 취소버튼 클릭했을 때 이전 값으로 다시 세팅하기 위한 변수 선언부
	
	var tob_cd = "";
	
	var ep_premium = "";
	var ep_deposit = "";
	var ep_loan = "";
	var ep_roi = "";
	var ep_iaf = "";
	var ep_investment = "";
	var ep_monthly = "";
	var ep_personnel = "";
	var ep_material = "";
	var ep_etc = "";
	var ep_unit_cost = "";
	
	//-----------------------------------------------------------------------------------------

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
	
	// 도형 스타일을 변수로 설정합니다
	var strokeColor = '#39f', fillColor = '#cce6ff', fillOpacity = 0.5, hintStrokeStyle = 'dash';
	
	var options = { // Drawing Manager를 생성할 때 사용할 옵션입니다
		map : map, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
		drawingMode : [
				kakao.maps.Drawing.OverlayType.MARKER,
				kakao.maps.Drawing.OverlayType.ARROW,
				kakao.maps.Drawing.OverlayType.POLYLINE,
				kakao.maps.Drawing.OverlayType.RECTANGLE,
				kakao.maps.Drawing.OverlayType.CIRCLE,
				kakao.maps.Drawing.OverlayType.ELLIPSE,
				kakao.maps.Drawing.OverlayType.POLYGON ],
		// 사용자에게 제공할 그리기 가이드 툴팁입니다
		// 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
		guideTooltip : [ 'draw', 'drag', 'edit' ],
		markerOptions : {
			draggable : true,
			removable : true
		},
		arrowOptions : {
			draggable : true,
			removable : true,
			strokeColor : strokeColor,
			hintStrokeStyle : hintStrokeStyle
		},
		polylineOptions : {
			draggable : true,
			removable : true,
			strokeColor : strokeColor,
			hintStrokeStyle : hintStrokeStyle
		},
		rectangleOptions : {
			draggable : true,
			removable : true,
			strokeColor : strokeColor,
			fillColor : fillColor,
			fillOpacity : fillOpacity
		},
		circleOptions : {
			draggable : true,
			removable : true,
			strokeColor : strokeColor,
			fillColor : fillColor,
			fillOpacity : fillOpacity
		},
		ellipseOptions : {
			draggable : true,
			removable : true,
			strokeColor : strokeColor,
			fillColor : fillColor,
			fillOpacity : fillOpacity
		},
		polygonOptions : {
			draggable : true,
			removable : true,
			strokeColor : strokeColor,
			fillColor : fillColor,
			fillOpacity : fillOpacity
		}
	};
	
	// 위에 작성한 옵션으로 Drawing Manager를 생성합니다
	var manager = new kakao.maps.Drawing.DrawingManager(
			options);
	
	// Toolbox를 생성합니다. 
	// Toolbox 생성 시 위에서 생성한 DrawingManager 객체를 설정합니다.
	// DrawingManager 객체를 꼭 설정해야만 그리기 모드와 매니저의 상태를 툴박스에 설정할 수 있습니다.
	var toolbox = new kakao.maps.Drawing.Toolbox({
		drawingManager : manager
	});
	
	// 지도 위에 Toolbox를 표시합니다
	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOP은 위 가운데를 의미합니다.
// 	map.addControl(toolbox.getElement(), kakao.maps.ControlPosition.TOPLEFT);
	
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
	
	// -----------------------------------------------------------------------------------------
	
	// 관심지역 설정
	setRegion();
	
	// 관심업종 설정
	setTob();
	
	// 사용자가 구를 선택하면 해당 구의 동 리스트를 조회
	$("#guBox").on("change", function(){
		var region_cd2 = $(this).val();
		
		if(region_cd2 == "all"){
			$("#dongBox").empty();
			
			var html = '<option class="dropdown-item" value="all">전체(동)</option>';
			$("#dongBox").append(html);
			
			searchAddr("대전광역시 중구 대흥동 500-5", "대덕인재개발원");			
			return;
		}
		
// 		console.log(region_cd2);
		dongListLookUp(region_cd2, 0);
	})

	// 동을 변경할 때
	$("#dongBox").on("change", function(){
		addr = $(this).val();
		
		dong = $(this).children("option:selected").text();
		
		hideMarkers(null);
		$(".iWindow").parent().parent().remove();
		
		searchAddr(addr, dong);
	})
	
	// 업종선택 셀렉트박스를 클릭할 때
	$("#upjongBox").on("click", function(){
		var dong = $("#dongBox").val();
		
		if(dong == "all"){
			swal("지역을 선택하여 주십시오.");
			return;
		}
		
		$("#popup").attr("style", "top: 0px; left:200px; display:block;");
	})
	
	// 업종선택 팝업창의 취소버튼을 클릭했을 때
	$("#hidePopup").on("click", function(){
		// 이전에 선택한 값이 없었다면
		if(tob_cd == ""){
			// 체크박스 전부 해제
			$("input:radio:checked").prop("checked",false);
	
			// 업종선택 셀렉트박스 값 지우기
			$("#upjongBox").val('');
		
		// 이전에 선택한 값이 있다면 해당 값 설정
		} else {
			$("input:radio[value='" + tob_cd + "']").attr("checked", true);
		}
		
		// 팝업창 숨기기
		$("#popup").attr("style", "top: 0px; left:200px; display:none;");
	})
	
	$("input:radio").on("click",function(){
		var code = $("input:radio:checked").eq(0).parents(".mid-category").data("cd2");
		var code2 = $("input:radio:checked").eq(1).parents(".mid-category").data("cd2");
// 		console.log(code);
// 		console.log(code2);
		if( $("input:radio:checked").parents(".mid-category").length > 1 && code != code2){
// 			console.log("부모가다름");
			$("input:radio:checked").prop("checked",false);
			$(this).prop("checked", true);
		}
	})
	
	$('#choiceBtn').on("click", function(){
		var selectedUpjong = $("input:radio:checked");
		$("#upjongBox").val(selectedUpjong.attr("upnm"));
		$("#upjongBox").attr("data-cd", selectedUpjong.val());
		$("#popup").attr("style", "top: 0px; left:200px; display:none;");
		
		tob_cd = selectedUpjong.val();
	})
	
	// 초기화 버튼을 클릭했을 때
	$("#resetBtn").on("click",function(){
		// 관심 지역, 업종이 있다면
		setRegion();
		setTob();
		
		$("#costBox").val("");
		$("#frm")[0].reset();
	})
	
	// 비용입력 모달
	$("#costBox").on("click", function(){
		var upjong = $("#upjongBox").val();
		
		if(upjong.length == 0){
			swal("업종을 선택하여 주십시오.");
			return;
		}
		
		var tob_cd = $("#upjongBox").attr("data-cd");
		
		// 객단가가 입력되어있다면 --> 기존 입력값 모달 출력
		// 입력되어있지 않다면 --> 투입자금 모달 출력
		var unit_cost = $("#ep_unit_cost").val();
		
		if(unit_cost.trim().length == 0){
			getFund(tob_cd);
		}
		
		$("#cost_popup").attr("style", "top: -70px; left:100px; display:block;");
	})
	
	// 비용입력 확인버튼을 클릭했을 때
	$("#okBtn").on("click", function(){
		var loan = Number($("#ep_loan").val());
		var roi = Number($("#ep_roi").val());

		// 대출금이 0이 아니면 이자율의 값(0이 아닌 값)이 있어야 함
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
		
		// 이자율이 0이 아니면 대출금의 값(0이 아닌 값)이 있어야 함
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
		
		// 객단가는 필수 입력값
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
		
		$("#cost_popup").attr("style", "top: -70px; left:100px; display:none;");
		$("#costBox").val("입력완료");
		
		saveCost();
		
		console.log(ep_unit_cost);
	})
	
	// 비용입력 취소버튼을 클릭했을 때
	$("#cancelBtn").on("click", function(){
		// 변수에 저장된 값이 없을 때
		if(ep_unit_cost == ""){
			$("#frm")[0].reset();
			$("#costBox").val("");
		
		// 저장된 값이 있을 때	
		} else {
			setCost();
		}
		
		$("#cost_popup").attr("style", "top: -70px; left:100px; display:none;");
	})
	
	// 비용입력 데이터지우기 버튼을 클릭했을 때
	$("#dataReset").on("click", function(){
		$("#frm")[0].reset();
		
		var tob_cd = $("#upjongBox").attr("data-cd");
		getFund(tob_cd);
	})
	
	// 분석하기 버튼을 클릭했을 때
	$("#analysis").on("click", function(e){
		e.preventDefault();
		
		// 지역 검증
		var dong = $("#dongBox").val();
		
		if(dong == "all"){
			swal("","지역을 선택하여 주십시오.","warning");
			return;
		}
		
		// 업종 검증
		var upjong = $("#upjongBox").val();
		
		if(upjong.length == 0){
			swal("","업종을 선택하여 주십시오.","warning");
			return;
		}
		
		// 비용 검증
		var cost = $("#costBox").val();
		
		if(cost.length == 0){
			swal("","비용을 입력하여 주십시오.","warning");
			return;
		}
		
		// form 안에 지역, 업종 추가
		var region_cd = $("#dongBox option:selected").attr("id");
		var tob_cd = $("#upjongBox").attr("data-cd");
		
		$("#region_cd").val(region_cd);
		$("#tob_cd").val(tob_cd);
		
		// form 값 재설정(placeholder --> value) 등 default 값 설정
		// input 값을 number로 변환하여 값이 0이면
		// 해당 input 값을 0 또는 placeholder 값으로 설정
		if(Number($("#ep_premium").val()) == 0){
			$("#ep_premium").val("0");
		};
		
		if(Number($("#ep_deposit").val()) == 0){
			$("#ep_deposit").val("0");
		};
		
		if(Number($("#ep_loan").val()) == 0){
			$("#ep_loan").val("0");
		};
		
		if(Number($("#ep_roi").val()) == 0){
			$("#ep_roi").val("0.0");
		};
		
		if($("#ep_iaf").val().trim().length == 0){
			var ph = $("#ep_iaf").attr("placeholder");
			if(ph == ""){
				$("#ep_iaf").val("0");
			} else {
				$("#ep_iaf").val(ph);
			}
		};
		
		if(Number($("#ep_investment").val()) == 0){
			$("#ep_investment").val("0");
		};
		
		if($("#ep_monthly").val().trim().length == 0){
			var ph = $("#ep_monthly").attr("placeholder");
			if(ph == ""){
				$("#ep_monthly").val("0");
			} else {
				$("#ep_monthly").val(ph);
			}
		};
		
		if($("#ep_personnel").val().trim().length == 0){
			var ph = $("#ep_personnel").attr("placeholder");
			if(ph == ""){
				$("#ep_personnel").val("0");
			} else {
				$("#ep_personnel").val(ph);
			}
		};
		
		if($("#ep_material").val().trim().length == 0){
			var ph = $("#ep_material").attr("placeholder");
			if(ph == ""){
				$("#ep_material").val("0");
			} else {
				$("#ep_material").val(ph);
			}
		};
		
		if(Number($("#ep_etc").val()) == 0){
			$("#ep_etc").val("0");
		};
		
		$("#frm").submit();
	})
})

// 비용입력 취소버튼 클릭시 이전에 입력한 값으로 세팅
function setCost(){
	$("#ep_premium").val(ep_premium);
	$("#ep_deposit").val(ep_deposit);
	$("#ep_loan").val(ep_loan);
	$("#ep_roi").val(ep_roi);
	$("#ep_iaf").val(ep_iaf);
	$("#ep_investment").val(ep_investment);
	$("#ep_monthly").val(ep_monthly);
	$("#ep_personnel").val(ep_personnel);
	$("#ep_material").val(ep_material);
	$("#ep_etc").val(ep_etc);
	$("#ep_unit_cost").val(ep_unit_cost);
}

// 비용입력 값 변수에 저장
function saveCost(){
	ep_premium = $("#ep_premium").val();
	ep_deposit = $("#ep_deposit").val();
	ep_loan = $("#ep_loan").val();
	ep_roi = $("#ep_roi").val();
	ep_iaf = $("#ep_iaf").val();
	ep_investment = $("#ep_investment").val();
	ep_monthly = $("#ep_monthly").val();
	ep_personnel = $("#ep_personnel").val();
	ep_material = $("#ep_material").val();
	ep_etc = $("#ep_etc").val();
	ep_unit_cost = $("#ep_unit_cost").val();
}

// 관심지역 설정
function setRegion(){
	var g_cd = "${interest.G_CD}";
	if(g_cd != ""){
		$("#guBox").val(g_cd);
		var d_cd = "${interest.D_CD}";
		dongListLookUp(g_cd, d_cd);
	} else {
		$("#guBox").val("all");
		$("#dongBox").empty();
		var html = '<option class="dropdown-item" value="all">전체(동)</option>';
		$("#dongBox").append(html);
		searchAddr("대전광역시 중구 대흥동 500-5", "대덕인재개발원");		
	}
};

// 관심업종 설정
function setTob(){
	var t_cd = "${interest.T_CD}";
	if(t_cd != ""){
		$("input:radio:checked").prop("checked",false);
		$("input[value='" + t_cd +"']").prop("checked", true);
		var upnm = $("input:radio:checked").attr("upnm");
		$("#upjongBox").val(upnm);
		$("#upjongBox").attr("data-cd", t_cd);
	} else {
		$("input:radio:checked").prop("checked",false);
		$("#upjongBox").val('');
	}
}

// 업종에 따른 자금투입현황을 ajax로 호출
function getFund(tob_cd){
	// 비용입력 모달 초기 설정
	$.ajax({
		url : "${pageContext.request.contextPath}/marginAnalysis/fund",
		data : "tob_cd=" + tob_cd,
		dataType : "json",
		method : "get",
		success : function(data){
// 			console.log(data);
			if(data.fundVo != null){
				$("#ep_iaf").attr("placeholder", data.fundVo.fund_fe);
				$("#ep_personnel").attr("placeholder", data.fundVo.fund_pe);
				$("#ep_material").attr("placeholder", data.fundVo.fund_me);
				$("#ep_etc").attr("placeholder", data.fundVo.fund_etc);
				
				$("#iv_total").val(data.fundVo.fund_fe);
				$("#de_total").val(data.fundVo.fund_fe);
				
				var cp = data.fundVo.fund_pe + data.fundVo.fund_me + data.fundVo.fund_etc;
				$("#cp_total").val(cp);
			}
		},
		error : function(error){
		   console.log(error);
		}
	});
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
		   var dongList = data.dongList;
		   var html = "";
		   var addr = "";
		   var dongName = "";
		   
		   $.each(dongList, function(idx, dong){
			   if(region_cd != ""){
				   if(dong.region_cd == region_cd){
					   addr = dong.region_csc;
					   dongName = dong.region_name;
					   html += "<option class=\"dropdown-item\" id=\""+ dong.region_cd + "\" value=\""+ dong.region_csc +"\" selected>"+ dongName + "</option>";
				   } else {
					   html += "<option class=\"dropdown-item\" id=\""+ dong.region_cd + "\" value=\""+ dong.region_csc +"\">"+ dong.region_name + "</option>";
				   }
			   } else if(idx == 0){
				   addr = dong.region_csc;
				   dongName = dong.region_name;
				   html += "<option class=\"dropdown-item\" id=\""+ dong.region_cd + "\" value=\""+ dong.region_csc +"\" selected>"+ dongName + "</option>";
			   } else {
				   html += "<option class=\"dropdown-item\" id=\""+ dong.region_cd + "\" value=\""+ dong.region_csc +"\">"+ dong.region_name + "</option>";
			   }
			   
		   })
		   
		   $("#dongBox").empty();
		   $('#dongBox').append(html);
		   
		   searchAddr(addr, dongName);
	   }
	   ,error : function(err){
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

function menuClick(e){
	$('.category-tab.depth-1 li').removeAttr('class');
	var tob_cd = e.getAttribute('data-code');
// 	console.log(tob_cd);
	e.parentElement.setAttribute('class', 'active');
	$('.tab-pane').attr('class', 'tab-pane');
	$('#category-'+ tob_cd +'').attr('class', 'tab-pane active');
// 	console.log('#category-'+ tob_cd);
}

// 시연을 위한 비용입력 세팅
function dataInit(){
	// 둔산2동 카페 설정 시 예상 비용
	// 상권분석 사이트 및 기타 자료 참고
	$("#ep_premium").val("0");
	$("#ep_deposit").val("6000");	
	$("#ep_loan").val("11000");
	$("#ep_roi").val("3.59");
	$("#ep_iaf").val("3600");
	$("#ep_investment").val("400");
	$("#ep_monthly").val("300");
	$("#ep_personnel").val("120");
	$("#ep_material").val("400");
	$("#ep_etc").val("0");
	$("#ep_unit_cost").val("8800");
}

</script>
<div class="box-center col-lg-10 mt-5 pt-4">
	<div class="col-lg-9 w-30 float-left">

		<div class="card shadow mb-4">

			<div>
				<div class="mb-4 pt-3 border-bottom-info">
					<div class="card-body">
						<h3 class="font-weight-bold text-primary text-center">수&nbsp;익&nbsp;분&nbsp;석</h3>
					</div>
				</div>
			</div>

			<div class="container">
				<h5 class="font-weight-normal text-black text-wrap">1.&nbsp;지역선택</h5>

				<div class="card-body mt-3">
					<select class="custom-select w-49 nav-item dropdown show" id="guBox">
						<option class="dropdown-item" value="all" selected>전체(구)</option>
						<c:forEach items="${guList }" var="gu">
						<option class="dropdown-item" value="${gu.region_cd }">${gu.region_name }</option>						
						</c:forEach>
					</select> 
					
					<select class="custom-select w-49" id="dongBox">
						<option class="dropdown-item" value="all">전체(동)</option>
					</select>
				</div>

				<hr>

				<h5 class="font-weight-normal text-black text-wrap">2.&nbsp;업종선택</h5>

				<div class="card-body mt-3">
					<input type="text" id="upjongBox" data-cd="" class="custom-select w-100 px-1 py-1" readonly
					placeholder="업종을 선택하여 주십시오."/>
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
						             								value="${bot.tob_cd }" upnm="${bot.tob_name }" data-click="">
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
				
				<h5 class="font-weight-normal text-black text-wrap">3.&nbsp;비용 입력</h5>

				<div class="card-body mt-3">
					<input type="text" id="costBox" data-cd="" class="custom-select w-100 px-1 py-1" readonly
					placeholder="비용을 입력하여 주십시오."/>
				</div>
				
				<!-- 비용 입력 팝업창 -->
				<div id="cost_popup" style="display:none;">
					<div class="card-header py-3">
						<h5 class="m-0 font-weight-bold text-primary text-xl-center">비용입력</h5>
					</div>
					
					<div class="card-body">
						<div class="table-responsive">
							<p class="p1"> - 기존사업자는 실제 발생하는 점포의 비용을 입력하시고 예비창업자는 창업 후 예상되는 비용 데이터를 입력하십시오.<br>
							    - 입력된 데이터는 각 표준산업대분류별 예시 데이터(중소벤처기업부, 창업진흥원 - 2018년 창업기업 실태조사)이므로 <br>
								&nbsp;&nbsp;참고하시어 실제 데이터를 입력하시기 바랍니다.</p>
							<a id="dataReset" href="#" class="btn btn-secondary btn-icon-split">
			                    <span class="text-center">데이터 지우기</span>
			                </a>
			                
							<%@include file="/WEB-INF/views/marginAnalysis/fundAdd.jsp" %>
							
							<br>
						</div>
					</div>
					
					<div id="div1" class="bg-gray-100">
						<a href="#" id="okBtn" class="btn btn-primary btn-icon-split">
						  <span class="text">확인</span>
						</a>
						<a href="#" id="cancelBtn" class="btn btn-secondary btn-icon-split">
						  <span class="text">취소</span>
						</a>
					</div>
				</div>
				
				<hr>
				
				<div>
					<div class="card-body mt-2 text-center">
						<a href="#" id="analysis" class="btn btn-primary mx-3 my-2">
							<span class="text">분석하기</span>
						</a>
							
						<a href="#" class="btn btn-secondary mx-3 my-2">
							<span class="text" id="resetBtn">초기화</span>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- kakao map -->
	<div class="float-right figure w-70" id="map" style="width: 400px; height: 655px;"></div>

</div>