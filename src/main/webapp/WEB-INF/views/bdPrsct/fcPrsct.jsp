<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			<h2>창/폐업률현황</h2>
			<br>
			<div class="card shadow col-12" id="info1">
				<div class="card-header">
					<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-info-circle"></i> 도움말</h6>
				</div>
				<div class="card-body">
					창/폐업률현황은 산업 및 사업자유형으로 분류한 대전광역시 사업체 창폐업 현황입니다<br>
					창/폐업률현황은 국세청에서 발표한 국세통계연보를 바탕으로 제공됩니다
				</div>
			</div>
			
			<table class="table table-bordered" id="resultTable">
				<caption><span id='br'>데이터 기준: 2017년</span></caption>
				<tr class='bg-gray-200'>
					<th rowspan="2">산업</th>
					<th colspan="4">사업자 현황</th>
					<th colspan="4">폐업자 현황</th>
					<th colspan="4">신규사업자 현황</th>
				</tr>
				<tr class='bg-gray-200'>
					<c:forEach begin="0" end="2">
						<th>법인<br>사업자</th>
						<th>일반<br>사업자</th>
						<th>간이<br>사업자</th>
						<th>면세<br>사업자</th>
					</c:forEach>
				</tr>
				<c:forEach begin="0" end="156" step="12" var="j" varStatus="status">
					<tr>
					<td>${fcList.get(j).industry_name}</td>
					<c:forEach begin="${status.current}" end="${status.current+11}" var="i">
						<td><fmt:formatNumber value="${fcList.get(i).bm_cnt}" pattern="#,###"/></td>
					</c:forEach>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>