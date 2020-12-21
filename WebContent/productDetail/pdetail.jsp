<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>product detail</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="./../common/nav.jsp"%>
	<script src="./../js/jquery.zoom.min.js"></script>
	<style>
		body{
			width: 100%;
			height: 100%;
		}
			.zoom{
			display: inline-block;
			position: relative;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			/* button 태그를 클릭하게 되면 현재 요소의 다음 요소에 대하여 src 속성을 제거한다 */
			/* 즉, 이문제에서는 img 태그의 src 속성이 사라진다 */
			$('button#prod-moreView').click(function() {
				$("#prod-images").css("display","block");
			});
			$('button#prod-moreView-remove').click(function() {//remove Attribute 버튼 클릭 시 이미지 삭제
				$("#prod-images").css("display","none");
			});
		});
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
	</script>
	<script>
		function testInnerHTML(){
			var str = " ";
	
			str +=  "<table>";
			str +=  "<tr>";
			str +=  "<td>";
			str +=  "<button type='button'>1개월 정기</button>"; 
			str +=  "</td>";
			str +=  "<td>";
			str +=  "<button type='button'>2개월 정기</button>"; 
			str +=  "</td>";
			str +=  "<td>";
			str +=  "<button type='button'>3개월 정기</button>"; 
			str +=  "</td>";
			str +=  "</td>";
			str +=  "</tr>";
			str +=  "<tr>";
			str +=  "<td>";
			str +=  "<button type='button'>4개월 정기</button>"; 
			str +=  "</td>";
			str +=  "<td>";
			str +=  "<button type='button'>5개월 정기</button>"; 
			str +=  "</td>";
			str +=  "<td>";
			str +=  "<button type='button'>6개월 정기</button>"; 
			str +=  "</td>";
			str +=  "</tr>";
			str +=  "</table>";
	
			document.getElementById("inHere").innerHTML = str;
		};
	</script>
	<style type="text/css">
		#prod-contents{
			position: absolute; 
			top: 62px ; 
			left: 150px ; 
			width: 550px ; 
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4">
				<h2 align="center">상품 이미지 상세보기</h2>
				<div id="myarea">
					<img class="img-thumbnail" alt="prod-img" src="../images/imsitest.png" width="400" height="600" onmouseover="applyImage(this.src);">
				</div>
				<div align="center">
					<img class="img-thumbnail" alt="a" src="./../images/imsitest01.png"
						width="70" height="130" onmouseover="applyImage(this.src);">
					<!-- apply 함수한테 나의 이미지 경로를 알려줌? -->
					<img class="img-thumbnail" alt="b" src="./../images/imsitest02.png"
						width="70" height="130" onmouseover="applyImage(this.src);"> 
					<img class="img-thumbnail" alt="c" src="./../images/imsitest03.png"
						width="70" height="130" onmouseover="applyImage(this.src);"> 
					<img class="img-thumbnail" alt="c" src="./../images/imsitest.png"
						width="70" height="130" onmouseover="applyImage(this.src);">
				</div>
			</div>
			<div class="col-md-2">
			</div>
			<div class="col-md-6 text-center">
				<h2> 상품 가격 상세보기</h2>
				<div class="text-center" style="height: 100%;">
					<table border="1" style="width: 100%; height: 100%;" class="text-left"> 
						<tr style="height: 100%" align="center">
							<td class="list-group-item" style="font-size: 12">탐 사 수</td>
							<td class="list-group-item">시중 판매 가격 : 11,000 원</td>
							<td class="list-group-item">일반 회원 판매 가격 : 10,000 원</td>
							<td class="list-group-item">구독 회원 가격 : 9,000 원</td>
							<td class="list-group-item">내일 토요일 12-19 도착 예정</td>
							<tr align="center">
								<td>
									<div class="form-group col-sm-4">
										<label>구매 수량</label>
										<input type="number" class="form-control mypopover" title="수량 입력란" data-content="구매하고자 하는 수량을 정수로 입력하세요." >
									</div><!--data-trigger 자동으로-->
								</td>
							</tr>
						<tr>
							<td align="center" class="list-group-item">
								<input type="radio" name="Delivery" value="1회 구매 10,000 원" checked="checked">1회 구매 10,000 원
							</td>
						<tr>	
							<td align="center">
								<input type="button" name="delivery" value="정기 배송" onclick="testInnerHTML();">
								<div id="inHere"></div>
							</td>
						</tr>
							<tr>	
							<td class="list-group-item">
								 <input type="button" style="width: 100%; color: blue; background: white; border:1; border-color: blue; font: bold;" name="goMall" value="장바구니 담기">
							</td>
							<td class="list-group-item">
							 	<input type="submit" style="width: 100%; color: white; background: blue;" name="goPayment" value="바로 구매 >">
							 </td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
			<ul class="nav nav-tabs" style="background: #f0f0f5">
			    <li class="active"><a data-toggle="tab" href="#prod-detail">상품 상세 보기</a></li>
			    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
			    <li><a data-toggle="tab" href="#prod-review">상품평</a></li>
			    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
			    <li><a data-toggle="tab" href="#cs-main">상품 문의</a></li>
	  		</ul>
	</div>
	<br><br><br><br><br><br><br>
	<div align="center">
		<button id="prod-moreView" style="width: 60%; font-size: 30px; color: blue; background: white;">상품 상세 내용 보기 ▼</button>
	</div>
	<div align="center" id="prod-images" style="display: none;" >
		 <img id="img0" title="홍삼" width="50%" height="50%" src="./../images/bottle.png" alt="bottle.png">  <br>
		 	면역력 증진·피로개선·지구력 증진에 도움을 줄 수 있는
			면역력 증진·피로개선·기억력개선에 도움을 줄 수 있음<br>
			쌀의 배아, 현미, 사탕수수 등에서 찾을 수 있는 옥타코사놀은 지구력 증진에 도움을 줄 수 있습니다.<br>
			천연소재 비타민E는 유해산소로부터 단백질의 산화를 방지하고, <br>
			DNA의 손상을 억제하여 세포를 보호하는데 필요합니다.
		 <img id="img1" title="홍삼1" width="50%" height="50%" src="./../images/point.jpg" alt="point.jpg">    <br>
		 	필리 홍삼 옥타코사놀 포인트
			01
			국내산 6년근 홍삼 사용
			국내산 6년근 홍삼분말을 사용하여 진세노사이드(Rg1, Rb1 및 Rg3의 합)를 하루 3.4 mg 섭취할 수 있습니다.<br>
		 <img id="img2" title="홍삼2" width="50%" height="50%" src="./../images/point01.jpg" alt="point01.jpg"><br>
		 	02
			지구력 증진을 위한 옥타코사놀 함유
			사탕수수에서 추출한 독일산 옥타코사놀을 하루 10 mg 섭취할 수 있습니다.<br>
		 <img id="img3" title="홍삼3" width="50%" height="50%" src="./../images/point02.jpg" alt="point02.jpg"><br>
		 	03
			비타민E 함유
			미국 BASF의 식물성 오일에서 추출한 비타민E(d-α-토코페롤)를 하루 3.3 mg 섭취할 수 있습니다.<br>
		 <img id="img4" title="홍삼4" width="50%" height="50%" src="./../images/point03.jpg" alt="point03.jpg"><br>
		 	제품설명
			필리 홍삼 옥타코사놀 제품형태
			이렇게 드세요
			33 g (550 mg x 60캡슐), 30일분<br>
			필리 홍삼 옥타코사놀 섭취방법
			홍삼농축액분말(홍삼: 국내산 / 6년근 / 원료삼배합비율: 홍삼근70%, 미삼류30%), 옥타코사놀(독일산), D-알파-토코페롤혼합제제(d-a-토코페롤, 대두유)
			부원료: 대두유(외국산: 미국, 태국, 벨기에 등),<br> 밀납, 대두레시틴
			캡슐기제: 젤라틴(돈피) 글리세린, 카카오색소(카카오색소, 덱스트린)
		 <br><br><br>
		 <button id="prod-moreView-remove" style="width: 60%; font-size: 30px; color: blue; background: white;">상 품 상세 보기 접기 ▲</button>
	</div>
</body>
</html>