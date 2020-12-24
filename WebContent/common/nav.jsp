
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!-- whologin 변수는 로그인 상태를 저장하고 있는 변수입니다. -->
<c:set var="whologin" value="0" />
<c:if test="${empty sessionScope.loginfo}">
	<!-- 로그인 하지 않은 경우 -->
	<c:set var="whologin" value="0" />
</c:if>
<c:if test="${not empty sessionScope.loginfo}">
	<c:if test="${sessionScope.loginfo.id == 'manager'}">\
		<!-- 관리자로 로그인한 경우 -->
		<c:set var="whologin" value="2" />
	</c:if>
	<c:if test="${sessionScope.loginfo.id != 'manager'}">
		<!-- 일반 사용자로 로그인한 경우 -->
		<c:set var="whologin" value="1" />
	</c:if>
</c:if>



<%!
    String YesForm = null ;
    String NoForm = null ;
    String NAME = "도담도담";
%>
<%
    String contextPath = request.getContextPath() ;
    String mappingName = "/dodamdodam"; //서블릿에 정의되어 있음

    //폼 태그에서 사용할 변수
    YesForm = contextPath + mappingName ;

    //폼이 아닌 곳에서 사용할 변수
    NoForm = contextPath + mappingName + "?command=" ;
%>

<%!
	String MakeCommand(String ... args){
		if( args.length == 0 ){
			return YesForm  ;
		}else if( args.length == 1 ){
			return YesForm + "?command=" + args[0]   ;	
		}else{
			String imsi = args[1] ;
			return YesForm + "?command=" + args[0] + "&" + imsi  ;
		}
	}

// 주소 만드는 부분
%>

<c:set var="contextPath" value="<%=contextPath%>" scope="application"/> 



<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<style type="text/css">
		.err{
			font-size : 10pt;
			color:red;
			font-weight: bolder;
			}
		
			
	</style>

</head>


<body>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <!-- Brand/logo -->
  
  <div class="navbar-header">
  <a class="navbar-brand" href="<%=contextPath%>/main.jsp">
    <img src="./../images/logo1.png" alt="logo" style="width:200px;">
  </a>
  </div>
  
  
  <ul class="navbar-nav">
    
<%--     <li class="nav-item">
    <a class="nav-link" href="<%=contextPath%>/main.jsp">Home</a></li> --%>

    <li class="nav-item">
      <a class="nav-link" href="#">
		<c:if test="${whologin == 0}">
				미로그인
			</c:if> 
				<c:if test="${whologin != 0}">
				${sessionScope.loginfo.name}(${sessionScope.loginfo.id}) 님
				</c:if>
			</font>
		</a>
    </li>
    
    
    

    
       
  	<li class="nav-item">
    <a class="nav-link" href="<%=contextPath%>/main.jsp">추천 받기</a>
    </li>
      
      
            
  	<li class="nav-item">
    <a class="nav-link" href="<%=contextPath%>/main.jsp">제품 보기</a>
    </li>
    
    
          
  	<li class="nav-item">
    <a class="nav-link" href="<%=contextPath%>/main.jsp">장바구니</a>
    </li>
    
    
           
  	<li class="nav-item">
    <a class="nav-link" href="<%=contextPath%>/main.jsp">고객포럼</a>
    </li>
    

    
        <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Dropdown</a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="#">Link 1</a>
        <a class="dropdown-item" href="#">Link 2</a>
        <a class="dropdown-item" href="#">Link 3</a></div>
    </li>
   <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">
      		회원<b class="caret"></b></a>
      <ul class="dropdown-menu">
      
	      	<li>
		      	<c:if test="${whologin == 0}">
					<a class="dropdown-item" href="<%=NoForm%>meInsert">회원 가입</a>
					</c:if> 
					<c:if test="${whologin != 0}">
						<a class="dropdown-item" href="<%=NoForm%>meUpdate&id=${sessionScope.loginfo.id}">회원 정보 수정</a>
					<a class="nav-link" href="<%=NoForm%>mypage">${sessionScope.loginfo.name}님</a>
				</c:if>
			</li>
			
			<li>
				<c:if test="${whologin == 0}">
					<a class="dropdown-item" href="<%=NoForm%>meLogin">로그인</a>
				</c:if> 
				<c:if test="${whologin != 0}">
					<a class="dropdown-item" href="<%=NoForm%>meLogout">로그 아웃</a>
				</c:if>
			</li>
			
			<li>
			<c:if test="${whologin == 1}">
				<a class="dropdown-item" href="<%=NoForm%>meDelete&id=${sessionScope.loginfo.id}">회원 탈퇴</a>
				</c:if>
			</li>
			<li>
				<c:if test="${whologin == 2}">
				<a class="dropdown-item" href="<%=NoForm%>meList">회원 목록 보기</a>
				</c:if>
			</li>
			<li>
				<c:if test="${whologin == 1}">
				<a class="dropdown-item" href="<%=NoForm%>meDetailView&id=${sessionScope.loginfo.id}">회원 상세 보기</a>
				</c:if>
			</li>

        </ul>
   </li>
    </ul>
  
  				<ul class="nav navbar-nav navbar-right">
					<li><c:if test="${empty sessionScope.loginfo}">
							<a href="<%=NoForm%>melogin"><span
								class="glyphicon glyphicon-log-in"> 로그인 </span> </a>
						</c:if> <c:if test="${not empty sessionScope.loginfo}">
							<a href="<%=NoForm%>melogout"><span
								class="glyphicon glyphicon-log-in"> 로그 아웃 </span> </a>
						</c:if></li>
				</ul>
  
  
</nav>



</body>
</html>
