<%@page import="utility.Paging"%>
<%@page import="DAO.ProductDAO"%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="./../common/nav.jsp"%>


<!DOCTYPE html>

<html>
	<head>

<style type="text/css">
	body {
	  background: #eecda3;
	  background: -webkit-linear-gradient(to bottom, #FAEBD7, #DEB887);
	  background: linear-gradient(to bottom, #FAEBD7, #DEB887);
	  min-height: 100vh;
	}
	section{
	padding-left: 130px;
	padding-right: 50px;
	}
	table {
	padding-left: 120px;
	align-content: center;
}
	
</style>

	<script type="text/javascript">


	</script>

	
</head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<body >


<div class="w3-sidebar w3-bar-block w3-yellow w3-xxlarge" style="width:70px; align-content: center;">

	
	<div class="container">
 		<a href="<%=NoForm%>pcategorylist&mode=eyes&${requestScope.parameters}"> 
					<img src="${pageContext.request.contextPath}/images/icon/icon_eyes.png" style="width: 42px;">
						</a>
		</div>	
	<div class="container">
 		<a href="<%=NoForm%>pcategorylist&mode=bloodcirculation&${requestScope.parameters}"> 
					<img src="${pageContext.request.contextPath}/images/icon/icon_bloodcirculation.png" style="width: 42px;">
						</a>
		</div>	
	<div class="container">						 
		 <a href="<%=NoForm%>pcategorylist&mode=digestiveapparatus&${requestScope.parameters}"> 
					<img src="${pageContext.request.contextPath}/images/icon/icon_digestiveapparatus.png" style="width: 42px;">
						</a> 
		</div>	
	<div class="container">												
 		<a href="<%=NoForm%>pcategorylist&mode=skin&${requestScope.parameters}"> 
					<img src="${pageContext.request.contextPath}/images/icon/icon_skin.png" style="width: 42px;">
						</a>
		</div>	
	<div class="container">						
 		<a href="<%=NoForm%>pcategorylist&mode=fatigue&${requestScope.parameters}"> 
					<img src="${pageContext.request.contextPath}/images/icon/icon_fatigue.png" style="width: 42px;">
						</a>
		</div>	
	<div class="container">						 				
 		<a href="<%=NoForm%>pcategorylist&mode=joint&${requestScope.parameters}"> 
					<img src="${pageContext.request.contextPath}/images/icon/icon_joint.png" style="width: 42px;">
						</a>
		</div>	
	<div class="container">								
 		<a href="<%=NoForm%>pcategorylist&mode=hair&${requestScope.parameters}"> 
					<img src="${pageContext.request.contextPath}/images/icon/icon_hair.png" style="width: 42px;">
						</a> 
		</div>	
	<div class="container">														
 		<a href="<%=NoForm%>pcategorylist&mode=immunity&${requestScope.parameters}"> 
					<img src="${pageContext.request.contextPath}/images/icon/icon_immunity.png" style="width: 42px;">
						</a> 
		</div>		
	<c:if test="${whologin == 2}">
		<div class="container" style="margin-top:20px;">														
	 		<a href="<%=NoForm%>pnewproduct"> 
						<img src="${pageContext.request.contextPath}/images/icon/icon_barcode.png" style="width: 42px;">
							</a> 
			</div>	
	</c:if>																								
  </div>	


  <div class="container text-#8B4513 py-5 text-center">
  	<h3>Product List</h3>
  </div>


<!--Section: Block Content-->
<section>

  <!-- Grid row -->
  <div class="row">
		<c:forEach var="bean" items="${requestScope.lists}">
		    <!-- Grid column -->
		    <div class="col-md-3 mb-3">
		      <!-- Card -->
		      <div class="">
           		 <div class="mask">
            		<a href="<%=NoForm%>pdetail&productcode=${bean.productcode}&${requestScope.parameters}">		  	
            		<img src="${pageContext.request.contextPath}/images/product/${bean.images}"
										class="img-fluid w-100" width="200" height="300"
										alt="${bean.images}" >
		         	 </a> 
		          </div> 
		        <div class="text-center pt-3">
		        <form class="form-inline" role="form" name="myform" action="<%=YesForm%>" method="post">
					  <input type="hidden" name="command" value="pdetail">
						<a href="<%=NoForm%>pdetail&productcode=${bean.productcode}&${requestScope.parameters}">
							<h5>${bean.productname}</h5> 		
						</a>
		       		  </form>
		          <hr>
		        <h6 class="mb-3">
		            <span class="text-danger mr-1">
		            ￦<fmt:formatNumber value="${bean.productprice*0.8}" pattern="###,###"/>
		            </span>
		            <span class="text-grey"><s>
		            ￦<fmt:formatNumber value="${bean.productprice}" pattern="###,###"/>
		            </s></span>
		          </h6>
		          <div>
		          	<div>
		         		 <form class="form-inline" role="form" method="post" action="<%=YesForm%>">
									<input type="hidden" name="command" value="mallcartadd">
									<input type="hidden" name="productcode" value="${bean.productcode}">
									<input type="hidden" name="stock" value="${bean.stock}">
									<input type="hidden" name="qty" value="1">         
								<button type="submit" class="btn btn-outline-info btn-sm mr-1 mb-2">장바구니에 추가하기</button>
							</form>
					</div>
					<div>		
							<form class="form-inline" role="form" name="myform" action="<%=YesForm%>" method="post">
									<input type="hidden" name="command" value="mallcartadd">
									<input type="hidden" name="productcode" value="${bean.productcode}">
									<input type="hidden" name="stock" value="${bean.stock}">
									<input type="hidden" name="months" value="1">
								<button type="submit" class="btn btn-outline-info btn-sm mr-1 mb-2" >정기 구매 신청하기</button>
		       		  		</form>
		       		 </div>
					<div> 		
		       		  	<c:if test="${whologin == 2}">
							<a href="<%=NoForm%>pdelete&productcode=${bean.productcode}&${requestScope.parameters}">		
								<button type="submit" class="btn btn-outline-danger btn-sm">상품 삭제 하기</button>
		       		  		</a>
		       		  	</c:if>
		       		  </div>
					</div>		
		        </div>
		      </div>
		    <!-- Card -->
		   </div>
		  <!-- Grid column -->
	</c:forEach>	
</div>

	<table>
		<tr>
			<td colspan="12" align="center">
				<form class="form-inline" role="form" name="myform" action="<%=YesForm%>" method="get">
				<input type="hidden" name="command" value="plist">
					<div class="form-group">
						<input type="text" class="form-control btn-xs" name="keyword"
							id="keyword" placeholder="검색 키워드">
					</div>
				<button class="btn btn-default btn-warning" type="submit" onclick="search();">검색</button>
				<p class="form-control-static">${requestScope.pagingStatus}</p>
				</form>
			</td>
		</tr>
		<tr>
			<td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<div align="center">
					<footer>${requestScope.pagingHtml}</footer>
				</div>		
			</td>	
		</tr>				
	</table>	
</section>
<br><br>

</body>
</html>