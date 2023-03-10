<%@page import="kr.or.ddit.member.model.MemberVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>


#dataTable{
	text-align: center;
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
		var grade = "${grade}";
		
		member_id = null;
		
		$(".fireuser").parent().css("background","#ffe6e6");
		
		$(".member").on("click", function() {

			var grade = $(this).find(".grade").text();
			
			if(grade=="탈퇴회원"){
				swal({
				    text: "이미 탈퇴처리된 회원입니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
				});
				return;
			}
			
			member_id = $(this).find(".memberId").text();
			
			console.log(grade);
			
			$("#member_id").val(member_id);
			
			$(".member").css("background-color", "#fff");
			$(".fireuser").parent().css("background","#ffe6e6");
			$(this).css("background-color", "gray");
		})

		$("#memberFire").on("click", function() {
			
			if(member_id==null){
				swal({
				    text: "탈퇴할 회원을 선택하여주세요.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
				});
				return;
				
			}
			removeCheck();

		})
		$("#memberListSelect").on("click",function(){
			
			$("#frm2").submit();
		})

	})
	function removeCheck() {
		swal({
			  text: "정말 탈퇴하시겠습니까?",
			  buttons: true,
			})
			.then((value) => {
			  if (value) {
				  $("#frm").submit();
			  } else {
			    swal.close();
			  }
			});
	}
	
</script>

<div id="div03" class="container-fluid">
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h3 class="m-0 font-weight-bold text-primary">회원관리</h3>
		</div>
		
		<div class="card-body">
			<div class="text-right">
				<form id="frm2"action="${pageContext.request.contextPath }/memberManager" method="get">
					<input type="search" id="keyword" name="keyword" class="form-control" placeholder="아이디 또는 이름을 입력해주십시오.">
					<a href="#" id="memberListSelect" class="btn btn-primary ">검색</a>
					<a href="${pageContext.request.contextPath }/memberManager" class="btn btn-primary ">전체보기</a>
				</form>
			</div>
			
			<br>
			
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
					<thead>
						<tr class="bg-gray-200">
							<th>아이디</th>
							<th>이름</th>
							<th>생년월일</th>
							<th>이메일</th>
							<th>전화번호</th>
							<th>관심지역</th>
							<th>관심업종</th>
							<th>회원상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${memberList }" var="member">
							<tr class="member">
								<td class="memberId">${member.member_id }</td>
								<td>${member.member_name }</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${member.member_birth }"/></td>
								<td>${member.member_email }</td>
								<td>${member.member_tel }</td>
								<c:choose>
									<c:when test="${member.region_cd == 0 }"><td>-</td></c:when>
									<c:otherwise><td>${region_name.get(member.member_id)}</td></c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${member.tob_cd == ''}"><td>-</td></c:when>
									<c:otherwise><td>${region_name2.get(member.member_id)}</td></c:otherwise>
								</c:choose>
								
								<c:choose>
									<c:when test="${member.member_grade == 1}"><td class="grade">관리자</td></c:when>
									<c:when test="${member.member_grade == 2}"><td class="grade">일반회원</td></c:when>
									<c:when test="${member.member_grade == 3}"><td class="fireuser grade">탈퇴회원</td></c:when>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<div class="text-right">
				<button type="button" id="memberFire" class="btn btn-danger">회원탈퇴</button>
				<form id="frm" action="${pageContext.request.contextPath }/memberManager" method="post">
					<input type="hidden" id="member_id" name="member_id" />
					<input type="hidden" id="region_cd" name="region_cd" />
				</form>
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
								<a href="${pageContext.request.contextPath}/memberManager?page=1&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">&lt;&lt;</a>
								<a href="${pageContext.request.contextPath}/memberManager?page=${pageVo.page-1}&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">&lt;</a>
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
									<a href="${pageContext.request.contextPath}/memberManager?page=${i}&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">${i}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
		
					<c:choose>
						<c:when test="${pageVo.page eq paginationSize || empty memberList}">
							<li class="paginate_button page-item next disabled">
								<span>&gt;</span>
								<span>&gt;&gt;</span>
							</li>
						</c:when>
		
						<c:otherwise>
							<li class="paginate_button page-item next">
								<a href="${pageContext.request.contextPath}/memberManager?page=${pageVo.page+1}&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">&gt;</a>
								<a href="${pageContext.request.contextPath}/memberManager?page=${paginationSize}&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">&gt;&gt;</a>
							</li>
						</c:otherwise>
					</c:choose>
		
				</ul>
			</div>
		</div>
	</div>
</div>