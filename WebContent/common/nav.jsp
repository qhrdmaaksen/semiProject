<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2020-12-21
  Time: 오전 10:29
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<link rel="stylesheet" href="./../css/bootstrap.min.css">
<script src="./../js/jquery-3.5.1.min.js"></script>
<script src="./../js/popper.min.js"></script>
<script src="./../js/bootstrap.min.js"></script>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="whologin" value="0" />
<c:if test="${empty sessionScope.loginfo}">
    <!-- 로그인 하지 않은 경우 -->
    <c:set var="whologin" value="0" />
</c:if>
<c:if test="${not empty sessionScope.loginfo}">
    <c:if test="${sessionScope.loginfo.level == '2'}">\
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
    String mappingName = "/dodamdodam"; //서블릿에 정의되어 있슴

    //폼 태그에서 사용할 변수
    YesForm = contextPath + mappingName ;

    //폼이 아닌 곳에서 사용할 변수
    NoForm = contextPath + mappingName + "?command=" ;
%>
<html>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">Navbar</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Link</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Dropdown </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
                </li>
                <li>
                    <c:if test="${whologin == '0'}">
                        <a class="nav-link" href="<%=NoForm%>melogin">로그인필요</a>
                    </c:if>
                    <c:if test="${whologin != '0'}">
                        <a class="nav-link" href="<%=NoForm%>mypage">${sessionScope.loginfo.name}님</a>
                    </c:if>
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
    </nav>
</body>
</html>
