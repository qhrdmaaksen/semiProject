<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<%@ include file="../common/nav.jsp"%>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<%
	pageContext.setAttribute("replaceChar", "\n");
		int twelve = 12 ;
		int offset = 2; //오프 셋 
		int content = twelve - 2 * offset; //12 - 2 * 오프셋
	%>
	<script>
		IMP.init('자신의가맹점_키');
		
		IMP.request_pay({
		    pg : 'inicis', // version 1.1.0부터 지원.
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '주문명:결제테스트',
		    amount : 14000, //판매 가격
		    buyer_email : 'iamport@siot.do',
		    buyer_name : '구매자이름',
		    buyer_tel : '010-1234-5678',
		    buyer_addr : '서울특별시 강남구 삼성동',
		    buyer_postcode : '123-456'
		}, function(rsp) {
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    }
		    alert(msg);
		});
		var Iamport = require('iamport');
		var iamport = new Iamport({
		  impKey: '자신의_API_키',
		  impSecret: '자신의_APIscret_키'
		});
		app.get('/payments/status/all',(req,res)=>{
		        iamport.payment.getByStatus({
		          payment_status: 'paid' 
		        }).then(function(result){
		            res.render('payments_list',{list:result.list});
		        }).catch(function(error){
		            console.log(error);
		            red.send(error);
		        })
		});
		function phonechange(){
			
		}
	</script>
	<script type="text/javascript">
	  function sendaddshipping() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수

	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample4_postcode').value = data.zonecode;
	                document.getElementById("sample4_roadAddress").value = roadAddr;
	                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
	                
	                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	                if(roadAddr !== ''){
	                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	                } else {
	                    document.getElementById("sample4_extraAddress").value = '';
	                }

	                var guideTextBox = document.getElementById("guide");
	                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	                if(data.autoRoadAddress) {
	                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                    guideTextBox.style.display = 'block';

	                } else if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                    guideTextBox.style.display = 'block';
	                } else {
	                    guideTextBox.innerHTML = '';
	                    guideTextBox.style.display = 'none';
	                }
	            }
	        }).open();
	    }
		$(document).ready(function() {
			$("[name=addrlist]").click(function(e) {
				var selectaddr = $(this).text();
				$("#addrtext").text($(this).text());
				$("#exampleModal").modal('hide');
			});
		});
	
	</script>
	<style type="text/css">
		#payinfotable th{ font-weight: bold; padding: 7px 10px 7px 15px;}
		#paymemberinfo th{ padding: 7px 10px 7px 15px;}
		#deliverytable th{ padding: 7px 10px 7px 15px;}
		a { text-decoration:none ;} 
	</style>
</head>
<body>
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-scrollable">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	         <div class="list-group">
		         <c:forEach items="${lists}" var="item">
					<button type="button" class="list-group-item list-group-item-action" aria-current="true" name="addrlist">
						<span>${item.address1}</span>
						<span>${item.address2}</span>
					</button>
		         </c:forEach>
			 </div>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="modal fade" id="addshipping" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-scrollable">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      	<form method="post" action="<%=YesForm%>?command=paymentaddaddr">
	      		<input type="hidden" name="id" value="${loginfo.id}">
	      		<input type="hidden" name="shippingname" value="${loginfo.name}">
	      		<input type="hidden" name="name" value="${loginfo.name}">
	      		<input type="hidden" name="phone" value="${loginfo.phone}">
	      		<input type="hidden" name="paymentshipping" value="gotopayment">
		      	<div class="input-group mb-3">
				  <input type="text" id="sample4_postcode" class="form-control" placeholder="우편번호" aria-label="우편번호" aria-describedby="basic-addon2">
				  <button type="button" class="input-group-text" id="basic-addon2" onclick="sendaddshipping()">우편번호 찾기</button>
				</div>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" name="sample4_roadAddress" id="sample4_roadAddress" placeholder="도로명주소" aria-label="도로명주소" aria-describedby="basic-addon1">
				</div>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" name="sample4_jibunAddress" id="sample4_jibunAddress" placeholder="지번주소" aria-label="지번주소" aria-describedby="basic-addon1">
				</div>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" id="sample4_extraAddress" placeholder="참고항목" aria-label="참고항목" aria-describedby="basic-addon1">
				</div>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" id="sample4_detailAddress" placeholder="상세주소" aria-label="상세주소" aria-describedby="basic-addon1">
				</div>
				<div class="row">
					<div class="col">
					</div>
					<div class="col">
						<button type="submit" class="btn btn-primary">추가하기</button>
					</div>
					<div class="col">
					</div>
				</div>
	      	</form>
			<span id="guide" style="color:#999;display:none"></span>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="container col-md-offset-<%=offset%> col-md-<%=content%>" style="padding-bottom: 10%; width: 40%;">
		<div class="ordTitle">
			<h1>주문/결제</h1>
			<hr style="border:none; border: 5px double orange;">
			<div align="right" style="color: blue">주문결제 > 
				<span style="color: black;">"주문완료"</span>
			</div>
		</div>
		<div data-component="customerinfo">
			<div class="customer_h2">
				<h3 style="margin-left: 200px;" class="col-md-3">구매자 정보</h3>
				<hr>
				<table id="paymemberinfo" style="padding: 10px 0px 10px 16px; font: 12px 돋움, Dotum, sans-werif; white-space: nowrap; width: 100%;" >
					<tr align="center">
						<th style="background: #f0f0f5; font-weight: bold;">이름
						</th>
						<td align="center">${sessionScope.loginfo.name}(${sessionScope.loginfo.id})님
						</td>
					</tr>
					<tr align="center">
						<th style="background: #f0f0f5; font-weight: bold;">휴대폰 번호</th>
						<td class="col-md-4">
							<input type="text" name="phonenum" value="${sessionScope.loginfo.phone}">
						</td>
						<td class="col-md-4">
							<button type="button" class="btn btn-warning btn-sm">
								<a href="http://localhost:8989/SemiProject/dodamdodam?command=memodify">수정
								</a>
							</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<hr>
		<div data-component="deleveryaddress">
			<div>
				<h3 style="padding: 0px 0px 0px 2px; margin: 30px 0px 8px; margin-left: 200px;">받는사람 정보
					<span>
						<button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal" id="shippingchange" class="btn btn-outline-primary btn-sm"
							style="margin: 0px 0px 0px 5px; padding: 4px 8px; font: 11px 돋움, Dotum, sans-serif;">
								배송지 변경
						</button>
						<button type="button" data-bs-toggle="modal" data-bs-target="#addshipping" class="btn btn-outline-primary "
							style="margin: 0px 0px 0px 5px; padding: 4px 8px; font: 11px 돋움, Dotum, sans-serif;">
								신규 배송지 추가
						</button>
					</span>
				</h3>
				<hr>
				<table id="deliverytable" style="padding: 10px 0px 10px 16px; font: 12px 돋움, Dotum, sans-werif; white-space: nowrap; width: 100%;">
					<tbody>
						<tr align="center">
							<th style="background: #f0f0f5; font-weight: bold;">배송지 이름
							</th>
							<td align="center">${lists[0].shippingname}
							</td>
							<!-- <td>
								<button class="col-md-6" type="button" name="basedelivery" style="background: white;">
									기본배송지
								</button>
							</td> -->
						</tr>
						<tr align="center">
							<th style="background: #f0f0f5; font-weight: bold;">배송주소</th>
							<td align="center" id="addrtext">${lists[0].address1}${lists[0].address2}</td>
						</tr>
						<tr align="center">
							<th style="background: #f0f0f5; font-weight: bold;">연락처</th>
							<td align="center">${sessionScope.loginfo.phone}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div style="margin: 8px 0px 0px; font:12px 돋움, Dotum, sans-serif;">
				<div style="font: 18px; margin: 20px 0px 9px; font-weight: bold; margin-left: 200px;">
					배송 1건 중 1
				</div>
				<hr style="border: none;">
				<div style="padding: 10px 15px 10px 20px; background: #EEEEEE;">
					<strong>1/29</strong>
					<span>도착 예정</span>
				</div>
				<hr style="border: none;">
				<div>
						<span>${bean.productname}</span>
					<p align="right"><span>수량 1개 / <span>무료 배송</span></span></p>
				</div>
				<hr>
				<div>
					
				</div>
			</div>
			<div>
				<h3 align="center">결제 정보</h3>
				<hr>
			</div>
			<table id="payinfotable" style="margin: 8px 0px 0px; font:12px 돋움, Dotum, sans-serif;">
				<tbody align="center">
				<tr align="center">
					<th>총 상품가격</th>
					<td>${bean.productprice}원</td>
				</tr>
				<tr align="center">
					<th>할인 쿠폰</th>
					<td align="center">
						${coupon.kind==1}
						<button style="float: right; font: 10px;" type="button" class="btn btn-outline-warning btn-sm"> 
							<a href="http://localhost:8989/SemiProject/dodamdodam?command=coupon">쿠폰 선택
							</a>
						</button>
					</td>
				</tr>
				<tr align="center">
					<th>배송비</th>
					<td>
						<fmt:formatNumber value="${shipExpense}" pattern="###,###"/>원
					</td>
				</tr>
				<tr align="center">
					<th>도담도담 캐시</th>
					<td>0원</td>
				</tr>
				<tr align="center">
					<th>총 결제금액</th>
					<td>
						<c:set var="finalAmount" value="${totalAmount + shipExpense}" />
						<strong>
							<fmt:formatNumber value="${finalAmount}" pattern="###,###"/> 원
						</strong>
					</td>
				</tr>
				
				<tr align="center">
					<th>결제방법</th>
					<td style="padding: 4px 0px 0px; float: right;">
						<input type="radio" name="" value="">&nbsp;신용/체크카드
						<input type="radio" name="" value="">&nbsp;무통장입금(가상계좌)
						<div align="center">
							<input type="checkbox" checked="checked">&nbsp;선택한 결제수단 및 휴대번호로 향후 결제 이용에 동의합니다(선택)
						</div>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<br><br><br>
		<div style="margin: 0px 0px 10px; font:12px 돋움, Dotum, sans-serif;">
			<div>
				<span>개인정보 제공안내</span>
				<button type="button" style="background: white; float: right;">보기</button>
			</div><br>
		</div>
		<div style="margin: 0px 0px 10px; font:12px 돋움, Dotum, sans-serif;">
			<div>
				<span>구매조건 확인 및 결제대행 서비스 약관 동의</span>
				<button type="button" style="background: white; float: right;">보기</button>
			</div><br>
		</div>
		<div style="margin: 10px 0px 0px; font:12px 돋움, Dotum, sans-serif;">
			<p>
        		* 개별 판매자가 등록한 마켓플레이스(오픈마켓) 상품에 대한 광고, 상품주문, 배송 및 환불의 의무와 책임은 각 판매자가 부담하고, 이에 대하여 쿠팡은 통신판매중개자로서 통신판매의 당사자가 아니므로 일체 책임을 지지 않습니다.
			</p><br>
		</div>
		<div align="center"style="margin: 15px 0px; font:12px 돋움, Dotum, sans-serif; ">
			위 주문 내용을 확인 하였으며, 회원 본인은 결제에 동의합니다.<br>
		</div>
		<div align="center">
			<button class="btn btn-primary" type="button">결제 하기</button>
		</div>
	</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>