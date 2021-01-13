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
        dl, dt, dd, ul, ol, menu, li,th {list-style: none; margin: 0px; padding: 0px; font-weight: normal;}
        #question-no {
            font-weight: bold;
            font-size: 16px;
            color: rgb(158, 158, 158);
        }
        #question-content{
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 35px;
        }
        #answer{
            height: 120px;
            margin-bottom: 30px;
        }
        #checker_div{
            width: 100%;
            height: 360px;
        }
        #radio_ul{
            height: 120px;
        }
        #checker_div{
            background-image: url("./../images/00.png");
        }
        #button{
            margin-bottom: 100px;
        }
        #button-style{
            height: 50px;
            font-size: 20px;
            font-weight: bold;
        }
        .progress{
            height: 12px;
        }
        .point{
            margin-top: 50px;
        }
        .answer1{
            width: 100%;
            height: 38px;
            padding: 6px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            box-sizing: border-box;
            margin-bottom: 5px;
            font-size: 15px;
            color: rgb(94, 94, 94);
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .radio_div{
            float: left;
            text-align: center;
            padding-left: 13%;
        }
        .radio_div:first-child{
            padding-left: 4%;
        }
        .image-checker-ul{
            width: 100%;
            height: 160px;
        }
        .image-checkered{
            width: 161px;
            height: 161px;
            float: left;
            overflow: hidden;
            border-radius: 50%;
            margin-left: 22px;
        }
        .image-checkered:first-child{
            margin-left: 0px;
        }
        .image-checker{
            width: 160px;
            height: 160px;
            border-radius: 50%;
            border: 2px solid #5a6268;
            overflow: hidden;
        }
    </style>
</head>
<body>
    <div class="container point">
        <div class="row">
            <div class="col-2"></div>
            <div class="col">
                <form id="survey-form" method="post" action="<%=YesForm%>">
                    <div class="progress">
                        <div id="survey-progress" class="progress-bar" style="width:1%"></div>
                    </div>
                    <div id="question-no"></div>
                    <div id="question-content"></div>
                    <div id="answer"></div>
                    <div id="button"></div>
                </form>
            </div>
            <div class="col-2"></div>
        </div>
    </div>
    <script>
        var num=1;
        var answer = null;
        var height = null;
        var weight = null;
        var momentum = null;
        var name = "";
        var gender = null;
        var command = '<input name="command" value="survey">';

        next0();
        function questionInput(){
            if(num==5){
                document.getElementById("question-no").innerHTML = "질문완료.";
            }else {
                document.getElementById("question-no").innerHTML = "질문 " + num;
            }
        }
        function buttonModify(){
            var tmp = null;
            if(num==4){
                tmp = '<button type="submit" onclick="complete()" id="button-style" class="btn btn-primary btn-block">설문 완료</button>'
            }else {
                tmp = '<button type="button" onclick="next' + num +'()" id="button-style" class="btn btn-primary btn-block">다음</button>'
            }
            document.getElementById("button").innerHTML = tmp;
        }
        function next0(){
            document.getElementById("question-content").innerHTML = "이름과 성별을 입력해주세요.";
            questionInput();
            console.log("test2");
            if(${empty sessionScope.loginfo}){
                answer = '<input type="text" id="name" name="name" class="answer1" placeholder="이름">';
            }else {
                answer = '<input type="text" id="name" name="name" class="answer1" value="${sessionScope.loginfo.name}" disabled>';
            }
            answer += '<ul id="radio_ul">' +
                '<li class="radio_div"><label><input type="radio" name="gender" value="male"><br>남자</label></li>' +
                '<li class="radio_div"><label><input type="radio" name="gender" value="female"><br>여자</label></li>' +
                '</ul>';
            document.getElementById("answer").innerHTML = answer;
            buttonModify();
        }
        function next1(){
            if(${empty sessionScope.loginfo}){
                name = document.getElementById("answer").firstChild.value;
            }
            var tmp = document.getElementsByName("gender");
            var result = false;
            for(var i=0 ; i<tmp.length ; i++){
                if(tmp[i].checked == true){
                    gender = tmp[i].value;
                    result = true;
                    break;
                }
            }
            if(!result){
                alert("한개 이상을 체크해야합니다.");
                return false;
            }
            num++;
            document.getElementById("question-content").innerHTML = "키와 몸무게를 입력해주세요.";
            document.getElementById("survey-progress").style.width = "25%";
            questionInput();
            answer = '<input type="text" id="height" name="height" class="answer1" placeholder="키">'
                + '<input type="text" id="weight" name="weight" class="answer1" placeholder="몸무게">';
            document.getElementById("answer").innerHTML = answer;
            buttonModify();
        }
        function next2(){
            height = document.getElementById("answer").firstChild.value;
            weight = document.getElementById("answer").lastChild.value;
            num++;
            document.getElementById("question-content").innerHTML = "평상시 운동량은 어느정도 입니까?";
            document.getElementById("survey-progress").style.width = "50%";
            questionInput();
            answer = '<ul id="radio_ul">' +
                '<li class="radio_div"><label><input type="radio" name="momentum" value="0"><br>안함</label></li>' +
                '<li class="radio_div"><label><input type="radio" name="momentum" value="1"><br>거의 안함</label></li>' +
                '<li class="radio_div"><label><input type="radio" name="momentum" value="2"><br>보통</label></li>' +
                '<li class="radio_div"><label><input type="radio" name="momentum" value="3"><br>거의 매일<br>운동함</label></li>' +
                '<li class="radio_div"><label><input type="radio" name="momentum" value="4"><br>매일 운동함</label></li>' +
                '</ul>'
            document.getElementById("answer").innerHTML = answer;
            buttonModify();
        }
        function next3(){
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
            document.getElementById("survey-progress").style.width = "75%";
            $("#answer").css("height", "680px");
            questionInput();
            answer = '<ul class="image-checker-ul">' +
                '<li id="image-checker1" class="image-checkered"><label id="image-label1" class="form-check-label image-checker"><input id="checker_input1" type="checkbox" name="answer3" class="form-check-input" style="display: none;" value="fatigue"><img id="checker_image1" src="./../images/fatigue.png" width="160px" height="160px"></label></li>' +
                '<li id="image-checker2" class="image-checkered"><label id="image-label2" class="form-check-label image-checker"><input id="checker_input2" type="checkbox" name="answer3" class="form-check-input" style="display: none;" value="eyes"><img id="checker_image2" src="./../images/eyes.png" width="145px" height="160px" style="padding-left: 8px"></label></li>' +
                '<li id="image-checker3" class="image-checkered"><label id="image-label3" class="form-check-label image-checker"><input id="checker_input3" type="checkbox" name="answer3" class="form-check-input" style="display: none;" value="digestiveapparatus"><img id="checker_image3" src="./../images/digestiveapparatus.png" width="160px" height="160px"></label></li>' +
                '<li id="image-checker4" class="image-checkered"><label id="image-label4" class="form-check-label image-checker"><input id="checker_input4" type="checkbox" name="answer3" class="form-check-input" style="display: none;" value="hair"><img id="checker_image4" src="./../images/hair.png" width="160px" height="160px"></label></li>' +
                '</ul><div id="checker_div"></div><ul class="image-checker-ul">' +
                '<li id="image-checker5" class="image-checkered"><label id="image-label5" class="form-check-label image-checker"><input id="checker_input5" type="checkbox" name="answer3" class="form-check-input" style="display: none;" value="bloodCirculation"><img id="checker_image5" src="./../images/blood.png" width="160px" height="160px"></label></li>' +
                '<li id="image-checker6" class="image-checkered"><label id="image-label6" class="form-check-label image-checker"><input id="checker_input6" type="checkbox" name="answer3" class="form-check-input" style="display: none;" value="immunity"><img id="checker_image6" src="./../images/immunity.png" width="160px" height="160px"></label></li>' +
                '<li id="image-checker7" class="image-checkered"><label id="image-label7" class="form-check-label image-checker"><input id="checker_input7" type="checkbox" name="answer3" class="form-check-input" style="display: none;" value="joint"><img id="checker_image7" src="./../images/joint.png" width="160px" height="160px"></label></li>' +
                '<li id="image-checker8" class="image-checkered"><label id="image-label8" class="form-check-label image-checker"><input id="checker_input8" type="checkbox" name="answer3" class="form-check-input" style="display: none;" value="skin"><img id="checker_image8" src="./../images/skin.png" width="160px" height="160px"></label></li>' +
                '</ul>';
            document.getElementById("answer").innerHTML = answer;
            buttonModify();
            $(document).ready(function ()
            {
                $("#checker_image1").hover(function(){
                    $("#checker_div").css("background-image","url('./../images/01.png')");
                }, function() {
                    $("#checker_div").css("background-image","url('./../images/00.png')");
                });
                $("#checker_input1").change(function () {
                    if($(this).is(":checked")){
                        $("#image-checker1").css("border","2px solid red");
                        $("#image-checker1").css("background-color","#9fcdff");
                        $("#image-label1").css("border","0px solid #5a6268");
                    }else {
                        $("#image-checker1").css("border","0px solid red");
                        $("#image-checker1").css("background-color","");
                        $("#image-label1").css("border","2px solid #5a6268");
                    }
                });
                $("#checker_image2").hover(function(){
                    $("#checker_div").css("background-image","url('./../images/02.png')");
                }, function() {
                    $("#checker_div").css("background-image","url('./../images/00.png')");
                });
                $("#checker_input2").change(function () {
                    if($(this).is(":checked")){
                        $("#image-checker2").css("border","2px solid red");
                        $("#image-checker2").css("background-color","#9fcdff");
                        $("#image-label2").css("border","0px solid #5a6268");
                    }else {
                        $("#image-checker2").css("border","0px solid red");
                        $("#image-checker2").css("background-color","");
                        $("#image-label2").css("border","2px solid #5a6268");
                    }
                });
                $("#checker_image3").hover(function(){
                    $("#checker_div").css("background-image","url('./../images/03.png')");
                }, function() {
                    $("#checker_div").css("background-image","url('./../images/00.png')");
                });
                $("#checker_input3").change(function () {
                    if($(this).is(":checked")){
                        $("#image-checker3").css("border","2px solid red");
                        $("#image-checker3").css("background-color","#9fcdff");
                        $("#image-label3").css("border","0px solid #5a6268");
                    }else {
                        $("#image-checker3").css("border","0px solid red");
                        $("#image-checker3").css("background-color","");
                        $("#image-label3").css("border","2px solid #5a6268");
                    }
                });
                $("#checker_image4").hover(function(){
                    $("#checker_div").css("background-image","url('./../images/04.png')");
                }, function() {
                    $("#checker_div").css("background-image","url('./../images/00.png')");
                });
                $("#checker_input4").change(function () {
                    if($(this).is(":checked")){
                        $("#image-checker4").css("border","2px solid red");
                        $("#image-checker4").css("background-color","#9fcdff");
                        $("#image-label4").css("border","0px solid #5a6268");
                    }else {
                        $("#image-checker4").css("border","0px solid red");
                        $("#image-checker4").css("background-color","");
                        $("#image-label4").css("border","2px solid #5a6268");
                    }
                });
                $("#checker_image5").hover(function(){
                    $("#checker_div").css("background-image","url('./../images/05.png')");
                }, function() {
                    $("#checker_div").css("background-image","url('./../images/00.png')");
                });
                $("#checker_input5").change(function () {
                    if($(this).is(":checked")){
                        $("#image-checker5").css("border","2px solid red");
                        $("#image-checker5").css("background-color","#9fcdff");
                        $("#image-label5").css("border","0px solid #5a6268");
                    }else {
                        $("#image-checker5").css("border","0px solid red");
                        $("#image-checker5").css("background-color","");
                        $("#image-label5").css("border","2px solid #5a6268");
                    }
                });
                $("#checker_image6").hover(function(){
                    $("#checker_div").css("background-image","url('./../images/06.png')");
                }, function() {
                    $("#checker_div").css("background-image","url('./../images/00.png')");
                });
                $("#checker_input6").change(function () {
                    if($(this).is(":checked")){
                        $("#image-checker6").css("border","2px solid red");
                        $("#image-checker6").css("background-color","#9fcdff");
                        $("#image-label6").css("border","0px solid #5a6268");
                    }else {
                        $("#image-checker6").css("border","0px solid red");
                        $("#image-checker6").css("background-color","");
                        $("#image-label6").css("border","2px solid #5a6268");
                    }
                });
                $("#checker_image7").hover(function(){
                    $("#checker_div").css("background-image","url('./../images/07.png')");
                }, function() {
                    $("#checker_div").css("background-image","url('./../images/00.png')");
                });
                $("#checker_input7").change(function () {
                    if($(this).is(":checked")){
                        $("#image-checker7").css("border","2px solid red");
                        $("#image-checker7").css("background-color","#9fcdff");
                        $("#image-label7").css("border","0px solid #5a6268");
                    }else {
                        $("#image-checker7").css("border","0px solid red");
                        $("#image-checker7").css("background-color","");
                        $("#image-label7").css("border","2px solid #5a6268");
                    }
                });
                $("#checker_image8").hover(function(){
                    $("#checker_div").css("background-image","url('./../images/08.png')");
                }, function() {
                    $("#checker_div").css("background-image","url('./../images/00.png')");
                });
                $("#checker_input8").change(function () {
                    if($(this).is(":checked")){
                        $("#image-checker8").css("border","2px solid red");
                        $("#image-checker8").css("background-color","#9fcdff");
                        $("#image-label8").css("border","0px solid #5a6268");
                    }else {
                        $("#image-checker8").css("border","0px solid red");
                        $("#image-checker8").css("background-color","");
                        $("#image-label8").css("border","2px solid #5a6268");
                    }
                });
            });
        }

        function complete(){
            $("#survey-form").append("<input type='text' id='name' name='name' value='" + name + "' style='display: none;'>");
            $("#survey-form").append("<input type='text' id='gender' name='gender' value='" + gender + "' style='display: none;'>");
            $("#survey-form").append("<input type='text' id='height' name='height' value='" + height + "' style='display: none;'>");
            $("#survey-form").append("<input type='text' id='weight' name='weight' value='" + weight + "' style='display: none;'>");
            $("#survey-form").append("<input type='text' id='momentum' name='momentum' value='" + momentum + "' style='display: none;'>");
            $("#survey-form").append(command);
        }
    </script>
</body>
</html>
