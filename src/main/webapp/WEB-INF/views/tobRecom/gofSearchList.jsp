<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Custom styles for this page -->
<link href="${pageContext.request.contextPath}/ex_img/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<style>
	#tob_name {
		width : 25%;
		display: inline-block;
	}
	#div02{
		margin-bottom : 10px;
	}
	#searchBtn{
		margin-top : -2px;
	}
	#popup{
		border : 1px solid black;
		position: absolute;
		z-index: 10;
		width: 700px;
		height : auto;
		background-color: #ffffff;
		border-radius : 5px;
	}
	#popupInput{
		border : 1px solid black;
		position: absolute;
		z-index: 10;
		width: 700px;
		height : auto;
		background-color: #ffffff;
		border-radius : 5px;
	}
	th{
		vertical-align: middle !important;
	}
	.control-label{
		margin: .2rem 0;
	}
	.card-body{
		text-align: center;
	}
	h3{
		margin: 1em 0;
	}
	.w-73{
		width: 73% !important;
	}
	.gofTr:hover{
		cursor: pointer;
	}
</style>

<script>
	$(document).ready(function(){
		// 검색키워드가 있을 때 input에 유지
		var query = "${tob_name}";
		if(query != ""){
			$("#tob_name").val(query);
		}
		
		// tr을 더블클릭했을 때
		$(".gofTr").on("click", function(){
			var rec = $(this).text().split('\n');
			for(var i = 1 ; i < rec.length ; i++ ){
				rec[i] = rec[i].trim(); // tr의 내용을 읽어
			}
			
			$("#code").val(rec[1]);
			$("#codeName").val(rec[2]); // 팝업창에 출력한다
			
			for (var i = 1; i < 6; i++) {
				$("#bdtrank"+i).val(rec[i+2]);
				$("#gnarank"+i).val(rec[i+7]);
			}
			
			$("#popup").attr("style", "top: 0px; left:200px; display:block;");
		})
		
		// 팝업창 숨기기
		$("#hidePopup").on("click", function(){
			$("#popup").attr("style", "top: 0px; left:200px; display:none;");
		})
		$("#hidePopup2").on("click", function(){
			$("#popupInput").attr("style", "top: 0px; left:200px; display:none;");
		})
		
		// 추가버튼 클릭
		$("#insertBtn").on("click", function(e){
			e.preventDefault();
			
			var bdtarray = [];
			var gnaarray = [];
			for(var i = 1 ; i < 6 ; i++){
				bdtarray.push($("#inbdtrank"+i).val());
				gnaarray.push($("#ingnarank"+i).val());
			}
			
			for(var i = 1 ; i < bdtarray.length ; i++){
				for(var j = 0 ; j < i ; j++){
					tmp1 = bdtarray[i];
					tmp2 = bdtarray[j];
					
					if(tmp1 == tmp2){
						swal({
							text: "중복된 상권유형이 있습니다",
							closeModal: false,
						    icon: "warning"
						});
						return;
					}
				}
			}
			
			for(var i = 1 ; i < gnaarray.length ; i++){
				for(var j = 0 ; j < i ; j++){
					tmp1 = gnaarray[i];
					tmp2 = gnaarray[j];
					
					if(tmp1 == tmp2){
						swal({
							text: "중복된 선호성별/연령이 있습니다",
							closeModal: false,
						    icon: "warning"
						});
						return;
					}
				}
			}
			
			$("#form03").submit();
		});
		
		// 수정버튼 클릭
		$("#modifyBtn").on("click", function(e){
			e.preventDefault();
			
			// 종류별 selectbox 현재값을 가져와 비교하고, 중복값이 있다면 저장되지 않게 한다
			var bdtarray = [];
			var gnaarray = [];
			for(var i = 1 ; i < 6 ; i++){
				bdtarray.push($("#bdtrank"+i).val());
				gnaarray.push($("#gnarank"+i).val());
			}
			
			for(var i = 1 ; i < bdtarray.length ; i++){
				for(var j = 0 ; j < i ; j++){
					tmp1 = bdtarray[i];
					tmp2 = bdtarray[j];
					
					if(tmp1 == tmp2){
						swal({
							text: "중복된 상권유형이 있습니다",
							closeModal: false,
						    icon: "warning"
						});
						return;
					}
				}
			}
			
			for(var i = 1 ; i < gnaarray.length ; i++){
				for(var j = 0 ; j < i ; j++){
					tmp1 = gnaarray[i];
					tmp2 = gnaarray[j];
					
					if(tmp1 == tmp2){
						swal({
							text: "중복된 선호성별/연령이 있습니다",
							closeModal: false,
						    icon: "warning"
						});
						return;
					}
				}
			}
			
			$("#form01").submit();
		})
		
		// tr 마우스오버 이벤트(배경색 변경)
		$(".gofTr").mouseover(function(){
		    $(this).css("background-color", "#cbdce7");
		  });
	    
		$(".gofTr").mouseout(function(){
	        $(this).css("background-color", "#ffffff");
	    });
		
		// 검색버튼을 클릭했을 때
		$("#searchBtn").on("click", function(e){
			e.preventDefault();
			
			var query2 = $("#tob_name").val().trim();
			
			// 입력된 값이 없으면 첫 화면으로 이동
			if(query2 == ""){
				$("#tob_name").val("");
				window.location.href="${pageContext.request.contextPath}/tobRecom/gofList";
			} else {
				$("#tob_name").val(query2);
				$("#form02").submit();
			}
		})
		
		// 추가버튼 클릭(분석기준 추가 가능여부 처리)
		$("#insertGof").on("click", function(){
			var iGof = "${forInsertTob}";
			console.log(iGof);
			console.log(iGof.length);
			if(iGof.length < 3){
				swal({
					text: "분석기준을 추가할 분류가 없습니다"
				})
				return;
			}
			
			// 분석기준 추가화면 출력
			$("#popupInput").attr("style", "top: 0px; left:200px; display:block;");
		})
		
	}); // document ready 끝
</script>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">분석기준관리</h6>
		</div>
		<div class="card-body">
			<div id="div02" class="text-right">
				<form id="form02" action="${pageContext.request.contextPath}/tobRecom/gofList" method="get">
					<input type="text" class="form-control" name="tob_name" id="tob_name" placeholder="업종명을 입력해주십시오."/>
					<a href="#" id="searchBtn" class="btn btn-primary ">검색</a>
				</form>
			</div>
		
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
					<thead>
						<tr class="text-center bg-gray-200">
							<th rowspan="2">업종분류코드</th>
							<th rowspan="2">업종분류명</th>
							<th colspan="5">선호상권유형</th>
							<th colspan="5">선호성별/연령</th>
						</tr>
						<tr class="text-center bg-gray-200">
							<th>1순위</th>
							<th>2순위</th>
							<th>3순위</th>
							<th>4순위</th>
							<th>5순위</th>
							<th>1순위</th>
							<th>2순위</th>
							<th>3순위</th>
							<th>4순위</th>
							<th>5순위</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${gofList}" var="gofListVo">
							<tr class="gofTr" data-cd="${gofListVo.code}">
								<td>${gofListVo.code}</td>
								<td style="width: 20%">${gofListVo.codeName}</td>
								<td>${gofListVo.bdtrank1}</td>
								<td>${gofListVo.bdtrank2}</td>
								<td>${gofListVo.bdtrank3}</td>
								<td>${gofListVo.bdtrank4}</td>
								<td>${gofListVo.bdtrank5}</td>
								<td>${gofListVo.gnarank1}</td>
								<td>${gofListVo.gnarank2}</td>
								<td>${gofListVo.gnarank3}</td>
								<td>${gofListVo.gnarank4}</td>
								<td>${gofListVo.gnarank5}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<div id="div01" class="text-right">
				<a href="#" id="insertGof" class="btn btn-primary">추가</a>
				
				<!-- 삭제는 업종분류 삭제시 '업종적합도 분석기준도 함께 삭제됩니다' 식으로 안내하고 함께 삭제되도록 처리한다 -->
				<a href="#" id="deleteGof" class="btn btn-primary" style="display:none;">삭제</a>
			</div>

			<div class="text-center">
				<ul class="pagination">

					<c:choose>
						<c:when test="${pageVo.page eq 1}">
							<li class="paginate_button page-item previous disabled">
								<span>&lt;&lt;</span>
								<span>&lt;</span>
							</li>
						</c:when>

						<c:otherwise>
							<li class="paginate_button page-item previous">
								<a href="${pageContext.request.contextPath}/tobRecom/gofList?page=1&pageSize=${pageVo.pageSize}&tob_name=${tob_name}">&lt;&lt;</a>
								<a href="${pageContext.request.contextPath}/tobRecom/gofList?page=${pageVo.page-1}&pageSize=${pageVo.pageSize}&tob_name=${tob_name}">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>

					<c:forEach var="i" begin="1" end="${paginationSize}" step="1">
						<c:choose>
							<c:when test="${pageVo.page eq i}">
								<li class="paginate_button page-item active">
									<span>${i}</span>
								</li>
							</c:when>

							<c:otherwise>
								<li class="paginate_button page-item">
									<a href="${pageContext.request.contextPath}/tobRecom/gofList?page=${i}&pageSize=${pageVo.pageSize}&tob_name=${tob_name}">${i}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<c:choose>
						<c:when test="${pageVo.page eq paginationSize}">
							<li class="paginate_button page-item next disabled">
								<span>&gt;</span>
								<span>&gt;&gt;</span>
							</li>
						</c:when>

						<c:otherwise>
							<li class="paginate_button page-item next">
								<a href="${pageContext.request.contextPath}/tobRecom/gofList?page=${pageVo.page+1}&pageSize=${pageVo.pageSize}&tob_name=${tob_name}">&gt;</a>
								<a href="${pageContext.request.contextPath}/tobRecom/gofList?page=${paginationSize}&pageSize=${pageVo.pageSize}&tob_name=${tob_name}">&gt;&gt;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			
			<!-- 분석기준관리(수정) popup창 -->
			<div id="popup" style="display:none;">
				<h3 class="text-dark text-center">분석기준&nbsp;수정</h3>
					<form id="form01" action="${pageContext.request.contextPath}/tobRecom/updateGof" method="post">
						<div class="form-inline row" style="margin: auto;">
							<div class="form-group col-sm-5" style="margin: auto;">
								<label class="control-label">업종분류코드</label><input type="text" class="form-control" name="code" id="code" readonly/>
								<c:forEach begin="1" end="5" var="i">
									<label class="control-label">선호상권유형 ${i}순위</label>
									<select class="custom-select w-73 nav-item dropdown show" id="bdtrank${i}" name="bdtrank${i}">
										<option class="dropdown-item">일반형</option>
										<option class="dropdown-item">음식형</option>
										<option class="dropdown-item">복합형</option>
										<option class="dropdown-item">유통형</option>
										<option class="dropdown-item">교육형</option>
									</select>
								</c:forEach>
							</div>
							<div class="form-group col-sm-5" style="margin: auto;">
								<label class="control-label">업종분류명</label><input type="text" class="form-control" name="codeName" id="codeName" readonly/>
								<c:forEach begin="1" end="5" var="i">
									<label class="control-label">선호성별/연령 ${i}순위</label>
									<select class="custom-select w-73 nav-item dropdown show" id="gnarank${i}" name="gnarank${i}">
										<option class="dropdown-item">20대 남성</option>
										<option class="dropdown-item">20대 여성</option>
										<option class="dropdown-item">30대 남성</option>
										<option class="dropdown-item">30대 여성</option>
										<option class="dropdown-item">40대 남성</option>
										<option class="dropdown-item">40대 여성</option>
										<option class="dropdown-item">50대 남성</option>
										<option class="dropdown-item">50대 여성</option>
										<option class="dropdown-item">60대 남성</option>
										<option class="dropdown-item">60대 여성</option>
									</select>
								</c:forEach>
							</div>
						</div>
					</form>
			
				<div class="card-body mt-0">
					<a href="#" id="modifyBtn" class="btn btn-primary my-2 ml-38">
						<span class="text">수정</span>
					</a>
					<a href="#" id="hidePopup" class="btn btn-secondary mx-3 my-2">
						<span class="text">취소</span>
					</a>
				</div>
			</div>
			<!-- 분석기준관리 popup창 끝 -->
			
			<!-- 분석기준추가 popup창 -->
			<div id="popupInput" style="display:none;">
				<h3 class="text-dark text-center">분석기준&nbsp;추가</h3>
					<form id="form03" action="${pageContext.request.contextPath}/tobRecom/insertGof" method="post">
						<div class="form-inline row" style="margin: auto;">
							<div class="form-group col-sm-5" style="margin: auto;">
								<!-- 추가 가능한 업종분류를 읽어 select에 출력한다 -->
								<label class="control-label">업종분류명</label>
									<select class="custom-select w-73 nav-item dropdown show" id="tobName" name="code">
										<c:forEach items="${forInsertTob}" var="tobs">
											<option class="dropdown-item" value="${tobs.tob_cd}">${tobs.tob_name}</option>
										</c:forEach>
									</select>
								<c:forEach begin="1" end="5" var="i">
									<label class="control-label">선호상권유형 ${i}순위</label>
									<select class="custom-select w-73 nav-item dropdown show" id="inbdtrank${i}" name="bdtrank${i}">
										<option class="dropdown-item">일반형</option>
										<option class="dropdown-item">음식형</option>
										<option class="dropdown-item">복합형</option>
										<option class="dropdown-item">유통형</option>
										<option class="dropdown-item">교육형</option>
									</select>
								</c:forEach>
							</div>
							<div class="form-group col-sm-5" style="margin: auto; padding: 4.1em 0 0 0">
								<c:forEach begin="1" end="5" var="i">
									<label class="control-label">선호성별/연령 ${i}순위</label>
									<select class="custom-select w-73 nav-item dropdown show" id="ingnarank${i}" name="gnarank${i}">
										<option class="dropdown-item">20대 남성</option>
										<option class="dropdown-item">20대 여성</option>
										<option class="dropdown-item">30대 남성</option>
										<option class="dropdown-item">30대 여성</option>
										<option class="dropdown-item">40대 남성</option>
										<option class="dropdown-item">40대 여성</option>
										<option class="dropdown-item">50대 남성</option>
										<option class="dropdown-item">50대 여성</option>
										<option class="dropdown-item">60대 남성</option>
										<option class="dropdown-item">60대 여성</option>
									</select>
								</c:forEach>
							</div>
						</div>
					</form>
			
				<div class="card-body mt-0">
					<a href="#" id="insertBtn" class="btn btn-primary my-2 ml-38">
						<span class="text">추가</span>
					</a>
					<a href="#" id="hidePopup2" class="btn btn-secondary mx-3 my-2">
						<span class="text">취소</span>
					</a>
				</div>
			</div>
			<!-- popup창 끝 -->
		</div>
	</div>
</div>
