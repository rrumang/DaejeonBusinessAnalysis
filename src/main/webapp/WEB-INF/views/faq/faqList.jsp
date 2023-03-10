<%@page import="kr.or.ddit.faq.model.FaqVo"%>
<%@page import="kr.or.ddit.paging.model.PageVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" src="../ex_img/js/Example.Modal.js"></script>

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

#addBtn{
	float:right;
}

#pages{
	text-align : center;
}

#accordion-container {
	font-size: 20px;
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
	background-repeat: no-repeat;
	background-position: right 50%;
	background-color: #6495ED;
}

.active-header:hover {
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
	padding : 15px;
}

.p{
	overflow-y: scroll;
	height : 220px;
	font-family: 'Nanum Gothic', sans-serif;
}
.text-center{
	left : 50%;
}

#modal{
	display:none;
	background-color : #FFFFFF;
	position : absolute;
	top:300px;
	left:200px;
	padding:10px;
	border:2px solid #E2E2E2;
	text-align: center;
	z-Index:9999;
}
#addhead{
	width : 900px;
	height : auto;
	margin : 0 auto;
}
	
#faq_title{
	width : 745px;
	display:inline;
	float:left;
	height: 35px;
}

#addbutton{
	float:left;
	margin-left : 10px;
}

#closeBtn{
	float:right;
	width : 38px;
	height: 40px;
	margin-left : 10px;
}

#contents{
	width : 900px;
	height : auto;
	margin : 0 auto;
}

#mmodal{
	display:none;
	background-color : #FFFFFF;
	position : absolute;
	top:300px;
	left:200px;
	padding:10px;
	border:2px solid #E2E2E2;
	text-align: center;
	z-Index:9999;
}

.mmodal #faq_title{
	width : 640px;
	display:inline;
	float:left;
	height: 35px;
}

#savebutton{
	float:left;
	margin-left : 10px;
}

#deletebutton{
	float:left;
	margin-left : 10px;
}

#mcloseBtn{
	float:right;
	width : 38px;
	height: 40px;
	margin-left : 10px;
	color : black;
}
i{
	text-align : center;
}
#xBtn{
	width : 40px;
	height : 40px;
}

#query {
	width : 25%;
	display: inline-block;
}

#div02{
	margin-bottom : 10px;
}
</style>
<script>
	$(document).ready(function() {
		// 엔터키 submit 안되게 막기
		$("input").keydown(function() {
			if (event.keyCode === 13) {
			 	 event.preventDefault();
			};
		});
		
		// 검색키워드가 있을 때 input에 유지
		var query = "${query}";
		if(query != ""){
			$("#query").val(query);
		}
		
		// 검색버튼을 클릭했을 때
		$("#searchBtn").on("click", function(e){
			e.preventDefault();
			
			var query2 = $("#query").val().trim();
			
			// 입력된 값이 없으면 첫 화면으로 이동
			if(query2 == ""){
				$("#query").val("");
				window.location.href="${pageContext.request.contextPath}/faq/faqList";
			} else {
				$("#query").val(query2);
				$("#form02").submit();
			}
		})
				
		//등록 모달창 인스턴스 생성
		var myModal = new Example.Modal({
			id:"modal" //모달 창 아이디 지정
		});
		//모달창 여는 버튼에 이벤트 걸기
		$("#addBtn").click(function() {
			myModal.show(); // 모달창 보여주기
		});
		// 등록시 제목은 80자까지만 입력할 수 있음
		$(".tt #faq_title").keyup(function(){
			var title = $(this).val();
			
			if(title.length > 80){
				swal({
				    text: "최대 80자까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $(".tt #faq_title").val(title.substr(0,80));
			        $(".tt #faq_title").focus();
				});
			};
		})
		// 등록시 내용은 1000자까지만 입력할 수 있음
		$(".tt #faq_content").keyup(function(){
			var content = $(this).val();
			
			if(content.length > 1000){
				swal({
				    text: "최대 1000자까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $(".tt #faq_content").val(content.substr(0,1000));
			        $(".tt #faq_content").focus();
				});
			};
		})
		// 모달 창 안에 있는 확인 버튼에 이벤트 걸기
		$("#addbutton").on("click", function() {
			if ($(".tt #faq_title").val() == "") {
				swal({
				    text: "제목을 입력해주세요",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
					$(".tt #faq_title").focus();
				});
			} else if ($(".tt #faq_content").val() == "") {
				swal({
				    text: "내용을 입력해주세요",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
					$(".tt #faq_content").focus();
				});
			} else {
				swal({
					text : "글을 등록하시겠습니까?",
					icon : "warning",
					buttons : [ '아니요', '예' ],
				}).then(function(isConfirm) {
					if (isConfirm) {
						// 제목과 내용에 특수기호 ', ", <, >, \n 이 포함되어있으면 변경
						var title = $(".tt #faq_title").val();
						$(".tt #faq_title").val(ConvertSystemSourcetoHtmlTitle(title));
						 
						var content = $(".tt #faq_content").val();
						$(".tt #faq_content").val(ConvertSystemSourcetoHtmlContent(content));
						  
						$("#addfrm").submit();
						myModal.hide(); // 모달창 감추기
					}
				});
			}
		});
		// 모달 창 안에 있는 X버튼에 이벤트 걸기
		$("#closeBtn").click(function() {
		    myModal.hide(); // 모달창 감추기
		});
				
		//수정,삭제 모달창 인스턴스 생성
		var myMModal = new Example.Modal({
			id:"mmodal" //모달 창 아이디 지정
		});
		//모달창 여는 버튼에 이벤트 걸기
		$(".accordion-content").dblclick(function() {
			if(${grade}==1){
				var faq_cd = $(this).find("#faq_cd2").val();
				$(".mmodal #faq_cd").val(faq_cd);
				var faq_title = $(this).find("#faq_title").val();
				$(".mmodal #faq_title").val(faq_title);
				var faq_content = $(this).find("#faq_content").val();
				$(".mmodal #faq_content").val(faq_content);
				myMModal.show(); // 모달창 보여주기
			}
		});
		// 수정시 제목은 80자까지만 입력할 수 있음
		$(".mmodal #faq_title").keyup(function(){
			var title = $(this).val();
			
			if(title.length > 80){
				swal({
				    text: "최대 80자까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $(".mmodal #faq_title").val(title.substr(0,80));
			        $(".mmodal #faq_title").focus();
				});
			};
		})
		// 수정시 내용은 1000자까지만 입력할 수 있음
		$(".mmodal #faq_content").keyup(function(){
			var content = $(this).val();
			
			if(content.length > 1000){
				swal({
				    text: "최대 1000자까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $(".mmodal #faq_content").val(content.substr(0,1000));
			        $(".mmodal #faq_content").focus();
				});
			};
		})
		// 모달 창 안에 있는 확인 버튼에 이벤트 걸기
		$("#savebutton").on("click", function(){
			if ($(".mmodal #faq_title").val() == "") {
				swal({
				    text: "제목을 입력해주세요",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
					$(".mmodal #faq_title").focus();
				});
			} else if ($(".mmodal #faq_content").val() == "") {
				swal({
				    text: "내용을 입력해주세요",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
					$(".mmodal #faq_content").focus();
				});
			} else {
				swal({
					text : "글을 수정하시겠습니까?",
					icon : "warning",
					buttons : [ '아니요', '예' ],
				}).then(function(isConfirm) {
					if (isConfirm) {
						// 제목과 내용에 특수기호 ', ", <, >, \n 이 포함되어있으면 변경
						var title = $(".mmodal #faq_title").val();
						$(".mmodal #faq_title").val(ConvertSystemSourcetoHtmlTitle(title));
						  
						var content = $(".mmodal #faq_content").val();
						$(".mmodal #faq_content").val(ConvertSystemSourcetoHtmlContent(content));
						
						$("#modfrm").submit();
						myModal.hide(); // 모달창 감추기
					}
				});
			}
		});
				
		$("#deletebutton").on("click", function(){
			swal({
				title : "글을 지우시겠습니까?",
				icon : "warning",
				buttons : [ '아니요', '예' ],
			}).then(function(isConfirm) {
				if (isConfirm) {
					$("#delfrm").submit();
				}
			});
		});
		
		$("#mcloseBtn").click(function() {
		    myMModal.hide(); // 모달창 감추기
		});
		
		/* =======================어코디언 시작=======================  */
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
				if($(this).is('.inactive-header')) {
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
<br>
<!-- Begin Page Content -->
<div id="div03" class="container-fluid">
	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h3 class="m-0 font-weight-bold text-primary">자주묻는질문</h3>
		</div>
		<div class="card-body">
		
			<div id="div02" class="text-right">
				<form id="form02" action="${pageContext.request.contextPath}/faq/faqList" method="get">
					<input type="text" class="form-control" name="query" id="query" placeholder="제목을 입력해주십시오."/>
					<a href="#" id="searchBtn" class="btn btn-primary ">검색</a>
					<a href="${pageContext.request.contextPath}/faq/faqList" class="btn btn-primary ">전체보기</a>
				</form>
			</div>
		
			<form action="${pageContext.request.contextPath }/faq/faqModify" id="frm">
				<input type="hidden" id="faq_cd" name="faq_cd" />
			</form>
			
			<c:choose>
				<c:when test="${!empty faqList}">
					<div id="accordion-container">
						<c:forEach items="${faqList }" var="faq">
							<c:choose>
								<c:when test="${faq.faq_yn == 1 }">
									<h2 class="accordion-header">${faq.faq_title}</h2>
									<div class="accordion-content">
										<pre class="p">${faq.faq_content}</pre>
										<input type="hidden" id="faq_cd2" name="faq_cd2" value="${faq.faq_cd }" />
										<input type="hidden" id="faq_title" name="faq_title" value="${faq.faq_title}" />
										<input type="hidden" id="faq_content" name="faq_content" value="${faq.faq_content}" />
									</div>
								</c:when>
							</c:choose>
						</c:forEach>
					</div>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${!empty query}">
							<div class="text-center">'${query}'(이)가 포함된 제목의 게시글이 존재하지 않습니다</div>
						</c:when>
						<c:otherwise>
							<div class="text-center">게시글이 존재하지 않습니다</div>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
			
			<br>
			
			<div id="head">
				<a id="addBtn" href="#" class="btn btn-success btn-icon-split">
					<c:if test="${grade == 1}">
					<span class="icon text-white-50"><i class="fas fa-check"></i></span><span class="text">글쓰기</span>
					</c:if>
				</a>
			</div>
			
			<div id="pages">
				<ul class="pagination">
					<c:choose>
						<c:when test="${pageVo.page == 1 || empty faqList}">
							<li class="disabled">
								<span>&lt;&lt;</span>
								<span>&lt;</span>
							</li>
						</c:when>
						
						<c:otherwise>
							<li>
								<a href="${pageContext.request.contextPath}/faq/faqList?page=1&pageSize=${pageVo.pageSize}<c:if test="${!empty query}">&query=${query}</c:if>">&lt;&lt;</a>
								<a href="${pageContext.request.contextPath}/faq/faqList?page=${pageVo.page-1}&pageSize=${pageVo.pageSize}<c:if test="${!empty query}">&query=${query}</c:if>">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>
					
					<c:forEach begin="1" end="${paginationSize }" step="1" var="i">
						<c:choose>
							<c:when test="${pageVo.page == i }">
								<li class="active">
									<span>${i }</span>
								</li>
							</c:when>
							
							<c:when test="${empty faqList}">
							</c:when>
							
							
							<c:otherwise>
								<li>
									<a href="${pageContext.request.contextPath}/faq/faqList?page=${i}&pageSize=${pageVo.pageSize}<c:if test="${!empty query}">&query=${query}</c:if>">${i }</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<c:choose>
						<c:when test="${pageVo.page == paginationSize || empty faqList}">
							<li class="disabled">
								<span>&gt;</span>
								<span>&gt;&gt;</span>
							</li>
						</c:when>
						
						<c:otherwise>
							<li>
								<a href="${pageContext.request.contextPath}/faq/faqList?page=${pageVo.page+1}&pageSize=${pageVo.pageSize}<c:if test="${!empty query}">&query=${query}</c:if>">&gt;</a>
								<a href="${pageContext.request.contextPath}/faq/faqList?page=${paginationSize}&pageSize=${pageVo.pageSize}<c:if test="${!empty query}">&query=${query}</c:if>">&gt;&gt;</a>
							</li>
						</c:otherwise>
					</c:choose>
					
				</ul>
			</div>
			
		</div>
	</div>
</div>

<!--등록창  -->
<div id="modal" class="tt">
	<form action="${pageContext.request.contextPath }/faq/faqAdd" method="post" id="addfrm">
		<div id="addhead">
			<input type="text" id="faq_title" name="faq_title" placeholder="제목을 입력하세요" class="control-label"/>
			<a href="#" id="addbutton" class="btn btn-success btn-icon-split">
				<span class="icon text-white-50"><i class="fas fa-check"></i></span>
				<span class="text">등록</span>
			</a>
			
			<a href="#" id="closeBtn">
				<img onclick="document.getElementById('reset').click()" id="xBtn" src="${pageContext.request.contextPath}/img/x버튼.png">
			</a>
			<input type='reset' id="reset" style="display:none;">
		</div>
		<br><br>
		<div id="contents">
			<textarea name="faq_content" id="faq_content" placeholder="내용을 입력하세요" rows="10" cols="100"
				style="width: 900px; height: 400px;"></textarea>
		</div>
	</form>
</div>

<!--수정/삭제창  -->
<div id="mmodal" class="mmodal">
	<form action="${pageContext.request.contextPath }/faq/faqDelete" method="post" id="delfrm">
		<input type="hidden" id="faq_cd" name="faq_cd" class="control-label" value="" />
	</form>
	
	<form action="${pageContext.request.contextPath }/faq/faqModify" method="post" id="modfrm">
		<div id="addhead">
			<input type="text" id="faq_title" name="faq_title" class="control-label" value=""/>
			<input type="hidden" id="faq_cd" name="faq_cd" class="control-label" value=""/>
			
			<a href="#" id="savebutton" class="btn btn-success btn-icon-split">
				<span class="icon text-white-50"><i class="fas fa-check"></i></span>
				<span class="text">수정</span>
			</a>
			
			<a href="#" id="deletebutton" class="btn btn-danger btn-icon-split">
				<span class="icon text-white-50"><i class="fas fa-trash"></i></span>
				<span class="text">삭제</span>
			</a>
			
			<a href="#" id="mcloseBtn">
				<img id="xBtn" src="${pageContext.request.contextPath}/img/x버튼.png">
			</a>
		</div>
		
		<br><br>
		
		<div id="contents">
			<textarea name="faq_content" id="faq_content" rows="10" cols="100" style="width: 900px; height: 400px;"></textarea>
		</div>
	</form>
</div>
