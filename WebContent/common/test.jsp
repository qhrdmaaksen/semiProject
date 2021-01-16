<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2021-01-15
  Time: 오후 5:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<html>
<head>
    <title>Title</title>
    <script>
        var IMP = window.IMP; // 생략해도 괜찮습니다.
        IMP.init("imp34864609"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.

        var merchant_uid = "ORD20180131-0000015";
        var name = "홍길동 영양제";
        var amount = 39900;
        var email = "lomuhoe@gmail.com";
        var b_name = "최인회";
        var b_tel = "010-4528-6862";
        var b_addr = "인천시 중구";
        var postcode = "22376";


        function requestPay() {
            // IMP.request_pay(param, callback) 호출
            IMP.request_pay({ // param
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: merchant_uid,
                name: name,
                amount: amount,
                buyer_email: email,
                buyer_name: b_name,
                buyer_tel: b_tel,
                buyer_addr: b_addr,
                buyer_postcode: postcode
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
                            amount: amount,
                            buyer_email: email,
                            buyer_name: b_name,
                            buyer_tel: b_tel,
                            buyer_addr: b_addr,
                            buyer_postcode: postcode
                        },
                        datatype: "json"
                    }).done(function (data) {
                        // 가맹점 서버 결제 API 성공시 로직
                        alert("결제에 성공하였습니다.");
                    })
                } else {
                    alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
                }
            });
        }
    </script>
</head>
<body>
    <button onclick="requestPay()">결제하기</button>
</body>
</html>
