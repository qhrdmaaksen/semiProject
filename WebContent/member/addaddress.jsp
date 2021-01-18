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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    
    
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
</head>
<body>
	<form id="myform" name="myform" class="form-horizontal" role="form"
					action="<%=YesForm%>" method="post">
					<input type="hidden" name="command" value="addaddress">
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
								value=""> <input type="hidden" name="sample4_postcode"
								id="sample4_postcode" value="">
						</div>
						<div class="col-xs-<%=2%> col-lg-<%=2%>" align="left">
							<input type="button" class="btn btn-info" value="우편 번호 찾기"
								onclick="sample4_execDaumPostcode();">
						</div>
						<span class="err">${errzipcode}</span>
					</div>
					<div class="form-group">
						<label for="address1"
							class="col-xs-<%=formleft%> col-lg-<%=formleft%> control-label">주소</label>
						<div class="col-xs-<%=formright%> col-lg-<%=formright%>">
						<input type="text" name="sample4_roadAddress" id="sample4_roadAddress"
								class="form-control" placeholder="도로명주소" value="">
						<span class="err">${erraddress1}</span>
						</div>
					</div>
					<div class="form-group">
						<label for="address2"
							class="col-xs-<%=formleft%> col-lg-<%=formleft%> control-label">지번주소
							</label>
						<div class="col-xs-<%=formright%> col-lg-<%=formright%>">
							<input type="text" name="sample4_jibunAddress" id="sample4_jibunAddress"
								class="form-control" placeholder="지번주소" value="">
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