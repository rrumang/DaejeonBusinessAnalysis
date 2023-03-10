<%@page import="kr.or.ddit.faq.model.FaqVo"%>
<%@page import="kr.or.ddit.paging.model.PageVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
#dataTable {
	text-align: center;
}

#title1{
	text-align: left;
	width:50%; 
	overflow:hidden; 
	text-overflow:ellipsis; 
	white-space:nowrap;
}

table tr td:nth-child(1) {
	width : 14%;
}

table tr td:nth-child(3),table tr td:nth-child(4){
	width : 18%;
} 


#h2 {
	float: left;
}

#pages {
	text-align: center;
}

.text-center {
	left: 50%;
}


.del{
	color: red;
}

#keyword{
	width: 25%;
	display: inline-block;
}
#div03{
	padding : 24px;
}

.table-responsive{
	height : 557px;
}
</style>
<script>
	$(document).ready(function() {
		var member_id = "${MEMBER_INFO}";
		if(member_id==""){
			$("#addBtn").css("display","none");
		}
		
		$(".del").on("click",function(){
			return false;
		});
		
		$(".member").mouseover(function(){
			$(this).css("cursor", "pointer");
		    $(this).css("background-color", "#cbdce7");
		  });
		
		$(".member").mouseout(function(){
	        $(this).css("background-color", "#ffffff");
	    });
		
		$(".member").on("click", function() {
			
			
			var freeboard_cd = $(this).find(".memberId").data("cd");
			
			$("#freeboard_cd").val(freeboard_cd);

// 			var member_id = $(this).find(".memberId").text();
// 			$("#member_id").val(member_id);

			$("#frm").submit();
			
		});
		
		$("#btn_keyword").on("click",function(){
			var keyword = $("#keyword").val().trim();
			$("#keyword").val(keyword);
			
			$("#frm5").submit();
		})
		
		$("#addBtn").click(function() {
						
			
			if($(USER_INFO)==null){
				swal({
				    text: "로그인하여주세요.",
				    icon: "warning",
				}).then(function() {
				        swal.close();
				});
				return;
				
			}
			
		});
	});
</script>

<div id="div03" class="container-fluid">

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h3 class="m-0 font-weight-bold text-primary">자유게시판</h3>
		</div>
		
		<div class="card-body">
			<div class="text-right">
				<form id="frm5"action="${pageContext.request.contextPath }/freeBoard" method="get">
					<input type="search" id="keyword" name="keyword" class="form-control" placeholder="제목 또는 아이디를 입력해주십시오.">
					<a href="#" id="btn_keyword" class="btn btn-primary ">검색</a>
					<a href="${pageContext.request.contextPath}/freeBoard" class="btn btn-primary ">전체보기</a>
				</form>
				
				<div class="table-responsive" style="width:100%;">
					
					<div style="margin-bottom:10px;">
						<form id="frm" action="${pageContext.request.contextPath }/freeBoard_Detail">
							<input type="hidden" id="freeboard_cd" name="freeboard_cd" />
						</form>
					</div>
					
					<table class="table table-bordered m-0" id="dataTable" width="100%"
						cellspacing="0">
						<thead>
							<tr class="bg-gray-200">
								<th id="fb_cd">번호</th>
								<th id="title">제목</th>
								<th>작성자아이디</th>
								<th id="thDate">작성일</th>
							</tr>
						</thead>
					
						<c:forEach items="${fBoardList }" var="fBoardList1">
							<tr class="member">
								
								<c:choose>
									<c:when test="${fBoardList1.fb_yn eq 1 }">
										<td class="memberId" data-cd="${fBoardList1.freeboard_cd}">${fn:substring(fBoardList1.freeboard_cd,9,12)}</td>
										<td id="title1">${fBoardList1.fb_title  }</td>
										<td>${fBoardList1.member_id  }</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${fBoardList1.fb_dt }"/></td>
									</c:when>
									
									<c:otherwise>
										<td class="del" colspan="5">삭제된 게시물 입니다.</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
						<c:choose>
							<c:when test="${empty fBoardList}">
								<td class="text-center" colspan="4">'${keyword}'(이)가 포함된 제목의 게시글이 존재하지 않습니다.</td>
							</c:when>
						</c:choose>
					</table>
				</div>
				
				<div class="text-right" style="margin-top:10px;">
					<a id="addBtn" href="${pageContext.request.contextPath }/freeBoardAdd" class="btn btn-success btn-icon-split">
						<span class="icon text-white-50"><i class="fas fa-check"></i></span><span class="text">글쓰기</span>
					</a>
				</div>
				
				<div class="text-center">
					<ul class="pagination">
	
						<c:choose>
							<c:when test="${pageVo.page eq 1}">
								<li class="paginate_button page-item previous disabled">
									<span>&lt;&lt;</span>
									<span>&lt;</span>
								</li>
							</c:when>
	
							<c:otherwise>
								<li class="paginate_button page-item previous">
									<a href="${pageContext.request.contextPath}/freeBoard?page=1&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">&lt;&lt;</a>
									<a href="${pageContext.request.contextPath}/freeBoard?page=${pageVo.page-1}&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">&lt;</a>
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
	
								<c:otherwise>
									<li class="paginate_button page-item">
										<a href="${pageContext.request.contextPath}/freeBoard?page=${i}&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">${i}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
	
						<c:choose>
							<c:when test="${pageVo.page eq paginationSize || empty fBoardList}">
								<li class="paginate_button page-item next disabled">
									<span>&gt;</span>
									<span>&gt;&gt;</span>
								</li>
							</c:when>
	
							<c:otherwise>
								<li class="paginate_button page-item next">
									<a href="${pageContext.request.contextPath}/freeBoard?page=${pageVo.page+1}&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">&gt;</a>
									<a href="${pageContext.request.contextPath}/freeBoard?page=${paginationSize}&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">&gt;&gt;</a>
								</li>
							</c:otherwise>
						</c:choose>
	
					</ul>
							
				</div>
			</div>
		</div>
	</div>
</div>



