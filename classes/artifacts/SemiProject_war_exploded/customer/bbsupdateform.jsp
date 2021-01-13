<%@  page contentType="text/html;charset=UTF-8" language="java"%>
 <%@ include file="../common/nav.jsp"%>
<%
	int myoffset = 2;
	int mywidth = 12 - 2 * myoffset;
	int formleft = 3 ;
	int formright = 12 - formleft ; 
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
			<div class="panel-heading"><h4>Update</h4></div>
			<div class="panel-body">
				<form class="form-horizontal" role="form" action="<%=YesForm%>"  method="post" enctype="multipart/form-data">
					<input type="hidden" name="command" value="boUpdate">
					<input type="hidden" name="pageNumber" value="${param.pageNumber}">
					<input type="hidden" name="pageSize" value="${param.pageSize}">
					<input type="hidden" name="mode" value="${param.mode}">
					<input type="hidden" name="keyword" value="${param.keyword}">
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="no">글번호</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="fakeno" id="fakeno"								
								placeholder="글번호" value="${bean.no}" disabled="disabled">
							<input type="hidden" name="no" id="no" value="${bean.no}">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="id">작성자</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="fakewriter" id="fakewriter"								
								placeholder="작성자" value="${bean.id}" disabled="disabled">
							<input type="hidden" name="id" id="id" value="${bean.id}">
							<span class="err">${errid}</span>							 
						</div>
					</div>					
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="title">글 제목</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="title" id="title"								
								placeholder="글 제목" value="${bean.title}">
								<span class="err">${errtitle}</span>								
						</div>
					</div>	
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="image">사진</label>
						<div class="col-sm-<%=formright%>">
							<input type="file" class="form-control" name="image"
								id="image" placeholder="">
							<span class="err form-control-static">${errimage}</span>								
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="content">글 내용</label>
						<div class="col-sm-<%=formright%>">
							<textarea name="content" id="content" rows="5" cols="" 
								placeholder="글 내용" class="form-control">${bean.content}</textarea>
								<span class="err">${errcontent}</span>								
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="likenumber">좋아요수</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="fakereadhit" id="fakereadhit"								
								placeholder="조회수" value="${bean.likenumber}" disabled="disabled">
							<input type="hidden" class="form-control" name="likenumber" id="likenumber" value="${bean.likenumber}">
							<span class="err">${errlikenumber}</span>
						</div>
					</div>			
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="postdate">작성 일자</label>
						<div class="col-sm-<%=formright%>">
							<input type="datetime" class="form-control" name="postdate" id="postdate"								
								placeholder="작성 일자" value="${bean.postdate}">
								<span class="err">${errpostdate}</span>
						</div>
					</div>					
					<div class="form-group">
						<div align="center" class="col-sm-offset-3 col-sm-6">
							<button class="btn btn-default" type="submit">수정하기</button>
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