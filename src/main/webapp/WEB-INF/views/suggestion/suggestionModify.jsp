<%@page import="kr.or.ddit.freeBoard.model.FreeBoardVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#delete {
	margin: 10px;
}

#modify {
	margin: 10px;
}

#reply {
	margin: 10px;
}

#back {
	float: right;
}

#check {
	margin: 10px;
}

#reply {
	float: right;
}

#fbc_title {
	width: 80%;
}

#fb_comment {
	width: 1235px;
}

#dataTable {
	text-align: center;
}

#cd {
	width: 15%;
}

#content1 {
	width: 50%;
}

#date {
	width: 15%;
}

#btn_comment {
	float: right;
}

#delete_1 {
	width: 10%;
}

#btn_trash {
	text-align: center;
	height: 80%;
}

#div01 {
	margin: 0 auto;
}

#div02 {
	margin: 0 auto;
}
</style>
<script>
	$(document).ready(function() {
		var session_id = "${memberId}";
		var writer_id = "${suggestionVo.member_id}";
		var commender = $("#commender").val();
		var grade = "${grade}";
		var replyStatus = "${reply_status}"
		var status2 = "${suggestionVo.suggestion_cd2}";
		
		$("#su_title").keyup(function(){
			var content = $(this).val();
			
			if(content.length > 50){
				swal({
				    text: "최대 50자까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#su_title").val(content.substr(0,50));
			        $("#su_title").focus();
				});
			};
		})
		$("#su_content").keyup(function(){
			var content = $(this).val();
			
			if(content.length > 1000){
				swal({
				    text: "최대 1000자까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#su_content").val(content.substr(0,1000));
			        $("#su_content").focus();
				});
			};
		})
		
		
		if(grade==1&&replyStatus==0){
			$("#reply").css("display","inline-block");
		}
		
		if(status2!=""){
			$("#reply").css("display","none");
		}
		
		$("#reply").on("click",function(){
			var parent = "${suggestionVo.suggestion_cd}";
			
			$("#sg_parent1").val(parent);
			$("#frm4").submit();
		})
		
		if(session_id!=""){
			$("#btn_comment").attr("disabled",false);
			$("#fb_comment").attr("placeholder","댓글을 입력해주세요");
		};
		
		if(session_id==writer_id||grade==1){
			$("#modify").attr("disabled",false);
			$("#delete").attr("disabled",false);
			$("#check").attr("disabled",false);
			
		};
		
		$("#btn_comment").on("click",function(){
			$("#frm3").submit();
		});
		
		$("#check").on("click",function(e){
			e.preventDefault();
			
			swal({
				  text: "게시글을 수정하시겠습니까?",
				  buttons: true,
			}).then((value) => {
			  if (value) {
				 // 입력 검증
				  if($("#su_title").val().trim() == ""){
					  swal({
					      text: "제목을 입력해주십시오",
					      closeModal: false,
					      icon: "warning",
					  }).then(function() {
				          swal.close();
				          $("#su_title").val("");
				          $("#su_title").focus();
					  });
					  return;
				  }
			  
				  if($("#su_content").val().trim() == ""){
					  swal({
					      text: "내용을 입력해주십시오",
					      closeModal: false,
					      icon: "warning",
					  }).then(function() {
				          swal.close();
				          $("#su_content").val("");
				          $("#su_content").focus();
					  });
					  return;
				  
				  } 
				  
				  var title = $("#su_title").val();
				  $("#su_title").val(ConvertSystemSourcetoHtmlTitle(title));
				  
				  var content = $("#su_content").val();
				  $("#su_content").val(ConvertSystemSourcetoHtmlContent(content));
				  
				  var su_cd = "${suggestionVo.suggestion_cd}";
				  $("#suggestion_cd2").val(su_cd);
				  
				  
				  $("#su_title2").val(title);
				  $("#su_content2").val(content);
				  
				  var su_yn = $("#su_secret_yn").val();
				  $("#su_secret_yn2").val(su_yn);
				  
				  $("#frm2").submit();
				  $("#reply").css("display","inline-block");
				  
				  
			  	}else {
				swal.close();
				}
			});
		});
		
		$("#delete").on("click",function(){
			
			var fb_cd = "${suggestionVo.suggestion_cd}";
			var parent = $(this).parent();
			$("#suggestion_cd1").val(fb_cd);
			
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
			$("#reply").css("display","none");
			$("#su_secret_yn").css("display","inline-block");
			$("#check").css("display","inline-block");
			$(this).css("display","none");
			$("#su_title").attr("readonly",false);
			$("#su_content").attr("readonly",false);
			
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
	<div id="div01" class="col-sm-10 col-sm-offset-3">
		<h1 class="h3 mb-2 text-gray-800">건의사항 - 상세보기</h1>
		<div>
			<a href="${pageContext.request.contextPath }/suggestion" id="back"
				class="btn btn-primary btn-icon-split"> <span
				class="icon text-white-50"><i class="fas fa-arrow-left"></i></span>
				<span class="text">목록</span>
			</a>
		</div>
		<form action="${pageContext.request.contextPath }/insertfreeboard"
			method="post" id="frm">

			<div id="head">
				<input type="text" id="su_title" name="su_title"
					value="${suggestionVo.sg_title}"
					class="form-control form-control-user" readonly />
			</div>
			<br>
			<div id="contents">
				<textarea name="su_content" id="su_content"
					class="form-control form-control-user" rows="20" cols="150"
					readonly>${suggestionVo.sg_content}</textarea>
				<br> <select class="form-control bg-light border-3 small"
					id="su_secret_yn" style="display: none;">
					<option value="1">공개글</option>
					<option value="0">비밀글</option>
				</select>
			</div>
			<br> <br>
			<h5 class="font-weight-bold text-primary">첨부파일</h5>
			<hr>
			
			<h5 id="h501" class="font-weight-bold text-primary">첨부파일</h5>
				<div class="text-right">
					<a href="#" id="addBtn" class="btn btn-primary ">첨부하기</a>
				</div>
				<hr>
				
				<div id="div01">
					<div class="fileDiv" class="col-sm-11">
						<input type="file" name="file" class="files" accept=".png, .gif, .jpg, .jpeg"/>
						<a href="#" class="btn btn-danger btn-circle deleteBtn">
	                    	<i class="fas fa-trash"></i>
	                  	</a>
					</div>
				</div>

			<div class="col-sm-11">
				<dl>
					<c:choose>
						<c:when test="${empty attachList}">
							<dd>첨부된 파일이 없습니다.</dd>
						</c:when>

						<c:otherwise>
							<c:forEach items="${attachList}" var="attachVo">
								<dd>
									<label class="label01">${attachVo.attach_name}</label> <a
										href="${pageContext.request.contextPath}/attach/download?attach_cd=${attachVo.attach_cd}">다운로드</a>
								</dd>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</dl>
			</div>
			<hr>
			<div class="text-right">
				<button type="button" id="check" style="display: none;"
					class="btn btn-success btn-icon-split">
					<span class="icon text-white-50"><i class="fas fa-check"></i></span>
					<span class="text">확인</span>
				</button>
				<button type="button" id="modify"
					class="btn btn-warning btn-icon-split" disabled>
					<span class="icon text-white-50"><i
						class="fas fa-info-circle"></i></span> <span class="text">수정</span>
				</button>
				<button type="button" id="delete"
					class="btn btn-danger btn-icon-split" disabled>
					<span class="icon text-white-50"><i class="fas fa-trash"></i></span>
					<span class="text">삭제</span>
				</button>
				<button type="button" style="display: none;" id="reply"
					class="btn btn-secondary btn-icon-split">
					<span class="icon text-white-50"><i
						class="fas fa-arrow-right"></i></span> <span class="text">답글</span>
				</button>
			</div>
		</form>
		<form action="${pageContext.request.contextPath }/SuggestionDlete"
			id="frm1">
			<input type="hidden" id="suggestion_cd1" name="suggestion_cd1" />
		</form>
		<form action="${pageContext.request.contextPath }/suggestionModify"
			method="post" id="frm2">
			<input type="hidden" id="suggestion_cd2" name="suggestion_cd2" /> <input
				type="hidden" id="su_title2" name="su_title2" /> <input
				type="hidden" id="su_content2" name="su_content2" /> <input
				type="hidden" id="su_secret_yn2" name="su_secret_yn2" />
		</form>
	</div>

	<br>
	<br>
	<hr>
	<br>
	<br>
	<div id="div02" class="col-sm-10 col-sm-offset-3">

		<div class="text-right"></div>
		<form id="frm4"
			action="${pageContext.request.contextPath }/suggestionAdd">
			<input type="hidden" id="sg_parent1" name="sg_parent1">
		</form>

	</div>

</body>
</html>