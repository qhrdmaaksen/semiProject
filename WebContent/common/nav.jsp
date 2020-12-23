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
<%!
    String YesForm = null ;
    String NoForm = null ;
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

</body>
</html>
