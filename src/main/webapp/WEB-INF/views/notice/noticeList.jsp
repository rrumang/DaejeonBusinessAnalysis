<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- Custom styles for this page -->
<link href="${pageContext.request.contextPath}/ex_img/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<style>
td:nth-child(1) {
	width : 10%;
}

td:nth-child(3) {
	width : 15%;
}

#query {
	width : 25%;
	display: inline-block;
}

#div02{
	margin-bottom : 10px;
}

#div03{
	padding : 24px;
}

.table-responsive{
	height : 557px;
}
</style>

<script>
	$(document).ready(function(){
		// 로그인한 회원 등급이 1, 관리자 일 때만 글쓰기 버튼 보임
		var member_grade = "${MEMBER_INFO.member_grade}";
		if(member_grade == 1){
			$("#div01").attr("style", "display:block;");
		}
		
		// 검색키워드가 있을 때 input에 유지
		var query = "${query}";
		if(query != ""){
			$("#query").val(query);
		}
	
		// tr을 클릭했을 때
		$(".noticeTr").on("click", function(){
			var notice_cd = $(this).data("cd");
			
			$("#notice_cd").val(notice_cd);
			$("#form01").submit();
		})
		
		$(".noticeTr").mouseover(function(){
			$(this).css("cursor", "pointer");
		    $(this).css("background-color", "#cbdce7");
		  });
	    
		$(".noticeTr").mouseout(function(){
	        $(this).css("background-color", "#ffffff");
	    });
		
		// 검색버튼을 클릭했을 때
		$("#searchBtn").on("click", function(e){
			e.preventDefault();
			
			var query2 = $("#query").val().trim();
			
			// 입력된 값이 없으면 첫 화면으로 이동
			if(query2 == ""){
				$("#query").val("");
				window.location.href="${pageContext.request.contextPath}/notice/noticeList";
			} else {
				$("#query").val(query2);
				$("#form02").submit();
			}
		})
		
		// 글쓰기 버튼 클릭했을 때
		$("#writeBtn").on("click", function(e){
			e.preventDefault();
		
			swal({
			  text: "게시글을 작성하시겠습니까?",
			  buttons: true,
			})
			.then((value) => {
			  if (value) {
			   	window.location.replace("${pageContext.request.contextPath}/notice/noticeAdd");
			  } else {
			    swal.close();
			  }
			});
		});
	});
	
	// 존재하지 않는 게시글 조회 시 메세지 출력
	$(function(){
		var message = "${MESSAGE}";
		if(message != ""){
			swal({
			    text: message,
			    closeModal: false,
			    icon: "warning",
			}).then(function() {
			    swal.close();
			});
		}
	});
</script>

<!-- Begin Page Content -->
<div id="div03" class="container-fluid">

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h3 class="m-0 font-weight-bold text-primary">공지사항</h3>
		</div>
		<div class="card-body">
			<div id="div02" class="text-right">
				<form id="form02" action="${pageContext.request.contextPath}/notice/noticeList" method="get">
					<input type="text" class="form-control" name="query" id="query" placeholder="제목을 입력해주십시오."/>
					<a href="#" id="searchBtn" class="btn btn-primary ">검색</a>
					<a href="${pageContext.request.contextPath}/notice/noticeList" class="btn btn-primary ">전체보기</a>
				</form>
			</div>
		
			<div class="table-responsive">
				<form id="form01" action="${pageContext.request.contextPath}/notice/noticeDetail" method="get">
					<input type="hidden" name="notice_cd" id="notice_cd"/>
				</form>

				<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
					<thead>
						<tr class="text-center bg-gray-200">
							<th>번호</th>
							<th>제목</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${!empty noticeList}">
								<c:forEach items="${noticeList}" var="noticeVo">
									<tr class="noticeTr" data-cd="${noticeVo.notice_cd}">
										<td class="text-center">
											<c:set var="notice_cd" value="${noticeVo.notice_cd}"/>
											${fn:substring(notice_cd,6,fn:length(notice_cd))}
										</td>
										<td>${noticeVo.notice_title}</td>
										<td class="text-center">
											<fmt:formatDate value="${noticeVo.notice_dt}" pattern="yyyy-MM-dd"/>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							
							<c:otherwise>
								<c:choose>
									<c:when test="${!empty query}">
										<tr>
											<td class="text-center" colspan="3">'${query}'(이)가 포함된 제목의 게시글이 존재하지 않습니다.</td>
										</tr>
									</c:when>
									
									<c:otherwise>
										<tr>
											<td class="text-center" colspan="3">게시글이 존재하지 않습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>							
							</c:otherwise>
						</c:choose>

					</tbody>
				</table>
			</div>

			<div id="div01" style="display:none;" class="text-right">
				<a id="writeBtn" href="#" class="btn btn-success btn-icon-split">
					<span class="icon text-white-50"><i class="fas fa-check"></i></span><span class="text">글쓰기</span>
				</a>
			</div>

			<div class="text-center">
				<ul class="pagination">

					<c:choose>
						<c:when test="${pageVo.page eq 1 || empty noticeList}">
							<li class="paginate_button page-item previous disabled">
								<span>&lt;&lt;</span>
								<span>&lt;</span>
							</li>
						</c:when>

						<c:otherwise>
							<li class="paginate_button page-item previous">
								<a href="${pageContext.request.contextPath}/notice/noticeList?page=1&pageSize=${pageVo.pageSize}<c:if test="${!empty query}">&query=${query}</c:if>">&lt;&lt;</a>
								<a href="${pageContext.request.contextPath}/notice/noticeList?page=${pageVo.page-1}&pageSize=${pageVo.pageSize}<c:if test="${!empty query}">&query=${query}</c:if>">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>

					<c:forEach var="i" begin="1" end="${paginationSize}" step="1">
						<c:choose>
							<c:when test="${pageVo.page eq i}">
								<li class="paginate_button page-item active">
									<span>${i}</span>
								</li>
							</c:when>
							
							<c:when test="${empty noticeList}">
							</c:when>

							<c:otherwise>
								<li class="paginate_button page-item">
									<a href="${pageContext.request.contextPath}/notice/noticeList?page=${i}&pageSize=${pageVo.pageSize}<c:if test="${!empty query}">&query=${query}</c:if>">${i}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<c:choose>
						<c:when test="${pageVo.page eq paginationSize || empty noticeList}">
							<li class="paginate_button page-item next disabled">
								<span>&gt;</span>
								<span>&gt;&gt;</span>
							</li>
						</c:when>

						<c:otherwise>
							<li class="paginate_button page-item next">
								<a href="${pageContext.request.contextPath}/notice/noticeList?page=${pageVo.page+1}&pageSize=${pageVo.pageSize}<c:if test="${!empty query}">&query=${query}</c:if>">&gt;</a>
								<a href="${pageContext.request.contextPath}/notice/noticeList?page=${paginationSize}&pageSize=${pageVo.pageSize}<c:if test="${!empty query}">&query=${query}</c:if>">&gt;&gt;</a>
							</li>
						</c:otherwise>
					</c:choose>

				</ul>
			</div>
		</div>
	</div>
</div>
<!-- /.container-fluid -->