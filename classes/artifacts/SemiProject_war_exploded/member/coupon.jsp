<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2020-12-29
  Time: 오전 10:42
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="mypage.jsp"%>
<html>
<head>
    <title><%=NAME%>, 마이페이지 - 쿠폰</title>
</head>
<body>
            <div class="container-fluid coupons">
                <ul class="nav nav-tabs nav-justified">
                    <li class="nav-item">
                        <a class="nav-link coupons_tabs active" data-toggle="tab" href="#home">사용가능</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link coupons_tabs" data-toggle="tab" href="#menu1">사용완료 / 기간만료</a>
                    </li>
                </ul>
            </div>
            <div class="container-fluid tab-content coupons">
                <div id="home" class="container-fluid tab-pane active">
                    <table class="table table-bordered">
                        <colgroup>
                            <col>
                            <col width="100">
                            <col width="150">
                            <col width="130">
                        </colgroup>
                        <thead>
                            <tr>
                                <td>쿠폰명</td>
                                <td>할인액</td>
                                <td>유효기간</td>
                                <td>쿠폰종류</td>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="coupon" items="${requestScope.coupons}">
                                <tr>
                                    <td>${coupon.name}</td>
                                    <td><fmt:formatNumber type = "percent" maxIntegerDigits="3" value = "${coupon.discount}" /></td>
                                    <td>${coupon.exp}</td>
                                    <td>
                                        <c:if test="${coupon.kind==1}">
                                            할인쿠폰
                                        </c:if>
                                        <c:if test="${coupon.kind==2}">
                                            배송비할인
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div id="menu1" class="container-fluid tab-pane fade"><br>
                    <table class="table table-bordered">
                        <colgroup>
                            <col>
                            <col width="100">
                            <col width="150">
                            <col width="130">
                        </colgroup>
                        <thead>
                        <tr>
                            <td>쿠폰명</td>
                            <td>할인액</td>
                            <td>유효기간</td>
                            <td>쿠폰종류</td>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="coupon" items="${requestScope.usedcoupons}">
                            <tr>
                                <td>${coupon.name}</td>
                                <td><fmt:formatNumber type = "percent" maxIntegerDigits="3" value = "${coupon.discount}" /></td>
                                <td>${coupon.exp}</td>
                                <td>
                                    <c:if test="${coupon.kind==1}">
                                        할인쿠폰
                                    </c:if>
                                    <c:if test="${coupon.kind==2}">
                                        배송비할인
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
