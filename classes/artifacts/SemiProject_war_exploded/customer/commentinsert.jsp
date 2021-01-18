<%@  page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../common/nav.jsp"%>


<%
	int myoffset = 2;
	int mywidth = 12 - 2 * myoffset;
	int formleft = 3;
	int formright = 12 - formleft;
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BootStrap Sample</title>
</head>
<body>
	<div class="container col-sm-offset-<%=myoffset%> col-sm-<%=mywidth%>">
		<div class="panel panel-default panel-primary">
			<div class="panel-heading">
				<h4>게시물 등록</h4>
			</div>
			<div class="panel-body">
				<form class="form-horizontal" role="form" action="<%=YesForm%>"
					method="post" >
					<input type="hidden" name="command" value="comment">
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="writer">작성자</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="fakewriter" id="fakewriter"
								placeholder="작성자" value="${sessionScope.loginfo.name}(${requestScope.seq_index})" disabled="disabled">
							<input type="hidden" name="id" id="id"
								value="${sessionScope.loginfo.id}">
							<input type="hidden" name="seq_index" id="seq_index"
								value="${requestScope.seq_index}">	
									
						</div>
					</div>
					
					
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="comment">댓글
							내용</label>
						<div class="col-sm-<%=formright%>">
							<textarea name="comment" id="comment" rows="5" cols=""
								placeholder="글 내용" class="form-control">${bean.comment}</textarea>
							<span class="err">${errcomment}</span>
						</div>
					</div>
			
					
					
					<div class="form-group">
						<div align="center" class="col-sm-offset-3 col-sm-6">
							<button class="btn btn-default" type="submit">새글 쓰기</button>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button class="btn btn-default" type="reset">취소</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>