<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		body{
			background-image: url(./../images/main_bg.gif);
			background-repeat: repeat-x;
			background-position: left bottom;
		}
		#pipe{/* 메뉴 설정 */
			width: 550px;
			padding: 5px ;
			border: 0px solid #darkgreen;
			margin-left: 0px;
		}
		#pipe li{
			margin-left: 0px;
			padding: 3px 15px ;
			list-style: none;/* 목록앞에 점 삭제 */
			display: inline;/* 디플을 인라로주면 가로로 정렬한다. */
			border-left: 1px solid #000000; /* 글 왼쪽 에 선 */
		}
		#pipe li.first{
			border-left: none;
		}
		#pipe a{
			margin-left: 5px;/* 크기?조정 */
			text-decoration: none;/* 언더라인 없음 */
			font-size: 13px;
			color: #304e06;
			font-weight: bold;/* 글자 진하게 */
		}
		#pipe a:hover{
			color: red;
			font-size: 15px;/* 폰사를 주면서 마우스를 가져다댈시 크기가 15px만큼 커짐 */
		}
		h3{
			margin-left: 15px ; /* 좌측 기준 15px만큼 공백 */
			color: darkgreen;
			margin-bottom: 2px;
		}
		p.box{
			font-size: 12px;
			width: 550px;
			margin: 5px;
			border: 1px dotted #000000;
			padding: 5px;
		}
		p strong{
			font-size: 13px; 
			color: red;
		}
		span.more a{
			margin-left: 500px;
			color: blue;
			font-size: 11px;
			text-decoration: none;
		}
	</style>
</head>
<body>
	<a href="index_hor6.htm"><img src="./../images/herblogo.jpg" border="0"></a>
	<ul id="pipe">
		<li class="first"><a href="#">허브가 뭐지?</a></li>
		<li><a href="#">허브의 종류</a></li>
		<li><a href="#">허브의 효능</a></li>
		<li><a href="#">내가 만드는 허브차</a></li>
	</ul>
	<br>

	<h3>허브란</h3>
	<p class="box">
		약초, 향초, 향신료나 약으로 사용하는 식물의 총칭. 허브는 푸른 풀을 의미하는 라틴어 허바(herba)에서 
		유래한 말로 지구상에는 2500여 종이 자생하는 것으로 알려져 있다.<br>
		<span class="more"><a href="#">more</a></span>
	</p>

	<h3>허브의 종류</h3>
	<p class="box">
		<strong>바질</strong>은 두통, 신경과민, 구내염, 강장효과, 건위, 진정, 살균, 불면증에 좋고 
		젖을 잘 나오게 하는 효능이 있으며, 졸림을 방지하여 늦게까지 공부하는 수험생에게 좋다. 
		또한 신장의 활동을 촉진시키며 벌레 물린데에 살균효과가 있다.<br>
		<span class="more"><a href="#">more</a></span>
	</p>

	<h3>허브의 효능</h3>
	<p class="box"><!-- <strong>태그 강한 중요성 텍스트를 정의하는 데 사용됩니다. 내부 콘텐츠는 일반적으로 굵게 표시됩니다 . -->
		<strong>레몬그라스(Lemongrass)</strong>는 억새를 닮은 포아과의 다년초로 잎을 찢어서 
		손가락으로 비벼보면 레몬같은 향기가 난다하여 붙어진 이름이다. 
		약품, 비누,린스, 캔디 등의 부향제로 쓰인다. 인도나 동남아에서는 일상 음료로 상용하는데 
		이 차는 소화기능을 강화 할 뿐 아니라 빈혈에도 효과가 있으며 냉차로 마시면 더욱 향기롭다.<br>
		<span class="more"><a href="#">more</a></span>
	</p>

</body>
</html>