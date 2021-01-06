<%@page import="utility.Paging"%>
<%@page import="DAO.ProductDAO"%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="./../common/nav.jsp"%>



<% int twelve = 12 ; %>
<%
	int myoffset = 2;
	int mywidth = twelve - 2 * myoffset;
	int formleft = 3 ;
	int formright = twelve - formleft ; 
%>
<!DOCTYPE html>
<html>
	<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
		function writeForm(){
			location.href='<%=NoForm%>prInsert';
		}
		function search(){
			if( $('#mode').val() == 'all' ){
				alert('검색 목록을 선택해주세요') ;				
			}
		}
		function searchAll(){
			location.href='<%=NoForm%>prList';
		}
	
	</script>
</head>
<body>
	<div class="container col-sm-offset-<%=myoffset%> col-sm-<%=mywidth%>">
		<div class="panel panel-default">
			<div class="panel-heading"><h4>상품 목록</h4></div>
			<table class="table table-condensed table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>상품명</th>
						<th>이미지</th>
						<th>단가</th>
						<th>삭제</th>
						<th>수정</th>
					</tr>
				</thead>
				<tr>
					<td colspan="12" align="center">
						<form class="form-inline" role="form" name="myform" action="<%=YesForm%>" method="get">
							<input type="hidden" name="command" value="prList">
							<div class="form-group">
								<select class="form-control" name="mode" id="mode">
									<option value="all" selected="selected">-- 선택하세요---------
									<option value="productname">상품명
									<option value="company">제조회사									
									<option value="category">카테고리									
								</select>
							</div>
							<div class="form-group">
								<input type="text" class="form-control btn-xs" name="keyword"
									id="keyword" placeholder="검색 키워드">
							</div>
							<button class="btn btn-default btn-warning" type="submit" onclick="search();">검색</button>
							<button class="btn btn-default btn-warning" type="button" onclick="searchAll();">전체 검색</button>
							
							<c:if test="${whologin == 2}">
								<button class="btn btn-default btn-info" type="button"
									onclick="writeForm();">상품 등록</button>
							</c:if>
								
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<p class="form-control-static">${requestScope.pagingStatus}</p>
						</form>
					</td>
				</tr>				
				<c:forEach var="bean" items="${requestScope.lists}">
				<tr>
					<td>${bean.productcode}</td>
					<td>
						<a href="<%=NoForm%>prDetailView&productcode=${bean.productcode}&${requestScope.parameters}">
							${bean.productname}
						</a>
					</td>
					<td>${bean.images}</td>
					<td>${bean.productprice}</td>
					<td>
						<c:if test="${whologin == 2}">
							<a href="<%=NoForm%>prDelete&productcode=${bean.productcode}&${requestScope.parameters}">
								삭제
							</a>
						</c:if>
						<c:if test="${whologin != 2}">
							삭제
						</c:if>				
					</td>
					<td>
						<c:if test="${whologin == 2}">
							<a href="<%=NoForm%>prUpdate&productcode=${bean.productcode}&${requestScope.parameters}">
								수정
							</a>
						</c:if>
						<c:if test="${whologin != 2}">
							수정
						</c:if>					
						
					</td>
				</tr>
				</c:forEach>			
			</table>
		</div>
		<div align="center">
			<footer>${requestScope.pagingHtml}</footer>
		</div>		
	</div>
	<br><br><br><br>
	<script type="text/javascript">
	   /* 방금 전 선택한 콤보 박스를 그대로 보여 주기 */ 
		$('#mode option').each(function (index){
			if( $(this).val() == '${requestScope.mode}' ){
				$(this).attr('selected', 'selected') ;
			}
		});	
		/* 이전에 넣었던 값 그대로 보존 */
		$('#keyword').val( '${requestScope.keyword}' ) ;		
	</script>	
</body>
</html>