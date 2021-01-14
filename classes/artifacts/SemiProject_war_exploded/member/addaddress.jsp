<%@  page contentType="text/html;charset=UTF-8" language="java"%>
 <%@ include file="../common/nav.jsp"%>
<%
	int myoffset = 2;
	int mywidth = 12 - 2 * myoffset;
	int formleft = 3;
	int formright = 12 - formleft;
%>
<html>
<head>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript" src="jquery.validate.js"></script>
<style type="text/css">
	.form-group {
		margin-bottom: 3px;
	}
	.good-result{/* 상태 양호 */
		font-size : 10pt;
		color:blue;
		font-weight: bolder;
	}
</style>
<script type="text/javascript">
		function checkDuplicateId(  ){
			var id = document.myform.id.value ;
			if( id.length == 0 ){
				alert('아이디를 입력해 주세요') ;
				document.myform.id.focus() ; 
				return false ;
			}
			var url='<%=NoForm%>meIdcheck&id=' + id ; 
			window.open(url, 'mywin', 'height=150,width=300') ;
		}
		
		function findZipcode( ){
			var url='<%=NoForm%>meZipcheck';
			window.open(url, 'mywin',
				'height=600,width=720,status=yes,scrollbars=yes,resizable=no');
		}
		
	function isCheckFalse() {
		document.myform.isCheck.value = false;
	}

</script>
</head>
<body>
	<form id="myform" name="myform" class="form-horizontal" role="form"
					action="<%=YesForm%>" method="post">
					<input type="hidden" name="command" value="addaddress"> <input
						type="text" name="isCheck" value="false"> <input
						type="hidden" name="mpoint" value="5">
					<div class="form-group">
					
						<label class="control-label col-sm-<%=formleft%>" for="writer">주문자</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="fakewriter" id="fakewriter"
								placeholder="작성자" value="${sessionScope.loginfo.name}(${sessionScope.loginfo.id})" disabled="disabled">
							<input type="hidden" name="id" id="id"
								value="${sessionScope.loginfo.id}">
									<input type="hidden" name="name" id="name"
								value="${sessionScope.loginfo.name}">
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="title">수령인</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="shippingname"
								id="shippingname" placeholder="글 제목" value="${bean.shippingname}"> 
							<span class="err">${errshippingname}</span>
						</div>
					</div>
					
					
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="title">휴대폰번호</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="phone"
								id="phone" placeholder="글 제목" value="${bean.phone}"> 
							<span class="err">${errphone}</span>
						</div>
					</div>
					
		
		
						<div class="form-group">
						<label for="zipcode"
							class="col-xs-<%=formleft%> col-lg-<%=formleft%> control-label">우편
							번호</label>
						<div class="col-xs-<%=formright - 2%> col-lg-<%=formright - 2%>">
							<input type="text" name="fakezipcode" id="fakezipcode"
								class="form-control" disabled="disabled" placeholder="우편 번호"
								value=""> <input type="hidden" name="zipcode"
								id="zipcode" value="">
						</div>
						<div class="col-xs-<%=2%> col-lg-<%=2%>" align="left">
							<input type="button" class="btn btn-info" value="우편 번호 찾기"
								onclick="findZipcode();">
						</div>
						<span class="err">${errzipcode}</span>
					</div>
					<div class="form-group">
						<label for="address1"
							class="col-xs-<%=formleft%> col-lg-<%=formleft%> control-label">주소</label>
						<div class="col-xs-<%=formright%> col-lg-<%=formright%>">
							<input type="text" name="fakeaddress1" id="fakeaddress1"
								class="form-control" disabled="disabled" placeholder="주소"
								value=""> <input type="hidden" name="address1"
								id="address1" value=""> <span class="err">${erraddress1}</span>
						</div>
					</div>
					<div class="form-group">
						<label for="address2"
							class="col-xs-<%=formleft%> col-lg-<%=formleft%> control-label">세부
							주소</label>
						<div class="col-xs-<%=formright%> col-lg-<%=formright%>">
							<input type="text" name="address2" id="address2"
								class="form-control" placeholder="세부 주소" value="삼성 아파트">
							<span class="err">${erraddress2}</span>
						</div>
					</div>
					

					
					
					
					
						<div class="form-group">
						<div class="col-xs-<%=12%> col-lg-<%=12%>" align="center">
								<button class="btn btn-default" type="submit">전송</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="reset" class="btn btn-default">초기화</button>
						</div>
					</div>
				</form>
</body>
</html>