<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	 <%@ include file="../common/nav.jsp"%>
	 <script type="text/javascript">
	 	function gotohome(){
	 		$(location).attr("href","http://localhost:8989/SemiProject/dodamdodam?command=index");
	 	}
	 	function paypay(){
	 		console.log("#paypay");
	 	}
	 </script>
	<style>
		ul {
			list-style: none;
		}
	</style>
</head>
<body>
	<div align="center" class="virtual-account-payment pay-type-content" data-controller="vaPayment" data-controller-data="{
        &quot;savedBankKcpCode&quot; : &quot;&quot;
    }">
    <p class="validate-message" style="display: none;"></p>
    <ul class="pay-type-sections">
        <li class="deposit-bank-wrap pay-type-section">
            <label for="depositBank" class="line-title">입금은행</label>
            <div class="line-data">
                <select id="depositBank" class="" name="depositBank">
                    <option value="" selected="" data-limitmsg="">선택</option>
                            <option value="NH" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">농협은행 79014990673671</option>
                            <option value="KB" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">국민은행 79014990673671</option>
                            <option value="SHINHAN" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">신한은행 79014990673671</option>
                            <option value="WOORI" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">우리은행 79014990673671</option>
                            <option value="HANA" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">KEB하나은행 79014990673671</option>
                            <option value="IBK" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">기업은행 79014990673671</option>
                            <option value="DAEGU" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">대구은행 79014990673671</option>
                            <option value="BUSAN" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">부산은행 79014990673671</option>
                            <option value="POST_OFFICE" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">우체국 79014990673671</option>
                            <option value="KYONGNAM" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">경남은행 79014990673671</option>
                            <option value="KWANGJU" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">광주은행 79014990673671</option>
                            <option value="SC" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">SC제일은행 79014990673671</option>
                            <option value="SUHYUB" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">수협은행 79014990673671</option>
                            <option value="CITI" data-limitmsg="" data-messagecolor="" data-paymentdisabled="false">씨티은행 79014990673671</option>
                </select>
                <p class="validate-message" style="display: none;"></p>
                <p class="pay-box__deactivated-payment-notice" id="virtualAccountPayTypeLimitMsg"></p>
                
            </div>
        </li>
        <li class="payBox-section  pay-type-section">
            <div class="line-data">
            	<span id="paypay">총 결제 금액 : ${param.totalprice}원</span><br>
	            <span class="line-title">입금기한 : </span>
                <span class="depositDueTxt">2021년 01월 18일 08시 59분까지</span>
                
            </div>
        </li>
        <li class="pay-type-explain">
            <p class="cash-receipt-explain">* 현금으로 결제한 모든 금액은 우리은행과 채무지급보증계약을 체결하여 고객님의 안전거래를 보장하고 있습니다.</p>
        </li>
    </ul>
    <div>
    	<button id="gohome" type="button" class="btn btn-primary" onclick="gotohome()">홈페이지로 돌아가기</button>
    </div>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>