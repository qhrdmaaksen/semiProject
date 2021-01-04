<!DOCTYPE html>
<html>

<!-- <script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript" src="jquery.validate.js"></script> -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="./../common/nav.jsp"%>

<script type="text/javascript">
		
</script>

<style type="text/css">

	</style>

<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  

</head>
<body>

<div class="container">
  <h2>도담도담 회원 정보 수정</h2>
 <!--  <form action="/action_page.php" class="was-validated"> class="form-horizontal"-->
  
	<form class="was-validated" role="form" name="myform" action="<%=YesForm%>"  method="post">
					<input type="hidden" name="command" value="memodify">					
					 <input type="hidden" name="isCheck" value="false"> 
  
    <div class="form-group">
      <label for="id">UserID:</label>
      <input type="text" class="form-control" id="id" placeholder="아이디" name="id" value="${requestScope.bean.id}"
				onkeyup="isCheckFalse();" required>
		<input type="hidden" name="id" id="id" value="${requestScope.bean.id}" >
				
	
    </div>
    
    <div class="form-group">
      <label for="password">Password:</label>
     	
     	<input type="password" name="password" id="password"
			class="form-control" placeholder="비밀 번호"
			value="" required>
		<div class="valid-feedback">영문/숫자 포함 6자리 이상이어야 합니다.(최대 15자) </div> 
		 
		 <div class="invalid-feedback"><span class="err">${errpassword}</span></div>
			    </div>

	<div class="form-group">
		<input type="password" name="password2" id="password2"
			class="form-control" placeholder="비밀 번호 확인" 
			value="" required>
		<div class="valid-feedback">상기 비밀번호와 동일하게 작성 해 주세요. </div> 
		 <div class="invalid-feedback">비밀번호를 작성 해 주세요.</div>
		 <!-- onkeyup="checkpw();" -->
    </div>
    
    <div class="form-group">
      <label for="name">UserName:</label>
      <input type="text" class="form-control" id="name" placeholder="이름" name="name" required>
      		<span class="err">${errname}</span>
			<div class="valid-feedback">형식 예시 : 홍길동</div> 
			  <div class="invalid-feedback">성함을 작성 해 주세요</div>
    </div>
    
    
    <div class="form-group">
      <label for="birth">UserBirthday:</label>
      <input type="date" name="birth" id="birth"
			class="form-control datepicker" placeholder="생년월일" value="" required>
			<span class="err">${errbirth}</span>
			<div class="valid-feedback">형식 예시 : 1900-01-01</div> 
			  <div class="invalid-feedback">생일을 작성 해 주세요</div>
    </div>
    
    
    <div class="form-group">
      <label for="phone">UserHphone:</label>
      <input type="number" class="form-control" id="phone" placeholder="휴대폰 번호" name="phone" required>
			<span class="err">${errphone}</span>
			<div class="valid-feedback">형식 예시 : 01012345678</div> 
			  <div class="invalid-feedback">휴대폰 번호를 작성 해 주세요</div>
    </div>

    
       
   <div class="form-group">
		<button type="submit" class="btn btn-outline-warning btn-lg" onclick="return checkForm();">
		<b>회원 정보 수정</b></button>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="reset"  class="btn btn-outline-danger btn-sm">취소</button>
	</div>
    
    
    
  </form>
</div>

   
</body>
</html>