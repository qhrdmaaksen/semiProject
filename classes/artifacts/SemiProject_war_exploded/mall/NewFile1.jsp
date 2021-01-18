 <%@ include file="./../common/nav.jsp"%>

<%@ page language="java"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
		<script>
			$( document ).ready( function() {
				$( 'select#jbSelect' ).change( function() {
					var jb = $( 'select#jbSelect' ).val();
					alert( jb );
				} );
			} );
		</script>
		<script>
			$( document ).ready( function() {
				var c_months = $('${Rshopinfo.months}').val();
				var $( 'select.mdb-select' ).val('c_months');
				$( 'select.mdb-select' ).change( function() {
					var jb = $( 'select.mdb-select' ).val();
					alert( jb );
				} );
			} );
		</script>
		
		
	</head>
	<body>
		<select id="jbSelect">
			<option>One</option>
			<option>Two</option>
			<option>Three</option>
		</select>
		
		
<div class="d-flex flex-wrap">
  <div class="select-outline position-relative w-24">
    <select class="mdb-select md-form md-outline">
      <option  name="ct_qty" id="ct_qty" value="1" readonly="readonly">1개</option>
      <option value="2">2개월</option>
      <option value="3">3개월</option>
      <option value="4">4개월</option>
      <option value="5">5개월</option>
      <option value="6">6개월</option>
    </select>
  </div>
</div>
		
		<br><br><br><br>
${Rshopinfo.months}




<!-- <script>

function change_qty2(t){ //var min_qty = '수량버튼'*1; 
var min_qty = 1; 
var this_qty = $("#ct_qty").val()*1; 
var max_qty = '200'; 
// 현재 재고 if(t=="m"){ this_qty -= 1; 
if(this_qty<min_qty){ //alert("최소구매수량 이상만 구매할 수 있습니다."); 
	alert("수량은 1개 이상 입력해 주십시오."); return; } 
	}else if(t=="p"){ this_qty += 1; if(this_qty>max_qty){ 
		alert("죄송합니다. 재고가 부족합니다."); return; } 
		} 
	var show_total_amount = basic_amount * this_qty; 
	//$("#ct_qty_txt").text(this_qty); 
	$("#ct_qty").val(this_qty); 
	$("#it_pay").val(show_total_amount); 
	$("#total_amount").html(show_total_amount.format()); 
	}


	</script> -->

</body>
</html>