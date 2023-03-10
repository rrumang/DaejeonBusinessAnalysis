<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript" src="ex_img/js/Example.Modal.js"></script>


<style>
* {
	margin: 0;
	padding: 0;
	list-style: none;
}

#content > *{
	font-size : 18px;
}

#main_logo {
	padding: 20;
	width: 30%;
}

.banner_img {
	width: 100%;
}

.banner {
	position: relative;
	width: 650px;
	height: 350px;
	top: 0px;
	margin: 0 auto;
	padding: 0;
	overflow: hidden;
}

.banner ul {
	position: absolute;
	margin: 0px;
	padding: 0;
	list-style: none;
}

.banner ul li {
	float: left;
	width: 650px;
	height: 350px;
	margin: 0;
	padding: 0;
}

.text12 {
	width: 300px;
	padding: 0 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

#gu {
	width: 150px;
}

#dong {
	width: 180px;
}

#slider-wrap {
	width: 100%;
	height: 400px;
	position: relative;
	overflow: hidden;
}

#slider-wrap ul#slider {
	height: 100%;
	position: absolute;
	top: 0;
	left: 0;
}

#slider-wrap ul#slider li {
	float: left;
	position: relative;
	width: 600px;
	height: 400px;
}

#slider-wrap ul#slider li>div {
	position: absolute;
	top: 20px;
	left: 35px;
}

#slider-wrap ul#slider li>div h3 {
	font-size: 36px;
	text-transform: uppercase;
}

#slider-wrap ul#slider li>div span {
	font-size: 21px;
}

#slider-wrap ul#slider li img {
	display: block;
	width: 100%;
	height: 100%;
}

/*btns*/
.slider-btns {
	position: absolute;
	width: 50px;
	height: 60px;
	top: 50%;
	margin-top: -25px;
	line-height: 57px;
	text-align: center;
	cursor: pointer;
	background: rgba(0, 0, 0, 0.1);
	z-index: 100;
	-webkit-user-select: none;
	-moz-user-select: none;
	-khtml-user-select: none;
	-ms-user-select: none;
	-webkit-transition: all 0.1s ease;
	-o-transition: all 0.1s ease;
	transition: all 0.1s ease;
}

.slider-btns:hover {
	background: rgba(0, 0, 0, 0.3);
}

#next {
	right: -50px;
	border-radius: 7px 0px 0px 7px;
	color: #eee;
}

#previous {
	left: -50px;
	border-radius: 0px 7px 7px 7px;
	color: #eee;
}

#slider-wrap.active #next {
	right: 0px;
}

#slider-wrap.active #previous {
	left: 0px;
}

/*bar*/
#slider-pagination-wrap {
	min-width: 20px;
	margin-top: 350px;
	margin-left: auto;
	margin-right: auto;
	height: 15px;
	position: relative;
	text-align: center;
}

#slider-pagination-wrap ul {
	width: 100%;
}

#slider-pagination-wrap ul li {
	margin: 0 4px;
	display: inline-block;
	width: 5px;
	height: 5px;
	border-radius: 50%;
	background: #fff;
	opacity: 0.5;
	position: relative;
	top: 0;
}

#slider-pagination-wrap ul li.active {
	width: 12px;
	height: 12px;
	top: 3px;
	opacity: 1;
	-webkit-box-shadow: rgba(0, 0, 0, 0.1) 1px 1px 0px;
	box-shadow: rgba(0, 0, 0, 0.1) 1px 1px 0px;
}

/*ANIMATION*/
#slider-wrap ul, #slider-pagination-wrap ul li {
	-webkit-transition: all 0.3s cubic-bezier(1, .01, .32, 1);
	-o-transition: all 0.3s cubic-bezier(1, .01, .32, 1);
	transition: all 0.3s cubic-bezier(1, .01, .32, 1);
}

#signal {
	width: 250px;
	height: 125px;
}

#data {
	width: 50px;
	height: 50px;
}

#service {
	width: 50px;
	height: 50px;
}

#team {
	width: 50px;
	height: 50px;
}

table {
	width: 100%;
	border: 2px solid #e4e8f0;
	border-collapse: collapse;
}

td {
	border: 2px solid #e4e8f0;
	padding: 10px;
	text-align : center;
}
#xBtn{
	width : 40px;
	height : 40px;
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

#dmodal{
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

#smodal{
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
.parent:after{
	content: "";
	display:block;
	clear : both;
}

</style>
<script>
	$(document).ready(function() {
		//rolling banner start
		//slide-wrap
		var slideWrapper = document.getElementById('slider-wrap');
		//current slideIndexition
		var slideIndex = 0;
		//items
		var slides = document.querySelectorAll('#slider-wrap ul li');
		//number of slides
		var totalSlides = slides.length;
		//get the slide width
		var sliderWidth = slideWrapper.clientWidth;
		//set width of items
		slides.forEach(function (element) {
		    element.style.width = sliderWidth + 'px';
		})
		//set width to be 'x' times the number of slides
		var slider = document.querySelector('#slider-wrap ul#slider');
		slider.style.width = sliderWidth * totalSlides + 'px';

		// next, prev
		var nextBtn = document.getElementById('next');
		var prevBtn = document.getElementById('previous');
		nextBtn.addEventListener('click', function () {
		    plusSlides(1);
		});
		prevBtn.addEventListener('click', function () {
		    plusSlides(-1);
		});

		// hover
		slideWrapper.addEventListener('mouseover', function () {
		    this.classList.add('active');
		    clearInterval(autoSlider);
		});
		slideWrapper.addEventListener('mouseleave', function () {
		    this.classList.remove('active');
		    autoSlider = setInterval(function () {
		        plusSlides(1);
		    }, 9000);
		});


		function plusSlides(n) {
		    showSlides(slideIndex += n);
		}

		function currentSlides(n) {
		    showSlides(slideIndex = n);
		}

		function showSlides(n) {
		    slideIndex = n;
		    if (slideIndex == -1) {
		        slideIndex = totalSlides - 1;
		    } else if (slideIndex === totalSlides) {
		        slideIndex = 0;
		    }

		    slider.style.left = -(sliderWidth * slideIndex) + 'px';
		    pagination();
		}

		//pagination
		slides.forEach(function () {
		    var li = document.createElement('li');
		    document.querySelector('#slider-pagination-wrap ul').appendChild(li);
		})

		function pagination() {
		    var dots = document.querySelectorAll('#slider-pagination-wrap ul li');
		    dots.forEach(function (element) {
		        element.classList.remove('active');
		    });
		    dots[slideIndex].classList.add('active');
		}

		pagination();
		var autoSlider = setInterval(function () {
		    plusSlides(1);
		}, 9000);
		//rolling banner end
		
		//팀소개 모달창
		var myModal = new Example.Modal({
			id:"modal" //모달 창 아이디 지정
		});
		$("#team").click(function() {
			myModal.show(); // 모달창 보여주기
		});
		$("#closeBtn").click(function() {
		    myModal.hide(); // 모달창 감추기
		});
		
		//자료출처 모달창
		var myModal2 = new Example.Modal({
			id:"dmodal" //모달 창 아이디 지정
		});
		$("#data").click(function() {
			myModal2.show(); // 모달창 보여주기
		});
		$("#closeBtn2").click(function() {
		    myModal2.hide(); // 모달창 감추기
		});
		
		//서비스소개 모달창
		var myModal3 = new Example.Modal({
			id:"smodal" //모달 창 아이디 지정
		});
		$("#service").click(function() {
			myModal3.show(); // 모달창 보여주기
		});
		$("#closeBtn3").click(function() {
		    myModal3.hide(); // 모달창 감추기
		});
		
		$("#region_btn").on("click",function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/simple_analysis",
				
				method : "post",
				data : "dong="+$("#dong").val(),
				
				success : function(data){
					var total = data.evaluation;
					var growth = Math.floor(data.growth*4*10)/10;
					var stability = Math.floor(data.stability*4*10)/10;
					var purchasePower = Math.floor(data.purchasePower*4*10)/10;
					var visitPower = Math.floor(data.visitPower*4*10)/10;
					
					$("#growth1").text(growth+"%");
					$("#stability1").text(stability+"%");
					$("#purchasePower1").text(purchasePower+"%");
					$("#visitPower1").text(visitPower+"%");
					
					$("#growth").css("width",growth+"%");
					$("#stability").css("width",stability+"%");
					$("#purchasePower").css("width",purchasePower+"%");
					$("#visitPower").css("width",visitPower+"%");
					
					console.log(total);
					
					
					if(total >= 65.5){
						$("#grade").attr("src","${pageContext.request.contextPath}/img/1grade.png");
					}else if(total < 65.5&&total>=40){
						$("#grade").attr("src","${pageContext.request.contextPath}/img/2grade.png");
					}else{
						$("#grade").attr("src","${pageContext.request.contextPath}/img/3grade.png");
					}
					
					
					//console.log(data);
				},
				error : function(){
					swal({
					    text: "지역을 선택해주세요",
					    closeModal: false,
					    icon: "warning",
					}).then(function() {
				        swal.close();
				        $("#dong").focus();
					});
					return;
				},dataType : "json"
				
			})
		});
		
		$("#gu").on("change",function() {
			var region_cd2 = $(this).val();
			
			if(region_cd2 == "all"){
				$("#dong").empty();
				
				var html = '<option class="dropdown-item" value="all">전체(동)</option>';
				$("#dong").append(html);
				
				return;
			} else {
			$.ajax({
				url : "${pageContext.request.contextPath}/tobRecom/inputDong",

				method : "post",

				data : "region_cd2="
						+ $("#gu").val(), // 구 지역코드를 전송

				success : function(data) {
					//alert(data[0].region_name);
					var html = "";
					html += '<option class="dropdown-item" value="all">지역선택(동)</option>';

					data.forEach(function(region) { // 구에 해당하는 동을 #dong에 생성

						html += "<option value='" + region.region_cd + "'" + ">"
								+ region.region_name
								+ "</option>";
					})
					$("#dong").html(html);
				},
				error : function() {
					swal({
					    text: "지역을 선택해주세요",
					    closeModal: false,
					    icon: "warning",
					}).then(function() {
				        swal.close();
				        $("#dong").focus();
					});
					return;
				}
			});
			}
		});
		
		// 게시글 제목이 긴 경우 말줄임표로 수정
		var arr = document.getElementsByClassName("text12");
		
		for(var i = 0; i < arr.length; i++){
			var html = arr[i].innerHTML;

			// a태그가 있으면
			if(html.indexOf("<a href=") != -1){
				
				var start = html.indexOf(">") + 1;
				var end = html.indexOf("</a>");
				
				var text = html.substring(start, end);
				
				if(text.length >= 14){
					var html2 = html.substring(html.indexOf("<a href="), start);
				
					var text2 = text.substr(0, 14) + "...";
					
					html2 += text2 + "</a>";
					
					arr[i].innerHTML = html2;
				}
			}
		}
		
	});
	
	// 이미 로그인 되어있으면 메인으로 리턴 후 알림창 띄우기
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

	// 소셜계정연동 및 회원가입에 성공한 경우 알림창 띄우기
	$(function(){
		var message = "${WELCOM}";
		if(message != ""){
			swal({
			    text: message,
			    closeModal: false,
			    icon: "success",
			}).then(function() {
			    swal.close();
			});
		}
	});
</script>
<!-- Page Heading -->
<div class="row">
	<div class="col-lg-8">

		<!--롤링베너  -->
		<div id="slider-wrap" style="width:850px; float:right;">
			<ul id="slider">
				<li><a href="http://www.sbiz.or.kr/hrp/cm/educamp.do"><img
						class="banner_img" src="img/1번.png"></a></li>
				<li><a
					href="https://www.semas.or.kr/web/board/webBoardView.kmdc?bCd=1&schCat=&rlIdx=&schCon=&schStr=&page=1&b_idx=31645&pNm=BOA0101&eventMode="><img
						class="banner_img" src="img/nono.png"></a></li>
				<li><a
					href="https://www.semas.or.kr/web/board/webBoardView.kmdc?bCd=1&schCat=&rlIdx=&schCon=&schStr=&page=1&b_idx=31536&pNm=BOA0101&eventMode="><img
						class="banner_img" src="img/3번.png"></a></li>
				<li><a
					href="https://www.semas.or.kr/web/PAT01/boardList.kmdc?pNm=PAT0110"><img
						class="banner_img" src="img/4번.png"></a></li>
				<li><a
					href="https://www.semas.or.kr/web/board/webBoardView.kmdc?bCd=1&b_idx=31528&pNm=BOA0101"><img
						class="banner_img" src="img/5번.png"></a></li>
				<li><a href="http://www.sbiz.or.kr/fcs/req/levelTest.do"><img
						class="banner_img" src="img/6번.png"></a></li>
			</ul>
			<br>
			<div class="slider-btns" id="next">
				<span>▶</span>
			</div>
			<div class="slider-btns" id="previous">
				<span>◀</span>
			</div>

			<div id="slider-pagination-wrap">
				<ul></ul>
			</div>
		</div>

		<!--창업신호등-->
		<div class="card shadow mb-4"
			style="width: 850px; float: right; margin-top: 25px;">
			<div class="card-header py-1">
				<h6 class="m-0 font-weight-bold text-primary">상권등급</h6>
			</div>
			<div class="card-body">
			<div class="parent">
				<div class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search float-right">
					<div class="input-group">
						<select class="form-control" id="gu">
							<option class="dropdown-item" value="all">지역선택(구)</option>
							<c:if test="${interestRegion.region_name != null}">
								<%-- 관심지역이 있을 경우 초기값으로 설정한다 --%>
								<option value="${interestRegion.region_cd2}" selected>${interestRegion.region_name}</option>
							</c:if>
							<c:forEach items="${regionList}" var="rList">
								<%-- 나머지 구를 option으로 설정한다 --%>
								<c:if
									test="${rList.region_cd2 == 0 && rList.region_name != interestRegion.region_name}">
									<option value="${rList.region_cd}">${rList.region_name}</option>
								</c:if>
							</c:forEach>
						</select>
						<form id="frm"
							action="${pageContext.request.contextPath }/simple_analysis"
							method="post">
							<select class="form-control" id="dong"
								name="dong"></select>
						</form>
						<div class="input-group-append">
							<button id="region_btn" class="btn btn-primary" type="button">
								<i class="fas fa-search fa-sm"></i>
							</button>
						</div>
					</div>
				</div>
				<br><br>
				</div>
					<div class="card shadow mb-5">
						<div class="card-body">
							<br>
							<div id="sign" style="text-align: center;">
								<img id="grade"
									src="${pageContext.request.contextPath}/img/1grade.png"><br>
								<br>
							</div>

							<h4  class="small font-weight-bold">
								성장성 <span id="growth1" class="float-right">0%</span>
							</h4>
							<div class="progress mb-4">
								<div id="growth" class="progress-bar bg-danger" role="progressbar"
									style="width: 0%" aria-valuenow="20" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
							<h4  class="small font-weight-bold">
								안정성 <span id="stability1" class="float-right">0%</span>
							</h4>
							<div class="progress mb-4">
								<div id="stability" class="progress-bar bg-warning" role="progressbar"
									style="width: 0%" aria-valuenow="40" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
							
							<h4  class="small font-weight-bold">
								구매력 <span id="purchasePower1" class="float-right">0%</span>
							</h4>
							<div class="progress mb-4">
								<div id="purchasePower" class="progress-bar bg-info" role="progressbar"
									style="width: 0%" aria-valuenow="80" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
							<h4  class="small font-weight-bold">
								집객력 <span id="visitPower1" class="float-right">0%</span>
							</h4>
							<div class="progress">
								<div id="visitPower" class="progress-bar bg-success" role="progressbar"
									style="width: 0%" aria-valuenow="100" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
						</div>
					</div>
			</div>
		</div>
	</div>

	<div class="col-lg-4" style="float: left;">

		<div class="card shadow mb-4" style="width: 300px;">
			<div class="card-header py-1">
				<h6 class="m-0 font-weight-bold text-primary">커뮤니티</h6>
			</div>
			<div class="card-body">
				<!--공지사항-->
				<a href="${pageContext.request.contextPath}/notice/noticeList" class="btn btn-primary btn-icon-split btn-sm"> 
					<span class="icon text-white-50"> <i class="fas fa-flag"></i></span>
					<span class="text">공지사항</span>
				</a>
				
				<c:choose>
					<c:when test="${empty noticeList}">
						<c:forEach begin="1" end="5" var="i">
							<c:choose>
								<c:when test="${i == 1}">
									<li class="text12">작성된 게시글이 없습니다.</li>
								</c:when>
								<c:otherwise>
									<br>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
					
					<c:otherwise>
						<c:choose>
							<c:when test="${fn:length(noticeList) < 5}">
								<c:forEach items="${noticeList}" var="noticeVo">
									<li class="text12">
										<a href="${pageContext.request.contextPath}/notice/noticeDetail?notice_cd=${noticeVo.notice_cd}">${noticeVo.notice_title}</a>
									</li>
								</c:forEach>
								<c:forEach begin="${fn:length(noticeList) + 1}" end="5">
									<br>
								</c:forEach>
							</c:when>
						
							<c:otherwise>
								<c:forEach items="${noticeList}" var="noticeVo">
									<li class="text12">
										<a href="${pageContext.request.contextPath}/notice/noticeDetail?notice_cd=${noticeVo.notice_cd}">${noticeVo.notice_title}</a>
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
					
				</c:choose>

				<br>

				<!-- 자주 묻는 질문 -->
				<a href="${pageContext.request.contextPath}/faq/faqList"
					class="btn btn-primary btn-icon-split btn-sm"> <span
					class="icon text-white-50"> <i class="fas fa-flag"></i>
				</span> <span class="text">자주묻는질문</span>
				</a>
				
				<c:choose>
					<c:when test="${empty faqList}">
						<c:forEach begin="1" end="5" var="i">
							<c:choose>
								<c:when test="${i == 1}">
									<li class="text12">작성된 게시글이 없습니다.</li>
								</c:when>
								<c:otherwise>
									<br>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
					
					<c:otherwise>
						<c:choose>
							<c:when test="${fn:length(faqList) < 5}">
								<c:forEach items="${faqList}" var="faq">
									<li class="text12">
										<a href="${pageContext.request.contextPath}/faq/faqList">${faq.faq_title}</a>
									</li>
								</c:forEach>
								<c:forEach begin="${fn:length(faqList) + 1}" end="5">
									<br>
								</c:forEach>
							</c:when>
						
							<c:otherwise>
								<c:forEach items="${faqList}" var="faq">
									<li class="text12">
										<a href="${pageContext.request.contextPath}/faq/faqList">${faq.faq_title}</a>
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
					
				</c:choose>
				
				<br>

				<!--자유게시판 -->
				<a href="${pageContext.request.contextPath}/freeBoard" class="btn btn-primary btn-icon-split btn-sm"> 
					<span class="icon text-white-50"> <i class="fas fa-flag"></i></span>
					<span class="text">자유게시판</span>
				</a>
				
				<c:choose>
					<c:when test="${empty fBoardList}">
						<c:forEach begin="1" end="5" var="i">
							<c:choose>
								<c:when test="${i == 1}">
									<li class="text12">작성된 게시글이 없습니다.</li>
								</c:when>
								<c:otherwise>
									<br>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
					
					<c:otherwise>
						<c:choose>
							<c:when test="${fn:length(fBoardList) < 5}">
								<c:forEach items="${fBoardList}" var="freeBoardVo">
									<li class="text12">
										<a href="${pageContext.request.contextPath}/freeBoard_Detail?freeboard_cd=${freeBoardVo.freeboard_cd}">${freeBoardVo.fb_title}</a>
									</li>
								</c:forEach>
								<c:forEach begin="${fn:length(fBoardList) + 1}" end="5">
									<br>
								</c:forEach>
							</c:when>
						
							<c:otherwise>
								<c:forEach items="${fBoardList}" var="freeBoardVo">
									<li class="text12">
										<a href="${pageContext.request.contextPath}/freeBoard_Detail?freeboard_cd=${freeBoardVo.freeboard_cd}">${freeBoardVo.fb_title}</a>
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
					
				</c:choose>

				<br>
				
				<!--건의사항게시판 -->
				<a href="${pageContext.request.contextPath}/suggestion" class="btn btn-primary btn-icon-split btn-sm"> 
					<span class="icon text-white-50"> <i class="fas fa-flag"></i></span>
					<span class="text">건의사항</span>
				</a>
				
				<!-- !!!아래는 추후 수정!!! -->
				<c:choose>
					<c:when test="${empty suggestionList}">
						<c:forEach begin="1" end="5" var="i">
							<c:choose>
								<c:when test="${i == 1}">
									<li class="text12">작성된 게시글이 없습니다.</li>
								</c:when>
								<c:otherwise>
									<br>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
					
					<c:otherwise>
						<c:choose>
							<c:when test="${fn:length(suggestionList) < 5}">
								<c:forEach items="${suggestionList}" var="suggestion">
									<li class="text12">
										<a href="#">${suggestion.sg_title}</a>
									</li>
								</c:forEach>
								<c:forEach begin="${fn:length(suggestionList) + 1}" end="5">
									<br>
								</c:forEach>
							</c:when>
						
							<c:otherwise>
								<c:forEach items="${suggestionList}" var="suggestion">
									<li class="text12">
										<a href="#">${suggestion.sg_title}</a>
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
					
				</c:choose>
			</div>
		</div>
		
		<div class="card shadow mb-4" style="width:300px; height:290px; cursor : pointer;">
				<table id="table" style="width:300px; height:290px;">
					<tr>
						<td>
							<img id="data" src="${pageContext.request.contextPath}/img/기준데이터.png"><br>
							<span>기준데이터</span>
						</td>
						<td>
							<img id="service" src="${pageContext.request.contextPath}/img/서비스소개.png"><br>
							<span>서비스소개</span>
						</td>
					</tr>
					<tr>
						<td>
							<img id="team" src="${pageContext.request.contextPath}/img/팀원소개.png"><br>
							<span>팀원소개</span>
						</td>
						<td>
							<a href="mailto:someone@example.com?Subject=Hello%20again" target="_top"><img id="service" src="${pageContext.request.contextPath}/img/미정.png"></a><br>
							<span>문의하기</span>
						</td>
					</tr>
				</table>
		</div>
		
	</div>
</div>

<!--팀원소개  -->
<div id="modal">
	<div>
		<img id="teamImg" src="${pageContext.request.contextPath}/img/팀원소개(내용).png" style="width : 750px; height : 500px; position: relative;">
	</div>
	<div>
		<a href="#" id="closeBtn"><img id="xBtn" src="${pageContext.request.contextPath}/img/x버튼.png" style="position: relative;"></a>
	</div>
</div>

<!--자료출처  -->
<div id="dmodal">
	<div>
		<img id="teamImg" src="${pageContext.request.contextPath}/img/기준데이터(내용).png" style="width : 750px; height : 500px; position: relative;">
	</div>
	<div>
		<a href="#" id="closeBtn2"><img id="xBtn" src="${pageContext.request.contextPath}/img/x버튼.png" style="position: relative;"></a>
	</div>
</div>

<!--서비스소개  -->
<div id="smodal">
	<div>
		<img id="teamImg" src="${pageContext.request.contextPath}/img/서비스소개(내용).png" style="width : 750px; height : 500px; position: relative;">
	</div>
	<div>
		<a href="#" id="closeBtn3"><img id="xBtn" src="${pageContext.request.contextPath}/img/x버튼.png" style="position: relative;"></a>
	</div>
</div>


<!-- /.container-fluid -->
