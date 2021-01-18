<%@  page contentType="text/html;charset=UTF-8" language="java"%>
 <%@ include file="../common/nav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	int myoffset = 2;
	int mywidth = 12 - 2 * myoffset;
	int formleft = 3;
	int formright = 12 - formleft;
	int mysearch = 2;
	//int label = 3 ; //양식의 왼쪽에 보여지는 라벨의 너비 
	//int content = twelve - label ; //우측의 내용 입력(input, select, textarea)의 너비
%>

<script type="text/javascript">
	function writeForm(){
			location.href='<%=NoForm%>boInsert';
	}
	function search(){
		if( $('#mode').val() == 'all' ){
			alert('검색 목록을 선택해주세요') ;
			//$('#mode').focus();
		}else{
			//alert('하하') ;
		}
		//alert( $('#mode').val() );
	}
	function searchAll(){
		//$('#mode').val('-');
		//$('#keyword').val('');
		location.href='<%=NoForm%>boList';
	}
</script>



</head>
<body>
<div class="container col-sm-offset-<%=myoffset%> col-sm-<%=mywidth%>">
		<div class="panel panel-default panel-primary">
			<div class="panel-heading">
				<form class="form-inline" role="form">
					<h2>게시물 목록</h2>
				</form>
			</div>
		<c:forEach var="bean" items="${requestScope.lists}">	
	<table class="table table-striped table-hover">
	<div class="container"> 
	<div class="row">
 	<div class="col-3"> 
 	<div class="card" style="width: 18rem;"> 
 		<img src="./../upload/${bean.image}" class="card-img-top" alt="${bean.image}">
 	<div class="card-body"> 
 		<h5 class="card-title">${bean.title}</h5> 
 		<p class="card-text">${bean.id}</p>
 		
  		<a href="<%=NoForm%>bbsdetailview&no=${bean.no}&${requestScope.parameters}">
								${bean.title}
			</a>
  	</div> 
  	</div>

  </div> 
  </div>
	</c:forEach>
	
	
		<tr>
			<td colspan="10" align="center">
				<form class="form-inline" role="form" name="myform" action="<%=YesForm%>" method="get">
					<input type="hidden" name="command" value="boList">
						<div class="form-group">
							<select class="form-control" name="mode" id="mode">
								<option value="all" selected="selected">-- 선택하세요---------
								<option value="id" >작성자
								<option value="title" >제목									
								<option value="content" >글 내용									
							</select>
						</div>
							<div class="form-group">
								<input type="text" class="form-control btn-xs" name="keyword"
									id="keyword" placeholder="검색 키워드">
							</div>
							<button class="btn btn-default btn-warning" type="submit" onclick="search();">검색</button>
							<button class="btn btn-default btn-warning" type="button" onclick="searchAll();">전체 검색</button>
							<button class="btn btn-default btn-info" type="button"
								onclick="writeForm();">글 쓰기</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<p class="form-control-static">${requestScope.pagingStatus}</p>
					</form>
				</td>
			</tr>
			
			</table>		
		</div>	
	</div>		
</body>
</html>