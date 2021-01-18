<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/nav.jsp"%>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="../js/jquery.zoom.min.js"></script>
	<script src="../js/jquery-3.5.1.min.js" type="text/javascript"></script>
	<link
	    rel="stylesheet"
	    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
	  />
	  <script type="text/javascript">
	  $(document).ready(function(){
			/*list 안의 내용 열리기 새거 열면 전에꺼 닫히고, 열린거 누르면 다시 닫힘*/
			$(".show-open").css('display','none'); //우선 내용부분을 모두 감춰줍니다
			$(".bms-list-tr").click(function(){ //클릭했을때
				var check = $(this).next().css("display") == "none"; //변수로, 열릴 부분의 display 상태 체크
				$(this).siblings().removeClass('bms-list-tr-active');//클릭하는 부분의 형제들에 배경색을 제거해줍니다
				var except = $(this).next();//선택된부분의 다음(내용)부분만 열리기 위해, 변수를 선언해주는데요. 이는 다음을 보시면 이해가 가실겁니다.
				if(check)// 열릴부분의 display가 none으로 되어있다면, 
				{
					$(this).next().css('display','block'); //열릴부분의 display를 block으로 변경해주고,
					$(".show-open").not(except).css('display','none'); //그외의 내용부분(.not() 으로 제어함) 은 display를 none으로 안보이게 변경시킵니다.
					$(this).addClass('bms-list-tr-active');//클릭한 부분에 클래스를 더해 배경색을 보여줍니다.		
		        }else{ //클릭 2번했을 경우 check는 display block으로 변했기때문에 그때의 상황에 맞춰 상태조절,
					$(this).next().css('display','none'); //선택된 다음 부분의 display를 감춥니다.
					$(this).removeClass('bms-list-tr-active');//선택된 부분의 배경색을 뺍니다. 
				}
			});
		})
	</script>
	<style type="text/css">
		.bms-list-tr {
			clear: both;
			height: 50px;
			border-top: 1px solid #dcdcdc;
			cursor: pointer;
			text-align: center;
		}
		
		.bms-list-tr-active {
			background: #f6f6f6 !important;
		}
		
		.bms-list-tr li {
			float: left;
			padding: 16px 0 0 0px;
			height: 100%;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}
	</style>
</head>
<body>
	<ul class="bms-list-tr">
		<li>가능</li>
	</ul>
	<section id="show6359" class="show-open"></section>

	<ul class="bms-list-tr">
		<li>가능</li>
	</ul>
	<section id="show6359" class="show-open"></section>

	<ul class="bms-list-tr">
		<li>가능</li>
	</ul>
	<section id="show6359" class="show-open"></section>
</body>
</html>