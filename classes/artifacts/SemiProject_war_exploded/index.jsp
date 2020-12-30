b <%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2020-12-18
  Time: 오전 10:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
</head>
<body>
<%
  String imsi = request.getContextPath() + "/dodamdodam?command=index" ;
  response.sendRedirect(imsi) ;
%>
</body>
</html>
