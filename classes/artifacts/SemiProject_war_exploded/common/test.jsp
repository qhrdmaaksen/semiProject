<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2021-01-07
  Time: 오후 6:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        article img{
            width: 180px;
            height: 180px;
        }

        .title{
            font-size: 20px;
            font-weight: bold;
        }

        .writer{
            font-size: 13px;
            color:grey;
            font-style: italic;
        }

        .image, .information{
            display: inline-block;
        }
        section, article{
            display: inline-block;
        }

        aside div img{
            position: absolute;
            right: 0;
            top: 0;
            width: 200px;
            height: 400px;
            margin-left: 50px;
            display: inline-block;
        }
    </style>
</head>
<body>
    <section>
        <article>
            <div class="image">
                <img src="음식1.png" alt="음식1">
            </div>
            <div class="information">
                <span class="title">굴 떡국</span>&nbsp;&nbsp;<span class="writer">by. 내공얌얌</span>
                <span class="ingredients">굴, 멸치육수, 부추, 파, 다진마늘, 국간장, 소금</span>
            </div>
        </article>
        <br>
        <article>
            <div class="image">
                <img src="음식2.png" alt="음식2">
            </div>
            <div class="information">
                <span class="title">굴 떡국</span>&nbsp;&nbsp;<span class="writer">by. 내공얌얌</span>
                <span class="ingredients">굴, 멸치육수, 부추, 파, 다진마늘, 국간장, 소금</span>
            </div>
        </article>
    </section>

    <aside>
        <div id="advertising_long">
            <img src="광고1.png" alt="광고">
        </div>
    </aside>
</body>
</html>
