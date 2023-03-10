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
	#info1{
		padding-left: 0;
		padding-right: 0;
	}
	#resultTable{
		margin-top: 40px;
		color: black;
		text-align: right;
	}
	caption{
		text-align: right;
		caption-side: top;
		font-weight: bold;
	}
	th{
		vertical-align: middle !important;
		text-align: center;
	}
</style>

<script>

</script>

<div class="col-sm-10 col-sm-offset-3 col-md-10 col-md-offset-2 main" id="base">
	<div id="subject">
		<div>
			<h2>임대시세현황</h2>
			<br>
			<div class="card shadow col-12" id="info1">
				<div class="card-header">
					<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-info-circle"></i> 도움말</h6>
				</div>
				<div class="card-body">
					점포 평균 임대시세는 한국감정원의 상업용부동산 임대동향 조사를 기반으로 작성된 자료입니다<br>
					자세한 자료는 한국감정원의 부동산 통계정보 시스템을 참고해 주시기 바랍니다
				</div>
			</div>
			
		<table class="table table-bordered" id="resultTable">
			<caption><span id='br'>데이터 기준: 2019년 1분기  단위 : 천원/㎡</span></caption>
			<tr class='bg-gray-200'>
				<th rowspan="2">지역</th>
				<th colspan="7">중대형</th>
				<th colspan="3">소규모</th>
			</tr>
			<tr class='bg-gray-200'>
				<th>지하1층</th>
				<th>1층</th>
				<th>2층</th>
				<th>3층</th>
				<th>4층</th>
				<th>5층</th>
				<th>6-10층</th>
				<th>지하1층</th>
				<th>1층</th>
				<th>2층</th>
			</tr>
			<c:forEach begin="0" end="50" step="10" var="j" varStatus="status">
				<tr>
				<td>${leaseList.get(j).leasearea}</td>
				<c:forEach begin="${status.current}" end="${status.current+9}" var="i">
					<c:choose>
						<c:when test="${leaseList.get(i).rent == 0.0}"><td>-</td></c:when>
						<c:otherwise><td>${leaseList.get(i).rent}</td></c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
			</c:forEach>
		</table>
		</div>
	</div>
</div>