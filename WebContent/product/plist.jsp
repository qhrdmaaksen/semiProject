<%@page import="utility.Paging"%>
<%@page import="DAO.ProductDAO"%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="./../common/nav.jsp"%>



<!DOCTYPE html>



<html>
	<head>
<!-- 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
<!-- 	  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
	


<style type="text/css">
	.card{
		width:200px;
		height: 300px;
		background-color: skyblue;
		display: inline-block;
	}
	.imsi{
		width:250px;
		height: 400px;
		padding-top: 10px;
		padding-left: 10px;
		background-color: #AAAAFF;	
		display: inline-block;
	}
	.list{
	display: inline-block;
	}
	ul{
	display: inline-block;
	}
</style>


	<script type="text/javascript">
	
	

	</script>
</head>
<body >



<div class="panel-heading"><h4>상품 목록</h4></div>


<ul class="list">
 
	<c:forEach var="bean" items="${requestScope.lists}">
	 <li>
		<div class="imsi">
		  <div class="card" style="" >
		    <img class="card-img-top" src="./../images/logo.png" alt="Card image" style="width:100%">
		    <div class="card-body">
			 <h5 class="card-title">${bean.productname}</h5>
			 <p class="card-text">${bean.productprice}</p>
		      <a href="#" class="btn btn-primary">장바구니에 추가</a>
		    </div>
		  </div>
		 </div>
	 </li>
	</c:forEach>

<%-- ${bean.images} --%>
</ul>










</body>
</html>