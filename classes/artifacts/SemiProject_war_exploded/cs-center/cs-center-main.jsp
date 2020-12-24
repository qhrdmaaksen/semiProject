<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int twelve = 12;
	int myoffset = 2;
	int mywidth = twelve - 2 * myoffset;
	int formleft = 3;
	int formright = twelve - formleft;
	int mysearch = 2;
	//int label = 3 ; //양식의 왼쪽에 보여지는 라벨의 너비 
	//int content = twelve - label ; //우측의 내용 입력(input, select, textarea)의 너비
%>
<!DOCTYPE html>
<html>
<head>
	<title>cs-center</title>
	<meta charset="UTF-8">
	<%@ include file="../common/nav.jsp" %>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$('#mode option').each(function (index){
			if ($(this).val() == '${requestScope.mode}') {
				$(this).attr('selected','selected') ;
			}
		});
		$('#keyword').val('${requestScope.keyword}') ;
	</script>
</head>
<body>
	<div class="container">
		<ul class="nav nav-tabs">
			<li class="nav-item">
				<a id="cs-main-top" class="nav-link active" data-toggle="tab" href="#cs-main-top-notice">
					공지 사항
				</a>
			</li>
			<li class="nav-item">
				<a id="cs-main-top" class="nav-link active" data-toggle="tab" href="#cs-main-top-question">
					자주묻는 질문
				</a>
			</li>
			<li class="nav-item">
				<a id="cs-main-top" class="nav-link active" data-toggle="tab" href="#cs-main-top-nonMember">
					비회원 주문
				</a>
			</li>
			<li class="nav-item">
				<a id="cs-main-top" class="nav-link active" data-toggle="tab" href="#cs-main-top-policies">
					약관 및 방침
				</a>
			</li>
			<li class="nav-item">
				<a id="cs-main-top" class="nav-link active" data-toggle="tab" href="#cs-main-top-inquiries">
					추가 문의
				</a>
			</li>
			<li class="nav-item">
				<a id="cs-main-top" class="nav-link active" data-toggle="tab" href="#cs-main-top-contect">
					연락처
				</a>
			</li>
		</ul>
	</div>
	<div class="tab-content">
		<div class="container offset-sm-<%=myoffset%> col-sm-<%=mywidth%>">
			<div id="cs-main-top-notice" class="container tab-pane active">
				<div class="card card-default card-primary.card-inverse">
					<div class="card-title">
						<form action="" class="form-inline">
							<h2>공지 사항</h2>
						</form>
					</div>
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<td align="center">제목</td>
								<td align="right">작성 일자</td>
							</tr>
						</thead>
						<tr>
							<td colspan="2" align="center">
								<form action="<%=YesForm%>" class="form-inline" name="myform" method="get">
									<input type="hidden" name="command" value="cs-center-main">
									<div class="form-group">
										<select class="form-control" name="mode" id="mode">
											<option value="all" selected="selected">-- 선택하세요 --
											<option value="subject">제목
											<option value="content">글 내용
										</select>
									</div>
									<div class="form-group">
										<input type="text" class="form-control btn-xs" name="keyword"
											id="keyword" placeholder="검색 키워드">
									</div>
									<button class="btn btn-default btn-warning" type="submit" onclick="search();">검색</button>
									<button class="btn btn-default btn-warning" type="button" onclick="searchAll();">전체 검색</button>
									<button class="btn btn-default btn-warning" type="button"
										 onclick="writeForm();">글 쓰기</button> <!-- 운영자만 글 쓰기 가능으로 hidden처리해야함-->
										 <p class="form-control-static">${requestScope.pagingStatus}</p>
								</form>
							</td>
						</tr>
						<c:forEach var="bean" items="${requestScope.lists}">
							<tr>
								<td>
									<c:forEach var="cnt" begin="1" end="${bean.depth}">
										<span class="badge re">re</span>
									</c:forEach>
									<a href="<%=NoForm%>cs-detailView&no=${bean.no}&${requestScope.parameters}">
										${bean.subject}
									</a>
								</td>
								<td>${bean.writer}</td>
								<td>${bean.content}</td>
								<td>${bean.regdate}</td>
								<td>
									<c:if test="${sessionScope.loginfo.id == bean.writer}">
										<a href="<%=NoForm%>cs-update&no=${bean.no}&${requestScope.parameters}">
											수정
										</a>
									</c:if>
									<c:if test="${sessionScope.loginfo.id != bean.writer}">
											수정
									</c:if>
								</td>
								<td>
									<c:if test="${sessionScope.loginfo.id == bean.writer}">
										<a href="<%=NoForm %>cs-delete&no=${bean.no}&${requestScope.parameters}">
											삭제
										</a>
									</c:if>
									<c:if test="${sessionScope.loginfo.id != bean.writer}">
										삭제
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
		</div>
	</div>
</body>
</html>