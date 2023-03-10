<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	#base{
		width : 100%;
		height : auto;
		margin : 0 auto;
	}
	#subject{
		width : 1100px;
		height : auto;
		margin : 3em auto;
		text-align : left;
		color: black;
	}
	.w-30 {
	width: 30% !important;
	}
	.w-40 {
	width: 40% !important;
	}
	.col-4{
		float: left;
	}
	.col-6{
		float: left;
	}
	hr {
		clear: both;
	}
	.label{
		font-weight: bold;
		margin: 0 2em;
	}
	#resultTable{
		margin-top: 20px;
		margin: auto;
		width: 80%;
		color: black;
		text-align: right;
	}
	caption{
		text-align: right;
		caption-side: top;
		font-weight: bold;
	}
	#cap{
		color: blue;
		margin: 0 0 0 10%;
		font-weight: bold;
	}
	#br{
		margin: 0 0 0 42%;
		font-size: 0.8em;
	}
	th{
		vertical-align: middle !important;
		text-align: center;
	}
	#info1{
		padding-left: 0;
		padding-right: 0;
	}
	.itext{
		text-align: center;
	}
	
</style>

<script>
	$(document).ready(function(){
		
		$.ajax({
			url : "${pageContext.request.contextPath}/bdPrsct/getTobCl2",
			method : "post",
			data : "tob_cd=" + $("#bigCl").val(), // 대분류코드를 전송
			success : function(data){
				var html = "";
				data.forEach(function(tob){ // 대분류코드에 해당하는 중분류
					html += "<option value='" + tob.tob_cd + "'" + ">" + tob.tob_name + "</option>";
				})
				$("#mediumCl").html(html);
			},
			error : function(){
				alert("error!!!");
			}
		});
		
		$("#bigCl").on("change", function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/bdPrsct/getTobCl2",
				method : "post",
				data : "tob_cd=" + $("#bigCl").val(), // 대분류코드를 전송
				success : function(data){
					var html = "";
					data.forEach(function(tob){ // 대분류코드에 해당하는 중분류
						html += "<option value='" + tob.tob_cd + "'" + ">" + tob.tob_name + "</option>";
					})
					$("#mediumCl").html(html);
				},
				error : function(){
					alert("error!!!");
				}
			});
		});
		
		$("#btn").on("click", function(){
 			var gu = $("#gu option:selected").attr("value");
			var tob_cd = $("#mediumCl option:selected").attr("value");
			
			if(tob_cd == null){
				swal("업종을 선택하여 주십시오.");
				return;
			}
			
			$.ajax({
				url : "${pageContext.request.contextPath}/bdPrsct/getSPrsct",
				method : "post",
				data : "tob_cd=" + tob_cd + "&gu=" + gu,
				success : function(data){
					var captionV = $("#bigCl option:selected").text() + " > " + $("#mediumCl option:selected").text();
					var html = "";
					html+="<span id='cap'>" + captionV + "</span> 업종 매출통계";
					html+="<table class='table table-bordered' id='resultTable'>";
					html+="<caption><span id='br'>월평균매출액: 만원 / 건단가: 원</span></caption>";
					html+="<tr class='bg-gray-200'>";
					html+="<th rowspan='2'>지역<br></th>";
					html+="<th rowspan='2'>업종<br></th>";
					html+="<th colspan='2'>2018년 상반기</th>";
					html+="<th colspan='2'>2018년 하반기</th>";
					html+="</tr>";
					html+="<tr class='bg-gray-200'>";
					html+="<th>월평균매출</th>"
					html+="<th>건단가</th>"
					html+="<th>월평균매출</th>"
					html+="<th>건단가</th>"
					html+="</tr>";
					
					html+="<tr>";
					html+="<td class='itext'>" + data[0].gu + "</td>";
					html+="<td class='itext'>" + data[0].tob + "</td>";
					html+="<td>" + numberWithCommas(data[0].sp_monthly) + "</td>";
					html+="<td>" + numberWithCommas(data[0].sp_unit_cost) +  "</td>";
					html+="<td>" + numberWithCommas(data[1].sp_monthly) + "</td>";
					html+="<td>" + numberWithCommas(data[1].sp_unit_cost) + "</td>";
					html+="</tr>";
					
					html+="</table>";
					$("#result").html(html);
				},
				fail : function(err){
					console.log(err);
				}
			});
		});
	}); // document ready 끝
	
	function numberWithCommas(x) { // 숫자 세자리마다 ','찍는 정규식 함수
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

</script>

<div class="col-sm-10 col-sm-offset-3 col-md-10 col-md-offset-2 main" id="base">
	<div id="subject">
		<div>
			<h2>매출현황</h2>
			<br>
			<div class="card shadow col-12" id="info1">
				<div class="card-header">
					<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-info-circle"></i> 도움말</h6>
				</div>
				<div class="card-body">
					(추정) 매출액 현황은 예비창업자 및 소상공인이 상권 성장 여부에 대한 추세를 확인하여 참고하도록 제공됩니다<br>
					(추정) 매출액 현황은 소상공인 전체 매출현황이 아니고, 점포면적, 입지에 따라 달라질 수 있습니다
				</div>
			</div>
			<hr class="border-primary">
				<div class="col-4 text-right">
				<span class="label">지역</span>
					<select class="custom-select w-30 nav-item dropdown show" id="gu">
						<c:forEach items="${guList}" var="gList">
							<option value="${gList.region_cd}">${gList.region_name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-6">
				<span class="label">업종</span>
					<select class="custom-select w-30 nav-item dropdown show" id="bigCl">
						<c:forEach items="${tobClList}" var="bigClList">
							<option value="${bigClList.tob_cd}">${bigClList.tob_name}</option>
						</c:forEach>
					</select>
					<select class="custom-select w-40 nav-item dropdown show" id="mediumCl"></select>
				</div>
				<button class="btn btn-primary" type="button" id="btn">현황보기</button>
			<hr class="border-primary">
		</div>
		<div id="result">
		</div>
	</div>
</div>