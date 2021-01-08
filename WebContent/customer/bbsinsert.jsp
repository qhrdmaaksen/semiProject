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
					method="post">
					<input type="hidden" name="command" value="boInsert">
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="writer">작성자</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="fakewriter" id="fakewriter"
								placeholder="작성자" value="${sessionScope.loginfo.name}(${sessionScope.loginfo.id})" disabled="disabled">
							<input type="hidden" name="id" id="id"
								value="${sessionScope.loginfo.id}">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="title">글
							제목</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="title"
								id="title" placeholder="글 제목" value="${bean.title}"> 
							<span class="err">${errtitle}</span>
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="image">이미지</label>
						<div class="col-sm-<%=formright%>">
							<input type="file" class="form-control" name="image"
								id="image" placeholder="이미지를 넣어 주셔용^^">
							<span class="err form-control-static">${errimage}</span>								
						</div>
					</div>
					
					
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="content">글
							내용</label>
						<div class="col-sm-<%=formright%>">
							<textarea name="content" id="content" rows="5" cols=""
								placeholder="글 내용" class="form-control">${bean.content}</textarea>
							<span class="err">${errcontent}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="postdate">작성
							일자</label>
						<div class="col-sm-<%=formright%>">
							<input type="datetime" class="form-control" name="postdate"
								id="postdate" placeholder="작성 일자" value="${bean.postdate}"> <span
								class="err">${errpostdate}</span>
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
</html>l>