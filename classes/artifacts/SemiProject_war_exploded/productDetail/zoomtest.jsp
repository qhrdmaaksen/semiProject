<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="../js/jquery.zoom.js"></script>
	<script>
		$(document).ready(function(){
			$("#test").children().siblings().each(function() {
				$(this).zoom();
			})
		});
	</script>
	<style>
		.zoom{
			display: inline-block;
			position: relative;
		}
	</style>
</head>
<body>
	<div id="test">
		<div id="flower" class="zoom">
			<img src="./../images/imsitest01.png" width="400">
		</div>
		<div id="flower2">
			<img src="./../images/imsitest02.png" width="400">
		</div>
		<div id="flower3">
			<img src="./../images/imsitest03.png" width="400">
		</div>
		<div id="flower4">
			<img src="./../images/imsitest.png" width="400"  >
		</div>
	</div>
</body>
</html>