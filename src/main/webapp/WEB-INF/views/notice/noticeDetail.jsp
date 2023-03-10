<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
#div03{
	padding : 24px;
}
.form-control[readonly]{
	background-color: #ffffff;
}
textarea{
	margin-top : 10px;
}
.label01{
	width : 60%;
}
</style>

<script>
	$(document).ready(function(){
		// 로그인한 회원 등급이 1, 관리자 일 때만 수정, 삭제 버튼 보임
		var member_grade = "${MEMBER_INFO.member_grade}";
		if(member_grade == 1){
			$("#modifyBtn").attr("style", "display:inline-block;");
			$("#deleteBtn").attr("style", "display:inline-block;");
		}
		
		// 삭제 버튼 클릭했을 때
		$("#deleteBtn").on("click", function(e){
			e.preventDefault();
		
			swal({
				  text: "게시글을 삭제하시겠습니까?",
				  buttons: true,
				})
				.then((value) => {
				  if (value) {
				   	window.location.replace("${pageContext.request.contextPath}/notice/noticeDelete?notice_cd=${noticeVo.notice_cd}");
				  } else {
				    swal.close();
				  }
				});
		});
		
		// 수정 버튼 클릭했을 때
		$("#modifyBtn").on("click", function(e){
			e.preventDefault();
		
			swal({
				  text: "게시글을 수정하시겠습니까?",
				  buttons: true,
				})
				.then((value) => {
				  if (value) {
				   	window.location.replace("${pageContext.request.contextPath}/notice/noticeModify?notice_cd=${noticeVo.notice_cd}");
				  } else {
				    swal.close();
				  }
				});
		});
		
		
	});
	
	// 존재하지 않는 파일 다운로드시
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

			<input type="text" class="form-control" value="${noticeVo.notice_title}" readonly/>
			<textarea class="form-control" rows="15" readonly>${noticeVo.notice_content}</textarea>
			
			<br>
			<h5 class="font-weight-bold text-primary">첨부파일</h5>
			<hr>

			<div class="col-sm-11">
				<dl>
					<c:choose>
						<c:when test="${empty attachList}">
							<dd>첨부된 파일이 없습니다.</dd>
						</c:when>

						<c:otherwise>
							<c:forEach items="${attachList}" var="attachVo">
								<dd>
									<label class="label01">${attachVo.attach_name}</label>
									<a href="${pageContext.request.contextPath}/attach/download?attach_cd=${attachVo.attach_cd}">다운로드</a>
								</dd>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</dl>
			</div>
			
			<div class="text-right">
				<a href="#" id="modifyBtn" style="display:none;" class="btn btn-primary ">수정</a>
				<a href="#" id="deleteBtn" style="display:none;" class="btn btn-primary ">삭제</a>
				<a href="${pageContext.request.contextPath}/notice/noticeList" class="btn btn-primary text-right">목록</a>
			</div>
			
		</div>
		
	</div>
</div>