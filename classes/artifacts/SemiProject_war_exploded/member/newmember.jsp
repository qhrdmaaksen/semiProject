<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> --%>
<%@  page contentType="text/html;charset=UTF-8" language="java"%>
 <%@ include file="../common/nav.jsp"%>
    
<!DOCTYPE html>
<html>
<script type="text/javascript">
		function checkDuplicateId(  ){
			var id = document.myform.id.value ;
			if( id.length == 0 ){
				alert('아이디를 입력해 주세요') ;
				document.myform.id.focus() ; 
				return false ;
			}
			var url='<%=NoForm%>idcheck&id=' + id ; 
			window.open(url, 'mywin', 'height=150,width=300') ;
		}
				
	function isCheckFalse() {
		document.myform.isCheck.value = true;
	}
	function checkForm() {
		var isCheck = document.myform.isCheck.value;
		//alert( isCheck ) ;
		if (isCheck == 'false') {
			alert('아이디 중복 체크를 우선 해주세용.');
			return false;
		}
	}
	function checkpw(){
		var pw1 = document.myform.password.value ;
		var pw2 = document.myform.password2.value ;
		if (pw1 != pw2) {
			alert('비밀번호가 일치하지 않습니다.') ;
			document.myform.password2.focus() ; 
			return false ;
		}
	}
</script>

<head>

  

</head>
<body>

<div class="container">
  <h2>도담도담 회원 가입</h2>
 <!--  <form action="/action_page.php" class="was-validated"> class="form-horizontal"-->
  
  <form id="myform" name="myform" class="was-validated" role="form"
					action="<%=YesForm%>" method="post">
					<input type="hidden" name="command" value="newmember">
					 <input type="hidden" name="isCheck" value="false">
					 <input type="hidden" name="point" value="10">
					 <input type="hidden" name="level" value="1">
					 <input type="hidden" name="picture" value="logo.png">
  
    <div class="form-group">
      <label for="id">UserID:</label>
      <input type="text" class="form-control" id="id" placeholder="아이디" name="id" value="${requestScope.bean.id}"
				onkeyup="isCheckFalse();" required>
	  <span class="err" id="spanid">${errid}</span>
      <div class="valid-feedback">아이디 중복 검사를 해 주세요<span class="err" id="spanid">${errid}</span></div>
      <div class="invalid-feedback">아이디를 4자 이상 12자 이하로 작성 해 주세요</div>
      
      <button type="button" class="btn btn-outline-info btn-sm" value="중복 검사"
								onclick="checkDuplicateId();">아이디 중복 검사</button>
    </div>
    
    <div class="form-group">
      <label for="password">Password:</label>
     	
     	<input type="password" name="password" id="password"
			class="form-control" placeholder="비밀 번호"
			value="" required>
		<span class="err">${errpassword}</span>	
		<div class="valid-feedback">영문/숫자 포함 6자리 이상이어야 합니다.(최대 15자) </div> 
		 <div class="invalid-feedback">비밀번호를 작성 해 주세요.</div>
			    </div>

	<div class="form-group">
		<input type="password" name="password2" id="password2"
			class="form-control" placeholder="비밀 번호 확인" 
			value="" required>

		<div class="valid-feedback">상기 비밀번호와 동일하게 작성 해 주세요. </div> 
		 <div class="invalid-feedback"><span class="err">${errpassword2}</span></div>
		 
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

    
    <div class="form-group form-check">
      <label class="form-check-label">
        <input class="form-check-input" type="checkbox" name="remember" required>
        도담도담의 이용약관, 개인정보 수집 및 이용(필수)에 동의합니다.
        <div class="valid-feedback">Valid.</div>
        <div class="invalid-feedback">Check this checkbox to continue.</div>
      </label>
    </div>
    
   <div class="form-group">
		<button type="submit" class="btn btn-warning btn-block" onclick="return checkForm();">
		<b>회원 가입</b>
		</button>
	</div>
    
    
    
  </form>
</div>

   
</body>
</html>