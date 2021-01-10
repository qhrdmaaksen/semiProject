<%@page import="utility.Paging"%>
<%@page import="DAO.ProductDAO"%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="./../common/nav.jsp"%>



<!DOCTYPE html>



<html>
	<head>

<style type="text/css">


</style>


	<script type="text/javascript">
	
	

	</script>

	
</head>
<body >



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
              <img class="img-fluid w-100"
                src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/12.jpg">
              <div class="mask rgba-black-slight"></div>
            </div>
          </a>

        <div class="text-center pt-3">

          <h5>${bean.productname}</h5>
          <p class="mb-2 text-muted text-uppercase small">Shirts</p>

          <hr>
          <h6 class="mb-3">
            <span class="text-danger mr-1">￦${bean.productprice}</span>
            <span class="text-grey"><s>￦${bean.productprice*1.2}</s></span>
          </h6>
          <%-- <h6 class="mb-3">${bean.productprice}</h6> --%>
          <button type="button" class="btn btn-primary btn-sm mr-1 mb-2"><i
              class="fas fa-shopping-cart pr-2"></i>Add to cart</button>
          <button type="button" class="btn btn-light btn-sm mr-1 mb-2"><i
              class="fas fa-info-circle pr-2"></i>Details</button>
    
        </div>

      </div>
      <!-- Card -->


    </div>
    <!-- Grid column -->

</c:forEach>



<!-- src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/12.jpg" -->





</body>
</html>