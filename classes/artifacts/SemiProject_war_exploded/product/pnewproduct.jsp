<%@page import="utility.Paging"%>
<%@page import="DAO.ProductDAO"%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="./../common/nav.jsp"%>
<%
	int myoffset = 2;
	int mywidth = 12 - 2 * myoffset;
	int formleft = 3 ;
	int formright = 12 - formleft ; 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BootStrap Sample</title>
	<style type="text/css">
		.form-group{ margin-bottom : 3px; }
	</style>
</head>
<body>
	<div class="container col-sm-offset-<%=myoffset%> col-sm-<%=mywidth%>">
		<div class="panel panel-default panel-primary">
		  <div class="container text-#8B4513 py-5 text-center">
  				<h3>상품 등록 페이지</h3>
  			</div>
			<div class="panel-body">
				<form class="form-horizontal" role="form" action="<%=YesForm%>" 
					method="post" enctype="multipart/form-data">
					<input type="hidden" name="command" value="pnewproduct"> 
					
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="productname">상품명</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="productname" id="productname"								
								placeholder="상품명을 입력 해 주세요" value="${bean.productname}">
								<span class="err form-control-static">${errproductname}</span>
						</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="productprice">상품 가격</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="productprice" id="productprice"								
								placeholder="상품 가격을 입력 해 주세요" value="${bean.productprice}">
								<span class="err form-control-static">${errproductprice}</span>
						</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="stock">재고</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="stock" id="stock"								
								placeholder="재고는 10개 이상 입력 해 주세요" value="${bean.stock}">
								<span class="err form-control-static">${errstock}</span>
						</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="bloodcirculation">혈액 순환 지수</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="bloodcirculation" id="bloodcirculation"								
								placeholder="혈액순환 정도를 한자리 정수로 입력 해 주세요" value="${bean.bloodcirculation}">
								<span class="err form-control-static">${errbloodcirculation}</span>
						</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="digestiveapparatus">소화 기관 지수</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="digestiveapparatus" id="digestiveapparatus"								
								placeholder="소화 기관 지수를 한자리 정수로 입력 해 주세요" value="${bean.digestiveapparatus}">
								<span class="err form-control-static">${errdigestiveapparatus}</span>
						</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="skin">피부 관련 지수</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="skin" id="skin"								
								placeholder="피부 관련 지수를 한자리 정수로 입력 해 주세요" value="${bean.name}">
								<span class="err form-control-static">${errskin}</span>
						</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="eyes">눈 관련 지수</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="eyes" id="eyes"								
								placeholder="눈 관련 지수를 한자리 정수로 입력 해 주세요" value="${bean.eyes}">
								<span class="err form-control-static">${erreyes}</span>
						</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="fatigue">피로에 좋은 정도</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="fatigue" id="fatigue"								
								placeholder="피로에 좋은 정도를 한자리 정수로 입력 해 주세요" value="${bean.fatigue}">
								<span class="err form-control-static">${errfatigue}</span>
						</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="joint">관절에 좋은 정도</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="joint" id="joint"								
								placeholder="관절에 좋은 정도를 한자리 정수로 입력 해 주세요" value="${bean.joint}">
								<span class="err form-control-static">${errjoint}</span>
						</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="hair">머리에 좋은 지수</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="hair" id="hair"								
								placeholder="머리에 좋은 지수를 한자리 정수로 입력 해 주세요" value="${bean.hair}">
								<span class="err form-control-static">${errhair}</span>
						</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="immunity">면역력 지수</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="immunity" id="immunity"								
								placeholder="면역력 지수를 한자리 정수로 입력 해 주세요" value="${bean.immunity}">
								<span class="err form-control-static">${errimmunity}</span>
						</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="images">상품 이미지</label>
						<div class="col-sm-<%=formright%>">
							<input type="file" class="form-control" name="images"
								id="images" placeholder="이미지를 등록 해 주세요">
							<span class="err form-control-static">${errimages}</span>								
						</div>
					
					</div>					
				<div class="form-group" style="margin: 20px;">
					<button type="submit" class="btn btn-outline-warning btn-lg">
						<b>상품 등록</b></button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="reset"  class="btn btn-outline-danger btn-sm">취소</button>
				</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>