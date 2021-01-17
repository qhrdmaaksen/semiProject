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
	<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%
	pageContext.setAttribute("replaceChar", "\n");
		int twelve = 12 ;
		int offset = 2; //오프 셋 
		int content = twelve - 2 * offset; //12 - 2 * 오프셋
	%>
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
	<div class="modal fade" id="couponselectbtn" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">적용하실 쿠폰을 선택해주세요.</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"	aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="list-group">
						<c:forEach items="${requestScope.soupons}" var="couponitem">
							<button type="button" class="list-group-item list-group-item-action" aria-current="true" name="couponselect">
								<span>${couponitem.usedcoupons}</span>
								<span><fmt:formatNumber type="percent" maxIntegerDigits="3" value="${coupon.discount}"></fmt:formatNumber></span>
								<c:if test="${coupon.kind==1}">
                                    할인쿠폰
                                </c:if>
								<c:if test="${coupon.kind==2}">
                                    배송비할인
                                </c:if>
							</button>
						</c:forEach>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-scrollable">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">배송지를 선택해주세요.</h5>
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
	        <h5 class="modal-title" id="exampleModalLabel">신규 배송지를 추가해주세요.</h5>
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
							<input type="text" id="phonenum" name="phonenum" value="${sessionScope.loginfo.phone}">
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
							<th style="background: #f0f0f5; font-weight: bold;">수령인
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
							<td align="center" id="addrtext">${lists[0].address1} ${lists[0].address2}</td>
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
						${couponitem.usedcoupons}
						<button style="float: right; font: 10px;" type="button"
							 class="btn btn-outline-warning btn-sm" data-bs-toggle="modal" data-bs-target="#couponselectbtn"> 
							<span>쿠폰 선택</span>
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
						<input type="radio" name="pymnt" value="card" checked>&nbsp;신용/체크카드
						<input type="radio" name="pymnt" value="banktrnsf">&nbsp;무통장입금(가상계좌)
						<div align="center">
							<input id="agreecheck" type="checkbox" checked="checked">&nbsp;선택한 결제수단으로 향후 결제 이용에 동의합니다(선택)
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
				 <a onfocus="blur()" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[닫기]':'[열기]';
				 this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)" ;>[열기]</a><div style="DISPLAY: none">

					<div class="agreements__content " data-agreements-content=""
						style="display: block;">
						<table class="agreements__content__table">
							<thead>
								<tr>
									<th class="agreements__content__th" width="24%">제공받는자</th>
									<th class="agreements__content__th" width="24%">제공목적</th>
									<th class="agreements__content__th" width="24%">제공정보</th>
									<th class="agreements__content__th">보유 및 이용기간</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="agreements__content__td"><span
										class="agreements__content__td__em"
										style="word-break: break-all">소니바리</span></td>
									<td class="agreements__content__td"><span
										class="agreements__content__td__em">서비스 제공, 사은행사,
											구매자확인, 해피콜</span></td>
									<td class="agreements__content__td">성명, 휴대전화번호(또는 안심번호),
										배송지주소, 이메일<br>※ 구매자와 수취인이 다를 경우에는 수취인의 정보(해외 배송 상품은
										개인통관고유부호 포함)가 제공될 수 있습니다.
									</td>
									<td class="agreements__content__td"><span
										class="agreements__content__td__em">재화 또는 서비스의 제공 목적이
											달성 된 후 파기</span> (단, 관계법령에 정해진 규정에 따라 법정기간 동안 보관)</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div><br>
		</div>
		<div style="margin: 0px 0px 10px; font:12px 돋움, Dotum, sans-serif;">
			<div>
				<span>구매조건 확인 및 결제대행 서비스 약관 동의</span>
				 <a onfocus="blur()" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[닫기]':'[열기]';
				 this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)" ;>[열기]</a><div style="DISPLAY: none">
				 
				  <li>
                ② 관련법령에 의한 정보보유
                <br>
                상법, 전자상거래 등에서의 소비자보호에 관한 법률, 전자금융거래법 등 관련법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 관련법령에서 정한 일정한 기간 동안 정보를 보관합니다. 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다.
                <ol>
                    <li>1) 계약 또는 청약철회 등에 관한 기록 : 보존기간: 5년 / 보존근거: 전자상거래 등에서의 소비자보호에 관한 법률</li>
                    <li>2) 대금결제 및 재화 등의 공급에 관한 기록 : 보존기간: 5년 / 보존근거: 전자상거래 등에서의 소비자보호에 관한 법률 (단, 건당 거래 금액이 1만원 이하의 경우에는 1년간 보존 합니다).</li>
                    <li>3) 소비자의 불만 또는 분쟁처리에 관한 기록 : 보존기간: 3년 / 보존근거: 전자상거래 등에서의 소비자보호에 관한 법률</li>
                    <li>4) 전자금융거래에 관한 기록 : 보존기간: 5년 / 보존근거: 전자금융거래법</li>
                    <li>5) 방문에 관한 기록 : 보존기간: 3개월 / 보존근거: 통신비밀보호법</li>
                </ol>
            </li>
				</div>
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
			<button class="btn btn-primary" type="button" onclick="requestPay()">결제 하기</button>
		</div>
	</div>
	<script>
        var IMP = window.IMP; // 생략해도 괜찮습니다.
        IMP.init("imp34864609"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.
        
        var today = new Date();

        var merchant_uid = today.getFullYear() + "" + today.getMonth() + "" + today.getDate() + "" + today.getHours() + "" + today.getMinutes() + "" + today.getSeconds();
        var list = new Array();
        var ordertype = 1;
        
        if(ordertype==1){
        	var product = new Object();
        	product.name = "홍길동 영양제";
        	product.amount = 39900;
        	product.qty = 1;
            list[0] = product;
        }else {
        	var product = new Object();
        	product.name = "홍길동 영양제";
        	product.amount = 39900;
        	product.orderclosing = "2021-02-16";
            list[0] = product;
        }
        
        var email = "";
        var b_name = "${sessionScope.loginfo.name}";
        var b_tel = $("#phonenum").val();
        var b_addr = $("#addrtext").text();

        function requestPay() {
        	if (${"#agreecheck"}.is(":checked")==false) {
				alert('결제 이용 동의를 선택해주세요.')
			};
        	console.log("결제 실행중");
        	var obj = document.getElementsByName("momentum");
        	if(obj.value == "banktrnsf"){
        		// 여기에 나중에 계좌이체로 처리할 페이지로 이동하게끔 유도
        	}
            // IMP.request_pay(param, callback) 호출
            IMP.request_pay({ // param
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: merchant_uid,
                buyer_email: email,
                name: product.name,
                amount: product.amount,
                buyer_name: b_name,
                buyer_tel: b_tel,
                buyer_addr: b_addr,
            }, function (rsp) { // callback
                if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
                    // jQuery로 HTTP 요청
                    jQuery.ajax({
                        url: "/dodamdodam?command=payOk", // 가맹점 서버
                        method: "POST",
                        contentType: "application/x-www-form-urlencoded; charset=utf-8",
                        data: {
                            imp_uid: rsp.imp_uid,
                            merchant_uid: rsp.merchant_uid,
                            name: name,
                            amount: product.amount,
                            buyer_email: email,
                            buyer_name: b_name,
                            buyer_tel: b_tel,
                            buyer_addr: b_addr,
                        },
                        datatype: "json"
                    }).done(function (data) {
                        // 가맹점 서버 결제 API 성공시 로직
                    	console.log("결제 성공");
                    })
                } else {
                    alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
                    console.log("결제 실패");
                }
            });
        }
    </script>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>