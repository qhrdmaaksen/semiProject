<%@  page contentType="text/html;charset=UTF-8" language="java"%>
 <%@ include file="../common/nav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
  <meta charset="utf-8">
<title>Insert title here</title>
<style type="text/css">



		#sidemenu { /* float 속성을 사용하여 메뉴를 화면의 왼쪽에 위치시킨다. */
			float:left;
			width:25%;
			margin-top:20px;
		}
	
	
	li  {float:left; list-style:none; margin-left:30px;}
	
	.spot_area {
    position: relative;
    border-right: 1px solid #d9dadd;
    padding: 41px 5px 67px 40px;
    }
    
 .sub_tmenu li {
    display: table-cell;
    width: 100px;
    height: 100px;
    text-align: center;
    padding: 10px, 0px, 10px, 0px;
	
	
}

.sub_tmenu li.on a {
    background-color: #525f78;
}

.sub_tmenu li a {
    display: block;
    width: 100%;
    padding: 14px 0px;
    background-color: #606e89;
    color: #fffff;
    text-decoration: none;
}

.sub_tmenu li span {
	
	color: #FFFFFF;
	
}


.spot_area {
    position: relative;
    border-right: 1px solid #d9dadd;
    padding: 41px 5px 67px 40px;
}

.ddlca{
	font-size: 20px;
}

.ship2{
	margin-left: 5%;

}

.ship3{
	margin-left: 5%;

}

.side_banner {
    position: absolute;
    top: 0;
    right: 0;
}

</style>


</head>
<body>

	<div id="sidemenu">
		<ul>
			<li><a href="herbis.htm">허브가 뭐지?</a></li>
			<li><a href="herbis.htm">허브가 뭐지?</a></li>
			<li><a href="herbis.htm">허브가 뭐지?</a></li>
			<li><a href="herbis.htm">허브가 뭐지?</a></li>
			<li><a href="herbis.htm">허브가 뭐지?</a></li>
			<li><a href="herbis.htm">허브가 뭐지?</a></li>
			<li><a href="herbis.htm">허브가 뭐지?</a></li>
			<li><a href="herbis.htm">허브가 뭐지?</a></li>
			<li><a href="herbis.htm">허브가 뭐지?</a></li>
			<li><a href="herbis.htm">허브가 뭐지?</a></li>
			<li><a href="herbis.htm">허브가 뭐지?</a></li>
			<li><a href="herbis.htm">허브가 뭐지?</a></li>
			
			
			
		</ul>
	</div>



<div class="sub_tmenu">
	<ul>
		<li class="on"><a href="" class="t1_1"><span>쇼핑</span></a></li><!--N=a:snb.shopping-->
		<li><a href="" class="t1_2"><span>콘텐츠</span></a></li><!--N=a:snb.contents-->
		<li><a href="" class="t1_5"><span>QR결제</span></a></li><!--N=a:snb.qrpay-->
		<li class="cell "><a href="" class="t1_3"><span>예약</span></a></li><!--N=a:snb.reservation-->
		<li><a href="" class="t1_4"><span>제휴카드</span></a></li><!--N=a:snb.card-->
	</ul>
</div>
	<br><br><br><br>
	
	<div id="spot_area">
		<ul>
			<li class="ship1">
				<div>
					<i class="fas fa-truck fa-lg "></i>
						<dl>
						<dt>배송중</dt>
						<dd class=" ddcla"> 0 </dd>
						</dl>
				</div>
			</li>
			<li class="ship2">
					<div>
					<i class="fas fa-box fa-lg"></i>
						<dl>
						<dt>배송완료</dt>
						<dd class=" ddcla"> 0</dd>
						</dl>
				</div>
			</li>
			<li class="ship2">
				<div>
					<i class="fas fa-undo-alt fa-lg"></i>
						<dl>
						<dt>취소/반품/교환</dt>
						<dd class=" ddcla">0 </dd>
						</dl>
				</div>
				
				<div class="side_banner">
					<li>
					<a href="" class="banner_link" style="background-color: ">
					<img src="./../images/bart.jpg" width="125" height="125">
					</a><!--N=a:top.banner-->
					</li>
				</div>
			</li>
		</ul>
	</div>
	
	


</body>
</html>
