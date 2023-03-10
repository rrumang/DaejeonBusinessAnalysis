<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>

	#form01 input, #form01 select {
		display: inline-block;
	}
	
	label {
		text-align : right;
		width : 12%;
		margin-bottom : 20px;
		margin-right : 20px;
	}
	
	#form01 input[type=radio] {
		width : 5%;
		text-align : left;
	}
	
	#regionDiv01, #regionDiv02, #tobDiv01, #tobDiv02{
		width : 30.7%;
		display: inline-block;
	}
	
	.div01 input{
		width : 30.7%;
		margin-left: 5px;
	}
	
	#div05 div {
		width : 30.7%;
	}
	
	#div02 input, #div02 select{
		width : 10%;
	}
	
	#div03 input{
		width : 9.55%;
	}
	
	#div04 input, #div04 select {
		width : 10%;
	}
	
	#regionDiv01 input, #regionDiv01 select, #tobDiv01 select {
		display: inline-block;
		width : 32.5%;
	}
	
	#div05 {
		margin-right : 2%;
	}
	
	#div06 {
		margin-right : 14.8%;
	}
	
	#div07 {
		margin : 0 auto;
		padding : 70px 0;
		width : 30%;
		height : 300px;
	}
	
	#div08 {
		margin : 0 auto;
		width : 41%;
	}
	
</style>

<script>
	$(document).ready(function(){
		checkMessage();
		
		// 숫자만 입력 가능하게 설정
		$("#div03 input[type=text]").keyup(function(){
			this.value=this.value.replace(/[^0-9]/g,'');
		})
		
		// 영문, 숫자만 입력 가능하게 설정
		$("#member_password").keyup(function(){
			this.value=this.value.replace(/[^a-zA-Z0-9]+$/g, '');
		})
		
		// 한글만 입력 가능하게 설정
		$("#member_name").keyup(function(){
			this.value=this.value.replace(/[^가-힣]+$/g,'');
		})
		
		$("#form01 input").attr("disabled", true);
		$("#form01 select").attr("disabled", true);
		$("#kakaoBtn").prop("disabled", true);
		$("#naverBtn").prop("disabled", true);
		
		// 카카오인증키가 존재하는 경우
		if("${MEMBER_INFO.member_kakao_key}" != ""){
			$("#kakaoBtn").attr("class", "btn btn-info");
			$("#kakaoBtn").text("KAKAO 연동해제");
		}

		// 네이버인증키가 존재하는 경우
		if("${MEMBER_INFO.member_naver_key}" != ""){
			$("#naverBtn").attr("class", "btn btn-info");
			$("#naverBtn").text("NAVER 연동해제");
		}
		
		// 회원의 이메일 세팅
		setEmail();
		
		// 회원의 관심지역 세팅
		setRegion();
		
		// 회원의 관심업종 세팅
		setTob();
		
		// 업종대분류를 선택하면 해당 업종대분류의 중분류 리스트를 조회
		$("#largeBox").on("change", function(){
			// 소분류 초기화
			$("#smallBox").empty();
			var html = '<option class="dropdown-item" value="all">전체(소분류)</option>';
			$("#smallBox").append(html);
			
			var tob_cd3 = $(this).val();
			
			if(tob_cd3 == "all"){
				// 중분류 초기화
				$("#middleBox").empty();
				
				var html2 = '<option class="dropdown-item" value="all">전체(중분류)</option>';
				$("#middleBox").append(html2);
				
				return;
			} else {
				setTobList(tob_cd3, "", "#middleBox");
			}
		});
		
		// 업종중분류를 선택하면 해당 업종대분류의 중분류 리스트를 조회
		$("#middleBox").on("change", function(){
			var tob_cd2 = $(this).val();
			
			if(tob_cd2 == "all"){
				// 소분류 초기화
				$("#smallBox").empty();
				var html = '<option class="dropdown-item" value="all">전체(소분류)</option>';
				$("#smallBox").append(html);
				
				return;
			} else {
				setTobList(tob_cd2, "", "#smallBox");
			}
		});
		
		// 구를 선택하면 해당 구의 동 리스트를 조회
		$("#guBox").on("change", function(){
			var region_cd2 = $(this).val();
			
			if(region_cd2 == "all"){
				$("#dongBox").empty();
				
				var html = '<option class="dropdown-item" value="all">전체(동)</option>';
				$("#dongBox").append(html);
				
				return;
			} else {
				dongListLookUp(region_cd2, 0);
			}
		});
		
		// 이메일을 선택했을 때
		$("#emailBox").on("change", function(){
			var email = $(this).val();
			
			var domainArr = new Array("@naver.com", "@gmail.com", "@hanmail.com");
			
			// 배열안에 포함되어있으면
			if($.inArray(email, domainArr) != -1){
				$("#member_email2").val(email);
			} else {
				$("#member_email2").val("");
				$("#member_email2").focus();
			}
		});
		
		// 회원정보조회 화면 수정버튼을 클릭했을 때 --> 수정 가능하게 input 활성화
		$("#modifyBtn").on("click", function(e){
			e.preventDefault();
			
			swal({
			  text: "회원정보를 수정하시겠습니까?",
			  buttons: true,
			  icon : "info",
			})
			.then((value) => {
			  if (value) {
				$("#form01 input").attr("disabled", false);
				$("#form01 select").attr("disabled", false);
				$("#form01 input:radio").attr("disabled", true);

			  	var naver = "${MEMBER_INFO.member_naver_key}";
			  	if(naver != ""){
			  		$("#naverBtn").attr("disabled", false);
			  	}
			  	
			  	var kakao = "${MEMBER_INFO.member_kakao_key}";
			  	if(kakao != ""){
			  		$("#kakaoBtn").attr("disabled", false);
			  	}
			  	
			  	$(this).css("display", "none");
			  	$("#cancelBtn").css("display", "none");
			  	
			  	$("#modifyBtn2").css("display", "inline-block");
			  	$("#cancelBtn2").css("display", "inline-block");
			  	
			  	$("#regionDiv01").css("display", "inline-block");
			  	$("#tobDiv01").css("display", "inline-block");
			  	
			  	$("#withdrawBtn").css("display", "none");
			  	$("#regionDiv02").css("display", "none");
			  	$("#tobDiv02").css("display", "none");
			  	
			  	$("#member_password").focus();
			  	
			  	$("#title").text("회원정보수정");
			  } else {
			    swal.close();
			  }
			});
			
		});
		
		// 회원정보 조회 취소버튼을 클릭했을 때
		$("#cancelBtn").on("click", function(e){
			e.preventDefault();
			
			swal({
			  text: "메인으로 이동하시겠습니까?",
			  buttons: true,
			  icon : "info",
			})
			.then((value) => {
			  if (value) {
				window.location.replace("${pageContext.request.contextPath}/main");
			  } else {
			    swal.close();
			  }
			});
		});
		
		// 회원정보 수정 취소버튼을 클릭했을 때
		$("#cancelBtn2").on("click", function(e){
			e.preventDefault();
			
			swal({
			  text: "회원정보 수정을 취소하시겠습니까?",
			  buttons: true,
			  icon : "info",
			})
			.then((value) => {
			  if (value) {
				    $("#form01 input").attr("disabled", true);
					$("#form01 select").attr("disabled", true);
					$("#form01 input:radio").attr("disabled", false);

					// 수정하기 전 값으로 변경
				  	var naver = "${MEMBER_INFO.member_naver_key}";
				  	if(naver != ""){
				  		$("#naverBtn").attr("disabled", true);
				  	}
				  	
				  	var kakao = "${MEMBER_INFO.member_kakao_key}";
				  	if(kakao != ""){
				  		$("#kakaoBtn").attr("disabled", true);
				  	}
				  	
				  	// 비밀번호는 빈칸으로 초기화
				  	$("#member_password").val("");
				  	
				  	// 이름
				  	var name = "${MEMBER_INFO.member_name}";
				  	$("#member_name").val(name);
				  	
				  	// 이메일 세팅
				  	setEmail();
				  	
				  	// 전화번호
				  	var tel1 = "${fn:substring(MEMBER_INFO.member_tel,0,3)}";
				  	var tel2 = "${fn:substring(MEMBER_INFO.member_tel,4,8)}";
				  	var tel3 = "${fn:substring(MEMBER_INFO.member_tel,9,fn:length(MEMBER_INFO.member_tel))}";
				  	$("#member_tel1").val(tel1);
				  	$("#member_tel2").val(tel2);
				  	$("#member_tel3").val(tel3);
				  	
					// 관심지역
					setRegion();
					
					// 관심업종
					setTob();
				  	
				  	//----------------------------------------------
				  	
				  	$("#modifyBtn").css("display", "inline-block");
				  	$("#cancelBtn").css("display", "inline-block");
				  	
				  	$("#modifyBtn2").css("display", "none");
				  	$("#cancelBtn2").css("display", "none");
				  	
				  	$("#withdrawBtn").css("display", "inline-block");
				  	
				  	$("#title").text("회원정보조회");  
				  
			  } else {
			    swal.close();
			  }
			});
		});
		
		// 네이버버튼을 클릭했을 때
		$("#naverBtn").on("click", function(){
			swal({
			  text: "네이버 계정 연동을 해제하시겠습니까?",
			  buttons: true,
			  icon : "info",
			})
			.then((value) => {
			  if (value) {
				unlinkedSocial("MEMBER_NAVER_KEY");
			  } else {
			    swal.close();
			  }
			});
		});
		
		// 카카오버튼을 클릭했을 때
		$("#kakaoBtn").on("click", function(){
			swal({
			  text: "카카오 계정 연동을 해제하시겠습니까?",
			  buttons: true,
			  icon : "info",
			})
			.then((value) => {
			  if (value) {
				unlinkedSocial("MEMBER_KAKAO_KEY");
			  } else {
			    swal.close();
			  }
			});
		});

		// 탈퇴버튼을 클릭했을 때
		$("#withdrawBtn").on("click", function(e){
			e.preventDefault();
			
			swal({
			  text: "탈퇴하시겠습니까?",
			  buttons: true,
			  icon : "info",
			})
			.then((value) => {
			  if (value) {
				$("#mypageDiv").css("display", "none");
				$("#btnDiv01").css("display", "none");
				  
				$("#checkDiv").css("display", "inline-block");
				$("#btnDiv03").css("display", "inline-block");
				
				$("#title").text("탈퇴확인");
				
				$("#check_password").focus();
			  } else {
			    swal.close();
			  }
			});
		});
		
		// 탈퇴-확인버튼을 클릭했을 때
		$("#okBtn02").on("click", function(e){
			e.preventDefault();
			
			// 비밀번호 확인 입력 검증
			var password = $("#check_password").val().trim();
			
			if(password == ""){
				swal({
				    text: "비밀번호를 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#check_password").val("");
			        $("#check_password").focus();
				});
				return;
			} else {
				checkPassword(password, "withdraw");
			}
		});
		
		// 탈퇴-취소버튼을 클릭했을 때
		// 취소버튼을 클릭했을 때
		$("#cancelBtn02").on("click", function(e){
			e.preventDefault();
			
			swal({
			  text: "탈퇴를 취소하시겠습니까?",
			  buttons: true,
			  icon : "info",
			})
			.then((value) => {
			  if (value) {
				  $("#check_password").val("");
				  
				  $("#checkDiv").css("display", "none");
				  $("#btnDiv03").css("display", "none");
				  
				  $("#mypageDiv").css("display", "inline-block");
				  $("#btnDiv01").css("display", "inline-block");
				  
				  $("#title").text("회원정보조회");
			  } else {
			    swal.close();
			  }
			});
		});
		
		// 비밀번호 입력 확인버튼을 클릭했을 때
		$("#okBtn").on("click", function(e){
			e.preventDefault();
			
			// 비밀번호 확인 입력 검증
			var password = $("#check_password").val().trim();
			
			if(password == ""){
				swal({
				    text: "비밀번호를 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#check_password").val("");
			        $("#check_password").focus();
				});
				return;
			} else {
				checkPassword(password, "myPage");
			}
		});
		
		// 취소버튼을 클릭했을 때
		$("#cancelBtn01").on("click", function(e){
			e.preventDefault();
			
			swal({
			  text: "취소 하시겠습니까?",
			  buttons: true,
			  icon : "info",
			})
			.then((value) => {
			  if (value) {
				window.location.replace("${pageContext.request.contextPath}/main");
			  } else {
			    swal.close();
			  }
			});
		});
		
		// 회원정보수정 - 확인버튼을 클릭했을 때
		$("#modifyBtn2").on("click", function(e){
			e.preventDefault();
			
			// 입력 검증 및 정규식 검사
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
			
			// 이름
			var name_reg = /^[가-힣]{2,7}$/;
			if ($("#member_name").val().trim() == "") {
				swal({
				    text: "이름을 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_name").val("");
			        $("#member_name").focus();
				});
				return;
			}else if(!name_reg.test($("#member_name").val())){
				swal({
				    text: "이름 형식(한글 2 ~ 7글자)이 올바르지 않습니다. 다시 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_name").val("");
			        $("#member_name").focus();
				});
				return;
			}
			
			// 이메일
			var email_reg = /^[a-zA-Z0-9]{4,}$/;
			var email1 = $("#member_email1").val();
			var email2 = $("#member_email2").val();
			
			if (email1.trim() == "") {
				swal({
				    text: "이메일을 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_email1").val("");
			        $("#member_email1").focus();
				});
				return;
			} else if(!email_reg.test(email1)){
				swal({
				    text: "이메일 형식(영문 대, 소문자, 숫자 조합 4글자 이상)이 올바르지 않습니다. 다시 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_email1").val("");
			        $("#member_email1").focus();
				});
				return;
			}

			var domain_reg = /^@[0-9a-zA-Z]{1,7}([.]{1}[a-zA-Z]{2,3}){1,2}$/;
			if (email2.trim() == "") {
				swal({
				    text: "도메인을 선택 또는 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_email2").val("");
			        $("#member_email2").focus();
				});
				return;
			} else if(!domain_reg.test(email2)){
				swal({
				    text: "도메인 형식(@포함)이 올바르지 않습니다. 다시 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_email2").val("");
			        $("#member_email2").focus();
				});
				return;
			}
			
			// 이메일 값 합치기
			$("#member_email").val(email1.trim() + email2.trim());
			
			var tel1 = $("#member_tel1").val();
			var tel2 = $("#member_tel2").val();
			var tel3 = $("#member_tel3").val();
			
			// 전화번호
			if (tel1.trim().length == 0) {
				swal({
				    text: "전화번호(1)를 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_tel1").val("");
			        $("#member_tel1").focus();
				});
				return;
			}else if(tel1.trim().length != 3){
				swal({
				    text: "전화번호(1)를 3글자 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_tel1").val("");
			        $("#member_tel1").focus();
				});
				return;
			}
			
			if (tel2.trim().length == 0) {
				swal({
				    text: "전화번호(2)를 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_tel2").val("");
			        $("#member_tel2").focus();
				});
				return;
			}else if(tel2.trim().length != 4){
				swal({
				    text: "전화번호(2)를 4글자 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_tel2").val("");
			        $("#member_tel2").focus();
				});
				return;
			}	
			
			if (tel3.trim().length == 0) {
				swal({
				    text: "전화번호(3)를 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_tel3").val("");
			        $("#member_tel3").focus();
				});
				return;
			}else if(tel3.trim().length != 4){
				swal({
				    text: "전화번호(3)를 4글자 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#member_tel3").val("");
			        $("#member_tel3").focus();
				});
				return;
			}	
			
			// 전화번호 합치기
			var tel = tel1.trim() + "-" + tel2.trim() + "-" + tel3.trim();
			
			$("#member_tel").val(tel);

			// 관심지역
			// 구를 선택했다면 동도 선택해야 함
			if($("#guBox").val() != "all") {
				if($("#dongBox").val() != "all") {
					// 관심지역
					$("#region_cd").val($("#dongBox").val());
				} else {
					swal({
					    text: "관심지역(동)을 선택해주십시오."
					    	+ "관심지역을 설정하고 싶지 않다면 '관심지역(구)'을 '전체'로 변경해주십시오.",
					    closeModal: false,
					    icon: "warning",
					}).then(function() {
				        swal.close();
					});
					return;
				}
			}
			
			// 관심업종
			// 대분류 -> 중분류 -> 소분류
			if($("#largeBox").val() != "all"){
				if($("#middleBox").val() != "all"){
					if($("#smallBox").val() != "all"){
						// 관심업종
						$("#tob_cd").val($("#smallBox").val());
					} else {
						swal({
						    text: "관심업종(소분류)을 선택해주십시오." 
						    	+ "관심업종을 설정하고 싶지 않다면 '관심업종(대분류)'을 '전체'로 변경해주십시오.",
						    closeModal: false,
						    icon: "warning",
						}).then(function() {
					        swal.close();
						});
						return;
					}
				} else {
					swal({
					    text: "관심업종(중분류)을 선택해주십시오." 
					    	+ "관심업종을 설정하고 싶지 않다면 '관심업종(대분류)'을 '전체'로 변경해주십시오.",
					    closeModal: false,
					    icon: "warning",
					}).then(function() {
				        swal.close();
					});
					return;
				}
			}
			
			swal({
				text: "수정하시겠습니까?",
				buttons: true,
				icon : "info",
			})
			.then((value) => {
				if (value) {
					// 입력 검증 완료--> 폼 전송
					$("#form01").submit();
				} else {
				  swal.close();
				}
			});
		});
		
		
	});

// 비밀번호 확인 ajax
function checkPassword(password, str){
	$.ajax({
		url : "${pageContext.request.contextPath}/checkPassword",
		data : "password=" + password,
		dataType : "json",
		method : "post",
		success : function(data){
			console.log(data.result);
			$("#check_password").val("");

			// 회원정보 화면 출력
			if(data.result == true && str == "myPage"){
				$("#checkDiv").css("display", "none");
				$("#btnDiv02").css("display", "none");
				
				$("#mypageDiv").css("display", "inline-block");
				$("#btnDiv01").css("display", "inline-block");
				
				$("#title").text("회원정보조회");
			
			// 탈퇴 처리
			} else if(data.result == true && str == "withdraw"){
				swal({
				  text: "탈퇴하시겠습니까? 연동된 소셜계정은 모두 연동이 해제되며, "
						+ "탈퇴한 아이디는 재사용이 불가능합니다.",
				  icon: "warning",
				  buttons: true,
				})
				.then((value) => {
				  if (value) {
					  withdraw();
				  } else {
				    swal.close();
				  }
				});
				
			} else {
				swal({
				    text: "비밀번호가 일치하지 않습니다. 다시 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
				    swal.close();
				    $("#check_password").val("");
			        $("#check_password").focus();
				});
			}
		},
		error : function(err){
			console.log(err);
		}
	});
}

// 회원 탈퇴처리
function withdraw(){
	$.ajax({
		url : "${pageContext.request.contextPath}/withdraw",
		dataType : "json",
		method : "post",
		success : function(data){
			console.log(data.result);
			
			if(data.result == true){
				swal({
				    text: "탈퇴처리가 완료되었습니다. 메인으로 이동합니다.",
				    closeModal: false,
				    icon: "success",
				}).then(function() {
				    swal.close();
				    window.location.replace("${pageContext.request.contextPath}/main");
				});
			} else {
				swal({
				    text: "탈퇴처리가 완료되지 않았습니다. 회원정보로 이동합니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
				    swal.close();
				    window.location.replace("${pageContext.request.contextPath}/myPage");
				});
			}
		},
		error : function(err){
			console.log(err);
		}
	});
}

	
// 네이버, 카카오 연동 해제 처리 ajax
function unlinkedSocial(social){
	$.ajax({
		url : "${pageContext.request.contextPath}/unlinkedSocial",
		data : "social=" + social,
		dataType : "json",
		method : "post",
		success : function(data){
			console.log(data.result);
			var result = data.result;
			
			if(result == "KAKAO"){
				swal({
				  text: "카카오 계정 연동 해제에 성공하였습니다.",
				  icon: "success",
				});
				$("#kakaoBtn").attr("class", "btn btn-secondary");
				$("#kakaoBtn").attr("disabled", true);
				$("#kakaoBtn").text("KAKAO 미연동중");
			} else if(result == "NAVER"){
				swal({
				  text: "네이버 계정 연동 해제에 성공하였습니다.",
				  icon: "success",
				});
				
				$("#naverBtn").attr("class", "btn btn-secondary");
				$("#naverBtn").attr("disabled", true);
				$("#naverBtn").text("NAVER 미연동중");
			} else {
				swal({
				  text: "계정 연동 해제에 실패하였습니다.",
				  icon: "warning",
				});
			}
		},
		error : function(err){
			console.log(err);
		}
	})
}
	
	
//동 리스트를 ajax로 호출하는 function() 
function dongListLookUp(region_cd2, region_cd){
	
	// 동 리스트 가져오기
	$.ajax({
		url : "${pageContext.request.contextPath}/bdAnalysis/dongListLookUp"
	   ,data : "region_cd2=" + region_cd2
	   ,dataType : "json"
	   ,method : "get"
	   ,success : function(data){
		   var list = $('#dongBox > option');
		   for(var i=0; i < list.length; i++){
			   list[i].remove();
		   }			

		   var dongList = data.dongList;
		   var html = "";
		   html = '<option class="dropdown-item" value="all">전체(동)</option>';
		   
		   $.each(dongList, function(idx, dong){
			   if(region_cd != ""){
				   if(dong.region_cd == region_cd){
					   html += "<option class=\"dropdown-item\" value=\""+ dong.region_cd +"\" selected>"+ dong.region_name + "</option>";
				   } else {
					   html += "<option class=\"dropdown-item\" value=\""+ dong.region_cd +"\">"+ dong.region_name + "</option>";
				   }
			   } else {
				   html += "<option class=\"dropdown-item\" value=\""+ dong.region_cd +"\">"+ dong.region_name + "</option>";
			   }
			   
		   })
		   
		   $("#dongBox").empty();
		   $('#dongBox').append(html);
		   
	   }
	   ,error : function(err){
		   console.log(err);
	   }
	})
}

// 이메일 세팅
function setEmail(){
	var email = "${MEMBER_INFO.member_email}";
	var arr = email.split("@");
	var idx = email.indexOf(arr[arr.length-1]);
	var addr = email.substring(0, idx-1);
	$("#member_email1").val(addr);
	
	var domain = "@" + arr[arr.length-1];
	$("#member_email2").val(domain);
	
	var domainArr = new Array("@naver.com", "@gmail.com", "@hanmail.com");
	
	// 배열안에 포함되어있으면
	if($.inArray(domain, domainArr) != -1){
		$("#emailBox").val(domain);
	} else {
		$("#emailBox").val("other");
	}
}

// 관심지역 세팅
function setRegion(){
	// 회원의 관심 지역이 있는지
	var region_cd = "${regionVo.region_cd}";
	
	// 관심지역이 있으면 초기값 세팅
	if(region_cd != ""){
		$("#regionDiv01").css("display", "inline-block");
		$("#regionDiv02").css("display", "none");
		
		var region_cd2 = "${regionVo.region_cd2}";
		
		$("#guBox").val(region_cd2);
		
		dongListLookUp(region_cd2, region_cd);
	} else {
		$("#regionDiv01").css("display", "none");
		$("#regionDiv02").css("display", "inline-block");
		
		$("#guBox").val("all");
		$("#dongBox").val("all");
	}
}

// 관심업종 세팅
function setTob(){
	// 회원의 관심 업종이 있는지
	var tob_cd = "${tobVo.tob_cd}";
	
	// 관심 업종이 있으면 초기값 세팅
	if(tob_cd != ""){
		$("#tobDiv01").css("display", "inline-block");
		$("#tobDiv02").css("display", "none");
		
		// 대분류
		var tob_cd3 = "${tobVo.tob_cd3}";
		$("#largeBox").val(tob_cd3);
		
		// 중분류
		var tob_cd2 = "${tobVo.tob_cd2}";
		setTobList(tob_cd3, tob_cd2, "#middleBox");
		
		setTobList(tob_cd2, tob_cd, "#smallBox");
	} else {
		$("#tobDiv01").css("display", "none");
		$("#tobDiv02").css("display", "inline-block");
		
		$("#largeBox").val("all");
		$("#middleBox").val("all");
		$("#smallBox").val("all");
	}
}

// 업종대/중분류에 해당하는 업종중/소분류 리스트를 가져오는 ajax
function setTobList(tob_cd2, tob_cd, boxName){
	$.ajax({
		url : "${pageContext.request.contextPath}/tob"
	   ,data : "tob_cd2=" + tob_cd2
	   ,dataType : "json"
	   ,method : "post"
	   ,success : function(data){
		   var list = data.midList;
		   var html = "";
		   
		   if(boxName == "#middleBox"){
		   	   html += '<option class="dropdown-item" value="all">전체(중분류)</option>';
		   } else if(boxName == "#smallBox"){
			   html += '<option class="dropdown-item" value="all">전체(소분류)</option>';
		   }
		   
		   $.each(list, function(idx, tob){
			   if(tob_cd != ""){
				   if(tob.tob_cd == tob_cd){
					   html += "<option class=\"dropdown-item\" value=\""+ tob.tob_cd +"\" selected>"+ tob.tob_name + "</option>";
				   } else {
					   html += "<option class=\"dropdown-item\" value=\""+ tob.tob_cd +"\">"+ tob.tob_name + "</option>";
				   }
			   } else {
				   html += "<option class=\"dropdown-item\" value=\""+ tob.tob_cd +"\">"+ tob.tob_name + "</option>";
			   }
			   
		   })
		   
		   $(boxName).empty();
		   $(boxName).append(html);
	   }
	   ,error : function(err){
		   console.log(err);
	   }
	})
}

//회원정보 수정 후 인지 아닌지 체크(message값이 있으면 수정처리 후)
function checkMessage(){
	var message = "${MESSAGE}";
	console.log(message);
	
	if(message != ""){
	    $("#checkDiv").css("display", "none");
	    $("#btnDiv03").css("display", "none");
	    $("#btnDiv02").css("display", "none");
	  
	    $("#mypageDiv").css("display", "inline-block");
	    $("#btnDiv01").css("display", "inline-block");
	}
	
	if(message == "success"){
		swal({
		    text: "회원 정보 수정이 완료되었습니다.",
		    closeModal: false,
		    icon: "success",
		}).then(function() {
		    swal.close();
		    $("#title").text("회원정보조회");
		});
	} else if(message == "fail"){
		swal({
		    text: "회원 정보 수정을 실패하였습니다.",
		    closeModal: false,
		    icon: "warning",
		}).then(function() {
		    swal.close();
		    $("#title").text("회원정보조회");
		});
	}
};
</script>

<div class="container-fluid">

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h3 id="title" class="m-0 font-weight-bold text-primary">회원정보</h3>
		</div>
		
		<div class="card-body text-center mt-4" id="checkDiv">
			<div id="div07">
				<div class="card shadow mb-4 py-3 px-3 text-info">
					<h5 class="m-0 font-weight-bold">
						<i class="fas fa-info-circle"> 비밀번호를 입력해주십시오. </i>
					</h5>
				</div>
			
				<input type="password" class="form-control" id="check_password" autofocus>
			</div>
		</div>
		
		<!-- 비밀번호 입력 확인 화면 -->
		<div class="text-center mb-4" id="btnDiv02">
			<a href="#" id="okBtn" class="btn btn-primary">확인</a>
			<a href="#" id="cancelBtn01" class="btn btn-secondary">취소</a>
		</div>

		<div class="text-center mb-4" id="btnDiv03" style="display: none;">
			<a href="#" id="okBtn02" class="btn btn-primary">확인</a>
			<a href="#" id="cancelBtn02" class="btn btn-secondary">취소</a>
		</div>
		
		<div class="card-body text-center mt-4" id="mypageDiv" style="display: none;">
			
			<div id="div08" class="card shadow mb-4 py-3 px-3 text-info">
				<h5 class="m-0 font-weight-bold">
					<i class="fas fa-info-circle"> 아이디, 성별, 생년월일을 제외한 회원정보 수정이 가능합니다. </i>
				</h5>
			</div>
			
			<form id="form01" action="${pageContext.request.contextPath}/modifyMember" method="post">
				<div class="div01 mr-5 pr-5">
					<label>아이디</label>
					<input type="text" class="form-control" name="member_id" id="member_id" 
						value="${MEMBER_INFO.member_id}" readonly> <br>			
				</div>
				
				<div class="div01 mr-5 pr-5">
					<label>비밀번호</label>
					<input type="password" class="form-control" name="member_password" id="member_password" 
						placeholder="현재 비밀번호 또는 변경할 비밀번호를 입력해주십시오."> <br>
				</div>
				
				<div class="div01 mr-5 pr-5">
					<label>이름</label>
					<input type="text" class="form-control" name="member_name" id="member_name"
						value="${MEMBER_INFO.member_name}" placeholder="이름을 입력해주십시오. (2 ~ 7글자)"> <br>			
				</div>

				<div id="div05"class="mr-5 pr-5">
					<label>성별</label>
					<div class="figure text-left">
						<input type="radio" name="member_gender" value="1" <c:if test="${MEMBER_INFO.member_gender eq 1}"> checked </c:if> > 남자&nbsp;&nbsp;
						<input type="radio" name="member_gender" value="2" <c:if test="${MEMBER_INFO.member_gender eq 2}"> checked </c:if> > 여자		
					</div>
				</div>
			
				<div id="div02" class="mr-5 pr-5">
					<label>이메일</label>
					<input type="hidden" name="member_email" id="member_email"/>

					<input type="text" class="form-control" id="member_email1" placeholder="이메일주소를 입력해주십시오.">
					<input type="text" class="form-control" id="member_email2" placeholder="'@'를 포함하여 입력해주십시오.">
					
					<select class="form-control w-49 nav-item dropdown show" id="emailBox">
						<option class="dropdown-item" value="all">이메일선택</option>
						<option class="dropdown-item" value="@naver.com">네이버</option>
						<option class="dropdown-item" value="@gmail.com">구글</option>
						<option class="dropdown-item" value="@hanmail.com">한메일</option>
						<option class="dropdown-item" value="other">직접입력</option>
					</select>
				</div>
				
				<div id="div03" class="mr-5 pr-5">
					<label>전화번호</label>
					<input type="hidden" name="member_tel" id="member_tel"/>
					
					<input type="text" class="form-control" id="member_tel1"
						value="${fn:substring(MEMBER_INFO.member_tel,0,3)}" placeholder="전화번호(1)"> - 			
					<input type="text" class="form-control" id="member_tel2"
						value="${fn:substring(MEMBER_INFO.member_tel,4,8)}" placeholder="전화번호(2)"> - 			
					<input type="text" class="form-control" id="member_tel3" placeholder="전화번호(3)"
						value="${fn:substring(MEMBER_INFO.member_tel,9,fn:length(MEMBER_INFO.member_tel))}">
				</div>
				
				<div id="div04" class="mr-5 pr-5">
					<label>생년월일</label>
					
					<fmt:formatDate value="${MEMBER_INFO.member_birth}" var="birth" pattern="yyyyMMdd"/>
					<c:set value="${fn:substring(birth,0,4)}" var="year"></c:set>
					<c:set value="${fn:substring(birth,4,6)}" var="month"></c:set>
					<c:set value="${fn:substring(birth,6,8)}" var="day"></c:set>
					
					<input type="text" class="form-control" value="${year}년" readonly/>
					<input type="text" class="form-control" value="${month}월" readonly/>
					<input type="text" class="form-control" value="${day}일" readonly/>
				</div>
				
				<div class="mr-5 pr-5">
					<label>관심지역</label>
					<input type="hidden" name="region_cd" id="region_cd" value="0"/>
					
					<div id="regionDiv01" style="display: none;">
						<input type="text" class="form-control" value="대전광역시" readonly>
						
						<select class="form-control w-49 nav-item dropdown show" id="guBox">
							<option class="dropdown-item" value="all">전체(구)</option>
							<c:forEach items="${guList}" var="gu">
								<option class="dropdown-item" value="${gu.region_cd}">${gu.region_name}</option>
							</c:forEach>
						</select> 
						
						<select class="form-control w-49 nav-item dropdown show" id="dongBox">
							<option class="dropdown-item" value="all">전체(동)</option>
						</select>
					</div>
					
					<div id="regionDiv02">
						<span>현재 설정된 관심지역이 없습니다.</span>
					</div>
				</div>
				
				<div class="mr-5 pr-5">
					<label>관심업종</label>
					<input type="hidden" name="tob_cd" id="tob_cd"/>
					
					<div id="tobDiv01" style="display:none;">					
						<select class="form-control w-49 nav-item dropdown show" id="largeBox">
							<option class="dropdown-item" value="all">전체(대분류)</option>
							<c:forEach items="${largeList}" var="tob">
								<option class="dropdown-item" value="${tob.tob_cd}">${tob.tob_name}</option>
							</c:forEach>
						</select> 
						
						<select class="form-control w-49 nav-item dropdown show" id="middleBox">
							<option class="dropdown-item" value="all">전체(중분류)</option>
						</select> 
						
						<select class="form-control w-49 nav-item dropdown show" id="smallBox">
							<option class="dropdown-item" value="all">전체(소분류)</option>
						</select>
					</div>
					
					<div id="tobDiv02">
						<span>현재 설정된 관심업종이 없습니다.</span>
					</div>
				</div>
			</form>
				
			<div id="div06">
				<label>소셜계정 연동해제</label>
				<button id="naverBtn" class="btn btn-secondary">NAVER 미연동중</button>
				<button id="kakaoBtn" class="btn btn-secondary">KAKAO 미연동중</button>
			</div>
		</div>
		
		<!-- 회원정보조회 화면 -->
		<div class="text-center mb-4" id="btnDiv01" style="display:none;">
			<a href="#" id="modifyBtn" class="btn btn-primary">수정</a>
			<a href="#" id="modifyBtn2" class="btn btn-primary" style="display: none;">확인</a>
			<a href="#" id="withdrawBtn" class="btn btn-danger">탈퇴</a>
			<a href="#" id="cancelBtn" class="btn btn-secondary">취소</a>
			<a href="#" id="cancelBtn2" class="btn btn-secondary" style="display: none;">취소</a>
		</div>
	</div>
</div>