<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#div03{
	padding : 24px;
}
textarea{
	margin-top : 10px;
}
#h501{
	float: left;
}
.fileDiv{
	margin : 10px;
}
.files{
	width : 60%;
}
</style>
<script>
	$(document).ready(function(){
		// 엔터키 submit 안되게 막기
		$("input").keydown(function() {
			if (event.keyCode === 13) {
			 	 event.preventDefault();
			};
		});

		// 제목은 50자까지만 입력할 수 있음
		$("#notice_title").keyup(function(){
			var title = $(this).val();
			
			if(title.length > 50){
				swal({
				    text: "최대 50자까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#notice_title").val(title.substr(0,50));
			        $("#notice_title").focus();
				});
			};
		})
		
		// 내용은 1000자까지만 입력할 수 있음
		$("#notice_content").keyup(function(){
			var content = $(this).val();
			
			if(content.length > 1000){
				swal({
				    text: "최대 1000자까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#notice_content").val(content.substr(0,1000));
			        $("#notice_content").focus();
				});
			};
		})
		
		// 등록 버튼 클릭했을 때
		$("#insertBtn").on("click", function(e){
			e.preventDefault();
		
			swal({
				  text: "게시글을 등록하시겠습니까?",
				  buttons: true,
			})
			.then((value) => {
			  if (value) {
			  	
				  // 입력 검증
				  if($("#notice_title").val().trim() == ""){
					  swal({
					      text: "제목을 입력해주십시오",
					      closeModal: false,
					      icon: "warning",
					  }).then(function() {
				          swal.close();
				          $("#notice_title").val("");
				          $("#notice_title").focus();
					  });
					  return;
				  }
				  
				  if($("#notice_content").val().trim() == ""){
					  swal({
					      text: "내용을 입력해주십시오",
					      closeModal: false,
					      icon: "warning",
					  }).then(function() {
				          swal.close();
				          $("#notice_content").val("");
				          $("#notice_content").focus();
					  });
					  return;
				  }
				  
				  // 제목과 내용에 특수기호 ', ", <, >, \n 이 포함되어있으면 변경
				  var title = $("#notice_title").val();
				  $("#notice_title").val(ConvertSystemSourcetoHtmlTitle(title));
				  
				  var content = $("#notice_content").val();
				  $("#notice_content").val(ConvertSystemSourcetoHtmlContent(content));
				  
				  $("#form01").submit();
				  
			  } else {
			    swal.close();
			  }
			});
		});
		
		// 취소버튼을 클릭했을 때
		$("#cancelBtn").on("click", function(e){
			e.preventDefault();
		
			swal({
				  text: "게시글 등록을 취소하시겠습니까?",
				  buttons: true,
				})
				.then((value) => {
				  if (value) {
				   	window.location.replace("${pageContext.request.contextPath}/notice/noticeList");
				  } else {
				    swal.close();
				  }
				});
		});
		
		// 첨부하기 버튼을 클릭했을 때
		$("#addBtn").on("click", function(e){
			e.preventDefault();
			
			if($(".files").length == 3){
				 swal({
			      text: "첨부파일은 3개까지만 추가할 수 있습니다.",
			      icon: "warning",
				 });
				return;
			}
			
			var str = '<div class="fileDiv" class="col-sm-11">'
				    + '<input type="file" name="file" class="files" accept=".png, .gif, .jpg, .jpeg, .pdf, .hwp, .doc, .xls, .xlsx, .csv, .zip"/>'
				 	+ '<a href="#" class="btn btn-danger btn-circle deleteBtn" style="margin-left:5px;">'
				 	+ '<i class="fas fa-trash"></i>'
				 	+ '</a></div>';
			
            $("#div01").append(str);
		});
		
		// 첨부파일 삭제버튼 클릭했을 때
		$(document).delegate(".deleteBtn", "click", function(e){
    		e.preventDefault();
    		
    		$(this).parent("div").remove();
    		
    		if($(".files").length == 0){
    			var str = '<div class="fileDiv" class="col-sm-11">'
				    + '<input type="file" name="file" class="files" accept=".png, .gif, .jpg, .jpeg, .pdf, .hwp, .doc, .xls, .xlsx, .csv, .zip"/>'
				 	+ '<a href="#" class="btn btn-danger btn-circle deleteBtn" style="margin-left:5px;">'
				 	+ '<i class="fas fa-trash"></i>'
				 	+ '</a></div>';
			
            	$("#div01").append(str);
    		}
    	});
		
		// 파일 첨부 시 용량 및 확장자 체크
		$(".files").on("change", function(){
			// 파일을 선택하면
			if($(this).val() != ""){
				// 용량 체크(한 파일 당 3메가까지만 가능)
				var maxSize = 1024 * 1024 * 3;
				var fileSize = this.files[0].size;
				
				if(fileSize > maxSize){
					 swal({
				     	text: "파일 용량은 3MB까지만 첨부할 수 있습니다.",
				     	icon: "warning",
					 });
					 $(this).val("");
					return;
				}
				
				// 확장자 체크
				var idx = $(this).val().lastIndexOf(".");
				var ext = $(this).val().substr(idx).toLowerCase();
				
				if($.inArray(ext, [".png", ".gif", ".jpg", ".jpeg", ".pdf", ".hwp", 
					".doc", ".xls", ".xlsx", ".csv", ".zip"]) == -1){
					swal({
				     	text: "png, gif, jpg, jpeg, pdf, hwp, doc, xls, xlsx, csv, zip 파일만 첨부 가능합니다.",
				     	icon: "warning",
					 });
					 $(this).val("");
					return;
				}
			}
		});
	});
	
	function ConvertSystemSourcetoHtmlTitle(str){
		 str = str.replace(/</g,"&lt;");
		 str = str.replace(/>/g,"&gt;");
		 str = str.replace(/\"/g,"&quot;");
		 str = str.replace(/\'/g,"&#39;");
		 str = str.replace(/\n/g,"<br/>");
		 return str;
	}
	
	function ConvertSystemSourcetoHtmlContent(str){
		 str = str.replace(/</g,"&lt;");
		 str = str.replace(/>/g,"&gt;");
		 str = str.replace(/\"/g,"&quot;");
		 str = str.replace(/\'/g,"&#39;");
		 return str;
	}
</script>

<!-- Begin Page Content -->
<div id="div03" class="container-fluid">

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h3 class="m-0 font-weight-bold text-primary">공지사항</h3>
		</div>
		
		<div class="card-body">
			<form id="form01" action="${pageContext.request.contextPath}/notice/noticeAdd" method="post" enctype="multipart/form-data">
				<input type="text" class="form-control" name="notice_title" id="notice_title" placeholder="제목을 입력해주십시오."/>
				<textarea class="form-control" rows="15" name="notice_content" id="notice_content" placeholder="내용을 입력해주십시오."></textarea>
				
				<br>
				<h5 id="h501" class="font-weight-bold text-primary">첨부파일</h5>
				<div class="text-right">
					<a href="#" id="addBtn" class="btn btn-primary ">첨부하기</a>
				</div>
				<hr>
				
				<div id="div01">
					<div class="fileDiv" class="col-sm-11">
						<input type="file" name="file" class="files" accept=".png, .gif, .jpg, .jpeg, .pdf, .hwp, .doc, .xls, .xlsx, .csv, .zip"/>
						<a href="#" class="btn btn-danger btn-circle deleteBtn">
	                    	<i class="fas fa-trash"></i>
	                  	</a>
					</div>
				</div>
			</form>
			
			<div class="text-right">
				<a href="#" id="insertBtn" class="btn btn-primary ">등록</a>
				<a href="#" id="cancelBtn" class="btn btn-secondary ">취소</a>
			</div>
		</div>
		
	</div>
</div>