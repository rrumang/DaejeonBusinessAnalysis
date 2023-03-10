<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	#base{
		width : 100%;
		height : auto;
		margin : 0 auto;
		color : black;
	}
	#subject{
		width : 1100px;
		height : auto;
		margin : 0 auto;
		text-align : left;	
	}
	#input{
		width : 1100px;
		height : auto;
		margin : 0 auto;
		text-align : left;
	}
	#subject1{
		width : 1100px;
		height : auto;
		margin : 0 auto;
	}
	h2{
		display: inline-block;
	}
	#dataTable{
		text-align: center;
		margin: 15px 0px 30px 0px;
	}
	th{
		background-color: #eaecf4;
	}
	td{
		background-color : white;
	}
	hr{
		clear: both;
		width : 1100px;
		border-width: 3px;
	}
	#lAppr:hover{
		cursor: pointer;
	}
	#tmenu1:hover{
		cursor: pointer;
	}
	#smenu{
		text-align: center;
		font-size: 1.2em;
		color: black;
		background-color: linen;
		font-weight: bold;
	}
	#tmenu2{
		height: 1.5em;
	}
	.rcol{
		background-color: linen;
		font-size: 1.2em;
		font-weight: bold;
		color: #f23065;
	}
	.label{
		width: 270px;
		height: 70px;
		color: black;
		font-weight: bold;
   		padding: 0px 0px 13px 0px;
	}
	progress {
		display:inline-block;
		width:300px;
		height:25px;
/*  		padding:15px 0 0 0; */
		border-radius: 15px;
		text-align: left;
		position:relative;
	}
	.progressbar1st::-webkit-progress-bar {
		height:25px;
		width:300px;
		margin:0 auto;
		background-color: #FFF5EE;
		border-radius: 15px;
		box-shadow:0px 0px 6px #777 inset;
	}
	.progressbar1st::-webkit-progress-value {
		display:inline-block;
		float:left;
		height:25px;
		margin:0px -10px 0 0;
		background: paleturquoise;
		border-radius: 15px;
		box-shadow:0px 0px 6px #777 inset;
	}
	.progressbar2nd::-webkit-progress-bar {
		height:25px;
		width:300px;
		margin:0 auto;
		background-color: #FFF5EE;
		border-radius: 15px;
		box-shadow:0px 0px 6px #777 inset;
	}
	.progressbar2nd::-webkit-progress-value {
		display:inline-block;
		float:left;
		height:25px;
		margin:0px -10px 0 0;
		background: thistle;
		border-radius: 15px;
		box-shadow:0px 0px 6px #777 inset;
	}
	.progressbar3rd::-webkit-progress-bar {
		height:25px;
		width:300px;
		margin:0 auto;
		background-color: #FFF5EE;
		border-radius: 15px;
		box-shadow:0px 0px 6px #777 inset;
	}
	.progressbar3rd::-webkit-progress-value {
		display:inline-block;
		float:left;
		height:25px;
		margin:0px -10px 0 0;
		background: mistyrose;
		border-radius: 15px;
		box-shadow:0px 0px 6px #777 inset;
	}
	.rightBox02 {
	  	float: right;
	}
	
	/* 상단 navigation바의 css 효과 지정  */
	a:hover{
		text-decoration: none;
	}
	.nav-tabs {
	  padding-left: 0;
	  margin-bottom: 0;
	  list-style: none;
	}
	.nav-tabs > li {
	  float: left;
	  position: relative;
	  display: block;
		text-align:center;
	}
	.nav-tabs > li > a {
		border-bottom: 1px solid #e3e3e6;
		font-size:13px;
		color:#777;
		position: relative;
		display: block;
		padding:8px 20px 10px 20px;
		letter-spacing:-1px;
		font-weight:400;
	}
	.nav-tabs > li > a .fa {
		font-weight:400;
		margin-right:5px;
	}
	.nav-tabs > li > a:hover {
	}
	.nav-tabs > li.active > a,
	.nav-tabs > li.active > a:hover,
	.nav-tabs > li.active > a:focus {
	  color: #66a3ff;
	  cursor: default;
		font-weight:700;
	  background-color: #fff;
		border-bottom: 1px solid #0088e8;
	}
	.nav-tabs.depth-1 {	
	  background-color: #66a3ff;
		padding:4px 4px 0 4px;
		overflow:auto;
	}
	.nav-tabs.depth-1 > li {
		border-bottom: 0px solid #fff;
	}
	.nav-tabs.depth-1 > li > a {
		border-bottom: 0px solid #fff;
		color: #fff;
		font-size:1.2rem;
		padding:8px 30px 8px 30px;
	}
	.nav-tabs.depth-1 > li.active > a,
	.nav-tabs.depth-1 > li.active > a:hover,
	.nav-tabs.depth-1 > li.active > a:focus {
	  color: #66a3ff;
	  background-color: #fff;
		border-bottom: 0px solid #fff;
	}
	.fnMove{
		cursor : pointer;
	}
	#table01 td{
		background : none;
	}
</style>

<script>
	$(document).ready(function(){
		
		/* progress bar 애니메이션 효과 */
		var i = 1;
		run = setInterval(function(){
			if(i==${resultList.size()+1}){
				clearInterval(run);
			} else {
				var limit = $("#mybar"+i).data("limit");
				
				var progressbar = $("#mybar"+i),
					max = progressbar.attr('max'),
					time = (1000/max)*5,	
			        value = progressbar.val();
		
			    var loading = function() {
			        value += 1;
			        addValue = progressbar.val(value);
			    
			        if (value == limit) {
			            clearInterval(animate);			           
			        }
			    };
		
			    var animate = setInterval(function() {
			        loading();
			    }, time);
				i++;
			}
		},20);
		
		var cd = ${region_cd};
		
		// 띄어쓰기 추가
		var gusung = $("#gsv").html();
		var gresult = gusung.replace("<br>", " ");
		$("#gsv").html(gresult);
		
		// 페이지 이동 (상권유형 판별)
		$("#tmenu1").on("click", function(){
			$("#region_cd").val(cd);
			$("#form13").submit();
		});
		
		// 페이지 이동 (종합입지평가)
		$("#lAppr").on("click", function(){
			$("#dongcd").val(cd);
			$("#form3").submit();
		});
		
		// 엑셀 다운로드
		$("#edn").on("click", function(){
			$("#excel").submit();
		})
		
	}); // document ready 끝
	
	function fnSaveAsPdf() {
        html2canvas(document.querySelector("#base")).then(function(canvas) {
        var imgData = canvas.toDataURL('image/png');
        var imgWidth = 210;
        var pageHeight = imgWidth * 1.414;
        var imgHeight = canvas.height * imgWidth / canvas.width;
        var heightLeft = imgHeight; 

        var doc = new jsPDF({
          'orientation': 'p',
          'unit': 'mm',
          'format': 'a4'
        });
        var position = 0;
        
        doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
        heightLeft -= pageHeight;
        
        while (heightLeft >= 20) {
            position = heightLeft - imgHeight;
            doc.addPage();
            doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
            heightLeft -= pageHeight;
        }
        
        doc.save('tobRecom 2-2page.pdf');
        console.log('Reached here?');
      });
    }
	
	// 스크롤 이동
	function fnMove(seq){
	    var offset = $("#result" + seq).offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	}
</script>

<div class="col-sm-10 col-sm-offset-3 col-md-10 col-md-offset-2 main" id="base">
	<div id="subject">
		<h2 class="figure font-weight-bold text-left">업종추천 보고서</h2>&nbsp;&nbsp;
		
		<div class="mt-3">
			<div class="row fulltab">
				<div class="col-12">
					<ul class="nav nav-tabs depth-1 fl" role="tablist">
						<li class=""><a href="#" id="lAppr">종합 입지평가</a></li>
						<li class="active"><a href="#" id="sTob">상권적합도 우수업종</a></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="my-3">
			<span onclick="fnMove('1')" class="fnMove">1. 상권유형 판별 결과</span>&nbsp;
			<span onclick="fnMove('2')" class="fnMove">2. 상권유형과 적합도 높은 업종</span>&nbsp;
				
			<div class="rightBox02">
				<a id="pdn" href="#" onclick="fnSaveAsPdf();" class="btn btn-primary btn-icon-split btn-sm">
		          <span class="text">PDF다운로드</span>
		        </a>
				
				<a id="edn" href="#" class="btn btn-primary btn-icon-split btn-sm">
		          <span class="text">EXCEL다운로드</span>
		        </a>
			</div>
		</div>
		
	</div>
	<hr>
	<br>
	
	<div id="input">
	<table class="table table-bordered dataTable" id="smenu">
		<tr>
			<td style="width: 50%; background-color:aliceblue; opacity: 0.8;" id="tmenu1">상권유형 판별</td>
			<td style="width: 50%; background-color:lightsteelblue;" id="tmenu2">상권유형에 따른 적합업종</td>
		</tr>
	</table>
	</div>
	
	<br>
	
	<div id="subject1">
	<h5 id="result1" class="font-weight-bold text-info text-left">1. 상권유형 판별 결과</h5>
	<table class="table table-bordered dataTable" id="dataTable">
		<thead>
			<tr role="row">
				<th>구분</th>
				<th>판별 결과</th>
				<th>설명</th>
			</tr>
		</thead>
		<tbody>
			<tr role="row">
				<td class="bg-gray-100">업종구성</td>
				<td class="rcol">${btype}</td>
				<td class="text-left">${btypeInfo}</td>
			</tr>
			<tr role="row">
				<td class="bg-gray-100">상권규모</td>
				<td class="rcol">${gyumoV}등급</td>
				<td class="text-left">상권 총매출액 기준 대전광역시 상위 <c:if test="${(gyumoV - 1) != 0}">
					${(gyumoV - 1)}</c:if>0 ~ ${gyumoV}0%</td>
			</tr>
			<tr role="row">
				<td class="bg-gray-100">주 고객층</td>
				<td class="rcol" id="gsv">${gusungV}</td>
				<td class="text-left">평균 고객구성비 대비 상권 내 고객비중이 높은 계층</td>
			</tr>
			<tr role="row">
				<td class="bg-gray-100">소비등급</td>
				<td class="rcol">${sobiV}등급</td>
				<td class="text-left">대전광역시 전체 소비수준 대비 상위 ${sobiV * 20 - 20}% ~ ${sobiV * 20}%</td>
			</tr>
		</tbody>
	</table>
	<br>
	
	<h5 id="result2" class="font-weight-bold text-info text-left">2. 상권유형과 적합도 높은 업종</h5>
	<table id="table01">
		<c:forEach begin="1" end="${resultList.size()}" var="i">
		<tr>
			<td class="label">${resultList.get(i-1).rank}. ${resultList.get(i-1).tob_name} (<fmt:formatNumber value="${resultList.get(i-1).point}" pattern="0"/>%)</td>
			<td>
				<div class="progress-bar-wrapper">
					<c:choose>
						<c:when test="${resultList.get(i-1).point >= 70}">
							<progress class="progressbar1st" id="mybar${i}" value="0" max="100" data-limit="<fmt:formatNumber value='${resultList.get(i-1).point}' pattern='0'/>"></progress>
						</c:when>
						<c:when test="${resultList.get(i-1).point >= 50}">
							<progress class="progressbar2nd" id="mybar${i}" value="0" max="100" data-limit="<fmt:formatNumber value='${resultList.get(i-1).point}' pattern='0'/>"></progress>
						</c:when>
						<c:otherwise>
							<progress class="progressbar3rd" id="mybar${i}" value="0" max="100" data-limit="<fmt:formatNumber value='${resultList.get(i-1).point}' pattern='0'/>"></progress>
						</c:otherwise>
					</c:choose>
				</div>
			</td>
		</tr>
		</c:forEach>
	</table>
	</div>
</div>
<form id="form3" action="${pageContext.request.contextPath}/tobRecom/result" method="get">
	<input type="hidden" id="dongcd" name="dongcd" />
	<input type="hidden" name="checkRe" value="y">
	<input type="hidden" id="report_cd" name="report_cd" value="${report_cd}">
</form>

<form id="form13" action="${pageContext.request.contextPath}/tobRecom/superbTob" method="post">
	<input type="hidden" id="region_cd" name="region_cd" />
	<input type="hidden" id="report_cd" name="report_cd" value="${report_cd}">
</form>

<form action="${pageContext.request.contextPath}/tobRecom/excel" id="excel" method="get">
	<input type="hidden" id="report_cd" name="report_cd" value="${report_cd}">
</form>
