<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  		font-size: 20px;
  		margin-top : 10%;
  		margin-left: 7%;
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
  <form action="/action_page.php" class="totallogin">

	<div class="borderclass ">
	<div class="logo">
  	 <h2>도담도담</h2>
  	 </div>
    <div class="form-group">
    <div class="container-fluid">
    <div class="col-sm-8" >
      <input type="email" class="form-control" id="아이디" placeholder="아이디,이메일,전화번호" name="id">
     </div>
    </div>
    </div>
    <div class="form-group">
    <div class="container-fluid">
    <div class="col-sm-8">
      <input type="password" class="form-control" id="비밀번호" placeholder="비밀번호를 입력하세요" name="password">
      </div>
    </div>
    </div>
    <div class="spanlogin">
     <button type="button" class="btn btn-warning" >로그인</button>
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

</body>
</html>