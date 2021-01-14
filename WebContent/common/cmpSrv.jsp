<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2021-01-13
  Time: 오후 4:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="nav.jsp"%>
<c:set var="number" value="0" />
<html>
<head>
    <title>도담도담, ${requestScope.name}님에게 맞는 약품입니다</title>
    <style>
        dl, dt, dd, ul, ol, menu, li,th {list-style: none; margin: 0px; padding: 0px; font-weight: normal;}
        #cmpSrv{
            margin-bottom: 30px;
        }
        #question-content{
            font-size: 20px;
            font-weight: bold;
            margin: 20px 0px;
        }
        .progress{
            height: 12px;
        }
        .point{
            margin-top: 50px;
        }
        .reco{
            padding: 0px 5px;
        }
        .recoTop4{
            height: 470px;
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
    <div class="container point">
        <div class="row">
            <div class="col-2"></div>
            <div class="col">
                <div class="progress">
                    <div id="survey-progress" class="progress-bar" style="width:100%"></div>
                </div>
                <div id="question-content">답변 완료</div>
                <div id="cmpSrv">
                    이름 : ${requestScope.name}<br>
                    성별 : ${requestScope.gender}<br>
                    키 : ${requestScope.height}<br>
                    몸무게 : ${requestScope.weight}<br>
                    운동량 : ${requestScope.momentum}<br>
                </div>
            </div>
            <div class="col-2"></div>
        </div>
    </div>
    <div class="container-fluid top4 text-center">
        <c:forEach var="productList" items="${requestScope.symptoms}">
            <c:choose>
                <c:when test="${requestScope.symptom.get(number) eq 'fatigue'}">
                    <h3>피로에 좋은 영양제</h3>
                </c:when>
                <c:when test="${requestScope.symptom.get(number) eq 'eyes'}">
                    <h3>눈에 좋은 영양제</h3>
                </c:when>
                <c:when test="${requestScope.symptom.get(number) eq 'digestiveapparatus'}">
                    <h3>소화기관에 좋은 영양제</h3>
                </c:when>
                <c:when test="${requestScope.symptom.get(number) eq 'hair'}">
                    <h3>모발에 좋은 영양제</h3>
                </c:when>
                <c:when test="${requestScope.symptom.get(number) eq 'bloodCirculation'}">
                    <h3>혈액순환에 좋은 영양제</h3>
                </c:when>
                <c:when test="${requestScope.symptom.get(number) eq 'immunity'}">
                    <h3>면역력에 좋은 영양제</h3>
                </c:when>
                <c:when test="${requestScope.symptom.get(number) eq 'joint'}">
                    <h3>관절에 좋은 영양제</h3>
                </c:when>
                <c:when test="${requestScope.symptom.get(number) eq 'skin'}">
                    <h3>피부에 좋은 영양제</h3>
                </c:when>
            </c:choose>
            <div class="row">
                <div class="col-2"></div>
                <c:forEach var="product" items="${productList}">
                    <div class="col reco">
                        <div class="card recoTop4">
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
                <div class="col-2"></div>
            </div>
            <c:set var="number" value="${number + 1}" />
        </c:forEach>
    </div>
</body>
</html>
