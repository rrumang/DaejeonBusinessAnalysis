<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	$(document).ready(function(){
		// 모든 input 값에 0을 반복적으로 입력하지 못하게 방지
		$("#frm input").keyup(function(){
			var value = $(this).val();
			if(value.length >= 1){
				var first = value.charAt(0);
				var second = value.charAt(1);
				
				// 첫번째 문자와 두번째 문자 모두 0인 경우 0 하나만 찍히도록 수정
				if(first == "0" && second == "0"){
					this.value = "0";
					return;
				}
			}
		});
		
		// 숫자만 입력 가능 및 최대 값 설정
		$("#frm input[type=text]:not(#ep_roi,#ep_unit_cost)").keyup(function(){
			this.value = this.value.replace(/[^0-9]/g,'');
			
			var id = "#" + $(this).attr("id");
			
			if($(this).val().length > 5){
				swal({
				    text: "최대 99,999만원까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $(id).val("");
			        $(id).focus();
				});
			};
		})
		
		// 숫자만 입력 가능 및 최대 값 설정
		$("#ep_unit_cost").keyup(function(){
			this.value = this.value.replace(/[^0-9]/g,'');
			
			if($(this).val().length > 6){
				swal({
				    text: "최대 999,999원까지 입력할 수 있습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#ep_unit_cost").val("");
			        $("#ep_unit_cost").focus();
				});
			};
		})
		
		// 숫자 및 소수점 둘쨋자리까지만 입력하도록 설정
		$("#ep_roi").keyup(function(){
			this.value=this.value.replace(/[^\.0-9]/g,'');
			
			var value = $(this).val();
			
			// "."이 포함되어있으면 --> 마지막에 입력한 "." 앞까지 자르기
			var idx = value.indexOf(".");
			var len = value.length;
			
			if( (idx == 0 && len > 1 ) ||( idx == 1 && len > 2 ) || (idx == 2 && len > 3 )){
				var last = value.charAt(len-1);
				
				if(last == "."){
					value = value.substring(0, len-1);
					$(this).val(value);
					
				} else if( (idx == 1 && len == 5) || (idx == 2 && len == 6) ){
					swal({
					    text: "소숫점 둘쨋자리까지 입력 가능합니다.",
					    closeModal: false,
					    icon: "warning",
					}).then(function() {
				        swal.close();
				        value = value.substring(0, len-1);
						$("#ep_roi").val(value);
				        $("#ep_roi").focus();
					});
				}
			}
		})
		
		// 이자율 값이 변경될 때 이벤트
		$("#ep_roi").on("propertychange change keyup paste input", function() {
			var roi = $(this).val();
			roi = Number(roi);
			
			if(roi > 24){
				swal({
				    text: "법정이자율(24%)을 초과할 수 없습니다.",
				    closeModal: false,
				    icon: "warning",
				}).then(function() {
			        swal.close();
			        $("#ep_roi").val("");
			        $("#ep_roi").focus();
				});
			}
		});
		
		// 이자율 입력란에서 벗어났을 때
		$("#ep_roi").focusout(function(){
			var roi = Number($(this).val());
			
			if(roi == 0){
				$(this).val("");
				return;
			}
		});
		
		// 권리금 값이 변경될 때
		$("#ep_premium").on("keyup", function(){
			$("#iv_total").val("");
			$("#de_total").val("");
			
			var premium = checkValue("#ep_premium");
			var deposit = checkValue("#ep_deposit");
			var iaf = checkValue("#ep_iaf");
			var investment = checkValue("#ep_investment");
			
			$("#iv_total").val(premium + deposit + iaf + investment);
			$("#de_total").val(premium + iaf + investment);
		});
		
		// 보증금 값이 변경될 때
		$("#ep_deposit").on("keyup", function(){
			$("#iv_total").val("");
			
			var premium = checkValue("#ep_premium");
			var deposit = checkValue("#ep_deposit");
			var iaf = checkValue("#ep_iaf");
			var investment = checkValue("#ep_investment");
			
			$("#iv_total").val(premium + deposit + iaf + investment);
		});
		
		// 인테리어 및 설비비 값이 변경될 때
		$("#ep_iaf").on("keyup", function(){
			$("#iv_total").val("");
			$("#de_total").val("");
			
			var premium = checkValue("#ep_premium");
			var deposit = checkValue("#ep_deposit");
			var iaf = checkValue("#ep_iaf");
			var investment = checkValue("#ep_investment");
			
			$("#iv_total").val(premium + deposit + iaf + investment);
			$("#de_total").val(premium + iaf + investment);
		});
		
		// 기타 투자비 값이 변경될 때
		$("#ep_investment").on("keyup", function(){
			$("#iv_total").val("");
			$("#de_total").val("");
			
			var premium = checkValue("#ep_premium");
			var deposit = checkValue("#ep_deposit");
			var iaf = checkValue("#ep_iaf");
			var investment = checkValue("#ep_investment");
			
			$("#iv_total").val(premium + deposit + iaf + investment);
			$("#de_total").val(premium + iaf + investment);
		});
		
		// 월세 값이 변경될 때
		$("#ep_monthly").on("keyup", function(){
			$("#cp_total").val("");
			
			var monthly = checkValue("#ep_monthly");
			var personnel = checkValue("#ep_personnel");
			var material = checkValue("#ep_material");
			var etc = checkValue("#ep_etc");
			
			$("#cp_total").val(monthly + personnel + material + etc);
		});
		
		// 인건비 값이 변경될 때
		$("#ep_personnel").on("keyup", function(){
			$("#cp_total").val("");
			
			var monthly = checkValue("#ep_monthly");
			var personnel = checkValue("#ep_personnel");
			var material = checkValue("#ep_material");
			var etc = checkValue("#ep_etc");
			
			$("#cp_total").val(monthly + personnel + material + etc);
		});
		
		// 재료비 값이 변경될 때
		$("#ep_material").on("keyup", function(){
			$("#cp_total").val("");
			
			var monthly = checkValue("#ep_monthly");
			var personnel = checkValue("#ep_personnel");
			var material = checkValue("#ep_material");
			var etc = checkValue("#ep_etc");
			
			$("#cp_total").val(monthly + personnel + material + etc);
		});
		
		// 기타운영비 값이 변경될 때
		$("#ep_etc").on("keyup", function(){
			$("#cp_total").val("");
			
			var monthly = checkValue("#ep_monthly");
			var personnel = checkValue("#ep_personnel");
			var material = checkValue("#ep_material");
			var etc = checkValue("#ep_etc");
			
			$("#cp_total").val(monthly + personnel + material + etc);
		});
		
	})
	
	// value 값이 있으면 value 값을,
	// value 값이 없으면 placeholder 값을 반환
	function checkValue(id){
		var result = "";
		
		if($(id).val() == ""){
			result = Number($(id).attr("placeholder"));
		} else {
			result = Number($(id).val());
		}
		
		return result;
	}
</script>

<style>
#dataTable td {
	color: black;
}

#dataTable td:nth-child(odd) {
	width : 11%;
	text-align: center;
	vertical-align: middle;
}

#dataTable td:nth-child(even) {
	width : 14%;
}

#frm input[type=text] {
	width: 65px;
	height: 24px; 
	margin-right: 5px;
	display: inline-block;
	text-align: right;
}

.sup1, .sp1 {
	color: #e74a3b;
}

#ep_unit_cost {
	border: 1px solid #e74a3b;
}

.p1 {
	color : black;
}

#dataTable {
	margin : 20px auto;
}

</style>

<form id="frm" method="post" action="${pageContext.request.contextPath}/marginAnalysis/analysis">
	<input type="hidden" name="region_cd" id="region_cd"/>
	<input type="hidden" name="tob_cd" id="tob_cd"/>

	<span class="sp1">* 필수 입력 사항</span> <br>
	<span class="sp1">* 모든 값은 숫자만 입력 가능하며, 이자율은 소숫점 둘째짜리까지 입력 가능하오니 참고하여 주시기 바랍니다.</span>
	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		<tbody>
			<tr class="bg-gray-200">
				<td colspan="8">초기투자비용</td>
			</tr>

			<tr>
				<td class="bg-gray-100">권리금</td>
				<td><input type="text" class="form-control form-control-sm" name="ep_premium" id="ep_premium" placeholder="${expenseVo.ep_premium}">만원</td>
				<td class="bg-gray-100">보증금</td>
				<td><input type="text" class="form-control form-control-sm" name="ep_deposit" id="ep_deposit" placeholder="${expenseVo.ep_deposit}">만원</td>
				<td class="bg-gray-100">대출금</td>
				<td><input type="text" class="form-control form-control-sm" name="ep_loan" id="ep_loan" placeholder="${expenseVo.ep_loan}">만원</td>
				<td class="bg-gray-100">이자율</td>
				<td><input type="text" class="form-control form-control-sm" name="ep_roi" id="ep_roi" placeholder="${expenseVo.ep_roi}">%, 연</td>
			</tr>

			<tr class="bg-gray-200">
				<td colspan="8">기타투자비용</td>
			</tr>
			
			<tr>
				<td colspan="2" class="bg-gray-100">인테리어 및 설비비</td>
				<td colspan="2"><input type="text" class="form-control form-control-sm" name="ep_iaf" id="ep_iaf" placeholder="${expenseVo.ep_iaf}">만원</td>
				<td colspan="2" class="bg-gray-100">기타투자비</td>
				<td colspan="2"><input type="text" class="form-control form-control-sm" name="ep_investment" id="ep_investment" placeholder="${expenseVo.ep_investment}">만원
				</td>
			</tr>

			<tr id="tr1">
				<td colspan="2" class="bg-gray-100">총 투자비용<sup class="sup1">1)</sup></td>
				<td colspan="2"><input type="text" class="form-control form-control-sm" name="iv_total" id="iv_total" readonly 
					placeholder="${expenseVo.ep_premium + expenseVo.ep_deposit + expenseVo.ep_iaf + expenseVo.ep_investment}">만원</td>
				<td colspan="2" class="bg-gray-100">감가상각 대상 투자비용<sup class="sup1">2)</sup></td>
				<td colspan="2"><input type="text" class="form-control form-control-sm" name="de_total" id="de_total" readonly
					placeholder="${expenseVo.ep_premium + expenseVo.ep_iaf + expenseVo.ep_investment}">만원</td>
			</tr>

			<tr class="bg-gray-200">
				<td colspan="8">운영비용</td>
			</tr>

			<tr>
				<td class="bg-gray-100">월세</td>
				<td><input type="text" class="form-control form-control-sm" name="ep_monthly" id="ep_monthly" placeholder="${expenseVo.ep_monthly}">만원</td>
				<td class="bg-gray-100">인건비</td>
				<td><input type="text" class="form-control form-control-sm" name="ep_personnel" id="ep_personnel" placeholder="${expenseVo.ep_personnel}">만원</td>
				<td class="bg-gray-100">재료비</td>
				<td><input type="text" class="form-control form-control-sm" name="ep_material" id="ep_material" placeholder="${expenseVo.ep_material}">만원</td>
				<td class="bg-gray-100">기타운영비</td>
				<td><input type="text" class="form-control form-control-sm" name="ep_etc" id="ep_etc" placeholder="${expenseVo.ep_etc}">만원</td>
			</tr>

			<tr>
				<td colspan="2" class="bg-gray-100">총 운영비용<sup class="sup1">3)</sup></td>
				<td colspan="2"><input type="text" class="form-control form-control-sm" name="cp_total" id="cp_total" readonly
					placeholder="${expenseVo.ep_monthly + expenseVo.ep_personnel + expenseVo.ep_material + expenseVo.ep_etc}">만원</td>
				<td colspan="2" class="bg-gray-100">객 단가<sup class="sup1">4)</sup></td>
				<td colspan="2" id="td1">
					<span class="sp1">*</span>
					<input type="text" style="width:80px;" class="form-control form-control-sm" name="ep_unit_cost" id="ep_unit_cost" placeholder="${expenseVo.ep_unit_cost}">원
				</td>
			</tr>

		</tbody>
	</table>
</form>
<div class="card col-12 p-0">
	<div class="card-header">
		<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-info-circle"></i> 도움말</h6>
	</div>
	<div class="card-body">
		<p class="p1">
			1) 총 투자비용은 대출금을 제외한 전체 투자비용입니다. <br>
			2) 감가상각 대상 투자비용은 권리금, 인테리어 및 설비비, 기타투자비의 합계입니다. <br>
			3) 총 운영비용은 전체 운영비용의 합계입니다. <br>
			4) 객단가는 1명의 고객이 1회 결제 시 이용하는 평균금액을 의미합니다.
		</p>
	</div>
</div>


