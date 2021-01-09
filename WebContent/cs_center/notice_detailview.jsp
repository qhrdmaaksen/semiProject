<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<%@ include file="../common/nav.jsp"%>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function gotoBack(){
			location.href='<%=NoForm%>cs_center_main&${requestScope.parameters}';
			//alert('${requestScope.parameter}') ;
		};
	</script>
</head>
<%
	int twelve = 12;
	int myoffset = 2; //전체 외관의 옵셋
	int mywidth = twelve - 2 * myoffset;
	int leftside = 4; //판넬의 좌측
	int rightside = twelve - leftside; //판넬의 우측
%>
<body>
	<div class="container col-sm-offset-<%=myoffset%> col-sm-<%=mywidth%>">
		<div class="panel panel-default panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title" align="center">공지사항 상세 보기</h1>
			</div>
			<div class="panel-body">
				<div class="col-sm-<%=leftside%> col-sm-<%=leftside%>">
					<table>
						<tr>
							<td align="center">
								<img align="middle" src="../images/logo1.png"
								class="img-rounded" width="300" height="100">
							</td>
						</tr>
					</table>
				</div>
				<div class="col-sm-<%=twelve%> col-sm-<%=twelve%>">
					<table class="table table-hover table-condensed">
						<tr>
							<td width="25%" align="center">제목</td>
							<td width="75%" align="left">${bean.subject}</td>
						</tr>
					</table>
					<table style="white-space:nowrap;">
						<tbody style="width: 100%;">
							<tr style="display: inline; " class="col-sm-<%=leftside%>">
								<td width="20%"><span style="display: inline;">글 번호</span></td>
								<td width="30%">${bean.no}</td>
							</tr>
							<tr style="display: inline; " class="col-sm-<%=leftside%>">
								<td width="20%">작성자</td>
								<td width="30%">${bean.writer}</td>
							</tr>
							<tr style="display: inline; " class="col-sm-<%=leftside%>">	
								<td width="20%">작성 일자</td>
								<td width="30%">${bean.regdate}</td>
							</tr>
						</tbody>
					</table>
					<br><br><br><br><br>
					<table>
						<tr>
							<td width="30%" align="center">글 내용</td>
							<td width="70%" align="left">${bean.content}
							</td>
						</tr> 
					</table>
				</div>
				<hr>
				<div class="col-sm-offset-5 col-sm-4">
					<button class="btn btn-primary" onclick="gotoBack();">
						돌아 가기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>