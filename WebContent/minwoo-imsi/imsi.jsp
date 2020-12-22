<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<title>태그 선택자 사용(li 요소에 디자인 적용)</title>
	<style type="text/css">
		h3{/*h3 전체*/
			background-color: #000000;
			color: #ffffff;
			width: 50%;/*전체 웹 페이지 100%중 50%*/
			margin-left: 20px;
		}
		li{/*li 전체*/
			line-height: 200% ;
			color: #ff6600;
			font-size: 12px;
			width: 400px;
			margin-left: 20px;
		}
		span{
			color:#ffffff; 
			background-color:#ff0000;
		}
		.hoho{/*class 지정 클래스는 .클래스이름 으로 코딩 (한 묶음으로 처리할때 class를 사용함.)*/
			color: #ff00ff;
			background-color: #ffffff;
			font-size: 15px;
		}
		#one{/*id 지정은 #아이디이름 으로 코딩*/
			color: #00ffff;
			background-color: #000000;
			font-size: 20px;
		}
		.haha{/*class hoho 와 haha 를 같이쓰는데 .haha .hoho 순서에따라 다르게 적용된다 . */
			font-size: 50px;
		}
		#two{
			color: green ; 
		}
		.gamja{
			background-color: #000000;
			color: #ffffff;
		}
	</style>
</head>
<body>
	<h1>선택자 사용하기</h1>
	<hr>
	<h2>두부<span id="two">감자</span>조림</h2> 
	<h3>재료</h3>
	<ul><!--순서없는 목록-->
		<li><span class="gamja">감자 </span>1개</li>
		<li><span class="hoho haha">두부</span> 1/2모</li>
		<li>꽈리고추 10개</li>
		<li>홍고추 1개</li>
	</ul>
	<h3>조리법</h3>
	<ol><!--순서있는 목록-->
		<li><span class="gamja">감자 </span>는 껍질을 벗기고 돌려가면서 어슷하게 썰어 찬물에 담가놓고 <span id="one">두부</span>는 도톰하게 한입크기로 썰며 꽈리고추, 홍고추는 어슷썬다.</li>	
		<li>첫번째 썰은 재료에 <span class="hoho">두부</span>를 팬에 기름을 두르고 노릇노릇하게 앞뒤로 지져 기름은 뺀다.</li> 
		<li>냄비에 <span class="gamja">감자 </span>와 홍고추를 담고 조림장을 반분량만 넣는다. </li>
		<li>3번째를 끓이다가 <span>감자</span>가 반정도 익으면, <span>두부</span>와 남은 양념장을 넣는다. </li>
		<li>윤기나게 졸여지면 꽈리고추를 마지막에 넣어 다시한번 살짝 졸여 조린다.</li>
	</ol>
</body>
</html>