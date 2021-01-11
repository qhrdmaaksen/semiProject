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
	function checkForm() {
		var isCheck = document.myform.isCheck.value;
		//alert( isCheck ) ;
		if (isCheck == 'false') {
			alert('아이디 중복 체크를 우선 해주세용.');
			return false;
		}
	}
</script>
</head>
<body>
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
</body>
</html>