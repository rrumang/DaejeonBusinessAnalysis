<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html>
<html lang="kr">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>WELCOME TO POJO</title>

<%@include file="/WEB-INF/views/common/basicLib.jsp"%>

</head>

<script type="text/javascript">

    /* NOTE : Use web server to view HTML files as real-time update will not work if you directly open the HTML file in the browser. */
    (function(d, m){
		var userId = "${MEMBER_INFO.member_id}";
		
		if(userId == ""){
			userId = null;
		}
      
		var kommunicateSettings = 
      		{
    		  "appId":"16db3b439f8c5644e9530caaa2520ecdd"
    		, "sessionTimeout": 0
    		, "popupWidget":true
    		, "automaticChatOpenOnNavigation":true
    		, "attachment":false
    		, "userId":userId
    		, "onInit": function() {
    			var iframeStyle = document.createElement('style');
    			var classSettings = ".kommunicate-custom-iframe{bottom:65px;right:0px;}";
            	classSettings += ".change-kommunicate-iframe-height{height:800px;width:600px;margin-bottom:10px;max-height: 100%!important;}";

            	iframeStyle.type = 'text/css';
            	iframeStyle.innerHTML = classSettings;
            	
            	document.getElementsByTagName('head')[0].appendChild(iframeStyle);
            	var launcherIconStyle = "@media(min-width: 600px){.mck-sidebox.fade.in,.mck-box .mck-box-sm{width:100%; height:100%;max-height:100%!important;border-radius:0px!important;}.mck-sidebox{right:0!important;bottom:0!important;}}";
            	Kommunicate.customizeWidgetCss(launcherIconStyle);

            	KommunicateGlobal.document.getElementById('mck-sidebox-launcher').addEventListener('click',function(){
                	var iframeClick = parent.document.getElementById("kommunicate-widget-iframe");
                	iframeClick.classList.add("change-kommunicate-iframe-height");
            	});

            	KommunicateGlobal.document.getElementById('km-chat-widget-close-button').addEventListener('click',function(){
                	var closeButtonClick = parent.document.getElementById("kommunicate-widget-iframe");
                	closeButtonClick.classList.remove("change-kommunicate-iframe-height");
            	});
    		}};
      
		var s = document.createElement("script"); 
		s.type = "text/javascript"; 
		s.async = true;
		s.src = "https://widget.kommunicate.io/v2/kommunicate.app";
		
		var h = document.getElementsByTagName("head")[0]; 
		h.appendChild(s);
		
		window.kommunicate = m; 
		m._globals = kommunicateSettings;
    })(document, window.kommunicate || {});
    
</script>

<body id="page-top">

	<!-- Page Wrapper -->

	<div id="wrapper">

		<!-- 레프트 -->
		<tiles:insertAttribute name="left" />
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- 헤더 -->
				<tiles:insertAttribute name="header" />
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<tiles:insertAttribute name="body" />
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; POJO 2019</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<div class="container-fluid"></div>
</body>

</html>
