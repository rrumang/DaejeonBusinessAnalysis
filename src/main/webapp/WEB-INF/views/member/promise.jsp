<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- jqeury 등록 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	function chk() {
		var req = document.form.req.checked;
		var num = 0;
		if (req == true) {
			num = 1;
		}
		if (num == 1) {
			document.form.submit();
		} else {
			swal({
				text : "약관에 동의하여 주세요.",
				closeModal : false,
				icon : "warning",
			}).then(function() {
				swal.close();
			});
			return;
		}
	}
	function nochk() {
		swal({
			text : "비동의시 가입할 수 없습니다. 메인으로 이동합니다.",
			closeModal : false,
			icon : "warning",
		}).then(function() {
			swal.close();
			location.href = "${pageContext.request.contextPath }/main";
		});
	}
</script>

<style>
body {
	background-image:
		url("${pageContext.request.contextPath}/img/background.png");
}

#img01 {
	border: 2px solid;
}
</style>
<link href="css/memberStyle.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<%@include file="/WEB-INF/views/common/basicLib.jsp"%>
<title>회원가입 창</title>
</head>
<body>
	<div class="container">
		<div id="div03" class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body m-0">
				<div class="px-5 pt-3">
					<div class="text-center">
						<form action="${pageContext.request.contextPath }/register"
							name="form">
							<table>
								<tr>

								</tr>
								<tr>
									<td height="15%"></td>
								</tr>
								<tr>
									<td height="60%" align="center">
										<hr> <br>
										<p align="center">
											<b>POJO 이용약관, 개인정보수집 및 이용 동의</b>
										</p> <br> <textarea cols="118" rows="20">
여러분을 환영합니다.

POJO - 대전광역시 상권분석 서비스(이하 ‘서비스’)를 이용해 주셔서 감사합니다.
본 약관은 다양한 POJO 서비스의 이용과 관련하여 POJO 서비스를 제공하는 POJO와
이를 이용하는 POJO 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며,
아울러 여러분의 POJO 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고
있습니다.

POJO는 대전광역시 상권과 관련한 다양한 정보를 제공하고 있습니다.
상권분석, 수익분석, 입지분석, 업종추천, 그외 여러가지 현황정보를
보다 쉽고 명확하게 확인하실 수 있습니다.

회원가입 시 POJO에서 제공하는 모든 서비스를 이용하실 수 있으며,
비회원은 분석기능을 제외한 대부분의 기능을 이용하실 수 있으니 참고하시기 바랍니다.

---------------------------------------------------------------------------------------------------------------------------------------------------------------

정보통신망법 규정에 따라 POJO에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 
개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.

1. 수집하는 개인정보
이용자는 회원가입을 하지 않아도 각종 현황 및 게시글 조회 등 대부분의 POJO 서비스를 회원과 동일하게 이용할 수 있습니다. 
이용자가 상권분석, 수익분석, 입지분석, 업종추천 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 
POJO는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.

회원가입 시점에 POJO가 이용자로부터 수집하는 개인정보는 아래와 같습니다.
- 회원 가입 시에 ‘아이디, 비밀번호, 이름, 생년월일, 성별, 휴대전화번호, 이메일주소’를 필수항목으로 수집합니다. 
- 회원 가입 시에 ‘관심지역, 관심업종’을 선택항목으로 수집합니다.


2. 수집한 개인정보의 이용
POJO 서비스의 회원관리, 서비스 개발・제공 및 향상 등 아래의 목적으로만 개인정보를 이용합니다.

- 회원 가입 의사의 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.
- 법령 및 POJO 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여
  서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 
  분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영을 위하여 개인정보를 이용합니다.
- 서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계 등에 개인정보를 이용합니다.
- 보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.


3. 개인정보의 파기
이용자의 개인정보는 회원 탈퇴 시 빠르게 삭제합니다. 
그러나 아래와 같이 이용자에게 따로 동의를 받는 경우에는 동의 받은 기간 동안 안전하게 보관하였다가 삭제합니다. 

다른 이용자 보호와 안전한 서비스 이용을 위한 경우
옳지 못한 방법으로 서비스를 이용하는 것을 막기 위해 일정 기간 동안 개인정보를 보관하였다가 삭제합니다.

회원 가입, 서비스 이용 관련 정보 (6개월 보관)
옳지 못한 방법으로 가입하거나 징계를 받은 경우, 가입 확인 시 이용된 휴대전화 번호를 보관합니다.

탈퇴 회원 관련 정보 (6개월 보관)
서비스를 옳지 않게 이용한 것에 대한 처벌과 책임을 피하기 위해 POJO로부터 징계를 받기 전에 
회원 가입과 탈퇴를 반복하지 못하도록 탈퇴한 이용자의 휴대전화 번호를 보관합니다.
  						</textarea> <br> <br> <input type="checkbox" name="req">
										이용약관, 개인정보수집 및 이용에 동의합니다. <br>
										<hr>
									</td>
								</tr>
								<tr>
									<td align="center" valign="top">
									<button onclick="chk()" class="btn btn-primary">동의</button>
									<a href="#" onclick="nochk()" class="btn" style="color:black; border:0.5px solid gray; padding:6.9px;">비동의</a>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>

