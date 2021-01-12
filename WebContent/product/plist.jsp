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
</style>

<script type="text/javascript">
	
</script>

	
</head>
<body >

  <div class="container text-#8B4513 py-5 text-center">
  	<h3>Product List</h3>
  </div>

<div>

<!--Section: Block Content-->
<section>

  <!-- Grid row -->
  <div class="row">
<c:forEach var="bean" items="${requestScope.lists}">
    <!-- Grid column -->
    <div class="col-md-3 mb-3">
 
      <!-- Card -->
      <div class="">

          <a href="#!">
            <div class="mask">
            <img src="${applicationScope.uploadedPath}/${bean.images}"
										class="img-fluid w-100" width="200" height="300"
										alt="${bean.images}">
            
              <!-- <img class="img-fluid w-100"
                src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/12.jpg"> -->
              <div class="mask rgba-black-slight"></div>
            </div>
          </a>

        <div class="text-center pt-3">

          <h5>${bean.productname}</h5>
          <p class="mb-2 text-muted text-uppercase small">Shirts</p>

          <hr>
          <h6 class="mb-3">
            <span class="text-danger mr-1">
            ￦<fmt:formatNumber value="${bean.productprice}" pattern="###,###"/>
            </span>
            <span class="text-grey"><s>
            ￦<fmt:formatNumber value="${bean.productprice*1.2}" pattern="###,###"/>
            </s></span>
          </h6>
          <%-- <h6 class="mb-3">${bean.productprice}</h6> --%>
         		 <form class="form-inline" role="form" method="post" action="<%=YesForm%>">
						<div class="form-group">
							<input type="hidden" name="command" value="mallcartadd">
							<input type="hidden" name="productcode" value="${bean.productcode}">
							<input type="hidden" name="stock" value="${bean.stock}">
							<input type="hidden" name="qty" value="1">         
						</div>
						<!-- <button type="submit" class="btn btn-primary btn-sm mr-1 mb-2"><i
             			 class="fas fa-shopping-cart pr-2"></i>Add to cart</button> -->
						<button type="submit" class="btn btn-primary btn-sm mr-1 mb-2">Add to cart</button>
					</form>
			<form class="form-inline" role="form" name="myform" action="<%=YesForm%>" method="get">
				<input type="hidden" name="command" value="pdetail">
             <button type="button" class="btn btn-light btn-sm mr-1 mb-2"><i
              class="fas fa-info-circle pr-2"></i>Details</button>         
         </form>
         
    
        </div>

      </div>
      <!-- Card -->


    </div>
    <!-- Grid column -->

</c:forEach>

</div>


<br><br><br>



<table>
	<tr>
		<td colspan="12" align="center">
			<form class="form-inline" role="form" name="myform" action="<%=YesForm%>" method="get">
				<input type="hidden" name="command" value="plist">
				<div class="form-group">
					<select class="form-control" name="mode" id="mode">
						<option value="all" selected="selected">-- 선택하세요---------
						<option value="name">상품명
						<option value="company">제조회사									
						<option value="category">카테고리									
					</select>
				</div>
				<div class="form-group">
					<input type="text" class="form-control btn-xs" name="keyword"
						id="keyword" placeholder="검색 키워드">
				</div>
					<button class="btn btn-default btn-warning" type="submit" onclick="search();">검색</button>
					<button class="btn btn-default btn-warning" type="button" onclick="searchAll();">전체 검색</button>
							
				<c:if test="${whologin == 2}">
					<button class="btn btn-default btn-info" type="button"
						onclick="writeForm();">상품 등록</button>
				</c:if>
								
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<p class="form-control-static">${requestScope.pagingStatus}</p>
			</form>
		</td>
	</tr>				
</table>	
		<br><br>
					
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<div align="center">
			<footer>${requestScope.pagingHtml}</footer>
		</div>		
		



<br><br>
	<script type="text/javascript">
	   /* 방금 전 선택한 콤보 박스를 그대로 보여 주기 */ 
		$('#mode option').each(function (index){
			if( $(this).val() == '${requestScope.mode}' ){
				$(this).attr('selected', 'selected') ;
			}
		});	
		/* 이전에 넣었던 값 그대로 보존 */
		$('#keyword').val( '${requestScope.keyword}' ) ;		
	</script>	

</body>
</html>