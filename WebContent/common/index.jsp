<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2020-12-21
  Time: 오전 10:23
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="./../common/nav.jsp"%>
<html>
<head>
    <title>도담도담, 보충제 구독 사이트</title>
    <style>
        /* Make the image fully responsive */
        .carousel-inner img {
            width: 100%;
            height: 100%;
        }
        #go-survey {
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <!-- 이 구역은 Carousel 영역 -->
    <div id="demo2" class="carousel slide" data-ride="carousel">

        <!-- Indicators -->
        <ul class="carousel-indicators">
            <li data-target="#demo2" data-slide-to="0" class="active"></li>
            <li data-target="#demo2" data-slide-to="1"></li>
            <li data-target="#demo2" data-slide-to="2"></li>
        </ul>

        <!-- The slideshow -->
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://www.w3schools.com/bootstrap4/la.jpg" alt="test01" width="1100" height="500">
                <div class="carousel-caption">
                    <h3>테스트 이미지1</h3>
                    <p>테스트중임</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://www.w3schools.com/bootstrap4/chicago.jpg" alt="test02" width="1100" height="500">
                <div class="carousel-caption">
                    <h3>테스트 이미지2</h3>
                    <p>테스트를 하고있음</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://www.w3schools.com/bootstrap4/ny.jpg" alt="test03" width="1100" height="500">
                <div class="carousel-caption">
                    <h3>테스트 이미지3</h3>
                    <p>토스트?</p>
                </div>
            </div>
        </div>

        <!-- Left and right controls -->
        <a class="carousel-control-prev" href="#demo2" data-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <a class="carousel-control-next" href="#demo2" data-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>

    </div>
    <div class="jumbotron text-center">
        <h1>건강 검진으로 필요한 영상소를 체크해보세요.</h1>
        <button id="go-survey" type="button" class="btn btn-primary" onclick="location.href='/dodamdodma?command=survey';">검진 시작</button>
    </div>
</body>
</html>
