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
		text-align: center;
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
		
		$("#btn").on("click", function(){
 			var gu = $("#gu option:selected").attr("value");
			var tob_cd = $("#bigCl option:selected").attr("value");
			
			$.ajax({
				url : "${pageContext.request.contextPath}/bdPrsct/getUtilizePrsct",
				method : "post",
				data : "tob_cd=" + tob_cd + "&gu=" + gu,
				success : function(data){
					var captionV = $("#gu option:selected").text() + " > " + $("#bigCl option:selected").text();
					var html = "";
					html+="<span id='cap'>" + captionV + "</span> 활용현황";
					html+="<table class='table table-bordered' id='resultTable'>";
					html+="<tr class='bg-gray-200'>";
					html+="<th>순위</th>";
					html+="<th>업종</th>";
					html+="<th>분석횟수</th>";
					html+="</tr>";
					
					data.forEach(function(Utilize){
						html+="<tr>";
						html+="<td class='itext'>" + Utilize.rank + "</td>";
						html+="<td>" + Utilize.tob_name + "</td>";
						html+="<td>" + numberWithCommas(Utilize.count) +  "</td>";
						html+="</tr>";
					})
					
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
			<h2>활용현황</h2>
			<br>
			<div class="card shadow col-12" id="info1">
				<div class="card-header">
					<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-info-circle"></i> 도움말</h6>
				</div>
				<div class="card-body">
					활용현황 페이지에서는 회원들의 상권분석 현황을 지역, 업종별로 조회할 수 있습니다
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
				</div>
				<button class="btn btn-primary" type="button" id="btn">현황보기</button>
			<hr class="border-primary">
		</div>
		<div id="result">
		</div>
	</div>
</div>