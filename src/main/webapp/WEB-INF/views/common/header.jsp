<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="kr.or.ddit.member.model.MemberVo"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#nav{
	width : 100%;
	margin : 0 auto;
}

#menu1{
	width : 900px;
	margin : 0 auto;
 	text-align : center;
 	color : black;
 	display : inline-block;
}

#img1{
	width : 500px;
	margin : 0 auto;
	text-align : left;
	float : left;
	margin-left : 0px;
}

.dropdown .dropdown-menu {
	font-size : 1rem;
}
</style>

<script>
	$(document).ready(function(){
		$(".logout").on("click",function(e){
			e.preventDefault();
			
			Kommunicate.logout();
			
			window.location.replace("${pageContext.request.contextPath}/logOut");
		})
	});
</script>
<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow" id="nav">
	<!--헤더메뉴  -->
	<div id="menu1">
		<div id="img1">
			<br>
	 		<img id="signal" src="${pageContext.request.contextPath}/img/대전상권분석.png" style="width : 180px; height:46px; float:left">
	 		<br><br>
			<h6 style="text-align:left; color:#A4BEDF">DaejeonBusinessAnalysis</h6>
				
		</div>
		<img id="img2" src="${pageContext.request.contextPath}/img/도시스.png" style="width : 600px; height : 107px; margin-right : -200px; float:left;"><br>
	</div>

	<!-- Topbar Navbar -->
	<ul class="navbar-nav ml-auto">

		<!-- Nav Item - User Information -->
		<li class="nav-item dropdown no-arrow">
		<a class="nav-link dropdown-toggle" href="#" id="userDropdown"
			role="button" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false"> <span
				class="mr-2 d-none d-lg-inline text-gray-600 h5">
				<c:set var="member_id" value="${MEMBER_INFO.member_id}"/>
					<c:if test="${member_id == null}">
						<c:set var="member_id" value="로그인"/>
					</c:if>
					[ ${member_id} ]
				</span>
		</a> 
		<%
			MemberVo SESSION_USER = (MemberVo)session.getAttribute("MEMBER_INFO");
			String member_id = "";
			if(SESSION_USER == null){
				member_id = "접속전입니다.";
			}else if(SESSION_USER.getMember_grade()==1){
				
			}else{
				member_id = SESSION_USER.getMember_id();
			}
		%>
		<% if(SESSION_USER == null){%>
		<!-- Dropdown - User Information -->
			<div
				class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
				aria-labelledby="userDropdown">
				
				<a class="dropdown-item" href="${pageContext.request.contextPath }/login"> 
				<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
					로그인
				</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="${pageContext.request.contextPath }/promise"> <i
					class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 회원가입
				</a> 
				
			</div>
			<%} else if(SESSION_USER.getMember_grade() == 2) {%>
			<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
				aria-labelledby="userDropdown">
				<a class="dropdown-item" href="${pageContext.request.contextPath}/report/reportList"> <i
					class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 분석이력
				</a> <a class="dropdown-item" href="${pageContext.request.contextPath}/myPage"> <i
					class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> 회원정보
				</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item logout" href="#"> 
				<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
					로그아웃
				</a>
			</div>
			<%} else if(SESSION_USER.getMember_grade() == 1) {%>
			<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
				aria-labelledby="userDropdown">
				<a class="dropdown-item" href="${pageContext.request.contextPath}/memberManager">
					<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 회원관리
				</a>
				<a class="dropdown-item" href="${pageContext.request.contextPath}/tobRecom/gofList">
					<i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> 업종추천 분석기준관리
				</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item logout" href="#"> 
				<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
					로그아웃
				</a>
			</div>
			<%} %>
	</ul>

</nav>
<!-- End of Topbar -->