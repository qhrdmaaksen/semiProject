<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	pageContext.setAttribute("replaceChar", "\n");
	int twelve = 12;
	int myoffset = 2;
	int mywidth = twelve - 2 * myoffset;
	int formleft = 3;
	int formright = twelve - formleft;
	int mysearch = 2;
	//int label = 3 ; //양식의 왼쪽에 보여지는 라벨의 너비 
	//int content = twelve - label ; //우측의 내용 입력(input, select, textarea)의 너비
%>
<!DOCTYPE html>
<html>
<head>
	<title>product detail</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../common/nav.jsp"%>
	<script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
	<script src="./js/jquery.zoom.min.js"></script>
	<script type="text/javascript" src="https://rawgit.com/jackmoore/autosize/master/dist/autosize.min.js"></script>
	<link
	    rel="stylesheet"
	    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
	  />
	<style>
	body {
		width: 100%;
		height: 100%;
	}
	
	.zoom {
		display: inline-block;
		position: relative;
	}
	#prod-contents {
		position: absolute;
		top: 62px;
		left: 150px;
		width: 550px;
	}
	#gojung.gojung2 {
		position: fixed;
	}
	#star_grade a{
        text-decoration: none;
        color: gray;
    }
    #star_grade a.on{
        color: red;
    }
    .list-group-item{
    	background-color: #FAEBD7;
    }
    .month_button:hover{
    	color:white;
    	cursor: pointer;	
    }
	</style>
	<script type="text/javascript">
		var totalprice = parseInt("${bean.productprice}");
		function imageZoom() {
			$("#myarea").zoom();
		}
		function applyImage(srcimg) {
			var mywidth = 340; /* form에 너비 높이들을 가져오는 문  */
			var myheight = 450;
	
			var imgInfo = "<img src='" + srcimg ;
					imgInfo += "' width='" + mywidth ;
					imgInfo += "' height='" + myheight + "'></img>";
	
			var target = document.getElementById('myarea');
			target.innerHTML = imgInfo;
			imageZoom();
		}
		$(document).ready(function() {
			var price = parseInt("${bean.productprice}");
 			 $.ajax({
 				url:"${pageContext.request.contextPath}/dodamdodam?command=preview",
 				type:"get",
 				success: (response) =>{
 					autosize($('textarea'));
					
 					$("[id*=starGarde_]").each(function() {
						
 						var star = "☆";
 						var star2 = "★";
 						var grade = Number($(this).text()); // 별점 수
 						var starGrade  = ""; //최종 문자열
 						//별점만큼 채워진별을 대입
 						for(var i = 0 ; i < grade; i++){
 							starGrade += star2;	
 						}
 						// 5-별점 만큼 빈별을 대입
 						for(var i = 0 ;i < 5-grade; i++){
 							starGrade += star;
 						}
 						// 완성된 문자열을 대입
 						$(this).text(starGrade).css("color","red");
 					});
 				},
 				error: () =>{
 					console.log("error")
 				}
			});
			$("input[name='delivery']").change(function() {
				if($(this).prop("checked")){
					$("#inHere").css("display", "block");
					$('#buy-qty').css("display", "none");
					$('#buy-qty2').css("display", "none");
					$("#productprice").text("월간 " + Math.floor(price * 0.8).format() + "원");
					totalprice = Math.floor(price * 0.8);
				}else {
					$("#inHere").css("display", "none");
					$('#buy-qty').css("display", "block");
					$('#buy-qty2').css("display", "block");
					$('#buy-qty').trigger("change");
				}
			});
			$('#star_grade a').click(function(){
		         $(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
		         $(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
		         var i = 1;
		         $("#star_grade a").each(function() {
		      	   if($(this).hasClass("on")){
		      	   		i++;
		      		   $("[name='grade']").val(i);
		      	   }
		         })
		         return false;
			});
			$("#buy-qty").on("click", function() {
				if($("input[name='delivery']").prop("checked")){
					$("input[name='delivery']").click();
				}	
			});
			$("#buy-qty").on('change',function(e) {
				if(${sessionScope.loginfo==null}){
					$("#productprice").text(Math.floor(price * e.target.value).format() + "원");
					totalprice = Math.floor(price * e.target.value);
				}else {
					$("#productprice").text(Math.floor(price * e.target.value * 0.8).format() + "원");
					totalprice = Math.floor(price * e.target.value * 0.8);
				}
			});
			$("#month1").on("click", function() {
				$("#productprice").text("월간 " + Math.floor(price * 0.8).format() + "원");
				totalprice = Math.floor(price * 0.8);
				$("#monthVal").val(1);
			});
			$("#month2").on("click", function() {
				$("#productprice").text("월간 " + Math.floor(price * 0.7).format() + "원");
				totalprice = Math.floor(price * 0.7);
				$("#monthVal").val(2);
			});
			$("#month3").on("click", function() {
				$("#productprice").text("월간 " + Math.floor(price * 0.7).format() + "원");
				totalprice = Math.floor(price * 0.7);
				$("#monthVal").val(3);
			});
			$("#month4").on("click", function() {
				$("#productprice").text("월간 " + Math.floor(price * 0.7).format() + "원");
				totalprice = Math.floor(price * 0.7);
				$("#monthVal").val(4);
			});
			$("#month5").on("click", function() {
				$("#productprice").text("월간 " + Math.floor(price * 0.7).format() + "원");
				totalprice = Math.floor(price * 0.7);
				$("#monthVal").val(5);
			});
			$("#month6").on("click", function() {
				$("#productprice").text("월간 " + Math.floor(price * 0.7).format() + "원");
				totalprice = Math.floor(price * 0.7);
				$("#monthVal").val(6);
			});
		});
		
		function deliverynone(none){
			$("#inHere").css("display", "none");
			$("input:radio[value='정기 배송']").removeAttr("checked");
		};
		
		Number.prototype.format = function(){
		    if(this==0) return 0;
		 
		    var reg = /(^[+-]?\d+)(\d{3})/;
		    var n = (this + '');
		 
		    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
		 
		    return n;
		};
		String.prototype.format = function(){
		    var num = parseFloat(this);
		    if( isNaN(num) ) return "0";
		 
		    return num.format();
		};
		function monthaert1(){
			alert(" 1 개월 정기 배송 선택 , 20% 할인");
		}
		function monthaert2(){
			alert(" 2 개월 정기 배송 선택 , 30% 할인");
		}
		function monthaert3(){
			alert(" 3 개월 정기 배송 선택 , 30% 할인");
		}
		function monthaert4(){
			alert(" 4 개월 정기 배송 선택 , 30% 할인");
		}
		function monthaert5(){
			alert(" 5 개월 정기 배송 선택 , 30% 할인");
		}
		function monthaert6(){
			alert(" 6 개월 정기 배송 선택 , 30% 할인");
		}
	</script>
</head>
<body>
	<input type="hidden" id="monthVal" value="">
	<div class="container">
		<div class="row">
			<div class="col-md-4">
				<h2 style="text-shadow: 0 0 3px #FF0000, 0 0 5px #0000FF;" align="center">상품 이미지 상세보기</h2>
				<div id="myarea">
					<img class="img-thumbnail" alt="prod-img"
						src="${pageContext.request.contextPath}/images/product/${bean.images}" width="400" height="600"
						onmouseover="applyImage(this.src);">
				</div>
				<div align="center">
					<img class="img-thumbnail" alt="a" src="${pageContext.request.contextPath}/images/product/${bean.images}"
						width="70" height="130" onmouseover="applyImage(this.src);">
					<!-- apply 함수한테 나의 이미지 경로를 알려줌? -->
					<img class="img-thumbnail" alt="b" src="${pageContext.request.contextPath}/images/imsitest02.png"
						width="70" height="130" onmouseover="applyImage(this.src);">
					<img class="img-thumbnail" alt="c" src="${pageContext.request.contextPath}/images/imsitest03.png"
						width="70" height="130" onmouseover="applyImage(this.src);">
					<img class="img-thumbnail" alt="c" src="${pageContext.request.contextPath}/images/imsitest.png"
						width="70" height="130" onmouseover="applyImage(this.src);">
				</div>
			</div>
			<div class="col-md-2"></div>
			<div class="col-md-6 text-center">
				<h2 style="text-shadow: 0 0 3px #FF0000, 0 0 5px #0000FF;">상품 가격 상세보기</h2>
				<div class="text-center" style="height: 100%;">
					<form id="product-form" action="<%=YesForm%>" method="post">
						<table style="width: 100%; height: 100%;"
							class="text-left">
							<tr style="height: 100%" align="center">
								<td>
									<td class="list-group-item" style="font-size: 12;text-shadow: 0 0 3px #FF0000;font-weight: bold;font: sans-serif 돋움;">상품명</td>
									<td id="productname" class="list-group-item" style="font-size: 12">${bean.productname}</td>
									
									<td style="text-shadow: 0 0 3px #FF0000;font-weight: bold;font: sans-serif 돋움;" class="list-group-item">판매 가격</td>
									<td class="list-group-item" id="productprice">
										<c:if test="${sessionScope.loginfo == null}">
											<fmt:formatNumber value="${bean.productprice}" pattern="#,###"/>원
										</c:if>
										<c:if test="${sessionScope.loginfo != null}">
											<fmt:formatNumber value="${bean.productprice*0.8}" pattern="#,###"/>원
										</c:if>
									</td>
									
									<td style="text-shadow: 0 0 3px #FF0000;font-weight: bold;font: sans-serif 돋움;" class="list-group-item">도착 예정일</td>
									<td class="list-group-item">내일 토요일 12-19 도착 예정</td>
									<td style="text-shadow: 0 0 3px #FF0000;font-weight: bold;font: sans-serif 돋움;" class="list-group-item" id="buy-qty2">구매 수량
										<div class="col-sm-6">
											<input id="buy-qty" type="number"
												class="form-control mypopover" title="수량 입력란" value="1" min="1"
												data-content="구매하고자 하는 수량을 정수로 입력하세요." >
										</div>
									</td>
								<td style="text-shadow: 0 0 3px #FF0000;font-weight: bold;font: sans-serif 돋움;" class="list-group-item" align="center"><input id="delivery-select" type="checkbox"
									name="delivery" value="정기 배송">&nbsp;&nbsp;정기 배송 선택
									<div id="inHere" style="display: none;">
										<table id="monthst">
											<tr>
												<td>
													<label><input type="radio" name="reguler_month" value="1" style="display: none;">
														<span id="month1" class="month_button" onclick="monthaert1()">1개월 정기</span>
													</label>
												</td>
												<td>
													<label><input type="radio" name="reguler_month" value="2" style="display: none;">
														<span id="month2" class="month_button" onclick="monthaert2()">2개월 정기</span>
													</label>
												</td>
												<td>
													<label><input type="radio" name="reguler_month" value="3" style="display: none;">
														<span id="month3" class="month_button" onclick="monthaert3()">3개월 정기</span>
													</label>
												</td>
											</tr>
											<tr>
												<td>
													<label><input type="radio" name="reguler_month" value="4" style="display: none;">
														<span id="month4" class="month_button" onclick="monthaert4()">4개월 정기</span>
													</label>
												</td>
												<td>
													<label><input type="radio" name="reguler_month" value="5" style="display: none;">
														<span id="month5" class="month_button" onclick="monthaert5()">5개월 정기</span>
													</label>
												</td>
												<td>
													<label><input type="radio" name="reguler_month" value="6" style="display: none;">
														<span id="month6" class="month_button" onclick="monthaert6()">6개월 정기</span>
													</label>
												</td>
											</tr>
										</table>
									</div>
								</td>
								<td class="list-group-item">
									<button type="button" style="width: 80%; color: blue; background: white; border: 1; border-color: blue; font: bold;"
										name="goMall" onclick="goCart();">장바구니 담기</button>
								</td>
								<td class="list-group-item">
									<button type="button" style="width: 80%; color: white; background: blue;"
										name="gopayment" onclick="goPay();">바로 구매</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		function goCart(){
			var command = '<input name="command" value="mallcartadd" style="display: none;">';
			$("#product-form").append(command);
			$("#product-form").append("<input type='hidden' id='productcode' name='productcode' value='" + ${bean.productcode} + "'>");
			$("#product-form").append("<input type='hidden' id='totalprice' name='totalprice' value='" + totalprice + "'>");
			$("#product-form").append("<input type='hidden' id='stock' name='stock' value='${bean.stock}'>");
			if($("#delivery-select:checked").length == 0){
				$("#product-form").append("<input type='hidden' id='qty' name='qty' value='"+$("#buy-qty").val()+"'>");
			}else {
				var monthVal = $("#monthVal").val();
				$("#product-form").append("<input type='hidden' type='text' name='months' value='"+monthVal+"'>");
			}
			$("#product-form").submit();
		};
		
		function goPay(){
				console.log("login check!");
				console.log(${whologin});
				if(${whologin==0}){
					alert("로그인이 필요합니다");
					return false;
				}else {
					console.log("로그인되어있음");
				}
			var command = '<input name="command" value="payment">';
			$("#product-form").append(command);
			$("#product-form").append("<input type='hidden' id='productcode' name='productcode' value='" + ${bean.productcode} + "'>");
			$("#product-form").append("<input type='hidden' id='totalprice' name='totalprice' value='" + totalprice + "'>");
			$("#product-form").append("<input type='hidden' id='stock' name='stock' value='${bean.stock}'>");
			$("#product-form").append("<input type='hidden' name='directbuy' value='1'>");
			if($("#delivery-select:checked").length == 0){
				var buyCount = $("#buy-qty").val();
				$("#product-form").append("<input type='hidden' name='qty' value='"+buyCount+"'>");
				$("#product-form").append("<input type='hidden' name='regular' value='-1'>");
			}else {
				var monthVal = $("#monthVal").val();
				$("#product-form").append("<input type='hidden' name='months' value='"+monthVal+"'>");
				$("#product-form").append("<input type='hidden' name='regular' value='1'>");
			}
			$("#product-form").submit();
		};
	</script>
	<div class="container mt-3">
		<ul class="nav nav-tabs" id="myTab" role="tablist"
			style="margin-top: 15%;">
			<li class="nav-item"><a id="prod-contents01"
				class="nav-link active" data-toggle="tab" href="#prod-detail"
				aria-controls="상품 정보" aria-selected="true">상품 정보</a></li>
			<li class="nav-item"><a id="prod-review01" class="nav-link"
				data-toggle="tab" href="#prod-review" role="tab"
				aria-controls="상품 리뷰" aria-selected="false">상품 리뷰</a></li>
			<li class="nav-item"><a id="cs-tab01" class="nav-link"
				data-toggle="tab" href="#cs-main" role="tab" aria-controls="고객 문의"
				aria-selected="false" onclick="location.href='http://localhost:8989/SemiProject/dodamdodam?command=cs_center_main&'">고객 문의</a></li>
			<li class="nav-item"><a id="delivery-info-tab" class="nav-link"
				data-toggle="tab" href="#delivery-info" role="tab"
				aria-controls="배송/교환/반품 안내" aria-selected="false">배송/교환/반품 안내</a></li>
		</ul>
	</div>
	<div class="tab-content" style="padding-bottom: 10%;">
		<div id="prod-detail" align="center" class="container tab-pane active"
			role="tabpanel" aria-labelledby="prod-contents01">
			<img id="img0" title="홍삼" width="50%" height="50%"
				src="${pageContext.request.contextPath}/images/bottle.png" alt="bottle.png">
			<!-- <button id="prod-moreView"
					style="width: 60%; font-size: 20px; color: blue; background: white;">상품
					정보 상세 보기 ▼</button> -->
			<img id="img1" title="홍삼1" width="50%" height="50%"
				src="${pageContext.request.contextPath}/images/point.jpg" alt="point.jpg"> <img id="img2"
				title="홍삼2" width="50%" height="50%" src="${pageContext.request.contextPath}/images/point01.jpg"
				alt="point01.jpg"> <img id="img3" title="홍삼3" width="50%"
				height="50%" src="${pageContext.request.contextPath}/images/point02.jpg" alt="point02.jpg"><br>
			<img id="img4" title="홍삼4" width="50%" height="50%"
				src="${pageContext.request.contextPath}/images/point03.jpg" alt="point03.jpg"><br> 면역력
			증진·피로개선·지구력 증진에 도움을 줄 수 있는 면역력 증진·피로개선·기억력개선에 도움을 줄 수 있음<br> 쌀의
			배아, 현미, 사탕수수 등에서 찾을 수 있는 옥타코사놀은 지구력 증진에 도움을 줄 수 있습니다. 03 비타민E 함유 미국
			BASF의 식물성 오일에서 추출한 비타민E(d-α-토코페롤)를 하루 3.3 mg 섭취할 수 있습니다.<br> <br>
			02 지구력 증진을 위한 옥타코사놀 함유 사탕수수에서 추출한 독일산 옥타코사놀을 하루 10 mg 섭취할 수 있습니다.<br>
			<br> 필리 홍삼 옥타코사놀 포인트 01 국내산 6년근 홍삼 사용 국내산 6년근 홍삼분말을 사용하여
			진세노사이드(Rg1, Rb1 및 Rg3의 합)를 하루 3.4 mg 섭취할 수 있습니다.<br> <br>
			천연소재 비타민E는 유해산소로부터 단백질의 산화를 방지하고, DNA의 손상을 억제하여 세포를 보호하는데 필요합니다. 제품설명
			필리 홍삼 옥타코사놀 제품형태 이렇게 드세요 33 g (550 mg x 60캡슐), 30일분<br> 필리 홍삼
			옥타코사놀 섭취방법 홍삼농축액분말(홍삼: 국내산 / 6년근 / 원료삼배합비율: 홍삼근70%, 미삼류30%),
			옥타코사놀(독일산), D-알파-토코페롤혼합제제(d-a-토코페롤, 대두유) 부원료: 대두유(외국산: 미국, 태국, 벨기에
			등),<br> 밀납, 대두레시틴 캡슐기제: 젤라틴(돈피) 글리세린, 카카오색소(카카오색소, 덱스트린)
			<!-- <button id="prod-moreView-remove"
					style="width: 60%; font-size: 20px; color: blue; background: white;">상
					품 상세 보기 접기 ▲</button> -->
			<br> <br> <br> <br>
		</div>
		<!-- 리뷰  -->
		<div id="prod-review" class="container tab-pane fade" role="tabpanel"
			aria-labelledby="prod-review01">
			<div class=" ">
				<div class="panel panel-default panel-primary">
					<div class="panel-heading" style="float: right;">
						<form class="form-inline" role="form">
							<h3 style="text-shadow: 0 0 3px #FF0000, 0 0 5px #0000FF;fl">리뷰 목록</h3>
						</form>
					</div>
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th>글 번호</th>
								<th>작성자</th>
								<th>글 내용</th>
								<th>작성 일자</th>
								<th>별점</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;수정</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;삭제</th>
							</tr>
						</thead>
						<tr align="right">
							<td colspan="10">
								<form class="form-inline" role="form" name="myform" 
									method="get">
									<input type="hidden" name="command" value=pdetail>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<p class="form-control-static">${requestScope.pagingStatus}</p>
								</form>
							</td>
						</tr>
						<c:forEach items="${reviewlists}" var="item"  begin="0" varStatus="i" end="${reviewlists.size()}">
							<tr>
								<%-- <td>${bean.no}</td> --%>
								<td>${item.reviewno}</td>
								<td>${item.id}</td>
								<td><textarea readonly="readonly" style="overflow: visible; resize: both;">${fn:replace(item.content, replaceChar,replaceChar)}</textarea></td>
								<td>${item.postdate}</td>
								<td id="starGarde_${i.index}">${item.grade}</td>
								<td>
									<c:if test="${whologin == 1 || whologin == 2}">
										<a href="?command=previewupdate&seq_review=${item.reviewno}&${requestScope.parameters}">
											수정 </a>
									</c:if> 
								</td>
								<td>
									<c:if test="${whologin == 1 || whologin == 2}">
										<a href="?command=preview_delete&seq_review=${item.reviewno}&${requestScope.parameters}">
											삭제 </a>
									</c:if> 
								</td>
							</tr>
						</c:forEach>
					</table>
					<div class="col-sm-offset-<%=myoffset%> col-sm-<%=mywidth%>"
						style="display: inline;">
						<div class="panel panel-default panel-primary">
							<div class="panel-heading">
								<h4 align="center">리뷰 등록</h4>
							</div>
							<div class="panel-body">
								<!-- 리뷰 등록  form -->
								<form class="form-horizontal" role="form" name="productForm" method="post" action="<%=YesForm%>">
									<input type="hidden" name="command" value="preview">
									<div class="row">
										<div class="form-group col-sm-6">
											<label class="control-label col-sm-<%=formleft%>"
												for="writer">작성자</label>
											<div class="col-sm-12">
												<input type="text" class="form-control" name="writer"
													id="fakewriter" placeholder="작성자"
													value="${sessionScope.loginfo.name}(${sessionScope.loginfo.id})" disabled="disabled"> 
												<input type="hidden"
													name="writer" id="writer"
													value="${sessionScope.loginfo.id}">										</div>
											<label class="control-label col-sm-12" for="subject">
											</label>
											<div class="form-group">
												<label class="control-label col-sm-<%=formleft%>"
													for="image"></label>
											</div>
												<label class="control-label col-sm-<%=formleft%>-
												for="regdate"> </label>
										</div>
										<div class="form-group col-sm-6">
											<label class="control-label col-sm-12" for="content" style="color: white;">
												&nbsp;</label>
											<div class="col-sm-12">
												<textarea name="content" id="content" rows="5" cols=""
													placeholder="글 내용" class="form-control"></textarea>
												<span class="err"></span>
											</div>
											<br>
											<div class="col-sm-6">
												<p id="star_grade">상품 별점 :
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
												</p>
											</div>
											<div align="center">
												<button class="btn btn-outline-primary" type="submit" id="addreview">글 등록</button>
											</div>
										</div>
									</div>
									<input type="hidden" name="id" value="${sessionScope.loginfo.name}(${sessionScope.loginfo.id}"><!--  세션의 아이디 값 대입 -->
									<input type="hidden" name='grade' value="0">
								</form>
								
							</div>
						</div>
					</div>
				</div>
				<div align="center">
					<footer>${requestScope.pagingHtml}</footer>
				</div>
			</div>
		</div>
		<div id="cs-go" class="container tab-pane fade" role="tabpanel"
			aria-labelledby="cs-tab01"></div>
		<div id="delivery-info" class="container tab-pane fade" align="center"
			role="tabpanel" aria-labelledby="delivery-info-tab">
				<h5 class="prod-delivery-return-policy-title" style="font-weight: bolder;">배송정보</h5>
				<table class="prod-delivery-return-policy-table" border="1">
					<colgroup>
						<col width="150px">
						<col width="340px">
						<col width="150px">
						<col width="*">
					</colgroup>
					<tbody>
						<tr align="center">
							<th>배송방법</th>
							<td>순차배송</td>
							<th rowspan="2">배송비</th>
							<td rowspan="2">무료배송<br>- 도서산간 지역 추가비용 없음
							</td>
						</tr>
						<tr align="center">
							<th>묶음배송 여부</th>
							<td>가능</td>
						</tr>
						<tr>
							<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;배송기간</th>
							<td colspan="3">
								<ol>
									<li class="prod-delivery-period-contents etc-pdd-info"><span>
											배송 지역 : 주문 및 결제 완료 후, 1-2일 이내 도착</span></li>
									<li class="prod-delivery-period-contents">미배송 지역 : 주문 및 결제
										완료 후, 2-3일 이내 도착
										<p class="prod-delivery-period__notice">- 도서 산간 지역 등은 하루가
											더 소요될 수 있습니다. 곧 고객님께 찾아갈 수 있도록 노력하겠습니다</p>
									</li>
									<li class="prod-delivery-period-contents">천재지변, 물량 수급 변동 등
										예외적인 사유 발생 시, 다소 지연될 수 있는 점 양해 부탁드립니다.</li>
								</ol>
							</td>
						</tr>
					</tbody>
				</table>
				<h5 class="prod-delivery-return-policy-title" style="font-weight: bold;">교환/반품 안내</h5>
				<table class="prod-delivery-return-policy-table" border="1">
					<colgroup>
						<col width="160px">
						<col width="*">
					</colgroup>
					<tbody align="center">
						<tr>
							<th>교환/반품 비용</th>
							<td>5,000원<br>- 단, 고객 변심의 경우에만 발생<br>- 부분반품 시,
								남은금액이 무료배송 조건을 유지하면 일부 반품비용이 부과
							</td>
						</tr>
						<tr>
							<th>교환/반품 신청 기준</th>
							<td>
								<p>ㆍ단순변심에 의한 상품의 교환/반품은 제품 수령 후 30일 이내까지만 가능 (교환/반품비용 고객부담)</p>
								<p>
									ㆍ상품의 내용이 표시·광고의 내용과 다른 경우에는 상품을 수령한 날부터 3개월 이내,<br> 그 사실을
									안 날 또는 알 수 있었던 날부터 30일이내에 청약철회 가능<br>
								</p>
							</td>
						</tr>
					</tbody>
				</table>
				<h5 class="prod-delivery-return-policy-title" style="font-weight: bold;">교환/반품 제한사항</h5>
				<table border="1">
				<tr>
					<td>
						<ol>
							<li>주문/제작 상품의 경우, 상품의 제작이 이미 진행된 경우</li>
							<li>상품 포장을 개봉하여 사용 또는 설치 완료되어 상품의 가치가 훼손된 경우 (단, 내용 확인을 위한 포장
								개봉의 경우는 예외)</li>
							<li>고객의 사용, 시간경과, 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우</li>
							<li>세트상품 일부 사용, 구성품을 분실하였거나 취급 부주의로 인한 파손/고장/오염으로 재판매 불가한 경우</li>
							<li>모니터 해상도의 차이로 인해 색상이나 이미지가 실제와 달라, 고객이 단순 변심으로 교환/반품을 무료로
								요청하는 경우</li>
							<li>제조사의 사정 (신모델 출시 등) 및 부품 가격 변동 등에 의해 무료 교환/반품으로 요청하는 경우</li>
						</ol>
							<div align="center">
								<span>※ 각 상품별로 아래와
									같은 사유로 취소/반품이 제한 될 수 있습니다.</span>
							</div>
					</td>
				</tr>		
				</table>
			<div class="product-item__table product-seller">
				<p class="prod-delivery-return-policy-title">&nbsp;</p>
				<table class="prod-delivery-return-policy-table" border="1">
					<colgroup>
						<col width="150px">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>판매자  :</th>
							<td>도담도담</td>
						</tr>
					</tbody>
				</table>
				<br>
				<p class="prod-minor-notice">미성년자가 체결한 계약은 법정대리인이 동의하지 않는 경우 본인
					또는 법정대리인이 취소할 수 있습니다.</p>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
<%@ include file="../common/footer.jsp" %>
</body>
</html>