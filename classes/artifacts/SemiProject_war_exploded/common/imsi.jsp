<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2020-12-29
  Time: 오후 6:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="nav.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form class="form-horizontal" role="form" action="<%=YesForm%>" method="post" >
        <input type="hidden" name="command" value="sss">
        <div class="borderclass ">
            <div class="logo">
                <h2>도담도담</h2>
            </div>
            <div class="form-group">
                <div class="container-fluid">
                    <input type="date" name="birth" id="birth">
                    <div class="col-sm-8" >
                        <input type="text" class="form-control" name="id" id="id"
                               data-toggle="tooltip" data-placement="top"
                               title="아이디,이메일,전화번호"
                               placeholder="아이디,이메일,전화번호를 입력하세요." value="${requestScope.id}">
                        <span class="err">${errid}</span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="container-fluid">
                    <div class="col-sm-8">
                        <input type="password" class="form-control" name="password"
                               id="password" placeholder="비밀번호를 입력하세요" value="${requestScope.password}">
                        <span class="err">${errpassword}</span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div align="center" class="col-sm-offset-3 col-sm-3">
                    <button class="btn btn-default" type="submit">로그인</button>
                </div>
            </div>
            <div class="container-fluid">
                <div class="row" >
                    <div class="col-sm-3" >
                        <button class="button button4">회원가입</button>
                    </div>
                    <div class="col-sm-3"> </div>
                    <div class="col-sm-3" >
                        <button class="button button4">아이디찾기</button>
                    </div>
                    <div class="col-sm-3" >
                        <button class="button button4">비밀번호찾기</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
