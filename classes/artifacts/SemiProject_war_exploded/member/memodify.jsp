<!DOCTYPE html>
<html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="mypage.jsp"%>
<script type="text/javascript">
		
</script>

<style type="text/css">

	</style>

<head>

  

</head>
<body >

<br><br>
<div class="container">
  <h3>도담도담 회원 정보 수정</h3>
  
	<form class="was-validated" role="form" name="myform" action="<%=YesForm%>"  method="post">
					<input type="hidden" name="command" value="memodify">					
  
    <div class="form-group">
      <label for="id">UserID:</label>
				<input type="text" name="fakeid" id="fakeid" class="form-control" 
	            				placeholder="아이디" disabled="disabled" value="${requestScope.bean.id}" > 
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
</div>
</div>
   
</body>
</html>