<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="./../member/mypage.jsp"%>
<%
	int offset = 3; //오프 셋 
	int content = 10 * offset; //12 - 2 * 오프셋
%>
<c:set var="shippingstatus" value="0" />

<c:if test="${not empty requestScope.order}">
	<c:if test="${requestScope.order.shippingstatus == '0'}">
		<!-- 배송준비중 -->
		<c:set var="shippingstatus" value="0" />
	</c:if>
	<c:if test="${requestScope.order.shippingstatus == '1'}">
		<!-- 배송중 -->
		<c:set var="shippingstatus" value="1" />
	</c:if>
	<c:if test="${requestScope.order.shippingstatus == '2'}">
		<!--배송예정 -->
		<c:set var="shippingstatus" value="2" />
	</c:if>
	<c:if test="${requestScope.order.shippingstatus == '3'}">
		<!-- 배송도착 -->
		<c:set var="shippingstatus" value="3" />
	</c:if>
</c:if>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">주문 내역</h3>
			</div>
			<div class="panel-body">
				<div class="table-responsive">
					<table class="table table-condensed">
						<thead>
							<tr>
								<th class="text-center">제품명</th>
								<th class="text-center">이미지</th>								
								<th class="text-center">단가</th>
								<th class="text-center">수량</th>
								<th class="text-center">금액</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="totalAmount" value="0" />
							<c:forEach items="${requestScope.lists}" var="odetail">
								<tr>
									<td>${odetail.productname}</td>
									<td>
										<img alt="${odetail.images}" width="45" height="45" 
											src="${applicationScope.uploadedPath}/${odetail.images}">										
									</td>	</tr>
							</c:forEach>
							<c:forEach items="${requestScope.lists}" var="lists">
								<tr>
									<tr>
									<td class="thick-line"></td>
									<td class="thick-line"></td>								
									<td class="text-center"><fmt:formatNumber
											value="${lists.productprice}" pattern="###,###"/> 원</td>
									<td class="text-center"><fmt:formatNumber
											value="${odetail.qty}" pattern="###,###"/> 개</td>
									<td class="text-center">
										<c:set var="amount" value="${lists.productprice * odetail.qty}" />
										<c:set var="totalAmount" value="${totalAmount + amount}" />
										<fmt:formatNumber value="${amount}" pattern="###,###"/> 원</td>
								</tr>
							</c:forEach>
							<tr>
								<td class="thick-line"></td>
								<td class="thick-line"></td>
								<td class="thick-line"></td>
								<td class="thick-line text-center"><strong>합계</strong></td>
								<td class="thick-line text-right"><fmt:formatNumber
										value="${totalAmount}" /> 원</td>
							</tr>
							<!-- 요금에 따른 운송비 구하기 -->
							<c:set var="shipExpense" value="0" />
							<c:choose>
								<c:when test="${totalAmount >= 100000}">
									<c:set var="shipExpense" value="0" />
								</c:when>
								<c:when test="${totalAmount >= 50000}">
									<c:set var="shipExpense" value="2000" />
								</c:when>
								<c:otherwise>
									<c:set var="shipExpense" value="4000" />
								</c:otherwise>
							</c:choose>
							<tr>
								<td class="no-line"></td>
								<td class="no-line"></td>
								<td class="no-line"></td>
								<td class="no-line text-center"><strong>운송비</strong></td>
								<td class="no-line text-right" >
									<fmt:formatNumber value="${shipExpense}" pattern="###,###"/> 원</td>										
							</tr>
							<tr>
								<td class="no-line"></td>
								<td class="no-line"></td>
								<td class="no-line"></td>
								<td class="no-line text-center"><strong>최종 금액</strong></td>
								<td class="no-line text-right">
									<c:set var="finalAmount" value="${totalAmount + shipExpense}" />
									<strong>
										<fmt:formatNumber value="${finalAmount}" pattern="###,###"/> 원
									</strong>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">결제 정보</h3>
			</div>
			<div class="panel-body">
				<div class="table-responsive">
					<table class="table table-bordered">
						<tbody>
							<tr>
								<td class="text-center gr"><strong>주문 번호</strong></td>
								<td>${order.ordernumber}</td>
								<td class="text-center gr"><strong>정기구독시작일</strong></td>
								<td><fmt:formatDate value="${order.orderdate}" pattern="yyyy년 MM월 dd일" /></td>
								<td class="text-center gr"><strong>정기구독끝나는날</strong></td>
								<td><fmt:formatDate value="${odetail.orderclosing}" pattern="yyyy년 MM월 dd일" /></td>
							</tr>
							<tr>
								<td class="text-center gr"><strong>주문 총액</strong></td>
								<td><fmt:formatNumber value="${finalAmount}" pattern="###,###"/> 원</td>
								<td class="text-center gr"><strong>할인 금액</strong></td>
								<td>0원</td>
							</tr>
							<tr>
								<td class="text-center gr"><strong>결제 금액</strong></td>
								<td><fmt:formatNumber value="${finalAmount}" pattern="###,###"/> 원</td>
								<td class="text-center gr"><strong>결제 상태</strong></td>
								<td>결제 완료</td>
							</tr>

						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">배송 정보</h3>
			</div>
			<div class="panel-body">
				<div class="table-responsive">
					<table class="table table-bordered">
						<tbody>
							<tr>
								<td class="text-center gr"><strong>배송상태</strong></td>
								<c:if test="${shippingstatus==1}">
								<td>배송중입니다.</td>
								</c:if>
								<c:if test="${shippingstatus==0}">
								<td>배송준비중입니다.</td>
								</c:if>
								<c:if test="${shippingstatus==2}">
								<td>배송예정입니다.</td>
								</c:if>
								<c:if test="${shippingstatus==3}">
								<td>배송도착했습니다.</td>
								</c:if>
							</tr>
							<tr>
								<td class="text-center gr"><strong>받으시는 분</strong></td>
								<td>${sessionScope.loginfo.name}(${sessionScope.loginfo.id})
									님</td>
							</tr>
							<tr>
								<td class="text-center gr"><strong>우편  번호 </strong></td>
								<td>${sessionScope.list.address1}</td>
							</tr>
							<tr>
								<td class="text-center gr"><strong>주소</strong></td>
								<td>${sessionScope.list.address1} ${sessionScope.list.address2}</td>
							</tr>
							<tr>
								<td class="text-center gr"><strong>적립 포인트 </strong></td>
								<td><fmt:formatNumber value="${sessionScope.loginfo.point}" pattern="###,###"/> 원</td>
							</tr>
							<tr>
								<td class="text-center gr"><strong>배송 방법 </strong></td>
								<td>택배</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>