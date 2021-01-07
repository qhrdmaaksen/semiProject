<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2021-01-07
  Time: 오후 6:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script>
        function addIngredient(){
            var p = document.createElement("p");
            p.innerHTML = document.getElementById("add_bar").value;
            document.getElementById("ingredient_list").appendChild(p);
            document.getElementById("add_bar").textContent="";
        }
    </script>
</head>
<body>
    <div id="ingredient">
        <h1>재료 관리</h1>

        <p>
            <input type="text" id="add_bar" size="35px;">
            <button onclick="addIngredient();">추가</button>
        </p>

        <div id="ingredient_list">
            <p>양배추</p>
            <p>대추</p>
        </div>

        <div id="save_area">
            <input type="submit" id="save_ingredient" value="저장">
        </div>
    </div>
</body>
</html>
