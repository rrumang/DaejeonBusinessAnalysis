<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<style>
body {
	background-image:
		url("${pageContext.request.contextPath}/img/background.png");
}

#div02 {
	margin-top: 20px;
	margin-left: 65px;
}

#tofh {
	width: 50px;
	height: 50px;
	margin-top: 10px;
}

.p-5 {
	padding: 30px;
}

.size {
	width: 80%;
	height: 120%;
}

.lol {
	margin: 0 auto;
	text-align: center;
}

#btn01 {
	display: inline-block;
	margin-left: 20px;
}

#value {
	width: 200px;
	margin-left: 110px;
}

#total {
	/* 	text-align: center; */
	margin: 0 auto;
}

#div01 {
	margin-left: 100px;
}

.p-5 {
	margin-bottom: -50px;
}

#div03 {
	width: 65%;
	margin: auto;
}

#div04 {
	margin: 0 auto;
	text-align: center;
}
</style>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	$(document).ready(function() {
						// 			dataInit();
						captcha();

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
									$("#gu").focus();
								}
							});
							}
						});
						$("#member_id").focusout(function(){
							$.ajax({	
								
								url : "${pageContext.request.contextPath}/duplication",
								
								method : "post",
								
								data : "member_id="
									+ $("#member_id").val(), // 멤버아이디를 전송
								
								success : function(data) {
									var result = data.result;
									if(result==1){
										swal({
											text : "이미 가입된 아이디가 있습니다",
											closeModal : false,
											icon : "warning",
										}).then(function() {
											swal.close();
											$("#member_id").val("");
											$("#member_id").focus();
										});
										return;								
									}else if(result==0){
										swal({
											text : "가입가능한 아이디입니다.",
											closeModal : false,
											icon : "warning",
										}).then(function() {
											swal.close();
										});
										return;	
									}
									
								},
								error  : function(){
									
								}
							});
							
						})
						
						

						$("#password_confirm").focusout(function() {
							if ($("#password_confirm").val() != $(
									"#member_password").val()) {
								swal({
									text : "비밀번호가 일치하지 않습니다.",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#password_confirm").val("");
									$("#member_password").focus();
								});
								return;
							}

						})

						$("#emailSelect").on("change", function() {
							var Email = $("#emailSelect").val().trim();

							if (Email == "direct") {
								$("#emailAddress").attr("readonly", false);
								$("#emailAddress").val("@");
							} else {
								$("#emailAddress").val(Email);
								$("#emailAddress").attr("readonly", true);
							}

						});

						$("#top").on("change",function() {
							var region_cd2 = $(this).val();
							
							if(region_cd2 == "all"){
								$("#mid").empty();
								$("#bot").empty();
								
								var html = '<option class="dropdown-item" value="all">업종선택(중)</option>';
								$("#mid").append(html);
								var html2 = '<option class="dropdown-item" value="all">업종선택(소)</option>';
								$("#bot").append(html2);
								
								return;
							} else {	
						
						
							$.ajax({
								url : "${pageContext.request.contextPath}/tob",
								method : "post",
								data : "tob_cd2="
										+ $("#top")
												.val(), // 

								success : function(data) {
									var list = data.midList;
									var html = "";
									html +='<option class="dropdown-item" value="all">업종선택(중)</option>';
									$.each(list,function(idx,tob) {
										html += 
											
											"<option value='" + tob.tob_cd + "'>"
												+ tob.tob_name
												+ "</option>";
									})
									$("#mid").empty();
									$("#mid").append(html);

								},
								error : function() {
									swal(
											{
												text : "에러!",
												closeModal : false,
												icon : "warning",
											})
											.then(
													function() {
														swal
																.close();
													});
								}
							});
							}
						});

						$("#mid").on("change",function() {
							var region_cd2 = $(this).val();
							
							if(region_cd2 == "all"){
								$("#bot").empty();
								
								var html2 = '<option class="dropdown-item" value="all">업종선택(소)</option>';
								$("#bot").append(html2);
								
								return;
							} else {		
							
						
							$.ajax({
								url : "${pageContext.request.contextPath}/tob",
								method : "post",
								data : "tob_cd2="
										+ $("#mid")
												.val(),
								success : function(data) {

									console
											.log("data 출력");
									console.log(data);
									console
											.log(data.midList);

									var list = data.midList;
									var html = "";
									html +='<option class="dropdown-item" value="all">업종선택(소)</option>';
									$.each(list,function(idx,tob) {
										html += "<option value='" + tob.tob_cd + "'>"
												+ tob.tob_name
												+ "</option>";
									})

									console.log(html);

									$("#bot").empty();
									$("#bot").append(
											html);

								},
								error : function() {
									alert("error!!!");
								}
									});
							}
						});

						$("#btn01").on("click", function() {

							$("#capKey").val($("#key").val());
							$("#capVal").val($("#value").val());
							var form01Data = $("#captchaFrm").serialize();
							console.log(form01Data);
							$.ajax({
								url : "/spring/captchaNkeyResult",
								data : form01Data,
								dataType : "json",
								success : function(data) {
									if (data.result == "true") {
										swal({
											text : "인증성공",
											closeModal : false,
											icon : "warning",
										}).then(function() {
											swal.close();
											$("#btn01").focus();
										});
										$("#value").val('');
										$("#capKey").val('');
										$("#capVal").val('');
										$("#refresh").prop("disabled", true);
										$("#value").prop("disabled", true);
										$("#btn01").prop("disabled", true);
										$("#accept").prop("invi")
									} else {
										swal({
											text : "인증 실패 다시 입력해주세요.",
											closeModal : false,
											icon : "warning",
										}).then(function() {
											swal.close();
											captcha();
											$("#value").focus();
											$("#value").val("");
										});
										return;
									}
								}
							});
						});
						$("#refresh").on("click", function() {
							captcha();
						});

						var msg = '${msg}';
						if (msg != '')
							alert(msg);

						$("#btn_register").on("click",function(e) {
							e.preventDefault();
							

							if ($("#password_confirm").val() != $(
									"#member_password").val()) {
								swal({
									text : "비밀번호가 일치하지 않습니다. 다시 확인해여 주세요",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#password_confirm").focus();
								});
								return;
							}
							
							if ($("#refresh").prop("disabled") == false) {
								swal({
									text : "자동가입방지를 확인해주세요.",
									icon : "warning",
								}).then(function() {
									swal.close();
								});
								return;
							}
							
							var member_id_reg = /^[a-zA-Z0-9]+$/;

							if ($("#member_id").val().trim().length == 0) {
								swal({
									text : "아이디를 입력하세요",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#member_id").focus();
								});
								return;
								
							} else if (!member_id_reg.test($("#member_id").val())) {
								swal(
										{
											text : "아이디는 영문 or 숫자 4~12글자.",
											closeModal : false,
											icon : "warning",
										}).then(function() {
									swal.close();
									$("#member_id").focus();
								});
								return;
							} else if ($("#member_id").val()
									.trim().length < 4) {
								swal({
									text : "아이디는 4글자이상입니다.",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#member_id").focus();
								});
								return;
							}

							// 			if (form.idDuplication.value != "idCheck") {

							var name_reg = /^[가-힣]+$/;
							if ($("#idDuplication").val() == "idUnchecked") {
								swal({
									text : "아이디중복체크를 해주세요.",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#member_name").focus();
								});
								return;
							}
							if ($("#member_name").val().trim().length == 0) {
								swal({
									text : "이름을 입력하세요",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#member_name").focus();
								});
								return;
							} else if (!name_reg.test($(
									"#member_name").val())) {
								swal(
										{
											text : "이름형식이 잘못되었습니다 다시입력해주세요.",
											closeModal : false,
											icon : "warning",
										}).then(function() {
									swal.close();
									$("#member_name").focus();
								});
								return;
							} else if ($("#member_name").val().trim().length < 2 || $("#member_name").val().trim().length > 7) {
								swal({
									text : "이름형식 (2~7 한글)이 틀립니다. 다시 입력하여 주세요.",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#member_name").focus();
								});
								return;
							}
							
							var password_reg = /^[a-zA-Z0-9]+$/;
							
							if ($("#member_password").val()
									.trim().length == 0) {
								swal({
									text : "비밀번호를 입력해주세요.",
									closeModal : false,
									icon : "warning",
								})
										.then(
												function() {
													swal
															.close();
													$(
															"#member_password")
															.focus();
												});
								return;
							} else if ($("#member_password")
									.val().trim().length < 6) {
								swal(
										{
											text : "비밀번호를 6글자 이상 입력하여 주세요.",
											closeModal : false,
											icon : "warning",
										})
										.then(
												function() {
													swal
															.close();
													$(
															"#member_password")
															.focus();
												});
								return;
							} else if (!password_reg.test($(
									"#member_password").val())) {
								swal(
										{
											text : "비밀번호는 영문 or 숫자만 입력가능합니다.(6~13)",
											closeModal : false,
											icon : "warning",
										})
										.then(
												function() {
													swal
															.close();
													$(
															"#member_password")
															.focus();
												});
								return;
							}

							if ($("#password_confirm").val()
									.trim().length == 0) {
								swal({
									text : "비밀번호 재확인을 하여주십시오.",
									closeModal : false,
									icon : "warning",
								})
										.then(
												function() {
													swal
															.close();
													$(
															"#password_confirm")
															.focus();
												});
								return;
							}
							var email_reg = /^[a-zA-Z0-9]+$/;
							if ($("#member_email").val().trim().length == 0) {
								swal({
									text : "이메일을 입력해주세요.",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#member_email").focus();
								});
								return;
							} else if (!email_reg.test($(
									"#member_email").val())) {
								swal({
									text : "이메일형식이 잘못되었습니다.",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#member_email").focus();
								});
								return;
							} else if ($("#member_email").val()
									.trim().length < 4) {
								swal(
										{
											text : "이메일을 4글자이상 입력하여주세요.",
											closeModal : false,
											icon : "warning",
										}).then(function() {
									swal.close();
									$("#member_email").focus();
								});
								return;
							}
							
							var email_reg2 = /^@[0-9a-zA-Z]{1,7}([.]{1}[a-zA-Z]{2,3}){1,2}$/;

							if ($("#emailAddress").val().trim().length == 0) {
								swal({
									text : "도메인을 선택해주세요.",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#emailAddress").focus();
								});
								return;
							}else if(!email_reg2.test($("#emailAddress").val())){
								swal({
									text : "이메일 형식이 올바르지 않습니다.",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#emailAddress").focus();
								});
								return;
							}
								
							var number_reg = /^[0-9]+$/;
							if ($("#middleNumber").val().trim().length == 0) {
								swal({
									text : "전화번호(2)를 입력해주세요.",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#middleNumber").focus();
								});
								return;
							} else if ($("#middleNumber").val()
									.trim().length < 4) {
								swal(
										{
											text : "전화번호(2)를 4글자이상 입력하여주세요.",
											closeModal : false,
											icon : "warning",
										}).then(function() {
									swal.close();
									$("#middleNumber").focus();
								});
								return;
							} else if (!number_reg.test($(
									"#middleNumber").val())) {
								swal({
									text : "숫자만 입력하여주세요",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#middleNumber").focus();
								});
								return;
							}

							if ($("#backNumber").val().trim().length == 0) {
								swal({
									text : "전화번호(3)를 입력해주세요.",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#backNumber").focus();
								});
								return;
							} else if ($("#backNumber").val()
									.trim().length < 4) {
								swal(
										{
											text : "전화번호(3)를 4글자이상 입력하여주세요.",
											closeModal : false,
											icon : "warning",
										}).then(function() {
									swal.close();
									$("#backNumber").focus();
								});
								return;
							} else if (!number_reg.test($(
									"#backNumber").val())) {
								swal({
									text : "숫자만 입력하여주세요",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#backNumber").focus();
								});
								return;
							}

							if ($("#year").val().trim().length == 0) {
								swal({
									text : "출생년도를 입력해주세요",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#year").focus();
								});
								return;
							}

							if ($("#month").val().trim().length == 0) {
								swal({
									text : "출생년월을 입력해주세요",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#month").focus();
								});
								return;
							}

							if ($("#day").val().trim().length == 0) {
								swal({
									text : "출생일자를 입력해주세요",
									closeModal : false,
									icon : "warning",
								}).then(function() {
									swal.close();
									$("#day").focus();
								});
								return;
							}

							if ($("#member_gender").val()
									.trim().length == 0) {
								swal({
									text : "성별을 선택해주세요",
									closeModal : false,
									icon : "warning",
								}).then(
										function() {
											swal.close();
											$("#member_gender")
													.focus();
										});
								return;
							}
							$("#frm").submit();
						})
					});

	function dataInit() {
		$("#member_id").val("newmember");
		$("#member_name").val("홍길동");
		$("#member_password").val("newmember");
		$("#password_confirm").val("newmember");
		$("#member_email").val("newmember");
		$("#emailAddress").val("@naver.com");
		$("#frontNumber").val("010");
		$("#middleNumber").val("5153");
		$("#backNumber").val("0541");
		$("#year").val("1991");
		$("#month").val("10");
		$("#day").val("8");
		$("#member_gender").val("1");
	}
	
	function captcha() {

		$.ajax({
					method : 'post',
					url : "/spring/captchaNkey",
					dataType : "json",
					success : function(data) {

						console.log(data.key);
						$("#key").val(data.key);

						$
								.ajax({
									url : "/spring/captchaImage",
									method : 'get',
									data : "key=" + data.key,
									success : function(data) {
										console.log(data);
										console.log(data.captchaImageName);
										$("#div01")
												.html(
														"<img src='captchaImage/"+data.captchaImageName+"'>");
									},
									error : function(xhr) {
										alert('에러' + xhr.status);
									}
								});
					},
					error : function(xhr) {
						alert('에러' + xhr.status);
					}
				});
	}
</script>

<title>POJO - 회원가입</title>

<%@include file="/WEB-INF/views/common/basicLib.jsp"%>

</head>

<body>

	<div class="container">
		<div id="div03" class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body m-0">
				<div class="px-5 pt-3">
					<div class="text-center">
						<h1 class="h4 text-gray-900 mb-4">회원가입</h1>
					</div>
					<form id="frm"
						action="${pageContext.request.contextPath }/register"
						method="post">
						<div class="form-group">
							<input type="text" maxlength="12"
								class="form-control form-control-user" id="member_id"
								onkeydown="inputIdChk()" name="member_id"
								placeholder="아이디 4~12자 (특수문자X) ">
						</div>
						<div class="form-group">
							<input type="text" class="form-control form-control-user"
								id="member_name" maxlength="7" name="member_name"
								placeholder="이름 (2~4글자)">
						</div>
						<div class="form-group row">
							<div class="col-sm-6 mb-3 mb-sm-0">
								<input type="password" maxlength="13"
									class="form-control form-control-user" id="member_password"
									name="member_password" placeholder="비밀번호 6~13글자 (특수문자X)">
							</div>
							<div class="col-sm-6">
								<input type="password" class="form-control form-control-user"
									id="password_confirm" name="password_confirm"
									placeholder="비밀번호 재확인">
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-4 mb-3 mb-sm-0">
								<input type="text" class="form-control form-control-user"
									id="member_email" name="member_email" placeholder="이메일">
							</div>

							<div class="col-sm-4">
								<input type="text" class="form-control form-control-user"
									id="emailAddress" name="emailAddress" placeholder="[도메인입력]"
									readonly>
							</div>
							<div class="col-sm-4">
								<select id="emailSelect"
									class="form-control bg-light border-3 small" name="emailSelect">
									<option value="">이메일 선택</option>
									<option value="@naver.com">네이버</option>
									<option value="@gmail.com">구글</option>
									<option value="@hanmail.net">한메일</option>
									<option value="direct">직접입력</option>
								</select>
							</div>
							&nbsp;&nbsp;&nbsp;&nbsp; ※직접입력시 "@"를 입력하여 주세요.
						</div>

						<div class="form-group row">
							<div class="col-sm-4 mb-3 mb-sm-0">
								<input type="text" class="form-control form-control-user"
									id="frontNumber" name="frontNumber" value="010" readonly>
							</div>

							<div class="col-sm-4">
								<input type="text" maxlength="4" class="form-control form-control-user"
									id="middleNumber" name="middleNumber" placeholder="">
							</div>

							<div class="col-sm-4">
								<input type="text" maxlength="4" class="form-control form-control-user"
									id="backNumber" name="backNumber" placeholder="">
							</div>
						</div>

						<div class="form-group row">
							<div class="col-sm-3 mb-3 mb-sm-0">
								<select class="form-control bg-light border-3 small" id="year"
									name="year">
									<option value="">년도</option>
									<c:forEach begin="1950" end="2010" step="1" var="year">
										<option value="${year }">${year }년</option>
									</c:forEach>

								</select>
							</div>

							<div class="col-sm-3">
								<select class="form-control bg-light border-3 small" id="month"
									name="month">
									<option value="">월</option>
									<c:forEach begin="01" end="12" step="1" var="month">
										<option value="${month }">${month }월</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-3">
								<select class="form-control bg-light border-3 small" id="day"
									name="day">
									<option value="">일</option>
									<c:forEach begin="01" end="31" step="1" var="day">
										<option value="${day }">${day }일</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-3">
								<select class="form-control bg-light border-3 small"
									id="member_gender" name="member_gender">
									<option value="">성별</option>
									<option value="1">남자</option>
									<option value="2">여자</option>
								</select>
							</div>

						</div>
						<div class="form-group row"></div>

						<hr>


						<div class="form-group row">
							<div class="col-sm-4">
								<input type="selectbo"
									class="form-control bg-light border-3 small" id="backNumber"
									value="관심지역(대전시)" readonly>
							</div>

							<div class="col-sm-4" id="regionSelect">
								<select class="form-control bg-light border-3 small dropdown show" id="gu">
									<option class="dropdown-item" value="all">지역선택(구)</option>
									<c:if test="${interestRegion.region_name != null}">
										<%-- 관심지역이 있을 경우 초기값으로 설정한다 --%>
										<option value="${interestRegion.region_cd2}" selected>${interestRegion.region_name}</option>
									</c:if>
									<c:forEach items="${regionList}" var="rList">
										<%-- 나머지 구를 option으로 설정한다 --%>
										<c:if test="${rList.region_cd2 == 0 && rList.region_name != interestRegion.region_name}">
											<option value="${rList.region_cd}">${rList.region_name}</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-4">
								<select class="form-control bg-light border-3 small dropdown show" id="dong"name="dong">
									<option class="dropdown-item" value="all">지역선택(동)</option>
								</select>

							</div>

						</div>
						<div class="form-group row">
							<div class="col-sm-4">
								<select id="top" name="top"
									class="form-control bg-light border-3 small dropdown show">
									<option class="dropdown-item" value="all">업종선택(대)</option>
									<c:forEach items="${TopTobList}" var="tobList">
										<option value="${tobList.tob_cd}">${tobList.tob_name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-4 mb-3 mb-sm-0">
								<select class="form-control bg-light border-3 small dropdown show" id="mid">
								<option class="dropdown-item" value="all">업종선택(중)</option>
								</select>
							</div>

							<div class="col-sm-4">
								<select id="bot" name="bot"	class="form-control bg-light border-3 small dropdown show">
								<option class="dropdown-item" value="all">업종선택(소)</option>
								</select>
							</div>
						</div>
					</form>
				</div>
				<hr>

				<div id="div02" class="form-group row">

					<div class="col-sm-4 mb-2" id="div01"></div>

					<div class="col-sm-4">
						<button type="button" id="refresh" class="btn ">
							<img id="tofh" src="img/새로고침.PNG">
						</button>
					</div>

					<input type="text" id="value" name="value" class="form-control">
					<button type="button" class="btn btn-secondary" id="btn01">인증</button>
				</div>

				<hr>

				<div id="div04">
					<a href="#" id="btn_register" class="btn btn-primary mr-3">회원가입</a>
					<a class="btn btn-danger"
						href="${pageContext.request.contextPath }/main">취소</a>
				</div>
			</div>

			<input type="hidden" id="key" name="key"> <label
				id="startTimeLabel" class="btn btn-secondary btn-icon-split" hidden>[인증완료]</label>


			<form id="captchaFrm">
				<input type="hidden" id="capKey" name="key"> <input
					type="hidden" id="capVal" name="value">
			</form>

			<input type="hidden" id="dongcd" name="dongcd" />

		</div>
	</div>

</body>

</html>
