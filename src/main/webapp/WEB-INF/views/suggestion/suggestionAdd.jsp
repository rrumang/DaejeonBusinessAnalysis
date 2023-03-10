<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
</style>
<script>
	$(document).ready(function() {
		$("#sg_title").keyup(function(){
			var content = $(this).val();
			
			if(content.length > 50){
				swal({
				    text: "최대 50자까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#sg_title").val(content.substr(0,50));
			        $("#sg_title").focus();
				});
			};
		})
		
		$("#sg_content").keyup(function(){
			var content = $(this).val();
			
			if(content.length > 1000){
				swal({
				    text: "최대 1000자까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#sg_content").val(content.substr(0,1000));
			        $("#sg_content").focus();
				});
			};
		})
		
		
		
		var parent = "${sg_parent1.suggestion_cd}";
		
		if(parent != ""){
			$("#sg_parent").css("display","inline-block");
			$("#sg_parent2").val(parent);
		}
		
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
				    + '<input type="file" name="file" class="files" accept=".png, .gif, .jpg, .jpeg, .pdf, .hwp, .doc, .xls, .xlsx"/>'
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
				    + '<input type="file" name="file" class="files" accept=".png, .gif, .jpg, .jpeg"/>'
				 	+ '<a href="#" class="btn btn-danger btn-circle deleteBtn" style="margin-left:5px;">'
				 	+ '<i class="fas fa-trash"></i>'
				 	+ '</a></div>';
			
            	$("#div01").append(str);
    		}
    	});
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
				
				if($.inArray(ext, [".png", ".gif", ".jpg", ".jpeg"]) == -1){
					swal({
				     	text: "png, gif, jpg, jpeg 파일만 첨부 가능합니다.",
				     	icon: "warning",
					 });
					 $(this).val("");
					return;
				}
			}
		});
		
		
		
		
		$("#savebutton").on("click",function(){
			if ($("#sg_title").val().trim().length == 0) {
				swal({
				    text: "제목을 입력하세요",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#sg_title").focus();
			        $("#sg_title").val("");
				});
				return;
			}
			if ($("#sg_content").val().trim().length == 0) {
				swal({
				    text: "내용을 입력하세요",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#sg_content").focus();
			        $("#sg_content").val("");
				});
				return;
			}
			
			 // 제목과 내용에 특수기호 ', ", <, >, \n 이 포함되어있으면 변경
			  var title = $("#sg_title").val();
			  $("#sg_title").val(ConvertSystemSourcetoHtmlTitle(title));
			  
			  var content = $("#sg_content").val();
			  $("#sg_content").val(ConvertSystemSourcetoHtmlContent(content));
			
			
			$("#frm").submit();	
		});
	});
	
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
	
	function ConvertSystemSourcetoHtmlTitle(str){
		 str = str.replace(/</g,"&lt;");
		 str = str.replace(/>/g,"&gt;");
		 str = str.replace(/\"/g,"&quot;");
		 str = str.replace(/\'/g,"&#39;");
		 str = str.replace(/\n/g,"<br />");
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
</head>
<body>
	<div class="card card-body mb-4">
		<h1 class="h3 mb-2 text-gray-800">건의사항 - 등록</h1>
		<br>
		<form action="${pageContext.request.contextPath }/insertSuggestion" method="post" id="frm" enctype="multipart/form-data">
			<div id="head">
				<input style="display:none;" type="text" id="sg_parent" value="${sg_parent1.sg_title}" name="sg_parent" placeholder="제목을 입력하세요" class="form-control form-control-user" disabled><br><br>
				<input  type="hidden" id="sg_parent2" name="sg_parent2" placeholder="제목을 입력하세요" class="form-control form-control-user" disabled>
				<input type="text" id="sg_title" name="sg_title" placeholder="제목을 입력하세요" class="form-control form-control-user" />
			</div>
			<br>
			<div id="contents">
				<textarea name="sg_content" id="sg_content" placeholder="내용을 입력하세요" class="form-control form-control-user"
					rows="20" cols="150"></textarea>
			</div>
			<br>
			<select class="form-control bg-light border-3 small"
				id="sg_secret_yn" name="sg_secret_yn">
				<option value="1" >공개글</option>
				<option value="0" >비밀글</option>
			</select>
			<br>
			
			<h5 id="h501" class="font-weight-bold text-primary">첨부파일</h5>
				<div class="text-right">
					<a href="#" id="addBtn" class="btn btn-primary ">첨부하기</a>
				</div>
				<hr>
				
				<div id="div01">
					<div class="fileDiv" class="col-sm-11">
						<input type="file" name="file" class="files" accept=".png, .gif, .jpg, .jpeg"/>
						<a href="#" class="btn btn-danger btn-circle deleteBtn">
	                    	<i class="fas fa-trash"></i>
	                  	</a>
					</div>
				</div>
				<hr>
			<div class="text-right">
			<button type="button" id="savebutton" class="btn btn-success btn-icon-split">
				<span class="icon text-white-50"><i class="fas fa-check"></i></span>
				<span class="text">등록</span>
			</button>
			<a href="${pageContext.request.contextPath }/suggestion" class="btn btn-danger btn-icon-split">
				<span class="icon text-white-50"><i class="fas fa-check"></i></span>
				<span class="text">취소</span>
			</a>
			</div>
		</form>

	</div>


</body>
</html>