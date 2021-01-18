<%--
  Created by Eclipse.
  User: 권연경
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- whologin 변수는 로그인 상태를 저장하고 있는 변수입니다. -->
<c:set var="whologin" value="0" />
<c:if test="${empty sessionScope.loginfo}">
	<!-- 로그인 하지 않은 경우 -->
	<c:set var="whologin" value="0" />
</c:if>
<c:if test="${not empty sessionScope.loginfo}">
	<c:if test="${sessionScope.loginfo.level == '2'}">
		<!-- 관리자로 로그인한 경우 -->
		<c:set var="whologin" value="2" />
	</c:if>
	<c:if test="${sessionScope.loginfo.level == '1'}">
		<!-- 일반 사용자로 로그인한 경우 -->
		<c:set var="whologin" value="1" />
	</c:if>
</c:if>
<%!
    String YesForm = null ;
    String NoForm = null ;
    String NAME = "도담도담";
%>
<%
    String contextPath = request.getContextPath() ;
    String mappingName = "/dodamdodam"; //서블릿에 정의되어 있음

    //폼 태그에서 사용할 변수
    YesForm = contextPath + mappingName ;

    //폼이 아닌 곳에서 사용할 변수
    NoForm = contextPath + mappingName + "?command=" ;
%>
<%!
	String MakeCommand(String ... args){
		if( args.length == 0 ){
			return YesForm  ;
		}else if( args.length == 1 ){
			return YesForm + "?command=" + args[0]   ;	
		}else{
			String imsi = args[1] ;
			return YesForm + "?command=" + args[0] + "&" + imsi  ;
		}
	}
%>
<c:set var="contextPath" value="<%=contextPath%>" scope="application"/>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.kr.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<%--아이콘 지정 따로 해주면 삭제해도됨--%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?after" type="text/css">
	
	<style type="text/css">
	body {
	  background: #eecda3;
	  background: -webkit-linear-gradient(to bottom, #FAEBD7, #DEB887);
	  background: linear-gradient(to bottom, #FAEBD7, #DEB887);
	  min-height: 100vh;
	}
	
	</style>
</head>
<body>
	<nav id="nav" class="navbar navbar-expand-sm bg-warning navbar-dark">
		<!-- Brand/logo -->
		<div class="navbar-header">
			<a class="navbar-brand" href="<%=NoForm%>index">
				<img src="${pageContext.request.contextPath}/images/logosize.png" alt="logo" style="width:200px;">
			</a>
		</div>
		<ul id="nav_ul" class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link" href="<%=NoForm%>survey">추천 받기</a>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link" href="<%=NoForm%>plist">상품 보기</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<%=NoForm%>mallcartlist">장바구니</a>
			</li>
			<c:if test="${whologin != 0}">
				<li class="nav-item">
					<a class="nav-link" href="<%=NoForm%>boList">고객포럼</a>
				</li>
			</c:if>
			<li class="nav-item dropdown">
				<c:if test="${whologin == 0}">
					<ul class="nav justify-content-end">
						<li class="nav-item">
							<a class="nav-link" href="<%=NoForm%>melogin">로그인</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="<%=NoForm%>newmember">회원 가입</a>
						</li>
				</c:if>
				<c:if test="${whologin != 0}">
					<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">${sessionScope.loginfo.name}님<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li>
							<a class="dropdown-item" href="<%=NoForm%>point">마이 페이지</a>
						</li>
						<li>
							<a class="dropdown-item" href="<%=NoForm%>melogout">로그 아웃</a>
						</li>
				</c:if>
				<c:if test="${whologin == 1}">
					<li>
						<a class="dropdown-item text-danger" href="<%=NoForm%>medelete&id=${sessionScope.loginfo.id}">회원 탈퇴</a>
					</li>
				</c:if>
				</ul>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<%=NoForm%>cs_center_main">고객센터</a>
			</li>
		</ul>
	</nav>
	<c:if test="${not empty requestScope.errmsg}">
		<div class="alert alert-danger alert-dismissable">
			<a href="#" id="myalert" class="close" data-dismiss="alert" aria-label="close">닫기</a>
			<strong>${requestScope.errmsg}</strong>
		</div>
	</c:if>
	<c:if test="${not empty sessionScope.message}">
		<script type="text/javascript">
			alert('${sessionScope.message}') ;
		</script>
		<% session.removeAttribute("message") ; %>
	</c:if>

</body>
</html>