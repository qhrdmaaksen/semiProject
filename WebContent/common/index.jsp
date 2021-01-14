<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2020-12-21
  Time: 오전 10:23
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="nav.jsp"%>
<html>
<head>
    <title>도담도담, 영양제 구독 사이트</title>
    <style>
        #go-survey {
            margin-top: 30px;
        }
        /* Make the image fully responsive */
        .carousel-inner img {
            width: 100%;
            height: 100%;
        }
        .gosurvey {
            margin-top: 20px;
        }
        .top4 {
            padding: 20px 200px;
        }
        .card-icon{
            float: left;
        }
        .card-icons{
            height: 65px;
        }
        .card-icon{
            width: 54px;
            height: 53px;
            border-radius: 50%;
            border: 2px solid #5a6268;
            overflow: hidden;
            margin-left: 5px;
            float: left;
        }
        .card-icon:first-child{
            margin-left: 0px;
        }
        .card-icon-img{
            width: 50px;
            height: 50px;
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
    <div class="jumbotron text-center gosurvey">
        <h1>건강 검진으로 필요한 영상소를 체크해보세요.</h1>
        <button id="go-survey" type="button" class="btn btn-primary" onclick="location.href='/dodamdodam?command=survey';">검진 시작</button>
    </div>
    <div class="container-fluid top4 text-center">
        <h3>저번달동안 가장 많이 팔린 영양제 리스트</h3>
        <div class="row">
            <c:forEach var="product" items="${requestScope.top4}">
                <div class="col-xl-3 col-lg-6 col-12">
                    <div class="card">
                        <img src="./../images/test02.png" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title text-center">${product.productname}</h5>
                            <ul class="card-icons">
                                <c:if test="${product.bloodCirculation > 0}">
                                    <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_bloodcirculation.png"></li>
                                </c:if>
                                <c:if test="${product.digestiveapparatus > 0}">
                                    <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_digestiveapparatus.png"></li>
                                </c:if>
                                <c:if test="${product.eyes > 0}">
                                    <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_eyes.png"></li>
                                </c:if>
                                <c:if test="${product.fatigue > 0}">
                                    <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_fatigue.png"></li>
                                </c:if>
                                <c:if test="${product.hair > 0}">
                                    <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_hair.png"></li>
                                </c:if>
                                <c:if test="${product.immunity > 0}">
                                    <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_immunity.png"></li>
                                </c:if>
                                <c:if test="${product.joint > 0}">
                                    <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_joint.png"></li>
                                </c:if>
                                <c:if test="${product.skin > 0}">
                                    <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_skin.png"></li>
                                </c:if>
                            </ul>
                            <a href="<%=NoForm%>pdetail&code=${product.productcode}" class="btn btn-primary stretched-link">제품 상세</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
