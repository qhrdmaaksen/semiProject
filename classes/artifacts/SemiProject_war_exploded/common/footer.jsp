<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>dodamFooter</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<style type="text/css">
		body{
			margin: 0px;
			font:12px "맑은 고딕";
		}
		h3{
			font-size:1.2em;
			color: black;
			font: bolder;
		}
		#representative{
			font-size:1.1em;
			color: black;
			font : bold;
			padding: 7px ; 
		}
		p{
			line-height: 120%;
			margin-bottom: 0px;
		}
		#cannanoogi{
			position: relative;
			font-size:13px;
			width: 100%;
			margin-left: 50px ;
			margin-bottom: 50px;
			text-align: justify;
			line-height: 0.1em;
			column-count: 4;/*column-count==세로로 칸을 만들 수*/
			column-gap: 50px;/* column-gap 칸막이와의 거리 */
			column-rule: 3px solid #f0f0f5;/* 칸막이 지정 선 */
		}
		#footermenu{
			width:100%;
			background-color: #f0f0f5;
			padding: 0px;
			margin: 0px;
			padding-top: 1%;
			font-size: 13px ; 
			border: 0px solid #darkgreen;
			padding-left: 5%;
		}
		#footermenu li{
			display: inline;
			font: sans-serif;
			border-left: 1px solid gray; 
			padding: 1px 15px ;
		}
		#footermenu a{
			text-decoration: none;
			color : black;
			border: 0px solid #darkgreen;
		}
		.cs{
			text-decoration: none;
			font-style: normal;
			padding-top: 2%;
			padding-right: 15%;
		}
		.footerdodam{
			font-style: normal;
		}
		.icon {
			width: 20px;
			height: 20px;
			margin-right: 0%;
		}
		#footermenu a:hover{
			color: red;
			font-size: 1.2em ;
		}
	</style>
</head>
<body>
	<footer>
		<div class="contianer">
			<div class="row" id="footermenu">
				<div class='col'>
					<ul>
						<li class="only-pc"><a href="/terms/service">이용 약관</a>
						<!--고객센터 메뉴로연동--></li>
						<li class="only-pc"><a href="/terms/privacy">개인정보 처리방침</a>
						<!--고객센터 메뉴로연동--></li>
						<li class="only-pc"><a onclick="location.href='http://localhost:8989/SemiProject/cs-center/cs-center-main.jsp'">고객 센터</a>
						<!--고객센터 메뉴로연동--></li>
					</ul>
				</div>
				<div class='col'>
				</div>
				<div class='col row'>
					<div class="col-sm-7">
					</div>
					<div class="col-sm-5">
						<ul>
							<li><a
								href="https://www.instagram.com/explore/tags/%EC%98%81%EC%96%91%EC%A0%9C/"
								target="_blank"> <img class="icon" alt="instgram"
									src="../images/instagram-icon.png">
							</a></li>
							<li><a
								href="https://www.facebook.com/%EC%98%81%EC%96%91%EC%A0%9C-%EA%B5%AC%EB%8F%85-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-106001111384695/?ref=page_internal"
								target="_blank"> <img class="icon" alt="facebook"
									src="../images/facebook_icon.png">
							</a></li>
						</ul>
					</div>
				</div>
				
			</div>			
		</div>
	<div id="cannanoogi">
		<address class="fooeraddress">
		<div class="footerdodam">
			<div id="footerlogimage" align="center">
				<img alt="도담도담" src="../images/logotest.png">
			</div>
			<h3 align="center" style="font: bolder;">회사명</h3>
				<p align="center">
					도담도담
				</p>
				<p id="representative" align="center">
					<b>대표</b>
				</p>
				<p align="center">
					1조 도담도담 팀
				</p>
				
				<p align="center">
					<span>사업자번호: 214-85-24928</span>
					<br/>
					<span>개인정보취급담당자: 김민우</span><br>
					<span>주소 : 서울시 서초구 강남대로 459 (서초동, 백암빌딩)</span>
					<br class="only-mobile"/>
				</p>
				<p align="center">
					<span>통신판매업신고: 제 서초-00098호 <a class="link" href="http://www.ftc.go.kr/bizCommPop.do?wrkr_no=7598700821" target="_blank">사업자정보확인</a>
					</span>
					<br/>
					<span>유통판매업신고: 제 2018-0107314 호</span><br/>
					<span>건강기능식품판매업신고: 제 2018-0107318 호</span>
				</p>
		</div>
				<br><br>
			<div class="cs"><h4 align="center">고객센터</h4>
				<p align="center">
					<span>고객문의: <a href="mailto:rlaalsdn8@gmail.com">rlaalsdn8@gmail.com</a>
					<span>전화: <a href="tel://010-9255-9798">010-9255-9798</a></span>
				</p>
				<p align="center">
					<span>제휴문의: <a href="mailto:rlaalsdn8@naver.com">rlaalsdn8@naver.com</a></span>
					<span>전화: <a href="tel://010-9255-9798">010-9255-9798</a></span>
				</p>
			</div>
		</address>
		</div>
	</footer>
</body>
</html>