<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<title>Insert title here</title>
</head>
<body>
<!-- 	naverLogin 후 callback 처리 할 페이지 -->
	<script>
		var naverLogin = new naver.LoginWithNaverId({
			clientId : 'qhNypmWqJyl2NftqWiT8',	
			callbackUrl : "https://nid.naver.com/nidlogin.logout",
			callbackHandle : true
		})
		
		naverLogin.init();
		
		
		// 로그인 한 사용자의 정보 조회 요청
		naverLogin.getLoginStatus(function (status) {
			// 로그인 성공 시
			if (status) {
// 				var name = naverLogin.user.getNickName(); // 로그인 한 회원의 이름값 조회
				var uniqId = naverLogin.user.getId();	  // 로그인 한 회원의 고유 Id값 조회(회원계정의 Id와는 다름)
				
				// 부모창 input 창에 값 넣기
				opener.inputNaver(uniqId);
				
				// 창닫기
				window.close();
				
			} else { // 로그인 실패 시
				console.log("callback 처리에 실패하였습니다.");
			}
		});
	</script>
	
	<!-- 로그아웃 요청 url -->
	<iframe src="https://nid.naver.com/nidlogin.logout" hidden="hidden"></iframe>
</body>
</html>