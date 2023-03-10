<%@page import="kr.or.ddit.support.model.ItemVo"%>
<%@page import="kr.or.ddit.support.model.ItemsVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
#base{
	width : 100%;
	height : auto;
	margin : 0 auto;	
}

#head{
	display:inline;
	width : 1100px;
	height : auto;
	margin : 0 auto;
}

#accordion-container {
	font-size: 17px;
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
	font-size: 20px;
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
	color:#6495ED; 
	background: white;
	background-repeat: no-repeat;
	background-position: right 50%;
}

.inactive-header:hover {
	color:#6495ED;
	background: #e5e5e5;
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
	padding: 10px 10px 10px 10px;
}
.text-center{
	left : 50%;
}
.btn btn-primary btn-icon-split btn-sm{
	color: #87F5F5;
}

</style>
<script>
	$(document).ready(function() {
		
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
		$('.accordion-header').click(function() {
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
<br>
<!-- Begin Page Content -->
<div id="div03" class="container-fluid">
	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h3 class="m-0 font-weight-bold text-primary">정부시책</h3>
		</div>
		<div class="card-body">
			<div id="accordion-container">
				<h2 class="accordion-header">정책자금</h2>
				<div class="accordion-content">
					<p class="p">
						<c:forEach items="${policyList }" var="policy">
							<a href="#" class="btn btn-primary btn-icon-split btn-sm">${policy.year }</a>
							<a href="javascript:void(window.open('${policy.url }','_blank'))">${policy.title}</a>
							<br><br>
						</c:forEach>
					</p>
				</div>
				<h2 class="accordion-header">성장지원</h2>
				<div class="accordion-content">
					<p class="p">
						<c:forEach items="${growthList }" var="growth">
							<a href="#" class="btn btn-primary btn-icon-split btn-sm">${growth.year }</a>
							<a href="javascript:void(window.open('${growth.url }','_blank'))">${growth.title}</a>
							<br><br>
						</c:forEach>
					</p>
				</div>
				<h2 class="accordion-header">재기지원</h2>
				<div class="accordion-content">
					<p class="p">
						<c:forEach items="${comebackList }" var="comeback">
							<a href="#" class="btn btn-primary btn-icon-split btn-sm">${comeback.year }</a>
							<a href="javascript:void(window.open('${comeback.url }','_blank'))">${comeback.title}</a>
							<br><br>
						</c:forEach>
					</p>
				</div>
				<h2 class="accordion-header">창업지원</h2>
				<div class="accordion-content">
					<p class="p">
						<c:choose>
							<c:when test="${empty foundationList}">
								<td colspan="8">지원시책이 없습니다</td>
							</c:when>
							<c:otherwise>
								<c:forEach items="${foundationList }" var="foundation">
									<a href="#" class="btn btn-primary btn-icon-split btn-sm">${foundation.year }</a>
									<a href="javascript:void(window.open('${foundation.url }','_blank'))">${foundation.title}</a>
									<br><br>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</p>
				</div>
				<h2 class="accordion-header">전통시장활성화</h2>
				<div class="accordion-content">
					<p class="p">
						<c:forEach items="${marketList }" var="market">
							<a href="#" class="btn btn-primary btn-icon-split btn-sm">${market.year }</a>
							<a href="javascript:void(window.open('${market.url }','_blank'))">${market.title}</a>
							<br><br>
						</c:forEach>
					</p>
				</div>
				<h2 class="accordion-header">보증지원</h2>
				<div class="accordion-content">
					<p class="p">
						<c:choose>
							<c:when test="${empty guaranteeList}">
								<td colspan="8">지원시책이 없습니다</td>
							</c:when>
							<c:otherwise>
								<c:forEach items="${guaranteeList }" var="guarantee">
									<a href="#" class="btn btn-primary btn-icon-split btn-sm">${guarantee.year }</a>
									<a href="javascript:void(window.open('${guarantee.url }','_blank'))">${guarantee.title}</a>
									<br><br>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</p>
				</div>
			</div>
			
		</div>
	</div>
</div>