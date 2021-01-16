<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2021-01-15
  Time: 오후 4:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <p>time : <span id="time"></span></p>
    <input type="button" id="execute" value="execute" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $('#execute').click(function(){
            $.ajax({
                url:'./time.php',
                success:function(data){
                    $('#time').append(data);
                }
            })
        })
    </script>
</body>
</html>
