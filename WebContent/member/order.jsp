<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="./../member/mypage.jsp"%>
<%
	int offset = 3; //오프 셋 
	int content = 10 * offset; //12 - 2 * 오프셋
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container col-md-offset-<%=offset%> col-md-<%=content%>">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">${sessionScope.loginfo.name} 님의 이전 주문 내역</h3>
			</div>
			<div class="panel-body">
				<div class="table-responsive">
					<table class="table table-condensed">
						<thead>
							<tr>
								<th class="text-center">이미지</th>
								<th class="text-center">주문 일자</th>
								<th class="text-center">상세 보기</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${requestScope.lists}" var="shopinfo">
								<tr class="record">
									<td align="center"><img alt="${odetail.images}" width="45" height="45" 
											src="${applicationScope.uploadedPath}/${odetail.images}"></td>
									<td align="center">${shopinfo.orderdate}</td>
									<td align="center">
										<a href="<%=NoForm%>mallDetail&id=${shopinfo.id}">상세 보기</a></td>
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