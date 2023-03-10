<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<!-- kakao 로그인 api 등록 -->
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />

<title>POJO - 로그인</title>

<%@include file="/WEB-INF/views/common/basicLib.jsp"%>

<style>
body {
/* 	background-color : #f9f5e3;  */
 	background-image: url("${pageContext.request.contextPath}/img/background.png"); 
}

#base {
	width : 55%;
	max-width: 530px;
	min-width: 530px;
	margin: auto;
}

#id_popup, #pw_popup{
	border : 1px solid black;
	position: absolute;
	z-index: 1;
	left : 0px;
	width: 90%;
	height : auto;
	background-color: #ffffff;
	border-radius : 5px;
}

#id_popup input, #pw_popup input{
	display : inline-block;
	text-align : center;
	width : 100%;
	margin : 5px;
}
#id_popup a, #pw_popup a{
	margin : 5px;
	padding : 5px;
}

#tofh {
	width: 40px;
	height: 40px;
	margin-left : 10px;
}

#div01 {
	display: inline-block;
}

#form01 input {
	margin-right : 20px;
}

form.user .btn-user{
	font-size : 1.1em;
}

form.user .form-control-user{
	font-size : 1rem;
}

#div02 {
	margin : 0 auto;
	height : 650px;
	padding: 0 90px;
}

button {
	cursor: pointer;
}

#div03 {
	margin : auto;
	margin-top : 8rem;
}
</style>

<!-- Bootstrap core JavaScript-->
<script src="${pageContext.request.contextPath}/ex_img/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/ex_img/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="${pageContext.request.contextPath}/ex_img/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${pageContext.request.contextPath}/ex_img/js/sb-admin-2.min.js"></script>

<!-- sweet alert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- 카카오 로그인 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<!-- jqeury 등록 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>    

<!-- naver login javascript SDK -->
<!-- <script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script> -->
<script>
	var contextPath = "${pageContext.request.contextPath}";
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>

<script type="text/javascript">

	$(document).ready(function() {
		var kakao = "${KAKAO}";
		var naver = "${NAVER}";
		
		var comment = "";
		var social = "";
		
		// 카카오 혹은 네이버 인증키가 있으면 소셜 로그인 버튼 숨기기, 코멘트 보이기
		if(kakao != "" || naver != ""){
			$("#social").css("display", "none");
			$("#comment").css("display", "block");
		
			if(kakao != ""){
				social = "Kakao";
			} else if(naver != ""){
				social = "Naver";
			}
			
			comment = social + " 계정이 인증되었습니다. <br>"
					  + "POJO 아이디로 로그인하시면 " + social
					  + " 계정이 자동 연결되며, 이후부터는 " + social
					  + " 계정으로 간편하게 로그인 하실 수 있습니다.";
			
			$("#comment").empty();
			$("#comment").append(comment);
		}
		
		// 네이버 로그인
		naverLogin();
		
		//---------------------------------------------------------------
		
		// 로그인 버튼을 클릭했을 때
		$("#login").on("click", function(e){
			e.preventDefault();
			
			// 입력 검증 및 정규식 검사
			
			// 아이디
			var member_id_reg = /^[a-zA-Z0-9]{4,12}$/;
			
			if($("#member_id").val().trim() == ""){
				swal({
				    text: "아이디를 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_id").val("");
			        $("#member_id").focus();
				});
				return;
			}else if(!member_id_reg.test($("#member_id").val())){
				swal({
				    text: "아이디 형식(영문 대, 소문자, 숫자 조합 4 ~ 12글자)이 올바르지 않습니다. 다시 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_id").focus();
				});
				return;
			}
			
			// 비밀번호
			var password_reg = /^[a-zA-Z0-9]{6,13}$/;
			if ($("#member_password").val().trim() == "") {
				swal({
				    text: "비밀번호를 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_password").val("");
			        $("#member_password").focus();
				});
				return;
			}else if(!password_reg.test($("#member_password").val())){
				swal({
				    text: "비밀번호 형식(영문 대, 소문자, 숫자조합 6 ~ 13글자)이 올바르지 않습니다. 다시 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_password").val("");
			        $("#member_password").focus();
				});
				return;
			}
			
			$("#loginForm").submit();
		});
		
		// 아이디찾기 버튼을 클릭했을 떄
		$("#findId").on("click",function(e){
			e.preventDefault();
			
			$("#id_popup").attr("style", "top: 150px; left:25px; display:block;");
		});
		
		// 아이디찾기 확인 버튼을 클릭했을 때
		$("#findIdBtn").on("click",function(e){
			e.preventDefault();
			
			// 이메일, 휴대전화번호 입력 검증
			var result = inputCheck($(this));
			console.log("result : " + result);
			console.log("result[0] : " + result[0]);
			console.log("result[1] : " + result[1]);
			
			// 검증이 완료되면 아이디찾기
			if(result.length == 2) {
				findId(result[0], result[1]);
			}
		});
		
		// 아이디찾기 취소버튼을 클릭했을 때
		$("#cancelIdBtn").on("click",function(e){
			e.preventDefault();
			
			// 입력값 초기화
			$("#id_email").val("");
			$("#id_tel").val("");
			
	        $("#id_popup").attr("style", "display:none;");
		});
		
		// 비밀번호찾기 버튼을 클릭했을 떄
		$("#findPw").on("click",function(e){
			e.preventDefault();
			
			captcha();
			
			$("#pw_popup").attr("style", "top: 125px; left:25px; display:block;");
		});
		
		// 비밀번호찾기 확인 버튼을 클릭했을 때
		$("#findPwBtn").on("click",function(e){
			e.preventDefault();
			
			var result = inputCheck($(this));
			
			// 이메일, 휴대전화번호 입력 검증 완료
			if(result.length == 2) {
				if($("#refresh").prop("disabled") == true){
					findPw(result[0], result[1]);
				} else {
					swal("자동입력방지를 완료해주십시오.");
				}
			}
			
		});
		
		// 비밀번호찾기 취소버튼을 클릭했을 때
		$("#cancelPwBtn").on("click",function(e){
			e.preventDefault();
			
			// 입력값 초기화
			$("#pw_email").val("");
			$("#pw_tel").val("");
	     
			$("#pw_popup").attr("style", "display:none;");
		});
		
		// 캡차 인증버튼을 클릭했을 때
		$("#btn01").on("click", function() {
			
			// 내용 입력 검증
			if($("#value").val() == "" || $("#value").val().trim() == ""){
				swal({
				    text: "내용을 입력해주십시오",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
				       swal.close();
				       $("#value").val("");
				       $("#value").focus();
				});
				return;
			}

			$("#capKey").val($("#key").val());
			$("#capVal").val($("#value").val());
			var form01Data = $("#captchaFrm").serialize();
			console.log(form01Data);
			$.ajax({
				url : "/spring/captchaNkeyResult",
				data : form01Data,
				dataType : "json",
				success : function(data) {
					console.log(data);
					console.log(data.result);
					if (data.result == "true") {
						swal("인증성공");
						$("#value").val('');
						$("#capKey").val('');
						$("#capVal").val('');
						$("#refresh").prop("disabled", true);
						$("#value").prop("readonly", true);
						$("#btn01").prop("disabled", true);
						$("#accept").prop("invi");
					} else {
						swal("인증실패");
						$("#value").val('');
						$("#value").focus();
						$("#capKey").val('');
						$("#capVal").val('');
						captcha();
					}
				},
				error : function(err){
					console.log("에러 : " + err);
				}
			});
		});
		
		// 새로고침 이미지를 클릭했을 때
		$("#refresh").on("click", function() {
			$("#value").val("");
	        $("#value").focus();
			captcha();
		});
		
	});
	
	// 로그인 실패 등 관련 메세지 출력
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
	
	// 이메일, 휴대전화번호 입력 검증
	function inputCheck(btn){
		console.log(btn);
		
		var email = btn.parent().children("input[type=email]").val().trim();
		console.log("email : " + email);
		
		var email_regExp = /^[a-zA-Z0-9]{4,}@[0-9a-zA-Z]{1,7}([.]{1}[a-zA-Z]{2,3}){1,2}$/i;
		
		if(email == ""){
			swal({
			    text: "이메일을 입력해주십시오.",
			    closeModal: false,
			    icon: "warning",
			}).then(function() {
		        swal.close();
		        btn.parent().children("input[type=email]").val("");
		        btn.parent().children("input[type=email]").focus();
			});
			return;
		} else if(!email_regExp.test(email)){
			swal({
			    text: "이메일 형식이 올바르지 않습니다. 다시 입력해주십시오.",
			    closeModal: false,
			    icon: "warning",
			}).then(function() {
		        swal.close();
		        btn.parent().children("input[type=email]").focus();
			});
			return;
		}
		
		var tel = btn.parent().children("input[type=text]").val().trim();
		console.log("tel : " + tel);
		
		var tel_regExp = /^\d{3}-\d{4}-\d{4}$/;
		
		if(tel.length == 0){
			swal({
			    text: "휴대전화번호를 입력해주십시오.",
			    closeModal: false,
			    icon: "warning",
			}).then(function() {
		        swal.close();
		        btn.parent().children("input[type=text]").val("");
		        btn.parent().children("input[type=text]").focus();
			});
			return;
		} else if(!tel_regExp.test(tel)){
			swal({
			    text: "휴대전화번호 형식이 올바르지 않습니다. 다시 입력해주십시오.",
			    closeModal: false,
			    icon: "warning",
			}).then(function() {
		        swal.close();
		        btn.parent().children("input[type=text]").focus();
			});
			return;
		}
		
		var result = new Array(email, tel);
		
		return result;
	}
	
	// 아이디 찾기
	function findId(email, tel){
		$.ajax({
			url : "${pageContext.request.contextPath}/findId",
			data : "member_email=" + email + "&member_tel=" + tel,
			dataType : "json",
			method : "post",
			success : function(data){
				console.log("성공" + data.memberVo);
				
				if(data.memberVo != null){
					swal({
					    text: data.memberVo.member_name + "님의 아이디는 " 
					    	+ data.memberVo.member_id + "입니다.",
					    closeModal: false,
					    icon: "success",
					}).then(function() {
				        swal.close();
				        $("#member_id").val(data.memberVo.member_id);
				        $("#member_password").focus();
				        
				        $("#id_email").val("");
				        $("#id_tel").val("");
				        $("#id_popup").attr("style", "display:none;");
					});
					return;
				} else {
					swal({
					    text: "일치하는 회원이 없습니다. 다시 입력해주십시오.",
					    closeModal: false,
					    icon: "warning",
					}).then(function() {
				        swal.close();
				        $("#id_email").focus();
					});
					return;
				}
				
			},
			error : function(err){
				console.log("실패" + err);
			}
		});
	}
	
	// 비밀번호 찾기
	function findPw(email, tel){
		$.ajax({
			url : "${pageContext.request.contextPath}/findPw",
			data : "member_email=" + email + "&member_tel=" + tel,
			dataType : "json",
			method : "post",
			success : function(data){
				console.log("성공" + data.result);
				
				// 이메일, 휴대전화번호가 일치하는 회원이 없는 경우
				if(data.result == "none"){
					swal({
					    text: "일치하는 회원이 없습니다. 다시 입력해주십시오.",
					    closeModal: false,
					    icon: "warning",
					}).then(function() {
				        swal.close();
				        $("#refresh").prop("disabled", false);
						$("#value").prop("readonly", false);
						$("#btn01").prop("disabled", false);
				        $("#pw_email").focus();
					});
					
					$("#refresh").prop("disabled", false);
					captcha();
					return;
				// 임시비밀번호 이메일 전송 및 db 수정을 성공한 경우
				} else if (data.result == "success"){
					swal({
					    text: "임시 비밀번호가 [" + email + "]로 발송되었습니다. 이메일을 확인하여 주십시오.",
					    closeModal: false,
					    icon: "success",
					}).then(function() {
				        swal.close();
				        
				        $("#member_password").val("");
				        $("#member_password").focus();
				        
				        $("#pw_email").val("");
				        $("#pw_tel").val("");
				        
				        $("#refresh").prop("disabled", false);
						$("#value").prop("readonly", false);
						$("#btn01").prop("disabled", false);
				        
				        $("#pw_popup").attr("style", "display:none;");
					});    
					return;
				// 임시비밀번호 이메일 전송 및 db 수정을 실패한 경우
				} else {
					swal({
					    text: "오류가 발생하였습니다. 재시도해주시기 바랍니다.",
					    closeModal: false,
					    icon: "warning",
					}).then(function() {
				        swal.close();
				        $("#pw_email").focus();
					});
					
					$("#refresh").prop("disabled", false);
					captcha();
					
					return;
				}
			},
			error : function(err){
				console.log("실패" + err);
			}
		});
	}
	
	// 캡차
	function captcha() {
		$.ajax({
			method : 'post',
			url : "/spring/captchaNkey",
			dataType:"json",
			success : function(data) {
				
				console.log(data.key);
				$("#key").val(data.key);
				
				$.ajax({
					url : "/spring/captchaImage",
					method : 'get',
					data : "key=" + data.key ,
					success : function(data) {
						console.log(data);
						console.log(data.captchaImageName);
						$("#div01").html("<img src='captchaImage/"+data.captchaImageName+"'>");
					},error : function(xhr) {
						alert('에러'+xhr.status);
					}
				});
			},error : function(xhr) {
				alert('에러'+xhr.status);
			}
		});
	}
	
	// 카카오 로그인 요청 처리할 function
	function loginWithKakao(){
		var loginId = "";
		
		Kakao.init("9e96d9b8ca5bed0ac8c0a0ebf8487a10"); // api key값 등록
		
		// 1. 카카오 로그인 클릭시 개발자센터에서 등록한 계정으로 자동 로그인하는 예제
		// 내 계정을 입력하지않아도 자동 로그인 처리 후 토큰 반환한다
		/* Kakao.Auth.login({
			success: function(authObj){
				alert(JSON.stringify(authObj));		
			},
			fail: function(err){
				alert(JSON.stringify(err));
			}
		}); */
		
		// 2. client 계정을 입력후 로그인 요청을 하는 예제
		// 다른 계정을 로그인 할 수 있는 loginForm창 출력
		Kakao.Auth.loginForm({
			// 로그인 성공 후 행위를 처리 할 function
			success: function(authObj){
				
				// 토큰을 발급 받은 후 해당 토큰을 이용하여 사용자 정보 조회 API요청
				Kakao.API.request({
					url : '/v2/user/me',	//사용자 정보를 조회하는  url
					// 조회 성공 시 행위를 아래 success function에 기술
					success : function(res){
	//						alert(JSON.stringify(res));
						loginId = res.id;	//
// 						alert(loginId);
						
						$("#member_kakao_key").val(loginId);
						$("#socialForm").submit();
						
					},
					// 조회 실패 시 error 알림 창 출력
					fail : function(err){
						alert(JSON.stringify(err));
					}
				});
			
			},
			// 로그인 실패 시 error 출력
			fail: function(err){
				alert(JSON.stringify(err));
			}
		});
	}
	
	// 네이버 로그인 버튼 생성
	function naverLogin(){
		var naverLogin = new naver.LoginWithNaverId({
			clientId : "qhNypmWqJyl2NftqWiT8", // 개발자 센터의 clientId 등록
			callbackUrl : "http://localhost${pageContext.request.contextPath}/naverCallback", // 로그인 후 callback처리를 할 url
			isPopup : true, /* 팝업을 통해 연동처리를 할지에 대한 여부 true : 팝업창 출력 / false : 페이지 이동 */
			loginButton : {color : "green", type : 3, height : 50} /* 로그인 버튼의 타입을 지정 */
		});
		
		/* 네이버 로그인 정보를 초기화하고 연동을 준비하기위해서 init을 호출 */
		naverLogin.init();
	}
	
	function inputNaver(uniqId){
		$("#member_naver_key").val(uniqId);
		$("#socialForm").submit();
	}
</script>

</head>

<body>

	<div id="base">

		<div id="div03" class="card o-hidden border-0 shadow-lg">
			<div class="card-body p-0">
				<div id="div02">
					<div class="pt-4">
						<div class="text-center pt-5">
							<h1 class="h4 text-gray-900 mb-5">로그인</h1>
						</div>

						<div id="comment" class="card shadow mb-4 card-body" style="display: none;"></div>

						<form class="user" id="loginForm" method="post"
							action="${pageContext.request.contextPath}/normalLogin">

							<div class="form-group">
								<input type="text" class="form-control form-control-user"
									id="member_id" name="member_id" placeholder="아이디를 입력해주십시오.">
							</div>

							<div class="form-group">
								<input type="password" class="form-control form-control-user"
									id="member_password" name="member_password" placeholder="비밀번호를 입력해주십시오.">
							</div>

							<a href="#" id="login" class="btn btn-primary btn-user btn-block">LOGIN</a>

						</form>
							
						<div id="social">
							<form id="socialForm" action="${pageContext.request.contextPath}/social" method="post">
								<input type="hidden" name="member_kakao_key" id="member_kakao_key"/>
								<input type="hidden" name="member_naver_key" id="member_naver_key"/>
							</form>
							
							<hr>

							<!-- naver login -->
							<div class="mb-3" id="naverIdLogin"></div>

							<!-- kakao login -->
							<a id="custom-login-btn" href="javascript:loginWithKakao()">
								<img src="//k.kakaocdn.net/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="345">
							</a>
							
							<!-- 로그인 한 kakao계정 로그아웃 요청 -->
							<a href="http://developers.kakao.com/logout"></a>
						</div>

						<hr>
						
						<div class="text-center">
							<a id="findId" href="#">아이디 찾기</a> &nbsp;&nbsp;/&nbsp;&nbsp;
							<a id="findPw" href="#">비밀번호 찾기</a>
						</div>
						
						<div class="text-center mt-1">
							<a href="${pageContext.request.contextPath}/main">MAIN</a> &nbsp;&nbsp;/&nbsp;&nbsp;
							<a href="${pageContext.request.contextPath}/promise">회원가입</a>
						</div>
						
						<!-- 아이디 찾기 -->
						<div id="id_popup" style="display: none;" class="card shadow mb-4 text-center">
							<div class="card-header py-3">
								<h5 class="m-1 font-weight-bold text-primary">아 이 디 찾 기</h5>
							</div>
							<div class="card-body">
								<input id="id_email" type="email" class="form-control email" placeholder="이메일을 입력해주십시오.">
								<input id="id_tel" type="text" class="form-control tel" placeholder="휴대전화번호를 입력해주십시오.(-포함)">
								
								<hr>
								
								<button id="findIdBtn" class="btn btn-primary">확인</button>
								<button id="cancelIdBtn" class="btn btn-secondary">취소</button>
							</div>
						</div>
						
						<!-- 비밀번호 찾기 -->
						<div id="pw_popup" style="display: none;" class="card shadow mb-4 text-center">
							<div class="card-header py-3">
								<h5 class="m-1 font-weight-bold text-primary">비 밀 번 호 찾 기</h5>
							</div>
							<div class="card-body">
								<input id="pw_email" type="email" class="form-control email" placeholder="이메일을 입력해주십시오.">
								<input id="pw_tel" type="text" class="form-control tel" placeholder="휴대전화번호를 입력해주십시오.(-포함)">
								
								<hr>
								
								<!-- 캡차 -->
								<div id="div01">
								</div>

								<button type="button" class="btn btn-gray" id="refresh">
									<img id="tofh" src="img/새로고침.PNG">
								</button>

								<form id="form01">
									<input type="hidden" id="key" name="key">
									<input type="text" id="value" name="value" class="form-control mt-2" placeholder="내용을 입력해주십시오." style="width:47%;">
									<button type="button" id="btn01" class="btn btn-secondary mr-1">인증</button>
								</form>

								<form id="captchaFrm">
									<input type="hidden" id="capKey" name="key">
									<input type="hidden" id="capVal" name="value">
								</form>

								<hr>

								<button id="findPwBtn" class="btn btn-primary">확인</button>
								<button id="cancelPwBtn" class="btn btn-secondary">취소</button>
							</div>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

</html>
