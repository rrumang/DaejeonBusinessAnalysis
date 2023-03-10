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
<script type="text/javascript">
	
</script>

<title>POJO - 회원가입</title>

<%@include file="/WEB-INF/views/common/basicLib.jsp"%>

</head>

<body class="bg-gradient-primary">

	<div class="container">

		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<!-- Nested Row within Card Body -->
				<div class="row">
					<div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
					<div class="col-lg-7">
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">회원가입</h1>
							</div>
							<form id="frm"
								action="${pageContext.request.contextPath }/main"
								method="post">
								<div class="form-group">
									<input type="text" class="form-control form-control-user"
										id="member_id" name="member_id" placeholder="아이디">
								</div>

								<div class="form-group">
									<input type="text" class="form-control form-control-user"
										id="member_name" name="member_name" placeholder="이름">
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="password" class="form-control form-control-user"
											id="member_password" name="member_password"
											placeholder="비밀번호">
									</div>
									<div class="col-sm-6">
										<input type="password" class="form-control form-control-user"
											id="password_confirm" placeholder="비밀번호 재확인">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" class="form-control form-control-user"
											id="member_email" name="member_email" placeholder="이메일">
									</div>
									<h4>@</h4>
									<div class="col-sm-5">
										<select id="emailAddress"
											class="form-control bg-light border-3 small"
											name="emailAddress">
											<option value="">이메일 선택</option>
											<option value="naver.com">naver.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="hanmail.net">hanmail.net</option>
										</select>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-3 mb-3 mb-sm-0">
										<input type="text" class="form-control form-control-user"
											id="frontNumber" name="frontNumber" value="010" readonly>
									</div>
									<h2>-</h2>
									<div class="col-sm-4">
										<input type="text" class="form-control form-control-user"
											id="middleNumber" name="middleNumber" placeholder="">
									</div>
									<h2>-</h2>
									<div class="col-sm-4">
										<input type="text" class="form-control form-control-user"
											id="backNumber" name="backNumber" placeholder="">
									</div>
								</div>

								<div class="form-group row">
									<div class="col-sm-3 mb-3 mb-sm-0">
										<select class="form-control bg-light border-3 small" id="year"
											name="year">
											<option value="">출생연도</option>
											<option value="1980">1980년</option>
											<option value="1981">1981년</option>
											<option value="1980">1982년</option>
											<option value="1980">1983년</option>
											<option value="1980">1984년</option>
											<option value="1980">1985년</option>
											<option value="1980">1986년</option>
											<option value="1980">1987년</option>
											<option value="1980">1988년</option>
											<option value="1980">1989년</option>
											<option value="1980">1990년</option>
											<option value="1980">1991년</option>
											<option value="1980">1992년</option>
											<option value="1980">1993년</option>
											<option value="1980">1994년</option>
											<option value="1980">1995년</option>
											<option value="1980">1996년</option>
											<option value="1980">1997년</option>
											<option value="1980">1998년</option>
											<option value="1980">1999년</option>
											<option value="1980">2000년</option>
											<option value="1980">2001년</option>
										</select>
									</div>

									<div class="col-sm-2.5">
										<select class="form-control bg-light border-3 small"
											id="month" name="month">
											<option value="">월</option>
											<option value="01">1월</option>
											<option value="02">2월</option>
											<option value="03">3월</option>
											<option value="04">4월</option>
											<option value="05">5월</option>
											<option value="06">6월</option>
											<option value="07">7월</option>
											<option value="08">8월</option>
											<option value="09">9월</option>
											<option value="10">10월</option>
											<option value="11">11월</option>
											<option value="12">12월</option>
										</select>
									</div>
									&nbsp;&nbsp;&nbsp;
									<div class="col-sm-2.5">
										<select class="form-control bg-light border-3 small" id="day"
											name="day">
											<option value="">일</option>
											<option value="01">1일</option>
											<option value="02">2일</option>
											<option value="03">3일</option>
											<option value="04">4일</option>
											<option value="05">5일</option>
											<option value="06">6일</option>
											<option value="07">7일</option>
											<option value="08">8일</option>
											<option value="09">9일</option>
											<option value="10">10일</option>
											<option value="11">11일</option>
											<option value="12">12일</option>
											<option value="13">13일</option>
											<option value="14">14일</option>
											<option value="15">15일</option>
											<option value="16">16일</option>
											<option value="17">17일</option>
											<option value="18">18일</option>
											<option value="19">19일</option>
											<option value="20">20일</option>
											<option value="21">21일</option>
											<option value="22">22일</option>
											<option value="23">23일</option>
											<option value="24">24일</option>
											<option value="25">25일</option>
											<option value="26">26일</option>
											<option value="27">27일</option>
											<option value="28">28일</option>
											<option value="29">29일</option>
											<option value="30">30일</option>
											<option value="31">31일</option>
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


								<div class="form-group row">
									<div class="col-sm-4">
										<input type="selectbo"
											class="form-control bg-light border-3 small" id="backNumber"
											placeholder="대전광역시(관심지역)" readonly>
									</div>
									<div class="col-sm-4 mb-3 mb-sm-0">
										<select class="form-control bg-light border-3 small"
											name="job">
											<option value="">관심지역(구)</option>
											<option value="동구">동구</option>
											<option value="중구">중구</option>
											<option value="서구">서구</option>
											<option value="대덕구">대덕구</option>
											<option value="유성구">유성구</option>
										</select>
									</div>

									<div class="col-sm-4">
										<select class="form-control bg-light border-3 small"
											name="job">
											<option value="">관심지역(동)</option>
											<option value="naver.com">원동</option>
											<option value="naver.com">인동</option>
											<option value="naver.com">효동</option>
											<option value="naver.com">천동</option>
											<option value="naver.com">가오동</option>
											<option value="naver.com">신흥동</option>
											<option value="naver.com">판암동</option>
											<option value="naver.com">삼정동</option>
											<option value="naver.com">용운동</option>
											<option value="naver.com">대동</option>
											<option value="naver.com">자양동</option>
											<option value="naver.com">신안동</option>
											<option value="naver.com">소제동</option>
											<option value="naver.com">가양동</option>
											<option value="naver.com">용전동</option>
											<option value="naver.com">성남동</option>
											<option value="naver.com">홍도동</option>
											<option value="naver.com">삼성동</option>
											<option value="naver.com">정동</option>
											<option value="naver.com">중동</option>
											<option value="naver.com">추동</option>
											<option value="naver.com">비룡동</option>
											<option value="naver.com">주산동</option>
											<option value="naver.com">용계동</option>
											<option value="naver.com">마산동</option>
											<option value="naver.com">효평동</option>
											<option value="naver.com">직동</option>
											<option value="naver.com">세천동</option>
											<option value="naver.com">신상동</option>
											<option value="naver.com">신하동</option>
											<option value="naver.com">신촌동</option>
											<option value="naver.com">사성동</option>
											<option value="naver.com">내탑동</option>
											<option value="naver.com">오동</option>
											<option value="naver.com">주촌동</option>
											<option value="naver.com">낭월동</option>
											<option value="naver.com">대별동</option>
											<option value="naver.com">이사동</option>
											<option value="naver.com">대성동</option>
											<option value="naver.com">장척동</option>
											<option value="naver.com">소호동</option>
											<option value="naver.com">구도동</option>
											<option value="naver.com">삼괴동</option>
											<option value="naver.com">상소동</option>
											<option value="naver.com">하소동</option>
											<option value="naver.com">중앙동</option>
											<option value="naver.com">신인동</option>
											<option value="naver.com">판암1동</option>
											<option value="naver.com">판암2동</option>
											<option value="naver.com">가양2동</option>
											<option value="naver.com">대청동</option>
											<option value="naver.com">산내동</option>
										</select>
									</div>

								</div>
								<div class="form-group row">
									<div class="col-sm-4">
										<select class="form-control bg-light border-3 small"
											name="job">
											<option value="">관심업종(대분류)</option>
											<option value="동구">서비스</option>
											<option value="중구">IT</option>
											<option value="서구">교육</option>
										</select>
									</div>
									<div class="col-sm-4 mb-3 mb-sm-0">
										<select class="form-control bg-light border-3 small"
											name="job">
											<option value="">관심업종(중분류)</option>
											<option value="동구">개발자</option>
											<option value="중구">프렌차이즈</option>
											<option value="서구">스타트업</option>
											<option value="대덕구">중견기업</option>
										</select>
									</div>

									<div class="col-sm-4">
										<select class="form-control bg-light border-3 small"
											name="job">
											<option value="">관심업종(소분류)</option>
											<option value="naver.com">치킨</option>
											<option value="naver.com">피자</option>
											<option value="naver.com">족발</option>
											<option value="naver.com">보쌈</option>
											<option value="naver.com">탕수육</option>
											<option value="naver.com">돈까스</option>
											<option value="naver.com">수육</option>
										</select>
									</div>

								</div>
								<hr>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<a onclick="document.getElementById('frm').submit();"
									class="btn btn-success btn-icon-split"> <span
									class="icon text-white-50"> <i class="fas fa-check"></i>
										<br>
								</span> &nbsp;&nbsp;&nbsp;회원가입&nbsp;&nbsp;&nbsp;
								</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
									href="login.jsp" class="btn btn-danger btn-icon-split">
									<span class="icon text-white-50"> <i
										class="fas fa-trash"></i>
								</span> <span class="text"> </span>취소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</a>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>


</body>

</html>
