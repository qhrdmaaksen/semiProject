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
	$(function(){
		var rating = $('.review.rating') ;
		
		rating.each(function(){
			var targetScore = $(this).attr('data-rate');
			console.log(targetScope);
			$(this).find('svg:nth-child(-n+' + targetScope +')').css({color:'#F05522'}) ;
		});
		
		var userScore = $('#makeStar') ;
		userScore.change(function(){
			var userScoreNum = $(this).val();
			console.log(userScoreNum) ;
			userScore.find('.rating').find('svg:nth-child(-n+' + userScope +')').css({color:'#F05522'}) ;
		});
	)};	
	</script>
</head>
<body>
	<h2>별점 표시하기</h2>
	<div class="review">
	<div class="rating" data-rate="3">
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>	
	</div>
	<div class="rating" data-rate="5">
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>	
	</div>
	<div class="rating" data-rate="2">
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>	
	</div>		
</div>

<hr>
<h2>별점주기</h2>
<div class="make_star">
	<select name="" id="makeStar">
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5">5</option>
	</select>
	<div class="rating" data-rate="3">
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>
		<i class="fas fa-star"></i>	
	</div>
</div>
</body>
</html>