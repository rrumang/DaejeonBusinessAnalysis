<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	#div01 {
		text-align: center;
	}
	
	#okBtn, #cancelBtn {
		margin : 20px 0;
		margin-right : 10px;
	}
	
	#form01 input[type=password] {
		margin-bottom : 10px;
	}
	
	#div02 {
		margin : 0 auto;
		height: 400px;
		width : 50%;
		padding-top: 60px;
	}
	p {
		color : black;
	}
	
	
</style>

<script>
	$(document).ready(function(){
		// 확인 버튼을 클릭했을 때
		$("#okBtn").on("click", function(e){
			e.preventDefault();
			
			var password = "${TEMPORARY}";
			var prev_pw = $("#prev_pw").val();
			
			if(prev_pw == ""){
				swal({
				    text: "현재 비밀번호를 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#prev_pw").val("");
			        $("#prev_pw").focus();
				});
				return;
			} else if(password != prev_pw) {
				swal({
				    text: "현재 비밀번호가 일치하지 않습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#prev_pw").val("");
			        $("#prev_pw").focus();
				});
				return;
			}
			
			// 변경할 비밀번호 검증
			var new_pw = $("#new_pw").val();
			var password_reg = /^[a-zA-Z0-9]{6,13}$/;
			
			if(new_pw == ""){
				swal({
				    text: "변경할 비밀번호를 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#new_pw").val("");
			        $("#new_pw").focus();
				});
				return;
			} else if(password == new_pw) {
				swal({
				    text: "변경할 비밀번호가 현재 비밀번호와 동일합니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#new_pw").val("");
			        $("#new_pw").focus();
				});
				return;
			} else if(!password_reg.test(new_pw)){
				swal({
				    text: "비밀번호 형식이 올바르지 않습니다. 다시 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#new_pw").val("");
			        $("#new_pw").focus();
				});
				return;
			}
			
			// 변경할 비밀번호 재입력 검증
			var check_pw = $("#check_pw").val();
			
			if(check_pw == ""){
				swal({
				    text: "변경할 비밀번호를 다시 한 번 입력해주십시오.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#check_pw").val("");
			        $("#check_pw").focus();
				});
				return;
			} else if(new_pw != check_pw) {
				swal({
				    text: "변경할 비밀번호가 일치하지 않습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#check_pw").val("");
			        $("#check_pw").focus();
				});
				return;
			}
			
			$("#form01").submit();
		});
		
		// 취소 버튼 클릭했을 때
		$("#cancelBtn").on("click", function(e){
			e.preventDefault();
		
			swal({
				  text: "비밀번호 변경을 취소하시겠습니까?",
				  buttons: true,
				})
				.then((value) => {
				  if (value) {
				   	// 메인으로 이동
				   	window.location.replace("${pageContext.request.contextPath}/main");
				  } else {
				    swal.close();
				  }
				});
			
		});
		
	});
</script>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h3 class="m-0 font-weight-bold text-primary">비밀번호 변경</h3>
		</div>

		<div id="div02" class="card-body">
			
			<div class="card shadow col-12 p-0">
				<div class="card-header">
					<h6 class="m-0 font-weight-bold text-primary">
						<i class="fas fa-info-circle"></i> 도움말</h6>
				</div>
				<div class="card-body">
					<p>
						임시비밀번호로 로그인 하셨습니다. 비밀번호를 변경해 주시기 바랍니다. <br>
						비밀번호는 영문 대, 소문자, 숫자 6자리 ~ 13자리로 작성하여야 합니다.
					</p>
				</div>
			</div>
			
			<br><br>
			
			<form id="form01" action="${pageContext.request.contextPath}/modifyPw" method="post">
				<input type="password" id="prev_pw" class="form-control" placeholder="현재 비밀번호를 입력해주십시오." />
				<input type="password" id="new_pw" name="member_password" class="form-control" placeholder="변경할 비밀번호를 입력해주십시오." />
				<input type="password" id="check_pw" class="form-control" placeholder="변경할 비밀번호를 다시 한 번 입력해주십시오." />
			</form>
		</div>
		
		<br><br>

		<div id="div01" class="bg-gray-100">
			<a href="#" id="okBtn" class="btn btn-primary btn-icon-split"> <span
				class="text">확인</span>
			</a> <a href="#" id="cancelBtn" class="btn btn-secondary btn-icon-split">
				<span class="text">취소</span>
			</a>
		</div>
	</div>
</div>
