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
	
	#subject2{
		width : 1100px;
		height : auto;
		margin : 0 auto;
	}
	
	#table{
		width : 1100px;
		margin-bottom : -16px;
	}
	
	.grade{
		margin: 5px;
		float: left;
		text-align: center;
	}
	
	.dots{
		width: 20px;
		height: 20px;
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
	
	#signal{
		width: 300px;
		height: 300px;
	}
	
	#bronze{
		background-color : #AE5E1A;
		color : white;
	}
	#bad{
		width : 1100px;
		height : auto;
		margin-top : -4;
	}
	#bad1{
		display: inline-block;
		width: 550px;
		height: auto;
		float:left;
		border: 0.1px;
    	border-collapse: collapse;
	}
	#bad1-1{
		width: 750px;
		height: auto;
		
	}
	#bad1-2{
		width: 350px;
		height: auto;
	}
	#bad2{
		display: inline-block;
		width: 550px;
		height: auto;
		float:left;
		border: 0.01px;
		border-left:1px solid white;
		border-collapse: collapse;
	}
	#bad2-1{
		width: 750px;
		height: auto;
		border-left:none
	}
	#bad2-2{
		width: 350px;
		height: auto;
	}
	#good1{
		width: 370px;
		height: auto;
		
	}
	#good2{
		width: 180px;
		height: auto;
	}
	#good1-1{
		width: 370px;
		height: auto;
		
	}
	#good2-1{
		width: 180px;
		height: auto;
	}
	.pp{
		width: 550px;
	}
	.bb{
		color : blue;
	}
	table:nth-child(1) td{
		width : 50%;
	}
</style>

<script>
	function fnMove(seq){
		var offset = $("#subject" + seq).offset();
		$('html, body').animate({scrollTop : offset.top}, 400);
	}
</script>

<div class="col-sm-10 col-sm-offset-3 col-md-10 col-md-offset-2 main" id="base">

	<div id="subject">
		<h2 class="figure font-weight-bold text-left">입지분석 비교 보고서</h2>&nbsp;&nbsp;
		<span onclick="fnMove('1')" class="fnMove">1. 종합 입지등급</span>&nbsp;
		<span onclick="fnMove('2')" class="fnMove">2. 업종별 입지등급</span>&nbsp;
		<span onclick="fnMove('3')" class="fnMove">3. 잠재고객분석</span>&nbsp;
	</div>
	<hr>
	<br>
	
	<div id="input">
		<table class="table table-bordered dataTable">
			<thead>
				<tr role="row">
					<th colspan="2">분석지역</th>
				</tr>
			</thead>
			<tbody>
				<tr role="row">
					<td>${selectAddr1}</td>
					<td>${selectAddr2}</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div id="subject1">
		<h5 class="font-weight-bold text-info text-left">1. 종합 입지등급</h5>
		<table id="table01" class="table table-bordered dataTable">
			<thead>
				<tr role="row">
					<th colspan="2" style="width: 20%">종합 입지등급</th>
				</tr>
			</thead>
			<tbody>
				<tr role="row">
					<td class="pb-5">
					<c:choose>
						<c:when test="${grade1 == 1}">
							<img id="signal" src="${pageContext.request.contextPath}/img/금.gif"><br>
							<span id="gold" class="btn btn-warning btn-icon-split">종합입지등급:1등급</span><br>
						</c:when>
						<c:when test="${grade1 == 2}">
							<img id="signal" src="${pageContext.request.contextPath}/img/은.gif"><br>
							<span id="silver" class="btn btn-secondary btn-icon-split">종합입지등급:2등급</span><br>
						</c:when>
						<c:when test="${grade1 == 3}">
							<img id="signal" src="${pageContext.request.contextPath}/img/동.gif"><br>
							<span id="bronze" class="btn btn-icon-split">종합입지등급:3등급</span><br>
						</c:when>
					</c:choose>
					</td>
					<td class="pb-5">
					<c:choose>
						<c:when test="${grade2 == 1}">
							<img id="signal" src="${pageContext.request.contextPath}/img/금.gif"><br>
							<span id="gold" class="btn btn-warning btn-icon-split">종합입지등급:1등급</span><br>
						</c:when>
						<c:when test="${grade2 == 2}">
							<img id="signal" src="${pageContext.request.contextPath}/img/은.gif"><br>
							<span id="silver" class="btn btn-secondary btn-icon-split">종합입지등급:2등급</span><br>
						</c:when>
						<c:when test="${grade2 == 3}">
							<img id="signal" src="${pageContext.request.contextPath}/img/동.gif"><br>
							<span id="bronze" class="btn btn-icon-split">종합입지등급:3등급</span><br>
						</c:when>
					</c:choose>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div id="subject2">
		<h5 class="font-weight-bold text-info text-left">2. 업종별 입지등급</h5>
		<table class="table table-bordered dataTable dataTable" id="table">
			<tr>
				<th colspan="4">좋음</th>
			</tr>
			<c:forEach begin="0" end="9" items="${resultList1}" var="rList1" varStatus="status">
			<tr>
				<td id="good1">${rList1.tob}</td>
				<td id="good2">
					<c:choose>
						<c:when test="${rList1.grade == 1}">
							<img class="dots" src="${pageContext.request.contextPath}/img/gold_coin.gif"> ${rList1.grade}등급
						</c:when>
						
						<c:when test="${rList1.grade == 2}">
							<img class="dots" src="${pageContext.request.contextPath}/img/silver_coin.gif"> ${rList1.grade}등급
						</c:when>
						
						<c:when test="${rList1.grade == 3}">
							<img class="dots" src="${pageContext.request.contextPath}/img/copper_coin.gif"> ${rList1.grade}등급
						</c:when>
					</c:choose>
				</td>
				<td id="good1-1">${resultList2[status.index].tob}</td>
				<td id="good2-1">
					<c:choose>
						<c:when test="${resultList2[status.index].grade == 1}">
							<img class="dots" src="${pageContext.request.contextPath}/img/gold_coin.gif"> ${resultList2[status.index].grade}등급
						</c:when>
						
						<c:when test="${resultList2[status.index].grade == 2}">
							<img class="dots" src="${pageContext.request.contextPath}/img/silver_coin.gif"> ${resultList2[status.index].grade}등급
						</c:when>
						
						<c:when test="${resultList2[status.index].grade == 3}">
							<img class="dots" src="${pageContext.request.contextPath}/img/copper_coin.gif"> ${resultList2[status.index].grade}등급
						</c:when>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
			<tr>
				<th colspan="4">보통</th>
			</tr>
			<c:forEach begin="10" end="19" items="${resultList1}" var="rList1" varStatus="status">
			<tr>
				<td>${rList1.tob}</td>
				<td>
					<c:choose>
						<c:when test="${rList1.grade == 1}">
							<img class="dots" src="${pageContext.request.contextPath}/img/gold_coin.gif"> ${rList1.grade}등급
						</c:when>
						
						<c:when test="${rList1.grade == 2}">
							<img class="dots" src="${pageContext.request.contextPath}/img/silver_coin.gif"> ${rList1.grade}등급
						</c:when>
						
						<c:when test="${rList1.grade == 3}">
							<img class="dots" src="${pageContext.request.contextPath}/img/copper_coin.gif"> ${rList1.grade}등급
						</c:when>
					</c:choose>
				</td>
				<td>${resultList2[status.index].tob}</td>
				<td>
					<c:choose>
						<c:when test="${resultList2[status.index].grade == 1}">
							<img class="dots" src="${pageContext.request.contextPath}/img/gold_coin.gif"> ${resultList2[status.index].grade}등급
						</c:when>
						
						<c:when test="${resultList2[status.index].grade == 2}">
							<img class="dots" src="${pageContext.request.contextPath}/img/silver_coin.gif"> ${resultList2[status.index].grade}등급
						</c:when>
						
						<c:when test="${resultList2[status.index].grade == 3}">
							<img class="dots" src="${pageContext.request.contextPath}/img/copper_coin.gif"> ${resultList2[status.index].grade}등급
						</c:when>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
			<tr>
				<th colspan="4">나쁨</th>
			</tr>
		</table>
		<div id="bad">	
			<table class="table table-bordered dataTable dataTable" id="bad1">
			<c:forEach begin="${resultList1.size()-10}" end="${resultList1.size()}" items="${resultList1}" var="rList1">
			<tr>
				<td id="bad1-1">${rList1.tob}</td>
				<td id="bad1-2">
					<c:choose>
						<c:when test="${rList1.grade == 1}">
							<img class="dots" src="${pageContext.request.contextPath}/img/gold_coin.gif"> ${rList1.grade}등급
						</c:when>
						
						<c:when test="${rList1.grade == 2}">
							<img class="dots" src="${pageContext.request.contextPath}/img/silver_coin.gif"> ${rList1.grade}등급
						</c:when>
						
						<c:when test="${rList1.grade == 3}">
							<img class="dots" src="${pageContext.request.contextPath}/img/copper_coin.gif"> ${rList1.grade}등급
						</c:when>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
			</table>
			<table class="table table-bordered dataTable dataTable" id="bad2">
			<c:forEach begin="${resultList2.size()-10}" end="${resultList2.size()}" items="${resultList2}" var="rList2">
			<tr>
				<td id="bad2-1">${rList2.tob}</td>
				<td id="bad2-2">
					<c:choose>
						<c:when test="${rList2.grade == 1}">
							<img class="dots" src="${pageContext.request.contextPath}/img/gold_coin.gif"> ${rList2.grade}등급
						</c:when>
						
						<c:when test="${rList2.grade == 2}">
							<img class="dots" src="${pageContext.request.contextPath}/img/silver_coin.gif"> ${rList2.grade}등급
						</c:when>
						
						<c:when test="${rList2.grade == 3}">
							<img class="dots" src="${pageContext.request.contextPath}/img/copper_coin.gif"> ${rList2.grade}등급
						</c:when>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
			</table>
		</div>
	</div>
	
	<div id="subject3">
		<h5 class="figure font-weight-bold text-info text-left">3. 잠재고객분석</h5>
		<table class="table table-bordered dataTable dataTable" id="population">
			<thead>
				<tr>
					<th colspan="2">유동인구</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				<c:choose>
				<c:when test="${move1 > move2 }">
					<td class="pp"><strong class="bb"><fmt:formatNumber value="${move1}" pattern="#,###"/>명</strong></td>
					<td><fmt:formatNumber value="${move2}" pattern="#,###"/>명</td>
				</c:when>
				<c:otherwise>
					<td><fmt:formatNumber value="${move1}" pattern="#,###"/>명</td>
					<td class="pp"><strong class="bb"><fmt:formatNumber value="${move2}" pattern="#,###"/>명</strong></td>
				</c:otherwise>
				</c:choose>
				</tr>
			</tbody>
		</table>							
		<table class="table table-bordered dataTable dataTable" id="population">
			<thead>
				<tr>
					<th colspan="2">주거인구</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				<c:choose>
				<c:when test="${live1 > live2 }">
					<td class="pp"><strong class="bb"><fmt:formatNumber value="${live1}" pattern="#,###"/>명</strong></td>
					<td><fmt:formatNumber value="${live2}" pattern="#,###"/>명</td>
				</c:when>
				<c:otherwise>
					<td><fmt:formatNumber value="${live1}" pattern="#,###"/>명</td>
					<td class="pp"><strong class="bb"><fmt:formatNumber value="${live2}" pattern="#,###"/>명</strong></td>
				</c:otherwise>
				</c:choose>
				</tr>
			</tbody>
		</table>							
		<table class="table table-bordered dataTable dataTable" id="population">
			<thead>
				<tr>
					<th colspan="2">직장인구</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				<c:choose>
				<c:when test="${job1 > job2 }">
					<td class="pp"><strong class="bb"><fmt:formatNumber value="${job1}" pattern="#,###"/>명</strong></td>
					<td><fmt:formatNumber value="${job2}" pattern="#,###"/>명</td>
				</c:when>
				<c:otherwise>
					<td><fmt:formatNumber value="${job1}" pattern="#,###"/>명</td>
					<td class="pp"><strong class="bb"><fmt:formatNumber value="${job2}" pattern="#,###"/>명</strong></td>
				</c:otherwise>
				</c:choose>
				</tr>
			</tbody>
		</table>							
	</div>
	<br><br><br><br>
</div>