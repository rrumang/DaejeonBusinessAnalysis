<%@page import="kr.or.ddit.faq.model.FaqVo"%>
<%@page import="kr.or.ddit.paging.model.PageVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<style>
#title1{
	text-align: left;
	width: 50%;
}

#dataTable {
	text-align: center;
}
table tr td:nth-child(1) {
	width : 14%;
}

table tr td:nth-child(3),table tr td:nth-child(4){
	width : 18%;
} 

#base {
	width: 100%;
	height: auto;
	margin: 0 auto;
}

#head {
	display: inline;
	width: 1100px;
	height: auto;
	margin: 0 auto;
}

#h2 {
	float: left;
}

#pages {
	text-align: center;
}

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
	height: 250px;
}

.p {
	overflow-y: scroll;
	height: 250px;
}

.text-center {
	left: 50%;
}

#modal {
	display: none;
	background-color: #FFFFFF;
	position: absolute;
	top: 300px;
	left: 200px;
	padding: 10px;
	border: 2px solid #E2E2E2;
	text-align: center;
	z-Index: 9999;
}

#addhead {
	width: 900px;
	height: auto;
	margin: 0 auto;
}

#faq_title {
	width: 750px;
	display: inline;
	float: left;
	height: 35px;
}

#addbutton {
	float: left;
	width: 100px;
	height: 35px;
	margin-left: 10px;
}

#closeBtn {
	float: right;
	width: 30px;
	height: 35px;
	margin-left: 10px;
	color: black;
}

#contents {
	width: 900px;
	height: auto;
	margin: 0 auto;
}

#mmodal {
	display: none;
	background-color: #FFFFFF;
	position: absolute;
	top: 300px;
	left: 200px;
	padding: 10px;
	border: 2px solid #E2E2E2;
	text-align: center;
	z-Index: 9999;
}

.mmodal #faq_title {
	width: 640px;
	display: inline;
	float: left;
	height: 35px;
}

#savebutton {
	float: left;
	width: 100px;
	height: 35px;
	margin-left: 10px;
}

#deletebutton {
	float: left;
	width: 100px;
	height: 35px;
	margin-left: 10px;
}

#mcloseBtn {
	float: right;
	width: 30px;
	height: 35px;
	margin-left: 10px;
	color: black;
}
.secret{
	color : #FFcc00;
}
.del{
	color: red;
}

#keyword{
	width: 25%;
	display: inline-block;
}
#fb_cd {
	width: 200px;
}
#div03{
	padding : 24px;
}
.table-responsive{
	height : 557px;
}
</style>

<script>
	$(document).ready(function() {
		var session_id3 = "${MEMBER_INFO}";
		if(session_id3!=""){
			$("#addBtn").css("display","inline-block");
		}
		
		$(".member").mouseover(function(){
			$(this).css("cursor", "pointer");
		    $(this).css("background-color", "#cbdce7");
		  });
		
		$(".member").mouseout(function(){
	        $(this).css("background-color", "#ffffff");
	    });
		
		$("#btn_btn_keyword").on("click",function(){
			
			$("#frm5").submit();
		})
		
		$(".member").on("click", function() {
			var member_id2 = "${MEMBER_INFO}";
			if(member_id2 == ""){
				swal({
	 			    text: "비회원은 건의사항 게시판을 이용할 수 없습니다.",
	 			    closeModal: false,
	 			    icon: "warning",
	 			}).then(function() {
	 		        swal.close();
	 			});
	 			return;
			}
			
			// 클릭한 게시글이 삭제된 게시글일 때
			if($(this).children().attr("class") == "del"){
				swal({
	 			    text: "삭제된 게시물입니다.",
	 			    closeModal: false,
	 			    icon: "warning",
	 			}).then(function() {
	 		        swal.close();
	 			});
	 			return;
			}
			
			var session_id = "${MEMBER_INFO.member_id}";
			
			if(session_id!=""){
				
				var grade = "${MEMBER_INFO.member_grade}";
				
				var suggestion_cd = $(this).find(".memberId").data("cd");
				$("#suggestion_cd").val(suggestion_cd);
	
				var member_id = $(this).find(".memberId").text();
				$("#member_id").val(member_id);
				
				var member_id2 = $(this).find(".memberId2").text();
				var status = $(this).find(".secret").text();
				var real_cd = 'suggestion'+member_id;
							
				if(status=="비밀글입니다."||status=="Re.  비밀글입니다."){
					
					if(grade == 1){
						$("#frm").submit();
					}else if(session_id != member_id2){
						
						if(status=="Re.  비밀글입니다."){
							$.ajax({
								url : "${pageContext.request.contextPath}/parentVo",
				
								method : "post",
				
								data : "real_cd="
										+ real_cd, 
				
								success : function(data) {
									if(session_id == data.parent){
										$("#frm").submit();
										return;
									}
								},
								error : function() {
									return;
								}
							});
						}
						return;
					}
				}
				$("#frm").submit();
			}
		});
		
		
		$("#btn_keyword").on("click",function(){
			$("#frm5").submit();
		})
		
		$("#addBtn").click(function() {
			if("${MEMBER_INFO}"==""){
				swal({
				    text: "로그인하여주세요.",
				    icon: "warning",
				}).then(function() {
				        swal.close();
				});
				return;
			}
		});
	});
</script>

<div id="div03" class="container-fluid">

	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h3 class="m-0 font-weight-bold text-primary">건의사항</h3>
		</div>
		
		<div class="card-body">
			<div class="text-right">
				<form id="frm5"action="${pageContext.request.contextPath }/suggestion">
						<input type="search" id="keyword" name="keyword" class="form-control" placeholder="제목 또는 아이디를 입력해주십시오.">
						<a href="#" id="btn_keyword" class="btn btn-primary ">검색</a>
						<a href="${pageContext.request.contextPath}/suggestion" class="btn btn-primary ">전체보기</a>
				</form>
				
				<div class="table-responsive">
					<div style="margin-bottom:10px;">
						<form id="frm" action="${pageContext.request.contextPath }/suBoard_Detail">
							<input type="hidden" id="member_id" name="member_id" />
							<input type="hidden" id="suggestion_cd" name="suggestion_cd" />
						</form>
					</div>
					
					<table class="table table-bordered m-0" id="dataTable" width="100%"
						cellspacing="0">
						<thead>
							<tr class="bg-gray-200">
								<th id="fb_cd">번호</th>
								<th id="title">제목</th>
								<th>작성자아이디</th>
								<th id="thDate">작성일</th>
							</tr>
						</thead>
			
						
						<c:forEach items="${suList }" var="suBoard">
							<tr class="member">
								<c:choose>
									
									<c:when test="${suBoard.sg_secret_yn eq 0 && suBoard.sg_yn eq 1}">
										<td class="memberId" data-cd="${suBoard.suggestion_cd}">${fn:substring(suBoard.suggestion_cd,10,13)}</td>
										<td id="title1" class="secret" ><c:if test="${suBoard.suggestion_cd2 ne null }"><span style="color : red;">Re.&nbsp;&nbsp;</span></c:if>비밀글입니다.</td>
										<td class="memberId2">${suBoard.member_id  }</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${suBoard.sg_dt }"/></td>
									</c:when>
									
									<c:when test="${suBoard.suggestion_cd2 ne null && suBoard.sg_yn eq 1 }">
										<td class="memberId" data-cd="${suBoard.suggestion_cd}">${fn:substring(suBoard.suggestion_cd,10,13)}</td>
										<td id="title1" class="secret"><span style="color : red;">Re.&nbsp;&nbsp;</span>${suBoard.sg_title  }</td>
										<td class="memberId2">${suBoard.member_id  }</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${suBoard.sg_dt }"/></td>		
									</c:when>
									<c:when test="${suBoard.sg_yn eq 1 }">
										<td class="memberId" data-cd="${suBoard.suggestion_cd}">${fn:substring(suBoard.suggestion_cd,10,13)}</td>
										<td id="title1">${suBoard.sg_title  }</td>
										<td class="memberId2">${suBoard.member_id  }</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${suBoard.sg_dt }"/></td>
									</c:when>
									<c:when test="${suBoard.sg_yn eq 0 && Board.sg_secret_yn eq 0 }">
										<td class="del" colspan="5">삭제된 게시물 입니다.</td>
									</c:when>
									<c:otherwise>
										<td class="del" colspan="5">삭제된 게시물 입니다.</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</table>
				</div>
				
				<div class="text-right" style="margin-top:10px;">
					<a id="addBtn" style=" display : none;" href="${pageContext.request.contextPath }/suggestionAdd" class="btn btn-success btn-icon-split">
						<span class="icon text-white-50"><i class="fas fa-check"></i></span><span class="text">글쓰기</span>
					</a>
				</div>
				
				<div class="text-center">
					<ul class="pagination">
	
						<c:choose>
							<c:when test="${pageVo.page eq 1}">
								<li class="paginate_button page-item previous disabled">
									<span>&lt;&lt;</span>
									<span>&lt;</span>
								</li>
							</c:when>
	
							<c:otherwise>
								<li class="paginate_button page-item previous">
									<a href="${pageContext.request.contextPath}/suggestion?page=1&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">&lt;&lt;</a>
									<a href="${pageContext.request.contextPath}/suggestion?page=${pageVo.page-1}&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">&lt;</a>
								</li>
							</c:otherwise>
						</c:choose>
	
						<c:forEach var="i" begin="1" end="${paginationSize}" step="1">
							<c:choose>
								<c:when test="${pageVo.page eq i}">
									<li class="paginate_button page-item active">
										<span>${i}</span>
									</li>
								</c:when>
	
								<c:otherwise>
									<li class="paginate_button page-item">
										<a href="${pageContext.request.contextPath}/suggestion?page=${i}&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">${i}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
	
						<c:choose>
							<c:when test="${pageVo.page eq paginationSize || empty suList}">
								<li class="paginate_button page-item next disabled">
									<span>&gt;</span>
									<span>&gt;&gt;</span>
								</li>
							</c:when>
	
							<c:otherwise>
								<li class="paginate_button page-item next">
									<a href="${pageContext.request.contextPath}/suggestion?page=${pageVo.page+1}&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">&gt;</a>
									<a href="${pageContext.request.contextPath}/suggestion?page=${paginationSize}&pageSize=${pageVo.pageSize}<c:if test="${!empty keyword}">&keyword=${keyword}</c:if>">&gt;&gt;</a>
								</li>
							</c:otherwise>
						</c:choose>
	
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>



