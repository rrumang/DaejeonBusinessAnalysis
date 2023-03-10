<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
<style>
	#base{
		width : 100%;
		height : auto;
		margin : 0 auto;	
	}
	
	#head{
		width : 900px;
		height : auto;
		margin : 0 auto;
	}
	
	#faq_title{
		width : 667px;
		display:inline;
		float:left;
		height: 35px;
	}
	
	#savebutton{
		float:left;
		height: 35px;
	}
	
	#contents{
		width : 900px;
		height : auto;
		margin : 0 auto;
	}
</style>
<script>
	$(document).ready(function() {
		$("#savebutton").on("click", function() {
			if($("#faq_title").val()==""){
				swal("제목을 입력해주세요")
			}else if($("#faq_content").val()==""){
				swal("내용을 입력해주세요")
			}else{
				swal({
					title : "Are you sure?",
					icon : "warning",
					buttons : [ 'No, cancel it!', 'Yes, I am sure!' ],
				}).then(function(isConfirm) {
					if (isConfirm) {
						$("#frm").submit();
					}
				});
			}
		});
	});
</script>
<div class="col-sm-10 col-sm-offset-3 col-md-10 col-md-offset-2 main" id="base">
	<form action="${pageContext.request.contextPath }/faq/faqAdd" method="post" id="frm">
		<div id="head">
			<input type="text" id="faq_title" name="faq_title" placeholder="제목을 입력하세요" class="control-label"/>
			<a href="#" id="savebutton" class="btn btn-success btn-icon-split">
				<span class="icon text-white-50"><i class="fas fa-check"></i></span>
				<span class="text">등록</span>
			</a>
		</div>
		<br><br>
		<div id="contents">
			<textarea name="faq_content" id="faq_content" placeholder="내용을 입력하세요" rows="10" cols="100"
				style="width: 766px; height: 412px;"></textarea>
		</div>
	</form>
</div>
