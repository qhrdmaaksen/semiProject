<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2021-01-15
  Time: 오후 4:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <input type="text" id="phonenum" name="phonenum" value="01045286862">
    <script>
        console.log($("#phonenum").val());
        alert($("#phonenum").val());
    </script>
</body>
</html>
