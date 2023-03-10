<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">

	$(document).ready(function() {
		captcha();
		$("#btn01").on("click",function(){
			var form01Data = $("#form01").serialize();
			console.log(form01Data);
			$.ajax({
				url : "/spring/captchaNkeyResult",
				data : form01Data,
				dataType:"json",
				success : function(data) {
					console.log(data);
					if(data.result==1){
						alert("인증성공");
					}else{
						alert("실패");
					}
				}
			});
		});
		
		$("#refresh").on("click",function(){
			captcha();
		});
	});
	
	
	function captcha() {
		$.ajax({
			method : 'post',
			url : "/spring/captchaNkey",
			dataType:"json",
			success : function(data) {
				
				console.log(data.key);
				$("#key").val(data.key);
				
				$.ajax({
					url : "/spring/captchaImage",
					method : 'get',
					data : "key=" + data.key ,
					success : function(data) {
						console.log(data);
						console.log(data.captchaImageName);
						$("#div01").html("<img src='captchaImage/"+data.captchaImageName+"'>");
					},error : function(xhr) {
						alert('에러'+xhr.status);
					}
				});
			},error : function(xhr) {
				alert('에러'+xhr.status);
			}
		});
		
	}
</script>
<body>
	<div id="div01">
	</div>
	<button type="button" id="refresh">새로고침</button><br>
	<form id="form01">
		<input type="hidden" id="key" name="key">
		<input type="text" name="value">
		<button type="button" id="btn01">전송</button>
	</form>
</body>
</html>