<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	
	#base{
		width : 100%;
		height : auto;
		margin : 0 auto;
		color : black;
	}
	
	#subject, #subject3{
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
	
	#subject1, #subject2, #subject4{
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
	
	.stitle{
		font-weight: bold;
		color: brown;
		font-size: 1.1em;
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
	.btype{
		font-size: 1.1em;
		font-weight: bold;
		color: brown;
	}
	.trListRank{
		background-color: rgb(254,254,238);
		font-weight: bold;
		font-size: 1.1em;
	}
	.gPrint{
		font-size: 1.1em;
		font-weight: bold;
		color: blueviolet;
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
		<h2 class="figure font-weight-bold text-left">업종추천 비교 보고서</h2>&nbsp;&nbsp;
		<span onclick="fnMove('1')" class="fnMove">1. 종합 입지등급</span>&nbsp;
		<span onclick="fnMove('2')" class="fnMove">2. 업종별 입지등급</span>&nbsp;
		<span onclick="fnMove('3')" class="fnMove">3. 상권유형</span>&nbsp;
		<span onclick="fnMove('4')" class="fnMove">4. 상권유형과 적합도 높은 업종</span>&nbsp;
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
		<table class="table table-bordered dataTable">
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
		<h5 class="font-weight-bold text-info text-left">3. 상권유형</h5>
		<span class="stitle">1) 업종구성에 따른 상권유형</span><br>		
		<table class="table table-bordered dataTable dataTable">
			<thead>
				<tr>
					<th colspan="2">상권유형</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="btype">${resultMap1.btype}</td>
					<td class="btype">${resultMap2.btype}</td>
				</tr>
			</tbody>
		</table>
		
		<table class="table table-bordered dataTable dataTable">
			<thead>
				<tr>
					<th colspan="6">상권구성</th>
				</tr>
				<tr>
					<th>음식업</th>
					<th>소매업</th>
					<th>서비스업</th>
					<th>음식업</th>
					<th>소매업</th>
					<th>서비스업</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="btype">${resultMap1.foodPercent}%</td>
					<td class="btype">${resultMap1.retailPercent}%</td>
					<td class="btype">${resultMap1.servicePercent}%</td>
					<td class="btype">${resultMap2.foodPercent}%</td>
					<td class="btype">${resultMap2.retailPercent}%</td>
					<td class="btype">${resultMap2.servicePercent}%</td>
				</tr>
			</tbody>
		</table>

		<span class="stitle">2) 상권 내 밀집업종</span><br>
		
		<table class="table table-bordered dataTable dataTable">
			<thead>
				<tr>
					<th colspan="5">음식업</th>
				</tr>
				<tr>
					<th style="width: 20%">업종</th>
					<th style="width: 20%">상권 내 비율</th>
					<th style="width: 10%">순위</th>
					<th style="width: 20%">업종</th>
					<th style="width: 20%">상권 내 비율</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach begin="0" end="4" var="i">
					<tr>
						<td>${fList1.get(i).tob_name}</td>
						<td><fmt:formatNumber value="${fList1.get(i).inRegion}" pattern="0.0"/>%</td>
						<td class="trListRank">${i+1}</td>
						<td>${fList2.get(i).tob_name}</td>
						<td><fmt:formatNumber value="${fList2.get(i).inRegion}" pattern="0.0"/>%</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<table class="table table-bordered dataTable dataTable">
			<thead>
				<tr>
					<th colspan="5">소매업</th>
				</tr>
				<tr>
					<th style="width: 20%">업종</th>
					<th style="width: 20%">상권 내 비율</th>
					<th style="width: 10%">순위</th>
					<th style="width: 20%">업종</th>
					<th style="width: 20%">상권 내 비율</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach begin="0" end="4" var="i">
					<tr>
						<td>${rList1.get(i).tob_name}</td>
						<td><fmt:formatNumber value="${rList1.get(i).inRegion}" pattern="0.0"/>%</td>
						<td class="trListRank">${i+1}</td>
						<td>${rList2.get(i).tob_name}</td>
						<td><fmt:formatNumber value="${rList2.get(i).inRegion}" pattern="0.0"/>%</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<table class="table table-bordered dataTable dataTable">
			<thead>
				<tr>
					<th colspan="5">서비스업</th>
				</tr>
				<tr>
					<th style="width: 20%">업종</th>
					<th style="width: 20%">상권 내 비율</th>
					<th style="width: 10%">순위</th>
					<th style="width: 20%">업종</th>
					<th style="width: 20%">상권 내 비율</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach begin="0" end="4" var="i">
					<tr>
						<td>${sList1.get(i).tob_name}</td>
						<td><fmt:formatNumber value="${sList1.get(i).inRegion}" pattern="0.0"/>%</td>
						<td class="trListRank">${i+1}</td>
						<td>${sList2.get(i).tob_name}</td>
						<td><fmt:formatNumber value="${sList2.get(i).inRegion}" pattern="0.0"/>%</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<span class="stitle">3) 상권규모에 따른 상권유형</span><br>
		<table class="table table-bordered dataTable dataTable">
			<tr>
				<td class="gPrint" style="width: 50%">${rating1}등급</td>
				<td class="gPrint" style="width: 50%">${rating2}등급</td>
			</tr>
		</table>
		
		<span class="stitle">4) 주요 고객구성에 따른 상권유형</span><br>
		<table class="table table-bordered dataTable dataTable">
			<tr>
				<td class="gPrint" style="width: 50%">${gValue1}</td>
				<td class="gPrint" style="width: 50%">${gValue2}</td>
			</tr>
		</table>
		
		<span class="stitle">5) 소비수준에 따른 상권유형</span><br>
		<table class="table table-bordered dataTable dataTable">
			<tr>
				<td class="gPrint" style="width: 50%">${spendRating1}등급</td>
				<td class="gPrint" style="width: 50%">${spendRating2}등급</td>
			</tr>
		</table>
	</div>

	<div id="subject4">
		<h5 class="figure font-weight-bold text-info text-left">4. 상권유형과 적합도 높은 업종</h5>
		<table class="table table-bordered dataTable dataTable">
			<thead>
				<tr>
					<th>업종</th>
					<th>적합도</th>
					<th>순위</th>
					<th>업종</th>
					<th>적합도</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach begin="0" end="9" var="i">
					<tr>
						<td>${totalResultList1.get(i).tob_name}</td>
						<td><fmt:formatNumber value='${totalResultList1.get(i).point}' pattern='0'/></td>
						<td class="trListRank">${i+1}</td>
						<td>${totalResultList2.get(i).tob_name}</td>
						<td><fmt:formatNumber value='${totalResultList2.get(i).point}' pattern='0'/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>