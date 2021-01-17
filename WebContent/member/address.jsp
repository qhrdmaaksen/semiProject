<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="./../member/mypage.jsp"%>
<%
	int offset = 3; //오프 셋 
	int content = 10 * offset; //12 - 2 * 오프셋
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">


function writeForm(){
	location.href='<%=NoForm%>addaddress';
}


</script>
<style type="text/css">

</style>
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
								<th class="text-center">수령인</th>
								<th class="text-center">전화번호</th>
								<th class="text-center">배달지</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${requestScope.lists}" var="bean">
								<tr class="record">
									<td align="center">${bean.name}</td>
									<td align="center">${bean.phone}</td>
									<td align="center">${bean.address1}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	
		<button class="btn btn-default btn-info" type="button"
								onclick="writeForm();"> 배송지 추가하기 </button>

</body>
</html>