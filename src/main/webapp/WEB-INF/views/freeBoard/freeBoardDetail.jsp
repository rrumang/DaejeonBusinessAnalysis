<%@page import="kr.or.ddit.freeBoard.model.FreeBoardVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#delete{
	margin : 10px;
}
#modify{
	margin : 10px;
}
#back{
	float : right;
}
#check{
	margin : 10px;
}
#fbc_title{
	width: 80%;
}
#fb_comment{
	width: 1235px;
}
#dataTable{
	text-align: center;
}
#cd{
	width : 15%;
}
#content1{
	width : 50%;
}
#date{
	width :15%;
}
#btn_comment{
	float: right;
}
#delete_1{
	width :10%;
}

#btn_trash{
	text-align: center;
	height: 80%;
}
#div12{
	margin: 0 auto;
}
#div13{
	margin: 0 auto;
}
.text-center1{
	margin: 0 auto;
}
#comment_text{
	width:  125%;
}

</style>
<script>
	$(document).ready(function() {
		$("input").keydown(function() {
			if (event.keyCode === 13) {
			 	 event.preventDefault();
			};
		});
		
		var session_id = "${memberId}";
		var writer_id = "${freeBoardVo1.member_id}";
		var commender = $("#commender").val();
		var grade = "${grade}";
		
		$("#fb_title").keyup(function(){
			var content = $(this).val();
			
			if(content.length > 50){
				swal({
				    text: "최대 50자까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#fb_title").val(content.substr(0,50));
			        $("#fb_title").focus();
				});
			};
		})
		
		
		
		$("#fb_content").keyup(function(){
			var content = $(this).val();
			
			if(content.length > 1000){
				swal({
				    text: "최대 1000자까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#fb_content").val(content.substr(0,1000));
			        $("#fb_content").focus();
				});
			};
		})
		
		
		if(session_id!=""){
			$("#btn_comment").attr("disabled",false);
			$("#fb_comment").attr("placeholder","댓글을 입력해주세요");
			$("#comment_text").attr("disabled",false);
		};
		
		if(session_id==writer_id||grade==1){
			$("#modify").css("display","inline-block")
			$("#delete").css("display","inline-block");
		};
		
		$("#btn_comment").on("click",function(){
			if($("#comment_text").val().trim().length==0){
				swal({
				    text: "댓글을 입력하여 주세요.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#btn_comment").focus();
			        return;
				});
				return;
			}
			
			$("#frm3").submit();
		});
		
		$("#check").on("click",function(e){
			
			e.preventDefault();
			swal({
				  text: "게시물을 수정하시겠습니까?",
				  buttons: true,
			})
			.then((value) => {
			  if (value) {
				  if($("#fb_title").val().trim() == ""){
					  swal({
					      text: "제목을 입력해주십시오",
					      closeModal: false,
					      icon: "warning",
					  }).then(function() {
				          swal.close();
				          $("#fb_title").val("");
				          $("#fb_title").focus();
					  });
					  return;
				  }
				  if($("#fb_content").val().trim() == ""){
					  swal({
					      text: "내용을 입력해주십시오",
					      closeModal: false,
					      icon: "warning",
					  }).then(function() {
				          swal.close();
				          $("#fb_content").val("");
				          $("#fb_content").focus();
					  });
					  return;
				  }
			
			var fb_cd = "${freeBoardVo1.freeboard_cd}";
			var fb_title = $("#fb_title").val();
			var fb_content = $("#fb_content").val();
			
			
			 $("#fb_title").val(ConvertSystemSourcetoHtmlTitle(fb_title));
			
			  $("#fb_content").val(ConvertSystemSourcetoHtmlContent(fb_content));
			
			$("#freeboard_cd2").val(fb_cd);
			$("#fb_title2").val(fb_title);
			$("#fb_content2").val(fb_content);
			
			$("#frm2").submit();
		} else {
	    	swal.close();
	  	}
	});
});
		
		$("#delete").on("click",function(){
			
			var fb_cd = "${freeBoardVo1.freeboard_cd}";
			var parent = $(this).parent();
			$("#freeboard_cd1").val(fb_cd);
			
			//
			swal({
				  text: "정말로 삭제하시겠습니까?",
				  buttons: true,
				})
				.then((value) => {
				  if (value) {
					  
					parent.empty();
					parent.append('삭제된 게시물입니다.');
					 $("#frm1").submit();
				  } else {
				    swal.close();
				  }
				});
			
		});
		
		$("#modify").on("click",function(){
			$("#check").css("display","inline-block");
			$(this).css("display","none");
			$("#fb_title").attr("readonly",false);
			$("#fb_content").attr("readonly",false);
			
		});
	});
	
	function ConvertSystemSourcetoHtmlTitle(str){
		 str = str.replace(/</g,"&lt;");
		 str = str.replace(/>/g,"&gt;");
		 str = str.replace(/\"/g,"&quot;");
		 str = str.replace(/\'/g,"&#39;");
		 str = str.replace(/\n/g,"<br/>");
		 return str;
	}
	
	function ConvertSystemSourcetoHtmlContent(str){
		 str = str.replace(/</g,"&lt;");
		 str = str.replace(/>/g,"&gt;");
		 str = str.replace(/\"/g,"&quot;");
		 str = str.replace(/\'/g,"&#39;");
		 return str;
	}
</script>
</head>
<body>
	<div id="div12" class="col-sm-10 col-sm-offset-3">
		<h1 class="h3 mb-2 text-gray-800">자유게시판 - 상세보기</h1>
		<div>
			<a href="${pageContext.request.contextPath }/freeBoard" id="back" class="btn btn-primary btn-icon-split">
				<span class="icon text-white-50"><i class="fas fa-exclamation-triangle"></i></span>
				<span class="text">목록</span>
			</a>
		</div>
		<br>
		
		<br>
		<form action="${pageContext.request.contextPath }/insertfreeboard" method="post" id="frm">
			
			<div id="head">
				<input type="text" id="fb_title" name="fb_title" value="${freeBoardVo1.fb_title}"  class="form-control form-control-user" readonly />
			</div>
			<br>
			<div id="contents">
				<textarea name="fb_content"  id="fb_content"  class="form-control form-control-user"
					rows="20" cols="150" readonly>${freeBoardVo1.fb_content}</textarea>
			</div>
			<br>
			<div class="text-right">
			<button type="button" style="display:none;" id="check" class="btn btn-success btn-icon-split">
				<span class="icon text-white-50"><i class="fas fa-check"></i></span>
				<span class="text">확인</span>
			</button>
			<button type="button" id="modify" class="btn btn-warning btn-icon-split" style="display : none;">
				<span class="icon text-white-50"><i class="fas fa-info-circle"></i></span>
				<span class="text">수정</span>
			</button>
			<button type="button" id="delete" class="btn btn-danger btn-icon-split" style="display : none;">
				<span class="icon text-white-50"><i class="fas fa-trash"></i></span>
				<span class="text">삭제</span>
			</button>
			
			</div>
		</form>
		<form action="${pageContext.request.contextPath }/Freedelete" id="frm1">
			<input type="hidden" id="freeboard_cd1" name="freeboard_cd1"/>
		</form>
		<form action="${pageContext.request.contextPath }/FreeModify" id="frm2">
			<input type="hidden" id="freeboard_cd2" name="freeboard_cd2"/>
			<input type="hidden" id="fb_title2" name="fb_title2"/>
			<input type="hidden" id="fb_content2" name="fb_content2"/>
		</form>
	</div>
	
	<br><br><hr><br><br>
	<div id="div13" class="col-sm-10 col-sm-offset-3">
		
		<table class="table " id="dataTable" width="100%" cellspacing="0">
			<thead>
				<tr>
					<th id="cd">댓글 번호</th>
					<th id="content1">내용</th>
					<th>작성자</th>
					<th id="date">작성일</th>
					<th id="delete_1">삭제</th>
					
				</tr>
			</thead>
			<c:forEach items="${comList }" var="com">
				<tr class="member">
					
					<c:choose>
						<c:when test="${com.cm_yn eq 1 }">
							<td id="comment_cd1" name="comment_cd1" class="memberId" data-cd="${com.comment_cd}" value="${com.comment_cd}">${fn:substring(com.comment_cd,7,10)}</td>
							<td class="text-left">${com.cm_content  }</td>
							<td id="commender" name="commender">${com.member_id  }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${com.cm_dt }"/></td>
							<td id="trash">
								<c:if test="${com.member_id == MEMBER_INFO.member_id || grade == 1 }">
									<a href="${pageContext.request.contextPath}/delete?comment_cd1=${com.comment_cd}"><i class="fas fa-trash"></i></a>
								</c:if>
							</td>
						</c:when>
						<c:otherwise>
							<td class="del" colspan="5" style="color: red">삭제된 댓글입니다.</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
		</table>
		
		<form id="frm4" action="${pageContext.request.contextPath }/delete" method="post">
			<input type="hidden" id="comment_cd2" name="comment_cd2">
		</form>
		
		
		<div class="form-group row">
			
				<div class="col-sm-9">
				<form id="frm3" action="${pageContext.request.contextPath }/Comment" method="post">
					<input id="comment_text" disabled type="text" maxlength="50" id="fb_comment" name="fb_comment" placeholder="로그인하신 회원만 이용가능합니다. [등록버튼 비활성화] "  class="form-control form-control-user" />
				</form>
				</div>
				<div class="col-sm-3">
				<button type="button" id="btn_comment" class="btn btn-secondary btn-icon-split" disabled>
					<span class="icon text-white-50"><i class="fas fa-arrow-right"></i></span>
					<span class="text">등록</span>
				</button>
			</div>
			</form>
			
			
		</div>
		
	</div>

</body>
</html>