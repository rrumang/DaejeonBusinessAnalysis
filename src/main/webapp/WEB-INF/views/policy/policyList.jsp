<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/common/basicLib.jsp"%>
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style>

#accordion-container {
	font-size: 15px;
	background: #ffffff;
	border: 1px solid #cccccc;
	padding: 5px 10px 10px 10px;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	border-radius: 5px;
	-moz-box-shadow: 0 5px 15px #cccccc;
	-webkit-box-shadow: 0 5px 15px #cccccc;
	box-shadow: 0 5px 15px #cccccc;
}

.accordion-header {
	font-size: 18px;
	background: #ebebeb;
	margin: 5px 0 0 0;
	padding: 5px 20px;
	border: 1px solid #cccccc;
	cursor: pointer;
	color: white;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	border-radius: 5px;
}

.active-header {
	-moz-border-radius: 5px 5px 0 0;
	-webkit-border-radius: 5px 5px 0 0;
	border-radius: 5px 5px 0 0;
	background: #cef98d;
	background-repeat: no-repeat;
	background-position: right 50%;
	background-color: #6495ED;
}

.active-header:hover {
	background: #c6f089;
	background-repeat: no-repeat;
	background-position: right 50%;
	background-color: #8CBDED;
}

.inactive-header {
	background: #ebebeb;
	background-repeat: no-repeat;
	background-position: right 50%;
}

.inactive-header:hover {
	background: #f5f5f5;
	background-repeat: no-repeat;
	background-position: right 50%;
}

.accordion-content {
	display: none;
	background: #ffffff;
	border: 1px solid #cccccc;
	border-top: 0;
	-moz-border-radius: 0 0 5px 5px;
	-webkit-border-radius: 0 0 5px 5px;
	border-radius: 0 0 5px 5px;
	height : 250px;
}

.p{
	overflow-y: scroll;
	height : 250px;
}
.text-center{
	left : 50%;
}
</style>
<script>
	$(document).ready(
			function() {
				$(".accordion-content").dblclick(function() {
					var faq_cd = $(this).find("#faq_cd2").val();
					$("#faq_cd").val(faq_cd);
					$("#frm").submit();
				});

				//Add Inactive Class To All Accordion Headers
				$('.accordion-header').toggleClass('inactive-header');

				//Set The Accordion Content Width
				var contentwidth = $('.accordion-header').width();
				// 				$('.accordion-content').css({
				// 					'width' : contentwidth
				// 				});

				//Open The First Accordion Section When Page Loads
				$('.accordion-header').first().toggleClass('active-header')
						.toggleClass('inactive-header');
				$('.accordion-content').first().slideDown().toggleClass(
						'open-content');

				// The Accordion Effect
				$('.accordion-header').click(
						function() {
							if ($(this).is('.inactive-header')) {
								$('.active-header')
										.toggleClass('active-header')
										.toggleClass('inactive-header').next()
										.slideToggle().toggleClass(
												'open-content');
								$(this).toggleClass('active-header')
										.toggleClass('inactive-header');
								$(this).next().slideToggle().toggleClass(
										'open-content');
							}

							else {
								$(this).toggleClass('active-header')
										.toggleClass('inactive-header');
								$(this).next().slideToggle().toggleClass(
										'open-content');
							}
						});

				return false;

			});
</script>
</head>
<body>
	<!-- header -->
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<!-- left영역 -->
			<%@include file="/WEB-INF/views/common/left.jsp"%>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<form action="${pageContext.request.contextPath }/faq/faqModify"
					id="frm">
					<input type="hidden" id="faq_cd" name="faq_cd" />
				</form>
				<div id="accordion-container">
					<h2 class="accordion-header">정책자금</h2>
					<div class="accordion-content">
						<p class="p">
							<c:forEach items="${itemsList }" var="items">
									<a href="${items.url }">${items.title}</a><br>
							</c:forEach>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>