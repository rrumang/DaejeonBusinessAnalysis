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
		width : 570px;
		display:inline;
		float:left;
		height: 35px;
	}
	
	#deletebutton{
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
	$("#savebutton").on("click", function(){
		swal({
			title : "Are you sure?",
			icon : "warning",
			buttons : [ 'No, cancel it!', 'Yes, I am sure!' ],
		}).then(function(isConfirm) {
			if (isConfirm) {
				$("#frm").submit();
			}
		});
	});
	
	$("#deletebutton").on("click", function(){
		swal({
			title : "Are you sure?",
			icon : "warning",
			buttons : [ 'No, cancel it!', 'Yes, I am sure!' ],
		}).then(function(isConfirm) {
			if (isConfirm) {
				$("#frm2").submit();
			}
		});
	});
});
</script>
<div class="col-sm-10 col-sm-offset-3 col-md-10 col-md-offset-2 main" id="base">

	<form action="${pageContext.request.contextPath }/faq/faqDelete"
		method="post" id="frm2">
		<input type="hidden" id="faq_cd" name="faq_cd" class="control-label"
			value="${faqVo.faq_cd }" />
	</form>
	
	<form action="${pageContext.request.contextPath }/faq/faqModify" method="post" id="frm">
			<div id="head">
				<div id="head">
					<input type="text" id="faq_title" name="faq_title" class="control-label" value="${faqVo.faq_title }"/>
					<input type="hidden" id="faq_cd" name="faq_cd" class="control-label" value="${faqVo.faq_cd }"/>
					<a href="#" id="savebutton" class="btn btn-success btn-icon-split">
						<span class="icon text-white-50"><i class="fas fa-check"></i></span>
						<span class="text">수정</span>
					</a>
					<a href="#" id="deletebutton" class="btn btn-danger btn-icon-split">
						<span class="icon text-white-50"><i class="fas fa-trash"></i></span>
						<span class="text">삭제</span>
					</a>
				</div>
			</div>
			<br><br>
			<div id="contents">
				<textarea name="faq_content" id="faq_content" rows="10" cols="100"
					style="width: 766px; height: 412px;">${faqVo.faq_content }</textarea>
			</div>
	</form>
</div>
