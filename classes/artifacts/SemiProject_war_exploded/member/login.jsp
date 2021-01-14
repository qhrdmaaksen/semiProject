<%@  page contentType="text/html;charset=UTF-8" language="java"%>
 <%@ include file="../common/nav.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <style type="text/css">
  	
	.borderclass{
		padding-top : 200px ;
		padding-bottom : 100px ;
		
	
		border: solid black;
	
	
	}
	.logo2{
  	margin-top: 70%;
  	}

  	.totallogin{
  		margin-top : 20%;
  		margin-left: 50%;
  		margin-bottom: 5%
  		
  	}
  	
  	.logo{
  	margin-bottom: 5%;
  	}
  
  	h2{
  		margin-left: 5%;
  		
  	
  	}
  	
  	
  	
  	.spanlogin{
  		font-size: 15px;
  		margin-top : 10%;
  		margin-left: 3%;
  		background-color: yellow;
  		color: black;
  		
  	}
  	
  	
  	
  	
  	.row{
  		margin-top: 80px;
  		font-size: 10px;
  		
  	}
  	
  	
  	
  	.button4 {
  background-color: white;
  color: black;
  border: 2px solid #e7e7e7;
}

 .button4:hover {background-color: #e7e7e7;}
  
  </style>
  
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
    	
        <div class="totallogin">
       
            <form class="form-horizontal" role="form" action="<%=YesForm%>" method="post" >
                <input type="hidden" name="command" value="melogin">
                <div class="borderclass ">
                    <div class="logo">
                        <h2>도담도담</h2>
                    </div>
                    <div class="form-group">
                        <div class="container-fluid">
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
        </div>
    </div>
</body>
</html>
