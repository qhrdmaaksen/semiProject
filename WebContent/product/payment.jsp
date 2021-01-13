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
	</script>
	<style type="text/css">
		#payinfotable th{ font-weight: bold; padding: 7px 10px 7px 15px;}
		#paymemberinfo th{ padding: 7px 10px 7px 15px;}
		#deliverytable th{ padding: 7px 10px 7px 15px;}
		
	</style>
</head>
<body>
	<div class="container col-md-offset-<%=offset%> col-md-<%=content%>">
		<div class="ordTitle">
			<h1>주문/결제</h1>
			<hr style="border:none; border: 5px double orange;">
			<div align="right" style="color: blue">주문결제 > 
				<span style="color: black;">"주문완료"</span>
			</div>
		</div>
		<div data-component="customerinfo" align="center">
			<div class="customer_h2">
				<h3 align="center">구매자 정보</h3>
				<table id="paymemberinfo" style="padding: 10px 0px 10px 16px; font: 12px 돋움, Dotum, sans-werif;">
					<tr align="center">
						<th style="background: #f0f0f5; font-weight: bold;">이름</th>
						<td>김민우</td>
					</tr>
					<tr align="center">
						<th style="background: #f0f0f5; font-weight: bold;">이메일</th>
						<td>rlaalsdn8@gmail.com</td>
					</tr>
					<tr align="center">
						<th style="background: #f0f0f5; font-weight: bold;">휴대폰 번호</th>
						<td>
							<input type="text" name="phonenum" value="010-9255-9798">
						</td>
						<td>
							<button type="button" style="background: white;">수정</button>
						</td>
						<td>쿠폰/티켓정보는 구매한 분의 번호로 전송됩니다.<br>*인증 번호를 못 받았다면, 010-9255-979 번호 차단 및 스팸 설정을 확인해 주세요.</td>
					</tr>
				</table>
			</div>
		</div>
		<div data-component="deleveryaddress">
			<div>
				<h3 style="padding: 0px 0px 0px 2px; margin: 30px 0px 8px;">받는사람 정보
					<span>
						<button type="button" name="deliverychange" 
							style="margin: 0px 0px 0px 5px; padding: 4px 8px; font: 11px 돋움, Dotum, sans-serif; background: white;">
								배송지 변경
						</button>
					</span>
				</h3>
				<table id="deliverytable" style="padding: 10px 0px 10px 16px; font: 12px 돋움, Dotum, sans-werif;">
					<tbody>
						<tr align="center">
							<th style="background: #f0f0f5; font-weight: bold;">이름</th>
							<td align="center">김민우</td>
							<td>
								<button type="button" name="basedelivery" style="background: white;">
									기본배송지
								</button>
							</td>
						</tr>
						<tr align="center">
							<th style="background: #f0f0f5; font-weight: bold;">배송주소</th>
							<td align="center">인천광역시 중구 중산동 1887-1 인천 영종하늘도시 한라비발디아파트 929동 1204호</td>
						</tr>
						<tr align="center">
							<th style="background: #f0f0f5; font-weight: bold;">연락처</th>
							<td align="center">010-9255-9798</td>
						</tr>
						<tr align="center">
							<th style="background: #f0f0f5; font-weight: bold;">배송 요청사항</th>
							<td align="center" colspan="2">문 앞</td>
							<td>
								<button type="button" name="deleverycondition" style="background: white;">
									변경
								</button>
							</td>
						</tr>
						<tr align="center">
							<th style="background: #f0f0f5; font-weight: bold;" align="center">해외배송상품<br>추가정보</th>
							<td align="center" style="padding: 10px 0px 10px 16px; font: 12px 돋움, Dotum, sans-werif;">
								<div>
									<label>
										<input type="radio" checked="checked"> 받는사람 개인통관 고유부호
									</label>
								</div>
								<div style="padding: 10px 15px 10px 50px; margin: 0px 0px 8px;">
									물품가액이 $150 초과할 경우 관/부가세가 발생 할 수 있으며,
									<br>물품 종류와 해외공급자 관계없이 같은 날 입항하게 되면 합산과세 대상이 됩니다.
								</div>
								<div>
									<label>
										개인통관 고유부호 (P로 시작하는 13자리)<br>
											<input type="text">
									</label>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div style="margin: 8px 0px 0px; font:12px 돋움, Dotum, sans-serif;">
				<div style="font: 18px; margin: 20px 0px 9px; font-weight: bold;">
					배송 1건 중 1
				</div>
				<hr>
				<div style="padding: 10px 15px 10px 20px; background: #EEEEEE;">
					<strong>1/29</strong>
					<span>도착 예정</span>
				</div>
				<hr>
				<div>
						<span>로지텍 버티컬 무선 마우스</span>
					<p align="right"><span>수량 1개 / <span>무료 배송</span></span></p>
				</div>
				<hr>
				<div>
					
				</div>
			</div>
			<div>
				<h3 align="center">결제 정보</h3>
			</div>
			<table id="payinfotable" style="margin: 8px 0px 0px; font:12px 돋움, Dotum, sans-serif;">
				<tr align="center">
					<th>총 상품가격</th>
					<td>120,000원</td>
				</tr>
				<tr align="center">
					<th>할인 쿠폰</th>
					<td>0원</td>
				</tr>
				<tr align="center">
					<th>배송비</th>
					<td>0원</td>
				</tr>
				<tr align="center">
					<th>도담도담 캐시</th>
					<td>0원</td>
				</tr>
				<tr align="center">
					<th>총 결제금액</th>
					<td>120,000원</td>
				</tr>
				<tr align="center">
					<th>결제방법</th>
					<td style="padding: 4px 0px 0px;">
						<input type="radio" name="" value="">&nbsp;계좌이체
						<input type="radio" name="" value="">&nbsp;신용/체크카드
						<input type="radio" name="" value="" checked="checked">&nbsp;휴대폰
						<input type="radio" name="" value="">&nbsp;무통장입금(가상계좌)
						<div style="margin: -2px 0px 0px; padding: 10px; background: #F4F6FA" align="left">
							<ul>
								<li>
									<div>
										<label style="font-weight: bold;">통신사 종류</label>
										<select>
											<option value="" selected="selected">선택하세요.</option>
											<option value="SKT">SKT</option>
											<option value="KT">KT</option>
											<option value="LG">LG</option>
										</select>
									</div>
								</li>
							</ul>
						</div>
						<div>
							<input type="checkbox" checked="checked">선택한 결제수단 및 휴대번호로 향후 결제 이용에 동의합니다(선택)
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div style="margin: 0px 0px 10px; font:12px 돋움, Dotum, sans-serif;">
			<div>
				<span>개인정보 제공안내</span>
				<button type="button" style="background: white;">보기</button>
			</div>
		</div>
		<div style="margin: 0px 0px 10px; font:12px 돋움, Dotum, sans-serif;">
			<div>
				<span>구매조건 확인 및 결제대행 서비스 약관 동의</span>
				<button type="button" style="background: white;">보기</button>
			</div>
		</div>
		<div style="margin: 10px 0px 0px; font:12px 돋움, Dotum, sans-serif;">
			<p>
        		* 개별 판매자가 등록한 마켓플레이스(오픈마켓) 상품에 대한 광고, 상품주문, 배송 및 환불의 의무와 책임은 각 판매자가 부담하고, 이에 대하여 쿠팡은 통신판매중개자로서 통신판매의 당사자가 아니므로 일체 책임을 지지 않습니다.
			</p>
		</div>
		<div align="center"style="margin: 15px 0px; font:12px 돋움, Dotum, sans-serif;">
			위 주문 내용을 확인 하였으며, 회원 본인은 결제에 동의합니다.
		</div>
		<div align="center">
			<button class="btn btn-primary" type="button">결제 하기</button>
		</div>
	</div>
</body>
</html>