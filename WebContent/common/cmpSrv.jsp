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
        section{ padding: 50px; }
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
        .card-subject{
            height: 50px;
        }
        .card-icon{
            float: left;
        }
        .card-icons{
            height: 40px;
        }
        .card-icon{
            width: 34px;
            height: 33px;
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
            width: 30px;
            height: 30px;
        }
        .product-button{
            background-color: #9fcdff;
            padding: 5px 13px;
            font-size: 15px;
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
                    <p>${requestScope.name}님의 건강설문 결과표</p>
                    <p>BMI : <fmt:formatNumber value="${requestScope.weight/((requestScope.height/100)*(requestScope.height/100))}" pattern="##.##"/></p>
                    <c:choose>
                        <c:when test="${requestScope.momentum eq 0}">
                            <p>운동량 : 운동 안함</p>
                        </c:when>
                        <c:when test="${requestScope.momentum eq 1}">
                            <p>운동량 : 운동 거의 안함</p>
                        </c:when>
                        <c:when test="${requestScope.momentum eq 2}">
                            <p>운동량 : 운동량 보통</p>
                        </c:when>
                        <c:when test="${requestScope.momentum eq 3}">
                            <p>운동량 : 운동을 자주함</p>
                        </c:when>
                        <c:when test="${requestScope.momentum eq 4}">
                            <p>운동량 : 운동을 매일함</p>
                        </c:when>
                    </c:choose>
                </div>
            </div>
            <div class="col-2"></div>
        </div>
    </div>

    <div class="container text-#8B4513 py-5 text-center">
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
                <c:when test="${requestScope.symptom.get(number) eq 'bloodcirculation'}">
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
                <c:forEach var="product" items="${productList}">
                    <!-- Grid column -->
                    <div class="col-md-3 mb-3">
                        <!-- Card -->
                        <div class="">
                            <a href="#!">
                                <div class="mask">
                                    <img src="./../images/product/${product.images}" class="img-fluid w-100" width="200" height="300" alt="${product.images}">
                                    <div class="mask rgba-black-slight"></div>
                                </div>
                            </a>
                            <div class="text-center pt-3">
                                <h5 class="card-subject">${product.productname}</h5>
                                <div>
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
                                </div>
                                <hr>
                                <h6 class="mb-3">
                                    <span class="text-danger mr-1">
                                        ￦<fmt:formatNumber value="${product.productprice*0.8}" pattern="#,###"/>
                                    </span>
                                    <span class="text-grey">
                                        <s>￦<fmt:formatNumber value="${product.productprice}" pattern="#,###"/></s>
                                    </span>
                                </h6>
                                <form class="form-inline" role="form" name="myform" action="<%=YesForm%>" method="post">
                                    <input type="hidden" name="command" value="pdetail">
                                    <a href="<%=NoForm%>pdetail&productcode=${product.productcode}">
                                        <button type="button" class="btn btn-sm mr-1 mb-2 product-button">Details</button>
                                    </a>
                                </form>
                            </div>
                        </div>
                        <!-- Card -->
                    </div>
                    <!-- Grid column -->
                </c:forEach>
            </div>
        </c:forEach>
    </div>

<%--    <div class="container-fluid top4 text-center">--%>
<%--        <c:forEach var="productList" items="${requestScope.symptoms}">--%>
<%--            <div class="row">--%>
<%--                <div class="col-2"></div>--%>
<%--                <c:forEach var="product" items="${productList}">--%>
<%--                    <div class="col reco">--%>
<%--                        <div class="card recoTop4">--%>
<%--                            <img src="./../images/test02.png" class="card-img-top" alt="...">--%>
<%--                            <div class="card-body">--%>
<%--                                <h5 class="card-title text-center">${product.productname}</h5>--%>
<%--                                <ul class="card-icons">--%>
<%--                                    <c:if test="${product.bloodCirculation > 0}">--%>
<%--                                        <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_bloodcirculation.png"></li>--%>
<%--                                    </c:if>--%>
<%--                                    <c:if test="${product.digestiveapparatus > 0}">--%>
<%--                                        <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_digestiveapparatus.png"></li>--%>
<%--                                    </c:if>--%>
<%--                                    <c:if test="${product.eyes > 0}">--%>
<%--                                        <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_eyes.png"></li>--%>
<%--                                    </c:if>--%>
<%--                                    <c:if test="${product.fatigue > 0}">--%>
<%--                                        <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_fatigue.png"></li>--%>
<%--                                    </c:if>--%>
<%--                                    <c:if test="${product.hair > 0}">--%>
<%--                                        <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_hair.png"></li>--%>
<%--                                    </c:if>--%>
<%--                                    <c:if test="${product.immunity > 0}">--%>
<%--                                        <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_immunity.png"></li>--%>
<%--                                    </c:if>--%>
<%--                                    <c:if test="${product.joint > 0}">--%>
<%--                                        <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_joint.png"></li>--%>
<%--                                    </c:if>--%>
<%--                                    <c:if test="${product.skin > 0}">--%>
<%--                                        <li class="card-icon"><img class="card-icon-img" src="./../images/icon/icon_skin.png"></li>--%>
<%--                                    </c:if>--%>
<%--                                </ul>--%>
<%--                                <a href="<%=NoForm%>pdetail&code=${product.productcode}" class="btn btn-primary stretched-link">제품 상세</a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </c:forEach>--%>
<%--                <div class="col-2"></div>--%>
<%--            </div>--%>
<%--            <c:set var="number" value="${number + 1}" />--%>
<%--        </c:forEach>--%>
<%--    </div>--%>
</body>
</html>
