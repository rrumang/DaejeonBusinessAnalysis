<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
</style>
<script>
//내용은 1000자까지만 입력할 수 있음


	$(document).ready(function() {
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
		
		
		
		$("#savebutton").on("click",function(e){
			
			e.preventDefault();
			
			swal({
				  text: "게시글을 등록하시겠습니까?",
				  buttons: true,
			}).then((value) => {
			  if (value) {
				 // 입력 검증
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
				  var title = $("#fb_title").val();
				  $("#fb_title").val(ConvertSystemSourcetoHtmlTitle(title));
				  
				  var content = $("#fb_content").val();
				  $("#fb_content").val(ConvertSystemSourcetoHtmlContent(content));
				  
				  
				$("#frm").submit();	
			  }else {
				swal.close();
			}
			});
			
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
</head>
<body>
	<div class="card card-body mb-4">
		<h1 class="h3 mb-2 text-gray-800">자유게시판 - 등록</h1>
		<br>
		<form action="${pageContext.request.contextPath }/insertfreeboard" method="post" id="frm">
			<div id="head">
				<input type="text" id="fb_title" name="fb_title" placeholder="제목을 입력하세요" class="form-control form-control-user" />
			</div>
			<br>
			<div id="contents">
				<textarea name="fb_content" id="fb_content" placeholder="내용을 입력하세요" class="form-control form-control-user"
					rows="20" cols="150"></textarea>
			</div>
			<br>
			<div class="text-right">
			<button type="submit" id="savebutton" class="btn btn-success btn-icon-split">
				<span class="icon text-white-50"><i class="fas fa-check"></i></span>
				<span class="text">등록</span>
			</button>
			<a href="${pageContext.request.contextPath }/freeBoard" class="btn btn-danger btn-icon-split">
				<span class="icon text-white-50"><i class="fas fa-check"></i></span>
				<span class="text">취소</span>
			</a>
			</div>
		</form>

	</div>


</body>
</html>