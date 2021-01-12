<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2020-12-22
  Time: 오후 7:34
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="nav.jsp"%>
<html>
<head>
    <title>도담도담, 당신에게 맞는 약품을 찾아봐요</title>
    <style>
        .point{
            background-color: #9fcdff;
            margin-top: 100px;
        }
    </style>
</head>
<body>
    <div class="container point">
        <div class="progress">
            <div id="survey-progress" class="progress-bar" style="width:1%"></div>
        </div>
        <form id="survey-form" method="post" action="<%=YesForm%>">
            <div id="question-no"></div>
            <div id="question-content"></div>
            <div id="answer"></div>
            <div id="button"></div>
        </form>
    </div>
    <script>
        var num=1;
        var answer = null;
        var height = null;
        var weight = null;
        var momentum = null;
        var command = '<input name="command" value="survey">';
        function questionInput(){
            if(num==4){
                document.getElementById("question-no").innerHTML = "질문완료.";
            }else {
                document.getElementById("question-no").innerHTML = "질문 " + num;
            }
        }
        function buttonModify(){
            var tmp = null;
            if(num==3){
                tmp = '<button type="button" onclick="complete()" class="btn btn-primary btn-block">설문 완료</button>'
            }else {
                tmp = '<button type="button" onclick="next' + num +'()" class="btn btn-primary btn-block">다음</button>'
            }
            document.getElementById("button").innerHTML = tmp;
        }
        function next0(){
            document.getElementById("question-content").innerHTML = "키와 몸무게를 입력해주세요.";
            questionInput();
            answer = '<input type="text" id="height" name="height" placeholder="키">'
                + '<input type="text" id="weight" name="weight" placeholder="몸무게">';
            document.getElementById("answer").innerHTML = answer;
            buttonModify();
        }
        function next1(){
            height = document.getElementById("answer").firstChild.value;
            weight = document.getElementById("answer").lastChild.value;
            num++;
            document.getElementById("question-content").innerHTML = "평상시 운동량은 어느정도 입니까?";
            document.getElementById("survey-progress").style.width = "33%";
            questionInput();
            answer = '<div><input type="radio" name="momentum" value="0">' +
                '<input type="radio" name="momentum" value="1"><input type="radio" name="momentum" value="2">' +
                '<input type="radio" name="momentum" value="3"><input type="radio" name="momentum" value="4"></div>' +
                '<div><div>거의 안함</div><div>보통</div><div>매일 운동함</div></div>'
            document.getElementById("answer").innerHTML = answer;
            buttonModify();
        }
        function next2(){
            var obj = document.getElementsByName("momentum");
            var result = false;
            for(var i=0 ; i<obj.length ; i++){
                if(obj[i].checked == true){
                    momentum = obj[i].value;
                    result = true;
                    break;
                }
            }
            if(!result){
                alert("한개 이상을 체크해야합니다.");
                return false;
            }
            num++;
            document.getElementById("question-content").innerHTML = "평상시 불편하거나 신경쓰이는 신체부위가 있으면 체크해주세요.";
            document.getElementById("survey-progress").style.width = "66%";
            questionInput();
            answer = '<div>이미지</div>';
            document.getElementById("answer").innerHTML = answer;
            buttonModify();
        }

        function complete(){
            console.log(height);
            console.log(weight);
            console.log(momentum);
            $("#survey-form").append(height);
            $("#survey-form").append(weight);
            $("#survey-form").append(momentum);
            $("#survey-form").append(command);
            // location.href='http://localhost:8999/common/cmpSrv.jsp';
        }

        next0();
        buttonModify();
        questionInput();
    </script>
</body>
</html>
