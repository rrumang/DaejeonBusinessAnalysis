<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<style>
	.sidebar .nav-item .nav-link span{
		font-size : 22px;
	}
	.sidebar .nav-item .collapse .collapse-inner{
		font-size : 20px;
	}
	.sidebar .sidebar-heading{
		font-size : 16px;
	}
</style>
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

	<!-- Sidebar - Brand -->
	<a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath }/main"> 
		<img id="main_logo" src="${pageContext.request.contextPath}/img/메인로고.png" top="10">
	</a>

	<!-- 로고와 메뉴사이의 구분선 -->
	<hr class="sidebar-divider my-0">

	<!-- 구분선 2 -->
	<hr class="sidebar-divider">

	<!-- 사이드바 헤더 -->
	<div class="sidebar-heading">POJO</div>

	<!-- 사이드바 메뉴 -->
	<li class="nav-item ">
		<a class="nav-link collapsed" href="${pageContext.request.contextPath}/bdAnalysis/input" aria-expanded="true" aria-controls="collapseTwo">
			<i class="fas fa-fw fa-table"></i><span>상권분석</span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link collapsed" href="${pageContext.request.contextPath}/marginAnalysis/input" aria-expanded="true" aria-controls="collapseUtilities">
			<i class="fas fa-fw fa-chart-area"></i><span>수익분석</span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link collapsed" href="${pageContext.request.contextPath}/location/showLocation" aria-expanded="true" aria-controls="collapseUtilities">
			<i class="fas fa-flag"></i><span>입지분석</span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link collapsed" href="${pageContext.request.contextPath}/tobRecom/input" aria-expanded="true" aria-controls="collapseUtilities">
			<i class="fas fa-info-circle"></i><span>업종추천</span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link collapsed" aria-expanded="true" aria-controls="collapseUtilities">
			<i class="fas fa-check"></i><span>상권현황</span>
		</a>
		<div id="bdPrsct" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="${pageContext.request.contextPath}/bdPrsct/bdInvestigate">상권조사</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/bdPrsct/businessPrsct">업소현황</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/bdPrsct/salesPrsct">매출현황</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/bdPrsct/leasePrsct">임대시세현황</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/bdPrsct/fcPrsct">창/폐업률현황</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/bdPrsct/utilizePrsct">활용현황</a>
			</div>
		</div>
	</li>

	<!-- 메뉴&커뮤니티 구분선 -->
	<hr class="sidebar-divider">

	<!-- 2차 메뉴판 헤더 -->
	<div class="sidebar-heading">커뮤니티</div>

	<!-- Nav Item - Pages Collapse Menu(게시판)-->
	<li class="nav-item">
		<a class="nav-link collapsed" aria-expanded="true" aria-controls="collapsePages">
			<i class="fas fa-fw fa-folder"></i><span>게시판</span>
		</a>
		<div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="${pageContext.request.contextPath}/notice/noticeList">공지사항</a>
				<a class="collapse-item" href="${pageContext.request.contextPath }/faq/faqList">자주묻는질문</a>
				<a class="collapse-item" href="${pageContext.request.contextPath }/support/supportList">정부시책</a>
				<a class="collapse-item" href="${pageContext.request.contextPath }/freeBoard">자유게시판</a>
				<a class="collapse-item" href="${pageContext.request.contextPath }/suggestion">건의사항</a>
			</div>
		</div>
	</li>
</ul>
<!-- End of Sidebar -->