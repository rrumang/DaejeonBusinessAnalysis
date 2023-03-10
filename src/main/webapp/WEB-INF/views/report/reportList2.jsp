<%@page import="kr.or.ddit.report.model.ReportVo"%>
<%@page import="kr.or.ddit.paging.model.PageVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
<style>
#base{
	width : 100%;
	height : auto;
	margin : 0 auto;	
}

#report{
	width : 1200px;
	height : auto;
	margin : 0 auto;
}
#icon{
	width : 23px;
	height : 25px;
}
#dataTable{
	text-align : center;
}
#select{
	width:150px;
}
#dataTable_length{
	float:right;
}
#ff{
	float:right;
}
#tob{
	width:25%;
}
#reg{
	width:20%;
}
#num{
	width:8%;
}
</style>
<script>
$(document).ready(function() {
	
	$(".reportTr").mouseover(function(){
	    $(this).css("background-color", "#cbdce7");
	  });
    
	$(".reportTr").mouseout(function(){
        $(this).css("background-color", "#ffffff");
    });
	
	var arr = new Array();
	var checkbox = "${checkbox}";
		
	// session에 checkbox 값이 있으면
	if(checkbox.length > 3){
		checkbox = checkbox.substr(1, checkbox.length-2);
		arr = checkbox.split(", ");
		console.log("checkbox : " + checkbox);
		
		for (var i = 0; i < arr.length; i++) {
			
			if($("input[value='" + arr[i] +"']").length != 0){
				$("input[value='" + arr[i] +"']").attr("checked", true);
			} 
		}
	}
	
	// 체크박스 값이 바뀔 때
	$("input[type=checkbox]").on("change", function(){
		// 체크해제할 경우
		if($(this).prop("checked") == false){
			var unChecked = $(this).val();
			
			// arr배열에 값이 있으면
			var idx = $.inArray(unChecked, arr);

			// arr 배열에서 삭제
			arr.splice(idx, 1);
			
			console.log("---삭제 후 배열--- : " + arr);
		} 
		// 체크할 경우
		var checkArr = $("input:checkbox:checked");
		
		console.log(checkArr);
		
		var st = arr.length + 1;
		
		for(i = 0; i < checkArr.length; i++){
			if($.inArray(checkArr[i].value, arr) == -1){
				console.log(checkArr[i].value);
					
				arr[st] = checkArr[i].value;
				st++;
			}
		};
		
		$.ajax({
			url : "${pageContext.request.contextPath}/report/setCheckBox",
			method : "post",
			traditional : true,
			data : {
				"reports" : arr
			},
			success : function(data){
				var list = data.checkbox;
				
				// 배열 초기화
				arr = [];
				
				for(i = 0; i < list.length; i++){
					arr[i] = list[i];
				}
				
				console.log("---추가 후 배열--- : ", arr);
			},
			error : function(err){
				console.log("에러 : " + err);
			}
		});
	});
	
	$("#csearchBtn").on("click", function(){
		if(arr.length != 2){
			swal("비교 분석할 보고서 2개를 선택해주세요");
		} else {
			$.ajax({
				url : "${pageContext.request.contextPath}/report/getReport",
				method : "post",
				traditional : true,
				data : {
					"reports" : arr
				},
				success : function(data){
					console.log(data.result);
					
					if(data.result == "true"){
						$("#arr").val(arr);
						console.log(arr);
						$("#comparison").submit();
					} else {
						swal("같은 종류의 보고서만 비교 가능합니다");
					}
				},
				error : function(err){
					console.log("에러 : " + err);
				}
			});
		}
	})
	
	//selectBox option설정
	$("#select option").each(function(){
		if($(this).val()=="${report_kind}"){
			$(this).attr("selected", "selected");
		}
	});
	
	//검색버튼
	$("#searchBtn").click(function() {
		var report_kind = $("#select option:selected").index();
		$("#report_kind").val(report_kind);
		$("#frm").submit();
	});
	
});
</script>
<br>
<!-- Begin Page Content -->
<div id="div03" class="container-fluid">
	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h3 class="m-0 font-weight-bold text-primary">분석보고서</h3>
		</div>
		
		<div class="card-body">

			<form action="${pageContext.request.contextPath }/report/reportList2"
				id="frm" method="post">
				<input type="hidden" id="report_kind" name="report_kind" />
			</form>

			<form action="${pageContext.request.contextPath }/report/comparison"
				id="comparison" method="post">
				<input type="hidden" id="arr" name="arr" />
			</form>

			<div id="search" class="row">
				<div class="col-sm-12 col-md-12">
					<div class="dataTables_length" id="dataTable_length">
						<select
							class="custom-select custom-select-sm form-control form-control-sm"
							id="select">
							<option value="0" selected>전체</option>
							<option value="1">상권분석</option>
							<option value="2">입지분석</option>
							<option value="3">수익분석</option>
							<option value="4">업종추천</option>
						</select>
						<button id="searchBtn" type="button"
							class="btn btn-primary btn-sm">검색</button>
						<button id="csearchBtn" type="button"
							class="btn btn-primary btn-sm">비교분석</button>
					</div>
				</div>
			</div>
			
			<br>
			
			<table class="table table-bordered dataTable" id="dataTable">
				<thead>
					<tr>
						<th>선택</th>
						<th id="num">번호</th>
						<th>보고서종류</th>
						<th id="reg">선택지역</th>
						<th id="tob">업종명</th>
						<th>분석일</th>
						<th>다시분석</th>
						<th>보기</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty reportList }">
							<td colspan="8">해당하는 데이터가 없습니다</td>
						</c:when>
					</c:choose>
					<c:forEach var="report" items="${reportList }" varStatus="status">
						<tr class="reportTr">
							<td>
							<input type='checkbox' id="report_cd" name="report_cd" value="${report.report_cd}" />
							</td>
							<td class="report_cd">${report.report_cd.substring(6)}</td>
							<c:choose>
								<c:when test="${report.report_kind == 1}">
									<td class="report_kind">상권분석</td>
								</c:when>
								<c:when test="${report.report_kind == 2}">
									<td class="report_kind">입지분석</td>
								</c:when>
								<c:when test="${report.report_kind == 3}">
									<td class="report_kind">수익분석</td>
								</c:when>
								<c:otherwise>
									<td class="report_kind">업종추천</td>
								</c:otherwise>
							</c:choose>
							<td class="region_cd">${addrList[status.index]}</td>
							<td class="tob_cd">${tobList[status.index]}</td>
							<td><fmt:formatDate value="${report.report_dt}" pattern="yyyy-MM-dd" /></td>
							<td><a href="${pageContext.request.contextPath}/report/reAnalysis?region_cd=${report.region_cd }&report_kind=${report.report_kind}&report_cd=${report.report_cd}" class="btn btn-primary btn-sm">다시분석</a></td>
							<td class="show"><a href="${pageContext.request.contextPath}/report/showReport?report_cd=${report.report_cd }&report_kind=${report.report_kind}"><img id="icon" src="${pageContext.request.contextPath}/img/report.png"/></a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<!--페이지네이션  -->
			<div class="text-center">
				<ul class="pagination">
					<c:choose>
						<c:when test="${pageVo.page == 1 || empty reportList }">
							<li class="disabled">
								<span>&lt;&lt;</span>
								<span>&lt;</span>
							</li>
						</c:when>
						
						<c:otherwise>
							<li>
								<a class=page href="${pageContext.request.contextPath}/report/reportList2?report_kind=${report_kind}&page=1&pageSize=${pageVo.pageSize}" data-page="1" data-size="${pageVo.pageSize}">&lt;&lt;</a>
								<a class=page href="${pageContext.request.contextPath}/report/reportList2?report_kind=${report_kind}&page=${pageVo.page - 1}&pageSize=${pageVo.pageSize}" data-page="${pageVo.page -1}" data-size="${pageVo.pageSize}">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>
					
					<c:forEach begin="1" end="${paginationSize }" step="1" var="i">
						<c:choose>
							<c:when test="${pageVo.page == i }">
								<li class="active">
									<span>${i }</span>
								</li>
							</c:when>
							
							<c:when test="${empty reportList}">
							</c:when>
							
							<c:otherwise>
								<li>
									<a class=page href="${pageContext.request.contextPath}/report/reportList2?report_kind=${report_kind}&page=${i}&pageSize=${pageVo.pageSize}"	data-page="${i }" data-size="${pageVo.pageSize }">${i }</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<c:choose>
						<c:when test="${pageVo.page == paginationSize || empty reportList }">
							<li class="disabled">
								<span>&gt;</span>
								<span>&gt;&gt;</span>
							</li>
						</c:when>
						
						<c:otherwise>
							<li>
								<a class=page href="${pageContext.request.contextPath}/report/reportList2?report_kind=${report_kind}&page=${pageVo.page + 1}&pageSize=${pageVo.pageSize}" data-page="${pageVo.page +1}" data-size="${pageVo.pageSize}">&gt;</a>
								<a class=page href="${pageContext.request.contextPath}/report/reportList2?report_kind=${report_kind}&page=${paginationSize}&pageSize=${pageVo.pageSize}" data-page="${paginationSize}" data-size="${pageVo.pageSize}">&gt;&gt;</a>
							</li>
						</c:otherwise>
					</c:choose>
					
				</ul>
			</div>	
			
		</div>
	</div>
</div>
