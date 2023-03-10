<%@page import="kr.or.ddit.member.model.MemberVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<style>


#dataTable{
	text-align: center;
}

#keyword{
	float: right;
	width: 200px;
	text-align: center;
}
#memberListSelect{
	float: right;
	margin-left: 10px;
	margin-right: 30px;
}
#keyword_label{
	float: right;
	margin-left: 10px;
	margin-right: 30px;
	height: 20px;
}
/* #fireuser{ */
/* 	background-color: red; */
/* } */
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
</head>

<body>
	<div id="wrapper">


		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">


				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">회원</h1>



					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">전체회원목록</h6>
						</div>
					<div id="dataTable_filter" class="datatTables_filter">
						<br>
						<form id="frm2"
							action="${pageContext.request.contextPath }/memberSearch"
							method="get">
							<button type="button" class="btn btn-success"
								id="memberListSelect" border="1px solid black">검색</button>
							<input type="search" id="keyword" name="keyword" class="form-control form-control-user"
								placeholder="아이디 or 이름">
						</form>
					</div>
						<div class="card-body">
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
										<c:forEach items="${memberSelectList }" var="member">
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
								<button type="button" id="memberFire" class="btn btn-danger">회원탈퇴</button>
								<form id="frm" action="${pageContext.request.contextPath }/memberManager" method="post">
											<input type="hidden" id="member_id" name="member_id" />
											<input type="hidden" id="region_cd" name="region_cd" />
								</form>
							</div>
						</div>
					</div>

				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

</body>

</html>