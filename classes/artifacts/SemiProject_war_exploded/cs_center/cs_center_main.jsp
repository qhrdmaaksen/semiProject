<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int twelve = 12;
int myoffset = 2;
int mywidth = twelve - 2 * myoffset;
int formleft = 3;
int formright = twelve - formleft;
int mysearch = 2;
//int label = 3 ; //양식의 왼쪽에 보여지는 라벨의 너비 
//int content = twelve - label ; //우측의 내용 입력(input, select, textarea)의 너비
%>
<!DOCTYPE html>
<html>
<head>
	<title>cs_center</title>
	<meta charset="UTF-8">
	<%@ include file="../common/nav.jsp"%>
	<script type="text/javascript">
		function getaskedlist (seq, askedmode="all", askedkeyword="") {
			$("a").removeClass('aksed_selected');
			$('a[id="askedlist[' + seq + ']"').addClass('aksed_selected');
			$.ajax({
				url:"/dodamdodam?command=cs_center_main_asked&pageNumber="+seq+"&pageSize=10&mode="+askedmode+"&keyword="+askedkeyword,
				type:"get",
				success: (response) => {
					var tableForm ="";
					for(var arr of response){
						tableForm += 
						`
							<tr>
								<td align="center">\${arr.category}</td>
								<c:if test="${whologin != 2}">
									<td align="center" colspan="3">
										<a href="#" onclick="askedloginCheck(\${arr.seq_index})">\${arr.title}</a>
									</td>
								</c:if>
								<c:if test="${whologin == 2}">
									<td align="center">
										<a href="#" onclick="askedloginCheck(\${arr.seq_index})">\${arr.title}</a>
									</td>
								</c:if>
								<c:if test="${whologin == 2}">
									<td>
										<a href="<%=NoForm%>asked_update&seq_index=\${arr.seq_index}&${parameters}">수정</a>
									</td>
								</c:if>
								<c:if test="${whologin == 2}">
									<td>
										<a href="<%=NoForm %>asked_delete&seq_index=\${arr.seq_index}&${parameters}">삭제</a>
									</td>
								</c:if>
							</tr>
						`
					}
					$("#askedbody").html(tableForm); 
				},error: () => {

				}
			})
		}
		function search() {
			var mode = $("#mode").val();
			var keyword = $("#keyword").val();
			location.href = "/SemiProject/dodamdodam?command=cs_center_main&pageNumber=1&pageSize=10&mode="+mode+"&keyword="+keyword;
		}
		function searchAll() {
			location.href = "/SemiProject/dodamdodam?command=cs_center_main&pageNumber=1&pageSize=10&mode=all&keyword=";
		}
		function askedsearch() {
			var askedmode = $("#askedmode").val();
			var askedkeyword = $("#askedkeyword").val();
			getaskedlist(1,askedmode,askedkeyword);
		}
		function askedsearchAll() {
			location.href = "/SemiProject/dodamdodam?command=cs_center_main&pageNumber=1&pageSize=10&mode=all&keyword=";
		}
		function writeForm(){
			location.href='<%=NoForm%>notice_insert';
		}
		function loginCheck(seq_index) {
			console.log("login check!");
			console.log(${whologin});
			if(${whologin==0}){
				alert("로그인이 필요합니다");
				return false;
			}else {
				console.log("로그인되어있음");
				location.href="${NoForm}?command=notice_detailview&seq_index="+seq_index+"&${requestScope.parameters}"; 
			}
		}
		$('#askedmode option').each(function(index) {
			if ($(this).val() == '${requestScope.askedmode}') {
				$(this).attr('selected', 'selected');
			}
		});
		$('#askedkeyword').val('${requestScope.askedkeyword}');
		function askedwriteForm(){
			location.href='<%=NoForm%>asked_insert';
		}
		function askedloginCheck(seq_index) {
			console.log("login check!");
			console.log(${whologin});
			if(${whologin==0}){
				//alert("로그인이 필요합니다");
				return false;
			}else {
				console.log("로그인되어있음");
				location.href="${NoForm}?command=asked_detailview&seq_index="+seq_index+"&${requestScope.askedparameters}"; 
			}
		}
	</script>
	<style type="text/css">
		.bold {
		font-weight: bold;
		}
		.anchor-link, .anchor-link:visited {
			text-decoration: none;
		}
		
		.highlighted-link {
			font-weight: bold;
			font-size: 1.05em;
		}
		.aksed_selected{
			color: red;
			font-weight: bold;
		}
	</style>
</head>
<body>
	<div class="container mt-3">
		<h2 align="center">고객 센터</h2>
		<br>
		<!-- Nav tabs -->
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active"
				data-toggle="tab" href="#home">공지사항</a></li>
			<li class="nav-item"><a class="nav-link" data-toggle="tab"
				href="#menu1" onclick="askedlist()">자주 묻는 질문</a></li>
			<li class="nav-item"><a class="nav-link" data-toggle="tab"
				href="#menu2">개인정보 처리방침</a></li>
			<li class="nav-item"><a class="nav-link" data-toggle="tab"
				href="#menu3">이용약관 및 방침</a></li>
			<li class="nav-item"><a class="nav-link" data-toggle="tab"
				href="#menu4">추가 문의</a></li>
		</ul>
		<!-- Tab panes -->
		<div class="tab-content">
			<div id="home" class="container-fluid tab-pane active" style="padding-bottom: 10%;">
				<table class="table table-striped table-hover">
					<colgroup>
						<col width="20%">
						<c:if test="${whologin != 2}">
							<col>
						</c:if>
						<c:if test="${whologin == 2}">
							<col width="60%">
							<col width="10%">
							<col width="10%">
						</c:if>
					</colgroup>
					<thead>
						<tr>
							<td align="center">분류</td>
							<c:if test="${whologin != 2}">
								<td align="center" colspan="3">제목</td>
							</c:if>
							<c:if test="${whologin == 2}">
								<td align="center">제목</td>
								<td></td>
								<td></td>
							</c:if>
						</tr>
					</thead>
					<c:forEach var="noticebean" items="${requestScope.lists}">
						<tr>
							<td align="center">${noticebean.category}</td>
							<c:if test="${whologin != 2}">
								<td align="center" colspan="3">
									<a href="#" onclick="loginCheck(${noticebean.seq_index})">${noticebean.title}</a>
								</td>
							</c:if>
							<c:if test="${whologin == 2}">
								<td align="center">
									<a href="#" onclick="loginCheck(${noticebean.seq_index})">${noticebean.title}</a>
								</td>
							</c:if>
							<c:if test="${whologin == 2}">
								<td>
									<a href="<%=NoForm%>notice_update&seq_index=${noticebean.seq_index}&${requestScope.parameters}">수정</a>
								</td>
							</c:if>
							<c:if test="${whologin == 2}">
								<td>
									<a href="<%=NoForm %>notice_delete&seq_index=${noticebean.seq_index}&${requestScope.parameters}">삭제</a>
								</td>
							</c:if>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="4" align="center">
							<form class="form-inline" name="myform" onsubmit="return false;">
								<input type="hidden" name="command" value="cs_center_main">
								<div class="form-group">
									<select class="form-control" name="mode" id="mode">
										<option value="title" selected="selected">제목</option>
										<option value="content">글 내용</option>
									</select>
								</div>
								<div class="form-group">
									<input type="text" class="form-control btn-xs" name="keyword" id="keyword" placeholder="검색 키워드">
								</div>
								<button class="btn btn-default btn-warning" type="button" onclick="search()">검색</button>
								<button class="btn btn-default btn-warning" type="button" onclick="searchAll()">전체 검색</button>
								<c:if test="${whologin == 2}">
									<button class="btn btn-default btn-warning" type="button" onclick="writeForm();">글 쓰기</button>
								</c:if>
								<div style="float: right; margin-top: 2%;" class="col-md-4">
									<p class="form-control-static">${requestScope.pagingStatus}</p>
								</div>
							</form>
						</td>
					</tr>
				</table>
			<div align="right" style="float: right;" class="container col-md-6">
				<div>${requestScope.pagingHtml}</div>
			</div>
			</div>
			<div id="menu1" class="container-fluid tab-pane fade" style="padding-bottom: 10%;">
				<table class="table table-striped table-hover">
					<colgroup>
						<col width="20%">
						<c:if test="${whologin != 2}">
							<col>
						</c:if>
						<c:if test="${whologin == 2}">
							<col width="60%">
							<col width="10%">
							<col width="10%">
						</c:if>
					</colgroup>
					<thead>
						<tr>
							<td align="center">분류</td>
							<c:if test="${whologin != 2}">
								<td align="center" colspan="3">제목</td>
							</c:if>
							<c:if test="${whologin == 2}">
								<td align="center">제목</td>
								<td></td>
								<td></td>
							</c:if>
						</tr>
					</thead>
					<tbody id="askedbody">
						<c:forEach var="bean" items="${askedlists}">
							<tr>
								<td align="center">${bean.category}</td>
								<c:if test="${whologin != 2}">
									<td align="center" colspan="3">
										<a href="#" onclick="askedloginCheck(${bean.seq_index})">${bean.title}</a>
									</td>
								</c:if>
								<c:if test="${whologin == 2}">
									<td align="center">
										<a href="#" onclick="askedloginCheck(${bean.seq_index})">${bean.title}</a>
									</td>
								</c:if>
								<c:if test="${whologin == 2}">
									<td>
										<a href="<%=NoForm%>asked_update&seq_index=${bean.seq_index}&${requestScope.askedparameters}">수정</a>
									</td>
								</c:if>
								<c:if test="${whologin == 2}">
									<td>
										<a href="<%=NoForm %>asked_delete&seq_index=${bean.seq_index}&${requestScope.askedparameters}">삭제</a>
									</td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
					<tr>
						<td colspan="4" align="center">
							<form class="form-inline" name="myform" onsubmit="return false;">
								<input type="hidden" name="command" value="cs_center_main_asked">
								<div class="form-group">
									<select class="form-control" name="askedmode" id="askedmode">
										<option value="title" selected="selected">제목
										<option value="content">글 내용
									</select>
								</div>
								<div class="form-group">
									<input type="text" class="form-control btn-xs" name="askedkeyword"
										id="askedkeyword" placeholder="검색 키워드">
								</div>
								<button class="btn btn-default btn-warning" type="button"
									onclick="askedsearch();">검색</button>
								<button class="btn btn-default btn-warning" type="button"
									onclick="askedsearchAll();">전체 검색</button>
								<c:if test="${whologin == 2}">
									<button class="btn btn-default btn-warning" type="button"
										onclick="askedwriteForm();">글 쓰기</button>
								</c:if>
								<div style="float: right; margin-top: 2%;" class="col-md-4">
									<p class="form-control-static">${requestScope.askedpagingStatus}</p>
								</div>
							</form>
						</td>
					</tr>
				</table>
				<div align="right" style="float: right;" class="container col-md-6">
					<ul class="pagination pagination-sm">
						<c:forEach begin="1" end="${(askedlists.size() / 10) +1 }" varStatus="i">
							<c:if test="${askedpagingNumber == i.index}">
								<li class="pagingnumcolor">
									<a href="#" id="askedlist[${i.index}]" class="aksed_selected" onclick="getaskedlist(${i.index})">${i.index}</a>
								</li>&nbsp;
							</c:if>
							<c:if test="${askedpagingNumber != i.index}">
								<li class="pagingnumcolor">
									<a href="#" id="askedlist[${i.index}]" onclick="getaskedlist(${i.index})">${i.index}</a>
								</li>&nbsp;
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div id="menu2" class="container tab-pane fade" align="center">
				<br>
				<!-- Button trigger modal -->
				<button type="button" class="btn btn-primary" data-toggle="modal"
					data-target="#exampleModalLong">개인정보 처리방침 보기</button>
				<hr style="border: none; border: 5px double orange;">
				<!-- Modal -->
				<div class="modal fade" id="exampleModalLong" tabindex="-1"
					role="dialog" aria-labelledby="exampleModalLongTitle"
					aria-hidden="true">
					<div class="modal-dialog modal-xl" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle"
									style="font-weight: bold;">도담도담</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<div class="policy privacy" style="display: block;">
									<div id="promise-kr">
										<h2 style="text-align: center;">고객의 개인정보를 위한 도담도담의 약속</h2>
										<div>
											<br>
										</div>
										<ul style="text-align: right; list-style: none;">
											<li><a class="anchor-link highlighted-link"
												href="#promise-kr">고객의 개인정보를 위한 도담도담의 약속</a></li>
											<li><a class="anchor-link" href="#notice-kr">개인정보
													처리방침</a></li>
											<li><a class="anchor-link" href="#promise-en">Our
													Privacy Promise</a></li>
											<li><a class="anchor-link" href="#notice-en">Privacy
													Notice</a></li>
										</ul>
									</div>
									<p>
										<br> 도담도담은 고객이 도담도담에서 상품을 구매하고 배송받은 이후 전 과정에 걸쳐 빠르고 혁신적이며
										안전한 쇼핑을 제공하기 위해 헌신하고 있습니다. 이러한 차별화된 경험을 통해 고객들이 "도담도담 없이 어떻게
										살았을까"라고 말하는 세상을 만드는 것이 도담도담의 목표입니다. 도담도담은 고객의 개인정보를 보호하면서 이러한
										개인 맞춤형 온라인 쇼핑서비스를 제공하는 것이 가능하다고 믿습니다. 따라서 고객의 개인정보를 보호하는 것은
										도담도담의 중요한 사업 원칙입니다.&nbsp;&nbsp;
									</p>
									<p>
										<b>&nbsp; &nbsp;</b>
									</p>
									<p>
										<b>고객의 개인정보는 고객의 것이며 도담도담은 이를 항상 존중합니다.&nbsp;</b>
									</p>
									<p>도담도담은 고객이 믿고 맡긴 개인정보를 제3자와 거래하지 않습니다. 주문 처리 또는 고객 경험개선을
										위해 수탁업체에 제한적으로 정보를 제공할 수 있으나, 그 경우 반드시 업체명과 제공되는 정보를 고지합니다.
										도담도담은 데이터 기반의 회사입니다. 데이터를 활용하여 고객 경험을 개선한다는 우리의 설립 원칙은 지금까지도
										유효합니다.&nbsp;</p>
									<p>
										<br> <b>도담도담의 혁신은 고객의 개인정보를 보호하며 맞춤형 쇼핑 경험을 제공하는 데서
											시작합니다.&nbsp;</b>
									</p>
									<p>고객의 데이터를 기반으로 우리는 빠르고 안전한 개인 맞춤형 쇼핑 경험을 제공하고 혁신해 나갑니다.
										예를 들어 고객의 개인별 니즈와 선호도에 따른 맞춤화된 추천 서비스를 제공하고 고객이 원하는 시간, 장소 및
										방식에 맞게 도담도담맨 또는 도담도담 플렉스가 상품을 배송합니다.&nbsp;</p>
									<p>
										또한 로켓페이와 같은 새롭고 매력적인 서비스 개발의 중심에는 개인정보에 대한 이해, 그리고 보안과 개인정보보호에
										대한 강력한 의지가 반영되어 있습니다. 도담도담 자체적으로 개발한 로켓페이는 사용이 편리한 결제 플랫폼으로,
										고도의 암호화와 데이터 분석을 통해 빠르고 안전하게, 터치 한 번으로 결제를 가능하게
										합니다.&nbsp;&nbsp;<br> <br> <b>도담도담은 세계 최고의 전문가와
											기술로 고객을 보호합니다.&nbsp;</b>
									</p>
									<p>
										안전하고 신뢰할 수 있는 서비스에 대한 중요성은 도담도담의 기업 문화 전반에 깊숙이 뿌리내리고 있습니다. <br>
										<br> 도담도담은 세계 최고 수준의 시스템 및 기술력을 바탕으로 고객의 개인정보를 안전하게
										보호합니다. 도담도담 보안팀은 관련 시스템을 24시간 끊김없이 모니터링하며 지속적으로 진화하는 사이버 위협에
										맞추어 프로세스를 강화합니다. 또한 글로벌 최고 수준의 기준에 부합하고 보다 엄격한 내부 기준을 마련하기 위해
										보안과 개인정보보호에 지속적으로 많은 투자를 하고 있습니다. 보안 및 개인정보보호 전담팀은 임직원을 대상으로
										데이터 취급방법에 대한 교육을 실시합니다. 임직원 모두는 기존 관행에 언제든지 문제를 제기하도록 장려되며,
										고객의 개인정보 보호에 대한 경각심을 갖고 노력을 기울이는 것을 공동의 책임으로 여기고 있습니다.<br>
										<br> 더 나아가 도담도담은 관련 법령을 준수하며 정부 및 규제 당국과 긴밀히 협력하여 이커머스
										산업의 미래를 만들어 나가고 있습니다.&nbsp;
									</p>
									<p>
										<b><br></b>
									</p>
									<table style="width: 100%">
									</table>
									<table>
									</table>
									<table border="0">
										<tbody>
											<tr>
												<td><b>Yuezhong Bao</b></td>
												<td><b>Max Leveson</b></td>
											</tr>
											<tr>
												<td><b>Chief Information Security Officer</b></td>
												<td><b>Chief Privacy Officer</b></td>
											</tr>
										</tbody>
									</table>
									&nbsp;&nbsp;
									<p>
										<br> <br>
									</p>
									<div id="notice-kr">
										<h2 style="text-align: center;">
											<br>
										</h2>
										<h2 style="text-align: center;">
											<br>
										</h2>
										<h2 style="text-align: center;">
											개인정보 처리방침<br>
										</h2>
										<h2 style="text-align: center;">
											<font size="3">(Ver. 9.3)</font>
										</h2>
										<ul style="text-align: right; list-style: none;">
											<li><a class="anchor-link" href="#promise-kr">고객의
													개인정보를 위한 도담도담의 약속</a></li>
											<li><a class="anchor-link highlighted-link"
												href="#notice-kr">개인정보 처리방침</a></li>
											<li><a class="anchor-link" href="#promise-en">Our
													Privacy Promise</a></li>
											<li><a class="anchor-link" href="#notice-en">Privacy
													Notice</a></li>
										</ul>
									</div>
									<h2 style="text-align: left;">
										<b style="font-family: Arial, sans-serif; font-size: 12px;">
											<p>
												<b>고객의 개인정보 보호는 도담도담 주식회사(이하 ‘도담도담’)의 중요한 사업 원칙입니다.
													도담도담은 지속적으로 고객에게 더 높은수준의 서비스, 편리함과 가치를 제공하기 위해 노력하지만 결코 고객
													개인정보 보호라는 가치를 희생하며 서비스 목표를 달성하지 않습니다.&nbsp; &nbsp;&nbsp;</b><br>
											</p>
										</b>
									</h2>
									<b style="font-family: Arial, sans-serif; font-size: 12px;">
										<p>
											<b>따라서, 도담도담이 수행하는 모든 활동은 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하
												‘정보통신망법’)과 개인정보 보호법 등 국내 관련 법령을 준수하며, 본 개인정보 처리방침을 따릅니다.</b>
										</p>
										<p>본 개인정보 처리방침은 도담도담의 개인정보 처리와 관련한 정보를 제공하고 고객이 가진 권리 및
											어떻게 그 권리를 행사할 수 있는지에 대하여 설명합니다. 마지막으로, 도담도담의 서비스 이용 중 개인정보와
											관련하여 문의가 있을 경우 연락할 수 있는 개인정보 보호책임자 및 담당자의 연락처를 안내합니다.</p>
										<p>
											<br> 도담도담은 고객의 개인정보와 관련된 변경사항이 생길 경우 개인정보 처리방침 개정을 통해 빠른
											시일 안에 고객에게 안내합니다. 개인정보 처리방침의 세부 목차는 아래와 같습니다.
										</p>
										<p>
											<b><a href="#kr-1">1. 수집하는 개인정보 및 이용에 관한 안내</a><br>
												<a href="#kr-2">2. 개인정보의 제공</a><br> <a href="#kr-3">3.
													개인정보의 위탁</a><br> <a href="#kr-4">4. 개인정보의 파기</a><br>
												<a href="#kr-5">5. 고객의 권리와 의무</a><br> <a href="#kr-6">6.
													자동 수집 장치의 설치/운영 및 그 거부에 관한 사항</a><br> <a href="#kr-7">7.
													개인정보 보호책임자 및 담당자 안내</a><br> <a href="#kr-8">8. 고지의 의무</a><br>
											</b> <br> <br> <a><strong>1. 수집하는 개인정보 및
													이용에 관한 안내</strong></a><br> 1.1 정회원
										</p>
										<p>정회원이란 도담도담 웹사이트 혹은 도담도담 앱을 통해 가입한 회원을 말합니다.</p>
									</b><span style="font-weight: bold;"><br>※ 부정이용이란 회원 탈퇴
										후 재가입, 상품 구매 후 구매취소 등을 반복적으로 행하는 등 “도담도담”이 제공하는 할인쿠폰, 이벤트 혜택
										등의 경제상 이익을 불·편법적으로 수취하는 행위, 이용약관 등에서 금지하고 있는 행위, 명의도용 등의 불·편법
										행위 등을 포함합니다.&nbsp;</span><br>
									<table border="1" width="80%">
										<thead>
											<tr>
												<td style="text-align: center; background-color: gray;"><b>분류</b></td>
												<td style="text-align: center; background-color: gray;"><b>수집∙이용목적</b></td>
												<td style="text-align: center; background-color: gray;"
													width=""><b>수집 ∙이용항목</b></td>
												<td style="text-align: center; background-color: gray;"
													width="291"><b>보유 및 이용기간</b></td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td rowspan="2" style="width: 163.233px;">필수정보</td>
												<td rowspan="2" style="width: 235.483px;">가입 서비스 이용 및
													상담,&nbsp;<br> 부정이용 확인∙방지, <br> 환불 및 리콜 안내
												</td>
												<td width="291">이름, 연락처(휴대전화번호), ID(이메일 주소), 비밀번호</td>
												<td rowspan="2" width="291">회원 탈퇴 시 즉시 삭제함<br> <br>
													부정이용 방지를 위한 정보(ID, 불량 이용 기록)는 탈퇴DB에서 6개월 후 삭제함<br> <br>
													거래기록 보존을 위한 정보(ID, 계좌번호, 배송지 주소)는 5년간 보관함(전자상거래 등에서의 소비자보호에
													관한 법률)<br> <br> IP 의 경우 3개월 보관함(통신비밀보호법)
												</td>
											</tr>
											<tr>
												<td width="291">배송지, 주소, 서비스 이용기록(방문일시, IP, 불량 이용 기록
													등), 기기 정보(기기 종류, OS버전)</td>
											</tr>
											<tr>
												<td rowspan="10">추가정보</td>
												<td>본인확인 성인인증</td>
												<td width="291">휴대전화 본인확인: 이름, 생년월일, 성별, 통신사명, 휴대전화번호,
													Duplicate Information(DI), Connecting Information(CI),
													내/외국인정보&nbsp;</td>
												<td rowspan="5" width="291">회원 탈퇴 시 즉시 삭제부정이용 방지를 위한 고객
													식별정보(DI, CI)는 탈퇴 DB에서 6개월 후 삭제함<br> <br> 거래기록 보존을
													위해 소비자 식별정보(DI, CI), 결제, 취소, 환불 및 배송정보는 5년간 보관함(전자상거래 등에서의
													소비자 보호에 관한 법률)
												</td>
											</tr>
											<tr>
												<td>취소∙환불</td>
												<td width="291">예금주 이름, 은행명, 계좌번호</td>
											</tr>
											<tr>
												<td>배송</td>
												<td width="291">수취인정보(이름, 연락처, 주소)</td>
											</tr>
											<tr>
												<td>여행상품</td>
												<td width="291">사용자 및 동반인 정보(국/영문이름)<br> ※ 서비스의
													유형에 따라, 추가적인 정보(생년월일 등)가 수집될 수 있습니다.
												</td>
											</tr>
											<tr>
												<td>기프트카드</td>
												<td width="291">수취인 이름 및 연락처</td>
											</tr>
											<tr>
												<td>전통주 구매 관리∙신고</td>
												<td width="291">구입자 인적사항(이름, 생년월일, 주소)</td>
												<td width="291">회원 탈퇴 시 세무서 신고가 완료된 후 즉시 삭제</td>
											</tr>
											<tr>
												<td>관세부과 및 통관</td>
												<td width="291">개인고유통관부호</td>
												<td width="291">정보 삭제 요청 및 회원 탈퇴 시 즉시 삭제</td>
											</tr>
											<tr>
												<td>이물신고(도담도담이츠서비스만 해당)</td>
												<td width="291">이름, 연락처, 음식점 소재지</td>
												<td width="291">접수 후&nbsp;3년(전자상거래 등에서의 소비자보호에 관한 법률)</td>
											</tr>
											<tr>
												<td>도담도담플레이 서비스 내 이용자 식별, 게시글(리뷰)작성시 노출, cs상담 및 응대</td>
												<td width="291">도담도담플레이의 닉네임과 프로필사진</td>
												<td width="291">서비스조건(와우멤버십) 해지시 지체 없이 삭제</td>
											</tr>
											<tr>
												<td>신용 등급 및 신용점수 확인, 신용정보 관련 금융정보 제공, 신용조회회사 또는
													신용정보집중기관에 대한 개인신용정보의 조회 및 등록, 상담업무, 민원처리, 공지사항 전달, 분쟁조정을 위한
													기록 보존, 서비스 이용에 따른 요금 정산, 서비스 안전한 이용을 위한 부정이용 방지, 서비스 이용 기록과
													접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 개선에 활용, 맞춤형 서비스 제공</td>
												<td width="291">- 개인식별정보(이름, 생년월일, 성별, 휴대폰번호,
													중복가입확인정보(DI), 고객번호), 나중결제 서비스 이용 내역(가입일시, 결제 및 연체 현황),
													도담도담이 제공하는 서비스 이용 내역(가입 내역, 등록한 배송지 수, 기본 배송 주소, 구매/취소/환불
													내역, 리뷰 내역), 부정거래정보, 서비스 접속 기록<br> <br> -
													개인신용평가회사(코리아크레딧뷰로 주식회사)로부터 조회할 개인신용정보: 신용등급, 신용점수, 신용정보 변동
													내역, 신용정보 조회내역(기관명, 조회일자, 조회목적), 카드현황(카드사, 보유카드, 이용내역, 한도,
													카드대출내역, 카드연체금액), 대출현황(기관명, 개설일, 만기일, 약정금액, 대출잔액, 상환금액,
													연체금액, 대출형태), 연체현황(기관명, 연체금액, 상환금액, 연체잔액), 대지급 현황(기관명, 발생일자,
													상환일자, 상환금액, 대지급잔액), 보증 현황(기관명, 보증일자, 보증금액), 기타(채무불이행정보,
													공공정보, 금융질서문란정보), 고객분류코드<br>
												</td>
												<td width="291">도담도담 회원 탈퇴 시 까지 또는 관계 법령에 따른 보관 의무 기간
													동안 보관</td>
											</tr>
											<tr>
												<td rowspan="3">선택정보</td>
												<td>배송서비스 개선&nbsp; (도담도담이츠 서비스에 해당)</td>
												<td width="291">개인 위치정보</td>
												<td width="291">배달 완료 후 1년까지 보관정보 삭제 요청 시 즉시 삭제</td>
											</tr>
											<tr>
												<td>마케팅, 분석</td>
												<td width="291">이메일, 연락처(휴대전화번호)</td>
												<td width="291">정보 삭제 또는 이용 정지 요청 및 회원 탈퇴 시 즉시 삭제</td>
											</tr>
											<tr>
												<td>정기배송</td>
												<td width="291">아기정보(이름, 나이, 성별)</td>
												<td width="291">정보 삭제 또는 이용 정지 요청 및 회원 탈퇴 시 즉시 삭제</td>
											</tr>
										</tbody>
									</table>
									<span style="font-family: Arial, sans-serif; font-size: 12px;">
										<p style="font-weight: bold;">
											<br> ※ 부정이용이란 회원 탈퇴 후 재가입, 상품 구매 후 구매취소 등을 반복적으로 행하는 등
											“도담도담”이 제공하는 할인쿠폰, 이벤트 혜택 등의 경제상 이익을 불·편법적으로 수취하는 행위, 이용약관
											등에서 금지하고 있는 행위, 명의도용 등의 불·편법 행위 등을 포함합니다. <br> ※ 고객의 권리를
											보장해 드리기 위하여 탈퇴 회원 또는 장기 미이용 회원에게 환불 또는 리콜 안내를 목적으로 구매정보를 이용하여
											연락을 취할 수 있습니다. <br> ※ 위의 정보는 서비스 이용에 따른 통계∙분석에 이용될 수
											있습니다.&nbsp; &nbsp;
										</p>
										<p style="font-weight: bold;">
											<br> 1.2 비회원
										</p>
										<p style="font-weight: bold;">비회원은 도담도담의 웹 혹은 앱을 통해 회원가입을
											하지 않고 도담도담의 서비스(소식지 등)를 이용하는 회원을 말합니다.</p>
										<table style="font-weight: bold; text-align: center;"
											border="1" width="80%">
											<thead>
												<tr>
													<td style="background-color: gray;" width="100"><b>분류</b></td>
													<td style="background-color: gray;" width="100"><b>수집∙이용목적</b></td>
													<td style="background-color: gray;" width="100"><b>수집∙이용항목</b></td>
													<td style="background-color: gray;" width="100"><b>보유
															및 이용기간</b></td>
												</tr>
												<tr>
													<td style="text-align: center;" width="100">구독회원 신청</td>
													<td style="text-align: center;" width="100">소식지 발송</td>
													<td style="text-align: center;" width="100">이메일</td>
													<td style="text-align: center;" width="100">구독 종료시
														즉시&nbsp;삭제</td>
												</tr>
											</thead>
										</table>
										<p style="font-weight: bold;"></p>
										<div style="font-weight: bold; text-align: center;">
											<br>
										</div> <b> 1.3 이벤트 참여 회원 </b>
										<p style="font-weight: bold;"></p>
										<p style="font-weight: bold;">이벤트 참여 회원은 도담도담에서 운영하는
											소셜미디어(페이스북, 카카오스토리, 트위터, 인스타그램, 카페 등) 및 도담도담 사이트의 게시판 등을 통하여
											진행하는 이벤트에 참여한 회원을 말합니다.</p>
										<table border="1" width="80%" style="font-weight: bold;">
											<thead>
												<tr>
													<td
														style="text-align: center; background-color: gray; width: 154.117px;"><b>분
															류</b></td>
													<td
														style="text-align: center; background-color: gray; width: 301.717px;"><b>수집항목</b></td>
													<td style="background-color: gray;">
														<div style="text-align: center;">
															<b>이용</b><b>목적</b>
														</div>
													</td>
													<td style="text-align: center; background-color: gray;"><b>보유∙파기</b></td>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>
														<div style="text-align: center;">
															<span style="background-color: transparent;">이벤트&nbsp;</span>
														</div>
														<div style="text-align: center;">
															<span style="background-color: transparent;">응모</span>
														</div>
													</td>
													<td>이름, 소셜 미디어 ID/도담도담 ID</td>
													<td style="text-align: center; width: 168.117px;">당첨자
														선정</td>
													<td rowspan="2" style="width: 177.767px;">수집된 정보는 도담도담
														이벤트 종료 후 30일 이내 파기</td>
												</tr>
												<tr>
													<td style="text-align: center;">이벤트&nbsp; 당첨</td>
													<td>배송 상품: 성명, 연락처, 주소 <br> 문자상품권(기프티쇼): 이름, 연락처
														<br> 도담도담캐시: 도담도담ID (이메일), 이름, 연락처
													</td>
													<td>
														<div style="text-align: center;">
															<span style="background-color: transparent;">경품&nbsp;</span><span
																style="background-color: transparent;">전달</span>
														</div>
													</td>
												</tr>
											</tbody>
										</table> <br> 1.4 크리에이터 회원
										<p></p>
										<p style="font-weight: bold;">크리에이터란 도담도담에서 제공하는 실시간 영상
											스트리밍 채널을 이용한 상품 판매 서비스인 도담도담라이브를 이용하여 상품을 판매하고자 실시간 영상 및 음성
											스트리밍 서비스 기능을 이용하는 회원을 의미합니다.</p>
										<table border="1" width="80%" style="font-weight: bold;">
											<thead>
												<tr>
													<td style="text-align: center; background-color: gray;"><b>수집
															이용 목적</b></td>
													<td style="text-align: center; background-color: gray;"><b>수집
															이용 항목</b></td>
													<td style="text-align: center; background-color: gray;"><b>보유기간</b></td>
												</tr>
												<tr>
													<td>크리에이터 신청 확인 및 결과 안내</td>
													<td>이메일 주소, 소속 에이전시 여부 및 에이전시 이름</td>
													<td colspan="1" rowspan="4">크리에이터 탈퇴 시 지체 없이 삭제 (단,
														관계법령에 정해진 규정에 따라 법정기간 동안 보관)</td>
												</tr>
												<tr>
													<td>이용자 및 판매자 대상 노출</td>
													<td>이메일 주소, 닉네임, 프로필 사진</td>
												</tr>
												<tr>
													<td>도담도담 라이브 서비스 운영, 긴급연락망 구축</td>
													<td>이름, 휴대폰 번호</td>
												</tr>
												<tr>
													<td>서비스 기능 개선을 위한 지표 확인</td>
													<td>내외국인 여부, 성별</td>
												</tr>
											</thead>
										</table>
										<p style="font-weight: bold;">
											<br>
										</p>
										<p style="font-weight: bold;">
											1.5 개인정보 수집 방법<br> 가. 회원가입 및 서비스이용 과정에서 이용자가 개인정보 수집에
											대하여 동의하고 직접 입력<br> 나. 고객센터를 통한 상담과정에서 웹페이지, 메일, 팩스, 전화
											등을 통한 수집<br> 다. 온/오프라인에서 진행되는 이벤트, 행사 등 참여<br> 라.
											로그분석 프로그램을 통한 생성정보 수집, '쿠키(cookie)'에 의한 정보 수집<br> <br>
											1.6 법령에 의하여 수집∙이용되는 회원 정보
										</p>
										<p style="font-weight: bold;"></p>
										<table border="1" width="80%" style="font-weight: bold;">
											<tbody>
												<tr>
													<td style="text-align: center; background-color: gray;"><b>보유정보</b></td>
													<td style="text-align: center; background-color: gray;"><b>보유기간</b></td>
													<td style="text-align: center; background-color: gray;"><b>근거법령</b></td>
												</tr>
												<tr>
													<td>대금결제 및 재화 등의 공급에 관한 기록</td>
													<td>5 년</td>
													<td>전자상거래 등에서의 소비자보호에 관한 법률</td>
												</tr>
												<tr>
													<td>계약 또는 청약철회 등에 관한 기록</td>
													<td>5 년</td>
													<td colspan="1" rowspan="3">전자상 거래 등에서의 소비자보호에 관한 법률</td>
												</tr>
												<tr>
													<td>소비자의 불만 또는 분쟁 처리에 관한 기록</td>
													<td>3 년</td>
												</tr>
												<tr>
													<td>표시·광고에 관한 기록</td>
													<td>6 개월</td>
												</tr>
												<tr>
													<td>전자금융 거래에 관한 기록</td>
													<td>5 년</td>
													<td>전자금융거래법</td>
												</tr>
												<tr>
													<td>위치정보취급대장</td>
													<td>6 개월</td>
													<td>위치정보의 보호 및 이용 등에 관한 법률</td>
												</tr>
												<tr>
													<td>웹사이트 방문 기록</td>
													<td>3 개월</td>
													<td>전자금융거래법</td>
												</tr>
											</tbody>
										</table>
										<p style="font-weight: bold;">
											<strong><br> </strong>
										</p>
										<p style="font-weight: bold;">
											<a><strong>2. 개인정보의 제공</strong></a> <br> 2.1 일반 이용 회원
										</p>
										<p style="font-weight: bold;">주문과 결제가 이루어진 경우, 상담 및 배송 등의
											원활한 거래 이행을 위하여 관련된 정보를 필요한 범위 내에서 판매자(제3자)에게 전달합니다. 제공받은 자의
											자세한 정보는 아래의 ‘제공받는 자’의 각 항목을 클릭하시면 확인 할 수 있습니다.&nbsp;&nbsp;</p>
										<table border="1" width="80%" style="font-weight: bold;">
											<thead>
												<tr>
													<td style="text-align: center; background-color: gray;"
														width="20%"><b>제공받는 자</b></td>
													<td style="text-align: center; background-color: gray;"
														width="25%"><b>제공 목적</b></td>
													<td style="text-align: center; background-color: gray;"
														width="35%"><b>제공 정보</b></td>
													<td style="text-align: center; background-color: gray;"
														width="20%"><b>보유 및 이용기간</b></td>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td width="20%"><a
														href="http://www.DodamDodam.com/np/etc/trustCompany">쿠폰
															상품 제공업체</a></td>
													<td width="25%">서비스 제공,&nbsp;구매자 확인,&nbsp;해피콜</td>
													<td width="35%">성명,&nbsp;휴대전화번호<br> ※&nbsp;서비스
														유형에 따라 주소가 제한적으로 제공될 수 있습니다.
													</td>
													<td rowspan="7" width="20%">재화 또는 서비스의 제공 목적이 달성된 후
														파기(단,&nbsp;관계법령에 정해진 규정에 따라 법정기간 동안 보관)</td>
												</tr>
												<tr>
													<td width="20%">공연/전시/체험상품 제공 업체</td>
													<td width="25%">서비스 제공,&nbsp;구매자 확인,&nbsp;해피콜</td>
													<td width="35%">성명,&nbsp;휴대전화번호</td>
												</tr>
												<tr>
													<td width="20%"><a
														href="http://www.DodamDodam.com/np/etc/trustCompany">배송
															상품 제공업체</a></td>
													<td width="25%">서비스 제공,&nbsp;사은 행사,&nbsp;구매자
														확인,&nbsp;해피콜</td>
													<td width="35%">성명,&nbsp;휴대전화번호,&nbsp;배송지주소,&nbsp;이메일<br>
														※&nbsp;구매자와 수취인이 다를 경우에는 수취인의 정보(해외 배송 상품은 개인고유통관부호 포함)가
														제공될 수 있습니다.
													</td>
												</tr>
												<tr>
													<td width="20%"><a
														href="http://www.DodamDodam.com/np/etc/trustCompany">여행
															상품 제공업체</a></td>
													<td width="25%">서비스 제공,&nbsp;예약확인,&nbsp;해피콜</td>
													<td width="35%">성명,&nbsp;휴대전화번호,&nbsp;이메일<br> ※
														서비스의 유형에 따라,&nbsp;동반인정보(이름)&nbsp;등 추가적인 정보가 제공될 수 있습니다.
													</td>
												</tr>
												<tr>
													<td width="20%">관할 세무서</td>
													<td width="25%">국세청 고시에 따른 주류 통신판매 주문에 대한 분기별 명세를 세무서에
														제공</td>
													<td width="35%">구입자
														인적사항(주소,&nbsp;성명,&nbsp;생년월일),&nbsp;주문일자,&nbsp;상품명,&nbsp;수량,&nbsp;주문금액</td>
												</tr>
												<tr>
													<td width="20%">해외직구 상품 제공업체- DodamDodam Global
														LLC(미국)</td>
													<td width="25%">서비스제공,&nbsp;구매자확인,&nbsp;해피콜,&nbsp;통관업무처리※&nbsp;물품
														구매 시 구매내역 전달</td>
													<td width="35%">성명,&nbsp;휴대전화번호,&nbsp;배송지주소,&nbsp;개인통관고유부호<br>
														※&nbsp;구매자와 수취인이 다를 경우에는 수취인의 정보가 제공될 수 있습니다.
													</td>
												</tr>
												<tr>
													<td width="20%">해외직구 상품 제공업체-DodamDodam Shanghai
														Trading Co., Ltd.(중국)</td>
													<td width="25%">서비스제공,&nbsp;구매자확인,&nbsp;해피콜,&nbsp;통관업무처리※&nbsp;물품
														구매 시 구매내역 전달</td>
													<td width="35%">성명,&nbsp;휴대전화번호,&nbsp;배송지주소,&nbsp;개인통관고유부호<br>
														※&nbsp;구매자와 수취인이 다를 경우에는 수취인의 정보가 제공될 수 있습니다.
													</td>
												</tr>
											</tbody>
										</table>
										<p style="font-weight: bold;">
											※ 동의 거부권 등에 대한 고지<br> 개인정보 제공은 서비스 이용을 위해 꼭 필요합니다. 개인정보
											제공을 거부하실 수 있으나, 이 경우 서비스 이용이 제한될 수 있습니다. 개인정보 제3자 제공은 구매 시에만
											이뤄지며, 명확한 내용은 구매 시 안내하여 드립니다.로켓배송상품은 도담도담이 직접 배송하는 상품으로,
											개인정보를 제3자(판매자)에게 제공하지 않습니다.<br> <br> 2.2 개인신용정보 제공
											및 조회
										</p>
										<p style="font-weight: bold;"></p>
										<table border="1" width="80%" style="font-weight: bold;">
											<thead>
												<tr>
													<td style="text-align: center; background-color: gray;"
														width="20%"><b>제공/조회받는 자</b></td>
													<td style="text-align: center; background-color: gray;"
														width="25%"><b>제공/조회 목적</b></td>
													<td style="text-align: center; background-color: gray;"
														width="35%"><b>제공/조회 정보</b></td>
													<td style="text-align: center; background-color: gray;"
														width="20%"><b>보유 및 이용기간</b></td>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td width="20%">코리아 크레딧뷰로 주식회사, NICE 평가정보 주식회사</td>
													<td width="25%">신용등급, 신용점수, 신용정보 내역 확인, 신용도 평가, 신용관련
														모형개발 및 (통계)분석, 맞춤서비스제공을 위한 통계정보 확인, 개인신용평가회사의 업무(연체정보 등록
														등), 본 계약 및 본 계약 이전 발생 계약의 유지 또는 사후관리</td>
													<td width="35%">[제공] 이름, 생년월일, 성별, 휴대폰번호,
														중복가입확인정보(DI), 고객번호, 서비스 가입 일시, 결제 및 연체 현황<br> <br>[조회]
														신용도판단정보: 연체, 대위변제, 대지급 정보, 보증현황, 채무불이행정보, 공공정보, 금융질서 문란정보
														등 신용거래정보: 대출현황 및 보증채무현황, 보유한 신용카드 이용 현황, 이동통신사 소액결제 이용 현황
														등과 이에 따른 실적을 포함한 거래내용 신용능력정보: 재산·채무·소득의 총액, 납세실적 신용등급 및
														평점정보: 신용등급, 신용점수, 경력·이력사항, 신용정보 변동 내역, 이동 통신사 이용 내역 등 기타
														신용도 판단에 필요한 개인신용정보
													</td>
													<td width="20%">[제공]관계법령에 따른 보관의무 기간 동안 보관<br> <br>[조회]서비스
														이용 종료일까지
													</td>
												</tr>
											</tbody>
										</table> <br> 2.3 크리에이터 회원
										<p></p>
										<p style="font-weight: bold;">상품 발송을 위하여 관련된 정보를 필요한 범위
											내에서 계약한 공급자 또는 판매자(제3자)에게 전달합니다. 제공받은 자의 자세한 정보는 아래의 ‘제공받는
											자’의 각 항목을 클릭하시면 확인 할 수 있습니다.&nbsp;&nbsp;</p>
										<table border="1" width="80%" style="font-weight: bold;">
											<thead>
												<tr>
													<td style="text-align: center; background-color: gray;"
														width="20%"><b>제공받는 자</b></td>
													<td style="text-align: center; background-color: gray;"
														width="25%"><b>제공 목적</b></td>
													<td style="text-align: center; background-color: gray;"
														width="35%"><b>제공 정보</b></td>
													<td style="text-align: center; background-color: gray;"
														width="20%"><b>보유 및 이용기간</b></td>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td width="20%">크리에이터와 계약한 공급자 또는 판매자</td>
													<td width="25%">상품발송</td>
													<td width="35%">이름, 연락처, 주소</td>
													<td width="20%">상품 발송 후 지체없이 파기 (단, 관계법령에 정해진 규정에 따라
														법정기간 동안 보관)</td>
												</tr>
											</tbody>
										</table> <br>
										<p></p>
										<p style="font-weight: bold;">
											<strong><br> </strong>
										</p>
										<p style="font-weight: bold;">
											<a><strong>3. 개인정보의 위탁</strong></a><br> 도담도담은 위탁한 개인정보를
											수탁자들이 안전하게 처리하고 있는지 지속적으로 관리 감독하고 있으며, 수탁 업무가 종료된 때에 수탁자가
											보유하고 있는 개인정보는 즉시 파기하도록 하고 있습니다.<br> <br> 3.1 개인정보
											국내 처리 위탁 현황
										</p>
										<table border="1" width="80%" style="font-weight: bold;">
											<thead>
												<tr>
													<td style="text-align: center; background-color: gray;"><b>구분</b></td>
													<td style="text-align: center; background-color: gray;"><b>수탁자</b></td>
													<td style="text-align: center; background-color: gray;"><b>위탁업무</b></td>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td style="width: 16.648%;">
														<p>고객상담</p>
													</td>
													<td style="width: 52.0006%;">
														<p>주식회사KS한국고용정보, 주식회사 트랜스코스모스코리아, U-BASE</p>
													</td>
													<td style="width: 28.9189%;">
														<p>고객 및 주문 정보 이용관리 등 콜센터 업무의 일체</p>
													</td>
												</tr>
												<tr>
													<td style="width: 16.648%;">
														<p>본인확인</p>
													</td>
													<td style="width: 52.0006%;">
														<p>한국모바일인증㈜, NHN한국사이버결제</p>
													</td>
													<td style="width: 28.9189%;">
														<p>본인인증</p>
													</td>
												</tr>
												<tr>
													<td style="width: 16.648%;" rowspan="4">
														<p>배송서비스</p>
													</td>
													<td style="width: 52.0006%;">
														<p>
															한진택배,&nbsp;천일정기화물, CJ대한통운, 롯데글로벌로지스, 도담도담로지스틱스서비스,&nbsp;<a
																href="http://www.DodamDodam.com/np/etc/trustPartners">개인
																배송사업자</a>
														</p>
														<p>삼성전자주식회사, SK매직㈜, LG전자주식회사, 주식회사위니온, 주식회사 하우저</p>
														<p>※ 로켓배송 상품 이외에는 판매자가 계약한 배송업체가 이용됩니다.</p>
													</td>
													<td style="width: 28.9189%;">
														<p>상품(음식 포함) 및 경품의 배송</p>
													</td>
												</tr>
												<tr>
													<td style="width: 52.0006%;">
														<p>㈜굿스플로</p>
													</td>
													<td style="width: 28.9189%;">
														<p>배송조회</p>
													</td>
												</tr>
												<tr>
													<td style="width: 52.0006%;">
														<p>LGU+,&nbsp;주식회사 케이티,&nbsp;SKTelink</p>
													</td>
													<td style="width: 28.9189%;">
														<p>안심번호서비스</p>
													</td>
												</tr>
												<tr>
													<td style="width: 52.0006%;">
														<p>도담도담풀필먼트서비스유한회사</p>
													</td>
													<td style="width: 28.9189%;">
														<p>물류센터 업무 일체</p>
													</td>
												</tr>
												<tr>
													<td style="width: 16.648%;">
														<p>알림 발송</p>
													</td>
													<td style="width: 52.0006%;">
														<p>LGU+,&nbsp;주식회사 케이티,&nbsp;㈜ 카카오,&nbsp;NHN
															주식회사,&nbsp;엘지씨엔에스</p>
													</td>
													<td style="width: 28.9189%;">
														<p>SMS&nbsp;및 메시지 발송</p>
													</td>
												</tr>
												<tr>
													<td style="width: 16.648%;">
														<p>데이터 보관</p>
													</td>
													<td style="width: 52.0006%;">
														<p>Amazon Web Services Inc.</p>
													</td>
													<td style="width: 28.9189%;">
														<p>데이터 보관</p>
													</td>
												</tr>
												<tr>
													<td style="width: 16.648%;">
														<p>데이터 처리</p>
													</td>
													<td style="width: 52.0006%;">
														<p>Microsoft</p>
													</td>
													<td style="width: 28.9189%;">
														<p>이메일,&nbsp;문서/파일 저장과 내부 커뮤니케이션 및 협업 도구</p>
													</td>
												</tr>
												<tr>
													<td style="width: 16.648%;">
														<p>고객 상담 녹취록&nbsp; 저장</p>
													</td>
													<td style="width: 52.0006%;">
														<p>GS 네오텍</p>
													</td>
													<td style="width: 28.9189%;">
														<p>Genesys 시스템 유지보수</p>
													</td>
												</tr>
												<tr>
													<td style="width: 16.648%;" rowspan="3">
														<p>결제 및 요금 정산 처리</p>
													</td>
													<td style="width: 52.0006%;">
														<p>NICE신용정보주식회사</p>
													</td>
													<td style="width: 28.9189%;">
														<p>납부 및 미납 요금 안내, 채권 추심 및 관련 업무</p>
													</td>
												</tr>
												<tr>
													<td style="width: 52.0006%;">
														<p>도담도담페이(주)</p>
													</td>
													<td style="width: 28.9189%;">
														<p>결제 처리 및 결제 도용 방지, 간편결제 서비스 제공 및 운영</p>
													</td>
												</tr>
												<tr>
													<td style="width: 52.0006%;">
														<p>[도담도담페이(주)에 의한 재위탁]&nbsp;NHN&nbsp;한국사이버결제
															주식회사,&nbsp;케이지모빌리언스,&nbsp;한국정보통신주식회사,&nbsp;주식회사
															다날,&nbsp;갤럭시아커뮤니케이션즈㈜, NICE 페이먼츠 주식회사</p>
													</td>
													<td style="width: 28.9189%;">
														<p>신용카드, 휴대폰, 계좌이체, 무통장 입금(가상계좌) 등을 통한 결제처리</p>
													</td>
												</tr>
											</tbody>
										</table>
										<p style="font-weight: bold;">
											<br>
										</p>
										<p style="font-weight: bold;">3.2 개인정보 국외 처리 위탁</p>
										<table border="1" width="80%" style="font-weight: bold;">
											<thead>
												<tr>
													<td style="background-color: gray;">
														<p style="text-align: center;">
															<b>이전&nbsp;받는 자</b>
														</p>
													</td>
													<td style="background-color: gray; width: 75.883px;">
														<p style="text-align: center;">
															<b>이전되는 국가</b>
														</p>
													</td>
													<td style="background-color: gray; width: 150.433px;">
														<p style="text-align: center;">
															<b>이전 일시 및 방법</b>
														</p>
													</td>
													<td style="background-color: gray; width: 150.8px;">
														<p style="text-align: center;">
															<b>이전 항목</b>
														</p>
													</td>
													<td style="background-color: gray;">
														<p style="text-align: center;">
															<b>이용목적 및 <br>처리 기간
															</b>
														</p>
													</td>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>
														<p>DodamDodam Global, LLC</p>
													</td>
													<td>
														<p style="text-align: center;">미국</p>
													</td>
													<td rowspan="3">
														<p>업무 상 개인정보 필요 시 네트워크를 통하여 전송</p>
													</td>
													<td rowspan="3">
														<p>서비스를 사용(가입 및 상담, 결제)하면서 수집·이용되는 개인정보</p>
													</td>
													<td rowspan="3">
														<p>연구개발업무</p>
														<p>업무 완료 시 지체 없이 파기</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>DodamDodam (Shanghai) Co.,&nbsp;Ltd.</p>
														<p>韩领网络科技(上 海)有限公司</p>
													</td>
													<td>
														<p style="text-align: center;">중국</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>DodamDodam (Beijing) Co., Ltd.</p>
														<p>韩领网络科技(北 京)有限公司</p>
													</td>
													<td>
														<p style="text-align: center;">중국</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>IBM Security</p>
													</td>
													<td>
														<p style="text-align: center;">미국</p>
													</td>
													<td>
														<p>업무 상 개인정보 필요 시 네트워크를 통하여 전송</p>
													</td>
													<td>
														<p>서비스를 사용(가입 및 상담, 결제)하면서 수집·이용되는 개인정보</p>
													</td>
													<td>
														<p>보안관제서비스 운영 및 관련 분석</p>
														<p>업무 완료 시 지체 없이 파기</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>Zendesk</p>
													</td>
													<td>
														<p style="text-align: center;">미국</p>
													</td>
													<td>
														<p>업무 상 개인정보 필요 시 네트워크를 통하여 전송</p>
													</td>
													<td>
														<p>고객 정보 (이름, 이메일, 전화번호, 회원번호)</p>
													</td>
													<td>
														<p>보안관제서비스 운영 및 관련 분석</p>
														<p>업무 완료 시 지체 없이 파기</p>
													</td>
												</tr>
											</tbody>
										</table>
										<p style="font-weight: bold;">
											<strong><br> </strong>
										</p>
										<p style="font-weight: bold;">
											<strong><br> <a>4. 개인정보의 파기</a></strong>
										</p>
										<p style="font-weight: bold;">수집된 개인정보의 보유•이용기간은 서비스 이용계약
											체결(회원가입)시부터 서비스 이용계약 해지(탈퇴신청, 직권탈퇴포함)시까지 입니다. 또한 동의 해지 시 고객의
											개인정보를 상기 명시한 정보보유 사유에 따라 일정 기간 저장하는 자료를 제외하고는 지체 없이 파기합니다.
											종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각 등을 통하여 파기하고, 전자적 파일형태로 저장된 개인정보는
											기록을 재생할 수 없는 기술적 방법 또는 물리적 방법을 사용하여 파기합니다.</p>
										<p style="font-weight: bold;">수집•이용목적이 달성된 개인정보의 경우 별도의
											DB에 옮겨져 내부규정 및 관련 법령을 준수하여 안전하게 보관되며, 정해진 기간이 종료되었을 때 지체없이
											파기됩니다. 이때, 별도의 DB로 옮겨진 개인정보는 회원이 동의한 목적을 초과하거나 혹은 법률이 정한 경우
											외의 다른 목적으로 이용되지 않습니다.</p>
										<p style="font-weight: bold;">도담도담을 최종 이용 후 1년 동안 이용 기록이
											없는 고객(장기미이용회원)의 개인정보는 별도로 분리하여 안전하게 관리하게 되며, 대상자에게는 분리 보관
											처리일을 기준으로 하여 최소 30일 이전에 이메일 주소를 통해 안내를 합니다. 단,통신비밀보호법, 전자상거래
											등에서의 소비자보호에 관한 법률 등의 관계법령의 규정에 의하여 보존할 필요가 있는 경우 규정된 기간 동안
											고객의 개인정보를 보관합니다.</p>
										<p style="font-weight: bold;">
											<br>
										</p>
										<p style="font-weight: bold;">
											<a><strong>5. 고객의 권리와 의무</strong></a><br> 5.1 고객의 권리
										</p>
										<p style="font-weight: bold;">고객 및 법정대리인은 언제든지 수집 정보에 대하여
											수정, 동의 철회, 삭제, 열람을 요청할 수 있습니다. 다만, 동의 철회, 삭제 시 서비스의 일부 또는 전부
											이용이 제한될 수 있습니다. 도담도담이 수집한 개인정보는 아래와 같은 방법을 통해 확인할 수 있습니다:</p>
										<p style="font-weight: bold;">
											&nbsp; &nbsp; &nbsp;<b> [수집된 개인정보 확인]</b><br> &nbsp;
											&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;· 도담도담 웹페이지에서 - 도담도담 &gt;
											My 정보 &gt; 개인정보 확인 수정 / 주문목록 / 배송조회<br> &nbsp; &nbsp;
											&nbsp; &nbsp; &nbsp; &nbsp;· 도담도담 모바일앱에서 - 도담도담 &gt; 내정보 관리
											&gt; 회원정보 수정 / 주문목록 / 배송조회<br> <br> 도담도담 웹 또는 앱을 통해
											직접 확인하지 못하는 정보는 도담도담 고객센터(1577-7011, 1:1 채팅문의,
											help@DodamDodam.com)에 요청하여 확인할 수 있습니다.
										</p>
										<p style="font-weight: bold;">개인정보 동의 철회 및 삭제, 처리 정지를
											요청하고자 하는 경우에는 도담도담 고객센터(1577-7011, 1:1 채팅문의,
											help@DodamDodam.com)를 통해 요청할 수 있습니다. 또한, 고객은 언제든 회원탈퇴를 통해
											개인정보의 수집 및 이용 동의를 철회할 수 있습니다. 이러한 요청 시, 서비스의 일부 또는 전부 이용이 제한될
											수 있습니다. 또한, 법률에 특별한 규정이 있거나 법령상 의무를 준수하기 위하여 불가피한 경우, 다른 사람의
											생명·신체를 해할 우려가 있거나 다른사람의 재산과 그 밖의 이익을 부당하게 침해할 우려가 있는 경우,
											개인정보를 처리하지 아니하면 정보 주체와 약정한 서비스를 제공하지 못하는 등 계약의 이행이 곤란한 경우로서
											정보주체가 그 계약의 해지 의사를 명확하게 밝히지 아니한경우에는 동의 철회, 삭제, 처리 정지가 어려울 수
											있습니다.</p>
										<p style="font-weight: bold;">요청하신 처리가 완료될 때까지 해당 정보를
											이용하거나 타인에게 제공하지 않습니다. 또한, 합리적인 사유로 잘못된 개인정보를 제3자에게 이미 제공한 경우,
											그 결과를 지체 없이 제3자에게 통지하여 동의 철회, 삭제, 처리 정지하도록 조치합니다</p>
										<p style="font-weight: bold;">5.2. 고객의 의무</p>
										<p style="font-weight: bold;">고객은 자신의 개인정보를 보호할 의무가 있으며,
											회사의 귀책사유가 없이 ID(이메일 주소), 비밀번호, 접근매체 등의양도·대여·분실이나 로그인 상태에서 이석
											등 고객 본인의 부주의나 관계법령에 의한 보안조치로 차단할 수 없는 방법이나 기술을 사용한 해킹 등 회사가
											상당한 주의에도 불구하고 통제할 수 없는 인터넷상의 문제 등으로 개인정보가 유출되어 발생한 문제에 대해 회사는
											책임을 지지 않습니다. 고객은 자신의 개인정보를 최신의 상태로 유지해야 하며, 고객의 부정확한 정보 입력으로
											발생하는 문제의 책임은 고객 자신에게 있습니다. 타인의 개인정보를 도용한 회원가입 또는 ID등을 도용하여 결제
											처리 시 고객 자격 상실과 함께 관계법령에 의거하여 처벌될 수 있습니다. 고객은 아이디, 비밀번호 등에 대해
											보안을 유지할 책임이 있으며 제3자에게 이를 양도하거나 대여할 수 없습니다. 고객은 회사의 개인정보보호정책에
											따라 보안을 위한 주기적인 활동에 협조할 의무가 있습니다.</p>
										<p style="font-weight: bold;">
											<strong><br> </strong>
										</p>
										<p style="font-weight: bold;">
											<a><strong>6. 자동 수집 장치의 설치/운영 및 그 거부에 관한 사항</strong></a>
										</p>
										<p style="font-weight: bold;">도담도담은 고객의 간편하고 효율적이며 개인 맞춤화된
											쇼핑을 위하여 서비스 이용과정에서 자동으로 생성하는 정보를 저장(수집)하거나 개인식별이 불가능한 기기 정보를
											수집하고 저장할 수 있습니다. 도담도담은 이러한 자동 생성 정보 중 어떠한 정보를 수집하며 어떻게 수집 거부를
											설정할 수 있는지 안내합니다.</p>
										<p style="font-weight: bold;">6.1. 쿠키</p>
										<p style="font-weight: bold;">
											쿠키(Cookie)는 사용자의 효율적이고 안전한 웹 사용을 보장하기 위해 웹사이트 접속 시 사용자의 디바이스로
											전송 및 저장되는 작은 텍스트 파일입니다. 쿠키가 저장된 이후 다시 웹사이트를 방문할 경우 쿠키는 웹사이트
											사용자의 디바이스를 인식하여 지난 설정과 과거 이용내역을 자동으로 불러옵니다. 또한 방문한 서비스 정보,
											서비스 접속 시간 및 빈도,서비스 이용 과정에서 생성된 또는 제공(입력)한 정보 등을 분석하여 고객의 취향과
											관심에 특화된 서비스(광고 포함)를 제공할 수 있습니다. 고객은 쿠키에 대한 선택권을 가지고 있으며,
											웹브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든
											쿠키의 저장을 거부할 수도 있습니다.<br> <br> &nbsp; &nbsp; &nbsp;<b>
												[쿠키 설정 변경 방법]</b><br> &nbsp; &nbsp; &nbsp; 현재 사용하는 브라우저의 쿠키
											설정 확인 및 변경은 아래와 같은 방법을 통해 가능합니다.
										</p>
										<p style="font-weight: bold;">
											&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;• Internet Explorer를
											사용하는 경우 쿠키 설정 방법 <a
												href="https://support.microsoft.com/ko-kr/help/17442/windows-internet-explorer-delete-manage-cookies">보기</a><br>
											&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;• Safari를 사용하는 경우 쿠키
											설정 방법 <a
												href="https://support.apple.com/ko-kr/guide/safari/sfri11471/mac">보기</a><br>
											&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;• FireFox를 사용하는 경우
											쿠키 설정 방법 <a
												href="https://support.mozilla.org/ko/kb/delete-cookies-remove-info-websites-stored">보기</a><br>
											&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;• Chrome 브라우저를 사용하는
											경우 쿠키 설정 방법 <a
												href="https://support.google.com/chrome/answer/95647?co=GENIE.Platform%3DDesktop&amp;hl=ko">보기</a><br>
											<br> 6.2. 맞춤형 광고
										</p>
										<p style="font-weight: bold;">
											고객에게 맞춤형 광고를 제공하기 위하여 도담도담은 웹 브라우저에서는 ‘쿠키’, 모바일 앱에서는
											광고식별자(ADID)를 수집하여 사용합니다. 도담도담은 쿠키 및 광고식별자를 통해 고객의 서비스 사용 이력을
											자동으로 수집하여 페이스북 및 Criteo(Tune을 통해서도 전달됨)에 제공합니다. 페이스북 및
											Criteo(Tune)는 이를 활용하여 고객 맞춤 광고를 진행합니다. 도담도담에서 수집하는 쿠키 및
											광고식별자는 다른 개인정보와 연계되지 않으며 개인을 식별하지 않습니다. 또한, 페이스북 및 Criteo는
											도담도담에서 제공하는 정보를 활용하여 개인을 식별하지 않습니다.<br> <br> 사용자는
											언제든지 이러한 맞춤형 광고 수신을 거부할 수 있으며, 이 경우 맞춤형 광고가 아닌 임의의 광고가 노출됩니다.
										</p>
										<p style="font-weight: bold;">
											<strong><br> </strong>
										</p>
										<p style="font-weight: bold;">
											<a><strong>7. 개인정보 보호책임자 및 담당자 안내</strong></a>
										</p>
										<p style="font-weight: bold;">고객의 개인정보에 관한 업무를 총괄해서 책임지고,
											개인정보와 관련된 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자 및 담당부서를 지정하여
											운영하고 있습니다. 회사가 제공하는 서비스를 이용하면서 발생하는 모든 개인정보 보호 관련 문의, 불만,
											피해구제 등에 관한 사항은 아래로 연락하여 문의할 수 있습니다. 도담도담은 이러한 문의에 대해 지체 없이 답변
											및 처리할 것입니다.</p>
										<table border="1" width="80%" style="font-weight: bold;">
											<tbody>
												<tr>
													<td style="background-color: gray;" width="220">
														<p style="text-align: center;">
															<b>개인정보 보호책임자</b>
														</p>
													</td>
													<td style="background-color: gray;" width="226">
														<p style="text-align: center;">
															<b>개인정보 민원처리 담당부서</b>
														</p>
													</td>
												</tr>
												<tr>
													<td width="220">
														<p>성명:&nbsp;Max Leveson</p>
														<p>연락처: 1577-7011</p>
														<p>이메일: help@DodamDodam.com</p>
													</td>
													<td width="226">
														<p>부서명: 도담도담 고객센터</p>
														<p>연락처: 1577-7011</p>
														<p>이메일: help@DodamDodam.com</p>
														<p>도담도담이츠 관련 개인정보 민원처리</p>
														<p>연락처: 1670-9827</p>
													</td>
												</tr>
											</tbody>
										</table>
										<p style="font-weight: bold;">
											<br> 기타 개인정보 침해 신고나 상담이 필요하신 경우에는 아래 기관에 문의 가능합니다.<br>
											&nbsp; &nbsp; &nbsp; ▶ 개인정보 침해신고센터: (국번없이) 118 / (웹사이트: <a
												href="http://privacy.kisa.or.kr/">privacy.kisa.or.kr</a>)<br>
											&nbsp; &nbsp; &nbsp; ▶ 대검찰청 사이버범죄수사단 : (국번없이) 1301 / (웹사이트: <a
												href="http://www.spo.go.kr/">www.spo.go.kr</a>)<br>
											&nbsp; &nbsp; &nbsp; ▶ 경찰청 사이버안전국 : (국번없이) 182 / (웹사이트: <a
												href="http://www.cyber.go.kr/">cyberbureau.police.go.kr</a>)
										</p>
										<p style="font-weight: bold;">
											<strong><br> </strong>
										</p>
										<p style="font-weight: bold;">
											<a><strong>8. 고지의 의무</strong></a>
										</p>
										<p style="font-weight: bold;">이 개인정보 처리방침은 시행일로부터 적용됩니다.
											고객의 개인정보 권리에 중요한 변경 사유가 발생하는 경우 최소 14일전에 도담도담 공지사항을 통하여
											고지합니다. 이 외의 다른 변경사항이 발생하는 경우에는 변경사항의 시행 최소 7일 전부터 공지사항을 통해
											고지합니다.</p>
										<p style="font-weight: bold;">
											<br> 개인정보 처리방침 버전 번호: 9.3<br> <br> 현재 개인정보
											처리방침 공고일자: 2020년 12월 29일<br> 현재 개인정보 처리방침 시행일자: 2021년 1월
											4일
										</p> <br> <br> <br> <br> <br>
										<div id="promise-en" style="font-weight: bold;">
											<h2 style="text-align: center;">Our Privacy Promise</h2>
											<div>
												<br>
											</div>
											<ul style="text-align: right; list-style: none;">
												<li><a class="anchor-link " href="#promise-kr">고객의
														개인정보를 위한 도담도담의 약속</a></li>
												<li><a class="anchor-link" href="#notice-kr">개인정보
														처리방침</a></li>
												<li><a class="anchor-link highlighted-link"
													href="#promise-en">Our Privacy Promise</a></li>
												<li><a class="anchor-link" href="#notice-en">Privacy
														Notice</a></li>
											</ul>
										</div>
										<p style="text-align: right;">
											<br>
										</p>
										<p style="">A personalized online shopping experience
											should not come at the expense of your right to data privacy,
											and that is why, at DodamDodam, the protection of your
											information is important to us and to how we operate. We are
											dedicated to delivering an innovative, fast, seamless and
											safe shopping experience from our online store until your
											package arrives and beyond. We want the experience to be so
											exceptional that we create a world in which our Customers
											ask: “How did I ever live without DodamDodam?”</p>
										<p style="">Our Customers are at the heart of our business
											and keeping your data safe is the starting point for our
											innovation – it is core to everything that we do as we look
											for ways to deliver better service, convenience and value.</p>
										<p style="font-weight: bold;">
											<b><br> </b>
										</p>
										<p style="font-weight: bold;">
											<b>It is your personal information, and we will always
												respect it</b>
										</p>
										<p style="">You trust us with your personal information,
											and we do not sell it on to third parties. We do share
											limited information with our direct partners so that we can
											fulfill an order or improve your overall experience, but we
											will always tell you who they are and what we are sharing.</p>
										<p style="">DodamDodam is a data-driven business. The use
											of data to improve the Customer experience is a founding
											principle of DodamDodam and remains so today.</p>
										<p style="font-weight: bold;">
											<br> <b>Innovation: personalizing your experience
												while keeping your data safe</b>
										</p>
										<p style="">Your data allows us to innovate and offer a
											personal, fast, and safe shopping experience. This includes
											tailoring recommendations to your individual needs and
											preferences so that your DodamDodamman or DodamDodam-Flex
											driver delivers your parcels when, where and how you want
											them.</p>
										<p style="">Our understanding of data and a strong
											commitment to security and privacy are central to how we
											develop new and exciting services like Rocket Pay. Built from
											scratch, Rocket Pay is a simple to use, yet highly secure
											payment platform that, through sophisticated encryption and
											data analytics, allows for One-Touch Payment which is as safe
											as it is user-friendly and fast.</p>
										<p style="font-weight: bold;">
											<b><br> </b>
										</p>
										<p style="font-weight: bold;">
											<b>Combining the power of technology with world-leading
												experts to keep you protected</b>
										</p>
										<p style="">The importance of providing secure and trusted
											services is deeply embedded within the culture of DodamDodam.</p>
										<p style="">We have world-leading systems and technology
											to keep your information safe and secure. Our expert team
											monitors these systems around the clock, upgrading processes
											to adapt to changing cyber threats as they emerge. This is
											supported by continued and significant investment into
											security and privacy to make sure our standards are aligned
											with, and where possible exceed global best practice.</p>
										<p style="">Our dedicated security and privacy teams train
											our staff in how to handle data. We aim to empower and
											encourage our people to challenge existing practices and
											believe it is the shared responsibility of every employee at
											DodamDodam to remain vigilant and committed to data security.</p>
										<p style="">We are also committed to working closely with
											governments and regulators to help shape the future of our
											industry.</p> <br>
									</span>
									<table style="width: 100%">
									</table>
									<table>
									</table>
									<table border="0">
										<tbody>
											<tr>
												<td><b>Yuezhong Bao</b></td>
												<td><b>Max Leveson</b></td>
											</tr>
											<tr>
												<td><b>Chief Information Security Officer</b></td>
												<td><b>Chief Privacy Officer</b></td>
											</tr>
										</tbody>
									</table>
									<p>
										<br> <br>
									</p>
									<div id="notice-en">
										<h2 style="text-align: center;"></h2>
										<h2 style="text-align: center;">
											Privacy Notice<br> <font size="3">(Ver. 9.3)</font>
										</h2>
										<ul style="text-align: right; list-style: none;">
											<li><a class="anchor-link " href="#promise-kr">고객의
													개인정보를 위한 도담도담의 약속</a></li>
											<li><a class="anchor-link" href="#notice-kr">개인정보
													처리방침</a></li>
											<li><a class="anchor-link" href="#promise-en">Our
													Privacy Promise</a></li>
											<li><a class="anchor-link highlighted-link"
												href="#notice-en">Privacy Notice</a></li>
										</ul>
									</div>
									<p>
										<b><br></b>
									</p>
									<p>
										<b>DodamDodam Corp. (“DodamDodam” or “Us” or “We”) is
											committed to protecting personal data at all times. Our
											dedication to delivering to our Customers an innovative,
											fast, seamless and safe experience, will not come at the
											expense of your right to data privacy.</b><br>
									</p>
									<p>
										<b>We are committed to ensuring that the way we conduct
											our business is compliant with applicable data protection and
											privacy laws in the Republic of Korea, including the Act on
											Promotion of Information and Communications Network
											Utilization and Information Protection (“the Network Act”),
											and the Personal Information Protection Act (“PIPA”).</b>
									</p>
									<p>This Notice describes our privacy practices and informs
										Customers of their data privacy rights and how to exercise
										them. It also contains important contact information to help
										Customers in submitting questions or queries in relation to
										data protection and privacy matters.</p>
									<p>We will promptly notify our Customers of any changes
										made to this Notice that may impact their personal data.</p>
									<p>
										<strong><br></strong>
									</p>
									<p>
										<strong>Table of Contents</strong>
									</p>
									<p>
										<b> <a href="#en-1">1. Types of Personal Data
												Collected and Used</a><br> <a href="#en-2">2. Provision
												of Personal Data</a><br> <a href="#en-3">3. Consignment
												of Personal Data Processing</a><br> <a href="#en-4">4.
												Disposal of Personal Data</a><br> <a href="#en-5">5.
												Rights and Obligations of Customers</a><br> <a href="#en-6">6.
												Installation/Operation of Automatic Data Collection Tool and
												How to Opt Out</a><br> <a href="#en-7">7. The Chief
												Privacy Officer and Staff Responsible for Privacy Inquires</a><br>
											<a href="#en-8">8. Obligation of Notification</a><br>
										</b> <br> &nbsp;<br> <a><strong>1. Types of
												Personal Data Collected and Used</strong></a><br> 1.1 DodamDodam
										Members<br>“DodamDodam members” refer to Customers who
										sign up via the DodamDodam website or DodamDodam mobile app.
									</p>
									<table border="1" width="80%">
										<thead>
											<tr>
												<td style="background-color: gray;" width="20%">
													<p style="text-align: center;">
														C<b>lassification</b>
													</p>
												</td>
												<td style="background-color: gray;" width="291">
													<p style="text-align: center;">
														<b>Purpose of <br>Collection and Use
														</b>
													</p>
												</td>
												<td style="background-color: gray;" width="311">
													<p style="text-align: center;">
														<b>Items to be Collected and Used</b>
													</p>
												</td>
												<td style="background-color: gray;" width="111">
													<p style="text-align: center;">
														<b>Period of Retention and Use</b>
													</p>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td rowspan="2" width="20%">
													<p>Required data</p>
												</td>
												<td rowspan="2" width="291">Member sign-up; service use
													and customer service; Fraud monitoring and prevention;
													Providing refund or recall; maintaining transaction records</td>
												<td width="311">
													<p>Name, contact information (mobile phone number), ID
														(email address), password</p>
												</td>
												<td rowspan="2" width="111">Deleted immediately upon
													withdrawal of membership.<br> <br> Information
													for preventing fraud (ID, fraud history) is deleted from
													the withdrawn member database after six months.<br> <br>
													Information for retaining transaction records (e.g., ID,
													bank account number, shipping address) is stored for five
													years (Act on the Consumer Protection in Electronic
													Commerce)<br> <br> IP address is retained for 3
													months (Protection of Communications Secrets Act)
												</td>
											</tr>
											<tr>
												<td width="291">
													<p>Shipping address, service usage history (date and
														time of visit, IP address, etc.), device information
														(type, OS version)</p>
												</td>
											</tr>
											<tr>
												<td rowspan="10" width="20%">
													<p>Additional data</p>
												</td>
												<td width="131">
													<p>Identity and age&nbsp;verification</p>
												</td>
												<td>Verification with mobile phone: name, date of
													birth, sex, mobile carrier, mobile phone number, Duplicate
													Information (“DI”), Connecting Information (“CI”),
													nationality (Korean or other citizens)</td>
												<td rowspan="5" width="291">These data types are
													deleted immediately upon withdrawal of membership.<br>
													<br> Customer identification Information for
													preventing fraud (DI, CI) is deleted from the withdrawn
													member database after six months from the fraudulent use<br>
													<br> In order to retain transaction records, Customer
													identification information (DI, CI) and payment, order
													cancellation, refund, and shipping information are stored
													for five years (Act on the Consumer Protection Electronic
													Commerce, Etc.)
												</td>
											</tr>
											<tr>
												<td width="131">
													<p>Cancellation,&nbsp;refund</p>
												</td>
												<td width="291">
													<p>Account holder’s name, bank name, bank account
														number</p>
												</td>
											</tr>
											<tr>
												<td width="131">
													<p>Shipping</p>
												</td>
												<td width="291">
													<p>Recipient information (name, contact information,
														address)</p>
												</td>
											</tr>
											<tr>
												<td width="131">
													<p>Travel</p>
												</td>
												<td width="291">User’s and companion’s information
													(Korean/English name)<br> * Additional information
													(e.g., date of birth) can be collected depending on the
													type of service.
												</td>
											</tr>
											<tr>
												<td width="131">
													<p>Gift card</p>
												</td>
												<td width="291">
													<p>Recipient’s name and contact information</p>
												</td>
											</tr>
											<tr>
												<td width="131">
													<p>Traditional liquor purchasing management and report
														to authorities</p>
												</td>
												<td width="291">
													<p>Purchaser's personal data (name, date of birth,
														address)</p>
												</td>
												<td width="291">
													<p>These data types are deleted immediately upon
														withdrawal of membership after completing tax office
														reporting.</p>
												</td>
											</tr>
											<tr>
												<td width="131">
													<p>Customs duty&nbsp;processing and&nbsp;customs
														clearance</p>
												</td>
												<td width="291">
													<p>Personal Customs Clearance Code (PCCC)</p>
												</td>
												<td width="291">
													<p>These data types are deleted immediately upon the
														user’s request for deletion of his or her information or
														withdrawal of membership.</p>
												</td>
											</tr>
											<tr>
												<td width="131">
													<p>Foreign&nbsp;substances report(applicable
														to&nbsp;DodamDodam Eats&nbsp;only)</p>
												</td>
												<td width="291">
													<p>Name, contact information, restaurant address</p>
												</td>
												<td width="291">
													<p>Three years from the submission of the report (Act
														on the Consumer Protection in Electronic Commerce, Etc.)</p>
												</td>
											</tr>
											<tr>
												<td width="131">
													<p>User identification, Write reviews(Post messages),
														Customer service</p>
												</td>
												<td width="291">
													<p>DodamDodam Play nickname and profile picture</p>
												</td>
												<td width="291">
													<p>Deleted without delay when the customer terminates
														the Terms of service (Wow Membership)</p>
												</td>
											</tr>
											<tr>
												<td width="131">
													<p>To verify credit rating and score; provide
														credit-related financial information; inquire and register
														personal credit information from/to the credit bureau or
														public credit registry; provide counseling; handle
														complaints; send notice; retain records for dispute
														mediation; settle fees according to the use of service;
														prevent fraud for safe use of the service; analyze service
														use records and access frequency; provide statistics on
														service use; use for service improvement; provide
														customized service; and maintain and provide follow-up
														management of this contract and the ones before.</p>
												</td>
												<td width="291">
													<p>
														- Personal credit information (name, date of birth,
														gender, mobile phone number, DI (Duplicate Information),
														customer number, date of service subscription, and
														payment/ overdue status) <br> <br> - Personal
														credit information to be inquired from the credit bureau
														(Korea Credit Bureau): Credit rating, credit score, credit
														information change history, credit information view
														history (name of institution, date, purpose), card
														information (card company, cards owned, use history,
														limit, card loan history, overdue amount), loan
														information (name of institution, opening date, due date,
														committed amount, loan balance, paid amount, overdue
														amount, type of loan), overdue information (name of
														institution, overdue amount, paid amount, overdue
														balance), substitute payment information (name of
														institution, date of repayment, repaid amount, repayment
														balance), guarantee information (name of institution,
														date, guaranteed amount), others (default information,
														public information, information on breach of financial
														order), and customer code
													</p>
												</td>
												<td width="291">
													<p>Until DodamDodam membership withdrawal or for a
														statutory period under applicable laws and regulations</p>
												</td>
											</tr>
											<tr>
												<td rowspan="3" width="20%">
													<p>Optional data</p>
												</td>
												<td width="131">
													<p>Delivery service&nbsp;improvement (DodamDodam Eats
														only)</p>
												</td>
												<td width="291">
													<p>Personal location information</p>
												</td>
												<td width="291">
													<p>One year from the completion of delivery; deleted
														immediately upon users request for deletion</p>
												</td>
											</tr>
											<tr>
												<td width="131">
													<p>Marketing and analysis</p>
												</td>
												<td width="291">
													<p>Email, contact information (mobile phone number)</p>
												</td>
												<td width="291">
													<p>These data types are deleted immediately upon the
														user’s request for deletion or suspension of use of his or
														her information or withdrawal of membership</p>
												</td>
											</tr>
											<tr>
												<td width="131">
													<p>Subscription</p>
												</td>
												<td width="291">
													<p>Baby information (name, age, gender)</p>
												</td>
												<td width="291">
													<p>These data types are deleted immediately upon the
														user’s request for deletion or suspension of use of his or
														her information or withdrawal of membership</p>
												</td>
											</tr>
										</tbody>
									</table>
									<p>
										※ Fraud includes illegal, abusive usage or other irregular
										behavior, including (i) the act of illegally or irregularly
										obtaining economic gains such as discount coupons and event
										benefits provided by DodamDodam, for example, repeatedly
										rejoining after cancelling membership or repeatedly cancelling
										purchases; (ii) other acts prohibited by the Terms of Use,
										etc.; and (iii)the act of using another person’s identity.<br>
										※ We may use Customer’s purchase information to contact
										withdrawn or long-term inactive members to provide a refund or
										recall.<br> ※ The above information can be used for
										service usage statistics and analysis.<br> <br> 1.2
										Guests<br> Guests refer to Customers who are not signed
										up to DodamDodam via the website or app but are using
										DodamDodam’s service (e.g., newsletter subscription.)
									</p>
									<table border="1" width="80%">
										<thead>
											<tr>
												<td style="background-color: gray;">
													<p style="text-align: center;">
														<b>Category</b>
													</p>
												</td>
												<td style="background-color: gray;">
													<p style="text-align: center;">
														<b>Method of Collection</b>
													</p>
												</td>
												<td style="background-color: gray;">
													<p style="text-align: center;">
														<b>Purpose of Collection and Use</b>
													</p>
												</td>
												<td style="background-color: gray;">
													<p style="text-align: center;">
														<b>Items to be Collected and Used</b>
													</p>
												</td>
												<td style="background-color: gray;">
													<p style="text-align: center;">
														<b>Period of Retention and Use</b>
													</p>
												</td>
											</tr>
											<tr>
												<td>
													<p>Apply for&nbsp;subscription&nbsp;membership</p>
												</td>
												<td>
													<p>Customers enter their information directly to
														DodamDodam newsletter subscription page</p>
												</td>
												<td>
													<p>Delivering newsletters</p>
												</td>
												<td>
													<p>Email</p>
												</td>
												<td>
													<p>Deleted immediately upon opt-out of subscription</p>
												</td>
											</tr>
										</thead>
									</table>
									<p>
										<strong><br> </strong>1.3 Event Participants<br>
										Event participants refer to Customers who participate in
										promotional events held on DodamDodam’s social media pages
										(Facebook, Kakao Story, Twitter, Instagram, Naver/Daum Cafe,
										etc.) or online boards.
									</p>
									<table border="1" width="80%">
										<thead>
											<tr>
												<td style="background-color: gray;">
													<p style="text-align: center;">
														<b>Category</b>
													</p>
												</td>
												<td style="background-color: gray;">
													<p style="text-align: center;">
														<b>Method of Collection</b>
													</p>
												</td>
												<td style="background-color: gray;">
													<p style="text-align: center;">
														<b>Items to be Collected and Used</b>
													</p>
												</td>
												<td style="background-color: gray;">
													<p style="text-align: center;">
														<b>Purpose of Use</b>
													</p>
												</td>
												<td style="background-color: gray;">
													<p style="text-align: center;">
														<b>Period of Retention</b>
													</p>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td style="width: 135.083px;">Event participants</td>
												<td style="width: 298.333px;">
													<p>Customers enter their information directly to social
														media pages or DodamDodam’s bulletin board to participate
														in or send via email to apply for an event</p>
												</td>
												<td style="width: 138.833px;">
													<p>Name, social media or DodamDodam ID</p>
												</td>
												<td style="width: 125.3664px;">
													<p>Picking event winners</p>
												</td>
												<td rowspan="2">
													<p>Collected information is destroyed within 30 days
														from the end of the promotional event.</p>
												</td>
											</tr>
											<tr>
												<td>
													<p>Event winners</p>
												</td>
												<td>
													<p>Event winners send their information directly to
														DodamDodam via SMS, direct message, or other messaging
														services, or by adding a comment to the winner
														announcement</p>
												</td>
												<td>Goods: name, contact information, address<br>
													<br> Mobile gift voucher (Giftishow): name, contact
													information<br> <br> DodamDodam Cash: DodamDodam
													ID (email), name, contact information
												</td>
												<td>
													<p>Delivering prizes</p>
												</td>
											</tr>
										</tbody>
									</table>
									<br>
									<p></p>
									<p>
										1.4 How Personal Data is Collected<br> A. Customers enter
										their personal data upon sign-up or in the process of using
										DodamDodam services, after providing consent to collection of
										such information.<br> B. Personal data is collected
										during customer support interactions via website, email, fax,
										and calls.<br> C. Personal data is collected when
										Customers participate in online and offline promotional
										events.<br> D. Data generated via log analysis programs
										and in cookies is collected.<br> <br> 1.5 Personal
										Data Collected and Used in Accordance with Applicable Laws
									</p>
									<table border="1" width="80%">
										<thead>
											<tr>
												<td style="background-color: gray;" width="239">
													<p style="text-align: center;">
														<b>Information Retained</b>
													</p>
												</td>
												<td style="background-color: gray;" width="71">
													<p style="text-align: center;">
														<b>Retention Period</b>
													</p>
												</td>
												<td style="background-color: gray;" width="135">
													<p style="text-align: center;">
														<b>Statutory Grounds</b>
													</p>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td width="239">
													<p>Records of payment and supplying&nbsp;goods, etc.</p>
												</td>
												<td width="71">
													<p>5 years</p>
												</td>
												<td width="135">
													<p>Act on the Consumer Protection in Electronic
														Commerce, Etc.</p>
												</td>
											</tr>
											<tr>
												<td width="239">
													<p>Records of contract or withdrawal
														of&nbsp;subscription, etc.</p>
												</td>
												<td width="71">
													<p>5 years</p>
												</td>
												<td rowspan="3" width="135">
													<p>Act on the Consumer Protection in Electronic
														Commerce, Etc.</p>
												</td>
											</tr>
											<tr>
												<td width="239">
													<p>Records of Customers’ complaint or&nbsp;settlement
														of disputes</p>
												</td>
												<td width="71">
													<p>3 years</p>
												</td>
											</tr>
											<tr>
												<td width="239">
													<p>Records of&nbsp;indication&nbsp;and advertisement</p>
												</td>
												<td width="71">
													<p>6 months</p>
												</td>
											</tr>
											<tr>
												<td width="239">
													<p>Records of electronic financial&nbsp;transactions</p>
												</td>
												<td width="71">
													<p>5 years</p>
												</td>
												<td width="135">
													<p>Electronic Financial Transactions Act</p>
												</td>
											</tr>
											<tr>
												<td width="239">
													<p>Location data management register</p>
												</td>
												<td width="71">
													<p>6 months</p>
												</td>
												<td width="135">
													<p>Act on the Protection, Use, etc. Of Location
														Information</p>
												</td>
											</tr>
											<tr>
												<td width="239">
													<p>Records of website visit</p>
												</td>
												<td width="71">
													<p>3 months</p>
												</td>
												<td width="135">
													<p>Protection of Communications Secrets Act</p>
												</td>
											</tr>
										</tbody>
									</table>
									<br> <br> <a><strong>2.&nbsp;Provision
											of Personal Data</strong></a><br> 2.1 General User
									<div>
										Once an order is placed and payment made, DodamDodam provides
										Customers' personal data required for the seamless process of
										transactions, including customer service and shipping
										services, to a third party (including sellers) within the
										required scope. Please click on the links in the Recipient<span
											style="font-size: small;">&nbsp;column of the table
											below to see the detailed information.&nbsp;</span><br>
										<table border="1" width="80%">
											<thead>
												<tr>
													<td style="background-color: gray;">
														<p style="text-align: center;">
															<b>Recipient</b>
														</p>
													</td>
													<td style="background-color: gray;">
														<p style="text-align: center;">
															<b>Purpose of Provision</b>
														</p>
													</td>
													<td style="background-color: gray;">
														<p style="text-align: center;">
															<b>Information Provided</b>
														</p>
													</td>
													<td style="background-color: gray;">
														<p style="text-align: center;">
															<b>Period of Retention and Use</b>
														</p>
													</td>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td style="width: 10%;">
														<p>
															<a href="http://www.DodamDodam.com/np/etc/trustCompany">Sellers
																offering coupons</a>
														</p>
													</td>
													<td style="width: 36%;">
														<p>Providing service, verifying purchaser identity,
															outbound “happy calls"</p>
													</td>
													<td style="width: 39%;">
														<p>Name, mobile phone number</p>
														<p>* Address may also be provided on a limited basis
															depending on the type of service.</p>
													</td>
													<td style="width: 13%;" rowspan="7">
														<p>These data types are destroyed after the purpose of
															the provision of goods or services is achieved.</p>
														<p>(* These data are retained for a statutory period
															under applicable laws and regulations.)</p>
													</td>
												</tr>
												<tr>
													<td style="width: 10%;">
														<p>Sellers of tickets
															(performances/exhibitions/activities)&nbsp;</p>
													</td>
													<td style="width: 36%;">
														<p>Providing service, verifying purchaser identity,
															outbound “happy calls”</p>
													</td>
													<td style="width: 39%;">
														<p>Name, mobile phone number</p>
													</td>
												</tr>
												<tr>
													<td style="width: 10%;">
														<p>
															<a href="http://www.DodamDodam.com/np/etc/trustCompany">Sellers
																of goods</a>
														</p>
													</td>
													<td style="width: 36%;">
														<p>Providing service, customer appreciation event,
															verifying purchaser identity, outbound “happy calls”</p>
													</td>
													<td style="width: 39%;">
														<p>Name, mobile phone number, shipping address, email</p>
														<p>* If the recipient is not the purchaser, the
															recipient’s information (including personal customs
															clearance code for cross-border shipping) may be
															provided.</p>
													</td>
												</tr>
												<tr>
													<td style="width: 10%;">
														<p>
															<a href="http://www.DodamDodam.com/np/etc/trustCompany">Travel
																suppliers</a>
														</p>
													</td>
													<td style="width: 36%;">
														<p>Providing service, reservation confirmation,
															outbound “happy calls”</p>
													</td>
													<td style="width: 39%;">
														<p>Name, mobile phone number, email</p>
														<p>* Additional information (e.g., name(s) or other
															information of companion(s)) may be provided depending on
															the type of service.</p>
													</td>
												</tr>
												<tr>
													<td style="width: 10%;">
														<p>Relevant tax office</p>
													</td>
													<td style="width: 36%;">
														<p>Providing online liquor sales register to the tax
															office on a quarterly basis in accordance with the public
															notice from the National Tax Service</p>
													</td>
													<td style="width: 39%;">
														<p>Purchaser's personal data (address, name, date of
															birth), order date, product name, quantity, order amount</p>
													</td>
												</tr>
												<tr>
													<td style="width: 10%;">
														<p>Providers of products&nbsp;directly purchased
															from&nbsp;overseas</p>
														<p>
															DodamDodam Global LLC&nbsp;<span
																style="background-color: transparent;">(US)</span>
														</p>
													</td>
													<td style="width: 36%;">
														<p>Providing service, verifying purchaser identity,
															outbound “happy calls”, customs clearance</p>
														<p>* Purchase details are provided when a purchase is
															made.</p>
													</td>
													<td style="width: 39%;">
														<p>Name, mobile phone number, shipping address,
															personal customs clearance code</p>
														<p>* If the recipient is not the purchaser, the
															recipient’s information may be provided.</p>
													</td>
												</tr>
												<tr>
													<td style="width: 10%;">
														<p>Providers of products&nbsp;directly purchased
															from&nbsp;overseas</p>
														<p>
															DodamDodam Shanghai Trading Co., Ltd.&nbsp;<span
																style="background-color: transparent;">(CHINA)</span>
														</p>
													</td>
													<td style="width: 36%;">
														<p>Providing service, verifying purchaser identity,
															outbound “happy calls”, customs clearance</p>
														<p>* Purchase details are provided when a purchase is
															made.</p>
													</td>
													<td style="width: 39%;">
														<p>Name, mobile phone number, shipping address,
															personal customs clearance code</p>
														<p>* If the recipient is not the purchaser, the
															recipient’s information may be provided.</p>
													</td>
												</tr>
												<tr>
													<td style="width: 10%;">
														<p>Korea Credit Bureau</p>
													</td>
													<td style="width: 36%;">
														<p>To verify credit rating, credit score, and credit
															information; assess credit rating, develop credit-related
															model and (statistical) analysis; check statistics for
															customized service provision; be used by credit bureau
															(including for overdue information registration); and
															maintain and provide follow-up management of the contract
															and the ones before.</p>
													</td>
													<td style="width: 39%;">
														<p>Name, date of birth, gender, mobile phone number,
															duplicate information (DI), customer number, date of sign
															up, and state of payment and overdue.</p>
													</td>
													<td style="width: 13%;">
														<p>Retained for a statutory period under applicable
															laws and regulations.</p>
													</td>
												</tr>
											</tbody>
										</table>
										<p>
											※ Notice of right to refuse consent to the personal data
											provision<br>Provision of personal data to a third party
											is necessary for Customers to use some of DodamDodam’s
											services. Customers may choose not to provide their personal
											data required for the services, in which case some of those
											services may be restricted from those Customers. DodamDodam
											provides Customers’ personal data to a third party only when
											a transaction is made and notifies customers of the details
											of provision when they make a purchase. Rocket Delivery
											products are shipped directly by DodamDodam, and therefore do
											not entail the provision of personal data to third parties
											(including sellers).
										</p>
										<p>
											<br>
										</p>
										<strong><br> </strong><a><strong>3.
												Consignment of Personal Data Processing</strong></a><br> DodamDodam
										oversees how securely our third parties process Customers’
										personal data consigned to them and ensures to have all the
										consigned data immediately destroyed upon the completion of
										consigned work.
										<p></p>
										3.1 Consignment of Personal Data within Korea<br>
										<table border="1" width="80%">
											<thead>
												<tr>
													<td style="background-color: gray;">
														<p style="text-align: center;">
															<b>Category</b>
														</p>
													</td>
													<td style="background-color: gray;">
														<p style="text-align: center;">
															<b>Consignee</b>
														</p>
													</td>
													<td style="background-color: gray;">
														<p style="text-align: center;">
															<b>Consigned Services</b>
														</p>
													</td>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>
														<p>Customer&nbsp;consultation</p>
													</td>
													<td>
														<p>KSJOB, Trans Cosmos Korea Inc., U-BASE</p>
													</td>
													<td>
														<p>All call center services, including the processing
															of customer and order information</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>Identity&nbsp;verification</p>
													</td>
													<td>
														<p>Korea Mobile Certification Inc.</p>
													</td>
													<td>
														<p>Identity verification</p>
													</td>
												</tr>
												<tr>
													<td rowspan="4">
														<p>Delivery&nbsp;service</p>
													</td>
													<td>
														<p>
															Hanjin Express, Cheonil Cargo Transportation, Lotte
															Global Logistics, CJ Logistics Corporation, DodamDodam
															Logistics Services, <a
																href="http://www.DodamDodam.com/np/etc/trustPartners">Independent
																Delivery Partners</a>,&nbsp;Samsung Electronics Co., Ltd.,
															SK Magic Co., Ltd., LG Electronics Inc., Winion Inc.,
															Howser, Inc.
														</p>
														<p>※ Products other than Rocket Delivery products are
															delivered by shipping companies contracted by each
															seller.</p>
													</td>
													<td>
														<p>Delivery of goods (including foods) and prizes</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>GoodsFlow Corporation</p>
													</td>
													<td>
														<p>Shipment tracking</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>LG Uplus, KT Corporation, SK Telink</p>
													</td>
													<td>
														<p>“Safety Number” (one-time virtual phone number)
															service</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>DodamDodam Fulfillment Services</p>
													</td>
													<td>
														<p>All fulfillment center works (inventory management,
															sorting, picking, shipping to distribution centers, etc.)</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>Notification&nbsp;messaging</p>
													</td>
													<td>
														<p>LG Uplus, KT, Kakao Corp., NHN Corp, LGCNS</p>
													</td>
													<td>
														<p>Sending messages (SMS, etc.)</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>Data storage</p>
													</td>
													<td>
														<p>Amazon Web Services Inc.</p>
													</td>
													<td>
														<p>Storing data</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>Data&nbsp;processing</p>
													</td>
													<td>
														<p>Microsoft</p>
													</td>
													<td>
														<p>Email service, document/file storage, internal
															communication, and collaboration tools</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>Save customer consultation transcripts</p>
													</td>
													<td>
														<p>GS NEOTEK</p>
													</td>
													<td>
														<p>Genesys system maintenance</p>
													</td>
												</tr>
												<tr>
													<td rowspan="3">
														<p>Payment and Fees Settlement processing</p>
													</td>
													<td>
														<p>NICE Payments</p>
													</td>
													<td>
														<p>Informing the amount of paid and unpaid fees; debt
															collection and other related work.</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>DodamDodamPay. Ltd.</p>
													</td>
													<td>
														<p>Payment processing &amp; prevention of payment
															misappropriation, Easy Payment service provision and
															operation</p>
													</td>
												</tr>
												<tr>
													<td>
														<p>[Re-outsourcing by DodamDodamPay. Ltd.] NHN KCP
															Corp., KG Mobilians, Korea Information Communication
															Corp., Danal Co., Ltd., Galaxia Communications Co.,Ltd.,
															NICE Payments</p>
													</td>
													<td>
														<p>Processing payment made by credit card, mobile
															phone, bank transfer, deposit without bankbook (virtual
															account), etc.</p>
													</td>
												</tr>
											</tbody>
										</table>
										<p>
											<br>
										</p>
										3.2&nbsp;Consignment of Personal Data Processing Overseas
										<table border="1" width="80%">
											<tbody>
												<tr>
													<td style="text-align: center; background-color: gray;"><b>Consignee</b></td>
													<td style="text-align: center; background-color: gray;"><b>Destination
															Country</b></td>
													<td style="text-align: center; background-color: gray;"><b>Time
															and Method of Transfer</b></td>
													<td style="text-align: center; background-color: gray;"><b>Items
															Transferred</b></td>
													<td style="background-color: gray;"><b>Purpose of
															Use and Period of Retention and Processing</b></td>
												</tr>
												<tr>
													<td>DodamDodam Global, LLC</td>
													<td>US</td>
													<td colspan="1" rowspan="3">Personal data is
														transferred over network when necessary for business
														purposes</td>
													<td colspan="1" rowspan="3">Personal data collected
														and used during customers’ use of services (sign-up,
														consultation, payment)</td>
													<td colspan="1" rowspan="3">Research and Development;<br>
														<br> Destroyed without delay upon completion of work
													</td>
												</tr>
												<tr>
													<td>DodamDodam (Shanghai) Co., Ltd.<br>
														韩领网络科技(上海)有限公司
													</td>
													<td>China</td>
												</tr>
												<tr>
													<td>DodamDodam (Beijing) Co., Ltd.<br>
														韩领网络科技(北京)有限公司
													</td>
													<td>China</td>
												</tr>
												<tr>
													<td>IBM Security</td>
													<td>US</td>
													<td>Personal data is transferred over network when
														necessary for business purposes</td>
													<td>Personal data collected and used during customers’
														use of services (sign-up,consultation, payment)</td>
													<td>Operation and analytics of security control
														service;<br> <br> Destroyed without delay upon
														completion of work
													</td>
												</tr>
												<tr>
													<td>Zendesk, Inc.</td>
													<td>US</td>
													<td>Cloud software product supply (Support, Guide,
														Chat, Sunshine)</td>
													<td>Customer information (name, email, phone number,
														member SRL)</td>
													<td>Operation and analytics of security control
														service;<br> <br> Destroyed without delay upon
														completion of work
													</td>
												</tr>
											</tbody>
										</table>
										<br> <br> <a><strong>4. Disposal of
												Personal Data</strong></a>&nbsp;<br>The retention and use period of
										the personal data collected starts when the service contract
										is signed (i.e. Customers sign up for membership) and ends
										when the contract is terminated (i.e.Customers apply for
										membership withdrawal or their membership is disqualified).
										Moreover, if Customers withdraw consent, DodamDodam
										immediately disposes of all of their personal data, with the
										exception of some retained due to the reasons specified above
										for a certain period. Hard copy printouts of personal data are
										shredded or burned, whereas electronic files of personal data
										are disposed through technical or physical means that ensure
										the information cannot be recovered.<br> <br> When
										the purpose of collection and use of personal data is
										achieved, DodamDodam moves the information to another
										database,stores it securely, and disposes it without delay
										after a predetermined period, in line with the internal policy
										and applicable laws. DodamDodam never uses personal data moved
										to a separate database outside or beyond the scope consented
										by Customers, unless mandated by law.<br> <br>
										Personal data of Customers who do not have any history of
										using DodamDodam for the past one year (long-term inactive
										members) is also segregated from other information and managed
										safely. DodamDodam sends email notifications to inactive
										members at least 30 days prior to moving their information to
										a separate storage. If it is, however, required by the
										Protection of Communications Secrets Act, the Act on the
										Consumer Protection in Electronic Commerce, Etc. or other
										applicable laws, DodamDodam may retain the necessary personal
										data of customers for the prescribed time period. <br> <br>
										<a><strong>5. Rights and Obligations of Customers</strong></a><br>
										5.1 Rights of Customers<br> Customers and their legal
										representatives may make requests to access, correct or delete
										their information collected by DodamDodam,and have the right
										to withdraw consent anytime. However, Customers who withdraw
										consent or have information deleted may have limited access to
										some or all of the DodamDodam services. Customers can check
										the personal data collected by DodamDodam by following the
										instruction described below:<br> <br> [How to view
										the personal data collected by DodamDodam]<br>
										<p>
											• Go to the DodamDodam website and click “도담도담” &gt; “개인정보
											확인/수정”, “주문목록”, “배송조회”<br> • Open the DodamDodam mobile
											app and go to “내정보관리”
										</p>
										<br>Customers may check the information not directly
										available from the DodamDodam website or app by contacting the
										DodamDodam customer support center (1577-7011,
										help@DodamDodam.com, 1:1 chat also available). Customers who
										wish to delete or stop the processing of their personal data,
										or withdraw consent, can make requests to the DodamDodam
										customer center (1577-7011, help@DodamDodam.com, 1:1 chat also
										available). They also have the right to withdraw membership,
										and thereby withdraw consent, to the collection and use of
										their personal data at any time. Upon making such requests,
										however, customers’ use of some or the entire service may be
										restricted. Furthermore, it may be difficult to fulfill
										requests from customers to delete or stop the processing of
										their personal data, or withdraw the consent if any of the
										following is true:<br> <br>
										<p>
											• There are special provisions under the law, or it is
											absolutely necessary to fulfill an obligation under the law;<br>
											• There is a possibility of incurring damage to life, body,
											property and other interests of a third party;<br> • It
											is impossible to execute the contracts with data subjects,
											including providing the service under the contract, without
											processing their personal data, yet the data subjects have
											failed to explicitly express their intent to terminate their
											contracts.
										</p>
										<br> Should Customers raise such requests, DodamDodam
										does not use the customers’ information or provide it to a
										third party until the requests are fulfilled. Moreover, if
										DodamDodam has provided incorrect personal data to a third
										party for reasonable grounds, DodamDodam promptly notifies the
										third party and ensures that the information is deleted and no
										longer processed, and the applicable consent is withdrawn.<br>
										<br> 5.2. Obligations of Customers<br>Customers have
										an obligation to protect their personal data. DodamDodam is
										not liable for issues that arise due to personal data leakage
										caused not by the fault of DodamDodam, but by any of the
										following:<br> <br>
										<p>
											• Negligence or acts or omissions of the customer, such as
											losing, letting others borrow or handing over an ID (email
											address), password, or medium used to access the service; or
											leaving PC unattended while still logged into the service;<br>
											• Methods that cannot be prevented by the security controls
											required by the applicable laws or hacking and other
											technologies that are outside the control of DodamDodam
											despite the security controls DodamDodam has undertaken.
										</p>
										<br> It is also an obligation of Customers to keep their
										personal data up to date. Any issues that arise due to
										incorrect information entered by customers are the
										responsibility of customers themselves. Individuals who sign
										up with personal data stolen from others or make payments with
										stolen IDs may lose their DodamDodam membership and face
										penalties pursuant to the applicable laws. Moreover, customers
										are responsible for keeping their ID and password secure and
										confidential and may not lend them or hand them over to a
										third party. They are also under an obligation to cooperate
										with activities regularly carried out by DodamDodam to ensure
										security according to its privacy and policy.
									</div>
									<div>
										<br> <a><strong>6. Installation/Operation of
												Automatic Information Collection Tool and How to Opt-Out</strong></a><br>
										<font><b><br></b></font> To provide convenient, effective
										and personalized shopping experiences to Customers, DodamDodam
										may store (collect) data automatically generated as Customers
										interact with the service or device information that doesn’t
										lead to the identification of individuals. And DodamDodam
										informs Customers specifically which information out of the
										automatically generated data it collects and how Customers can
										opt-out from such collection.<br> <br> 6.1. Cookie<br>
										A cookie is a small text file sent to and stored on a user's
										device when the user visits a website. When the user visits
										the same site again, the cookie allows the site to recognize
										the user's device to automatically pull up his or her previous
										settings and history of using the site. Moreover, a cookie can
										be used to offer services (including advertisements) tailored
										to fit the interest and taste of customers by analyzing the
										websites visited, time and frequency of the visits and
										information generated or provided (entered) when using the
										services. It is up to customers to accept or decline cookies:
										they can choose to accept all cookies, check every time they
										receive and store a new cookie or refuse to store any cookies.<br>
										<br> [How to change cookie settings]
										<p>
											<a
												href="https://support.microsoft.com/en-us/help/17442/windows-internet-explorer-delete-manage-cookies">in
												Internet Explorer</a><br> <a
												href="https://support.apple.com/guide/safari/manage-cookies-and-website-data-sfri11471/mac">in
												Safari</a><br> <a
												href="https://support.mozilla.org/en-US/kb/enable-and-disable-cookies-website-preferences">in
												FireFox</a><br> <a
												href="https://support.google.com/chrome/answer/95647?co=GENIE.Platform%3DDesktop&amp;hl=en">in
												Chrome</a>
										</p>
										<br>6.2. Personalized ads <br>To deliver
										personalized ads, DodamDodam collects and uses cookies from
										the web browser and ADID from the mobile app. Cookies and ADID
										are used to automatically collect customers’ history of
										interaction with the DodamDodam service and forward this
										information to Facebook and Criteo (the information also sent
										to Criteo viaTune). Facebook and Criteo (Tune) then uses this
										information to personalize ads for customers. The cookies and
										ADID collected by DodamDodam are not linked to other personal
										data and are not used to identify individuals. Facebook and
										Criteo also, under no circumstances, leverage the information
										DodamDodam provides to identify individuals.<br> <br>
										Customers can choose to opt-out from receiving personalized
										ads any time and will see general ads instead of personalized
										ones once opted out.&nbsp;<br> <br> <a><strong>7.
												The Chief Privacy Officer and Staff Responsible for Privacy
												Inquiries</strong></a>&nbsp;<br> <br>The Chief Privacy Officer
										(CPO) and the department responsible for handling privacy
										inquiries are designated as below to oversee all matters
										related to customer privacy and handle complaints and address
										damage from privacy-related issues. Customers may make
										inquiries, raise complaints or ask for damage relief regarding
										privacy issues through the contact points below. DodamDodam
										will promptly respond to and handle inquiries.<br>
									</div>
									<div>
										<table border="1" width="80%">
											<tbody>
												<tr>
													<td style="background-color: gray;" width="220">
														<p style="text-align: center;">
															<b>Chief Privacy Officer</b>
														</p>
													</td>
													<td style="background-color: gray;" width="226">
														<p style="text-align: center;">
															<b>Department Handling Privacy Complaints</b>
														</p>
													</td>
												</tr>
												<tr>
													<td width="220">
														<p>Name: Max Leveson</p>
														<p>Phone number: 1577-7011</p>
														<p>Email address: help@DodamDodam.com</p>
													</td>
													<td width="226">
														<p>Department: DodamDodam Customer Center</p>
														<p>Phone number: 1577-7011</p>
														<p>Email address: help@DodamDodam.com</p>
														<p>
															<b>For DodamDodam Eats:</b>
														</p>
														<p>Phone number: 1670-9827</p>
													</td>
												</tr>
											</tbody>
										</table>
										Customers who need to receive consultation on privacy matters
										or report a personal data breach may also contact the
										following authorities:<br>
										<p>
											•Personal data breach reporting center: 118 (without area
											code),&nbsp;<a href="http://privacy.kisa.or.kr/">privacy.kisa.or.kr</a><br>
											•Cybercrime Investigation Team at the Supreme Prosecutors’
											Office: 1301 (without area code),&nbsp;<a
												href="http://www.spo.go.kr/">www.spo.go.kr</a><br>
											•Cybercrime Investigation Team at the National Police Agency:
											1821301 (without area),&nbsp;<a
												href="http://www.cyber.go.kr/">cyberbureau.police.go.kr</a><br>
											<br> <a><strong>8.&nbsp;Obligation of
													Notification&nbsp;</strong></a><br> Privacy notice takes effect
											from its effective date. Should there be grounds for a
											material change to customer’s right to data privacy,
											customers will be notified by DodamDodam at least 14 days
											before the change. Other changes will be notified to
											customers at least 7 days prior to their
											implementation.&nbsp;&nbsp;<br> <br> <b><u>Note:</u></b><br>
											<br>
										</p>
										<p>
											In the event of inconsistency or discrepancy between the
											English version and the Korean version of this Privacy
											Notice, the Korean version shall prevail.&nbsp; &nbsp;&nbsp;<br>
										</p>
										<p>
											Version 9.3<br> Release date: December 29 2020&nbsp;<br>
											Effective date: January 4 2022<br>
										</p>
									</div>
									<p>
										개인정보 처리방침<br>(2020년 12월 15일 ~ 2022년 01월 04일)
									</p>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="menu3" class="container tab-pane fade" style="padding-bottom: 15%;">
				<br>
				<h2 align="center">(주)도담도담</h2>
				<hr style="border: none; border: 5px double orange;">
				<nav id="navbar-example3" class="navbar navbar-light bg-light">
					<a class="navbar-brand" href="#"
						style="font-weight: bolder; color: blue; font-size: 20px;">이용
						약관 및 방침</a>
					<nav class="nav nav-pills flex-column">
						<a class="nav-link" href="#item-1">목적</a> <a class="nav-link"
							href="#item-2">회원 가입</a> <a class="nav-link" href="#item-3">지급
							방법</a> <a class="nav-link" href="#item-4">환급</a> <a class="nav-link"
							href="#item-5">이용자의 의무</a> <a class="nav-link" href="#item-6">정기구매
							서비스 이용제한</a>
					</nav>
				</nav>
				<div data-spy="scroll" data-target="#navbar-example3"
					data-offset="0">
					<h4 id="item-1">제1조 (목적)</h4>
					<p>
						<span class="bold">제1조(목적)</span> 이 약관은 (주)도담도담 회사(사업자등록번호 :
						759-87-00821, 통신판매업신고번호 : 제2020-서울강남-03029호, 대표자 : 1조 도담도담)가 운영하는
						온라인 웹사이트 도담도담 및 모바일 어플리케이션 도담도담케어(이하 두 서비스를 통칭하여 “도담도담”라 함)에서 제공하는
						전자상거래 관련 서비스(이하 “서비스”라 한다.)를 이용함에 있어 도담도담와 이용자의 권리, 의무 및 책임사항을
						규정함을 목적으로 합니다. *PC통신, 스마트폰 앱, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는
						한 준용합니다.<br>
						<span class="bold">제2조(정의) </span> ① “도담도담"란 (주)케어위드 회사가 재화 또는
						용역(이하 “재화 등"이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수
						있도록 설정한 가상의 영업장 및 그에 부수되는 콘텐츠 서비스를 말하며, 아울러 서비스를 운영하는 사업자의 의미로도
						사용합니다. ② “이용자"란 “도담도담"에 접속하여 이 약관에 따라 “도담도담"가 제공하는 서비스를 받는 회원 및
						비회원을 말합니다. ③ “회원"이라 함은 “도담도담"에 회원등록을 한 자로서, 계속적으로 “도담도담"가 제공하는
						서비스를 이용할 수 있는 자를 말합니다. ④ “비회원"이라 함은 회원으로 가입하지 않고 “도담도담"가 제공하는 서비스를
						이용하는 자를 말합니다.<br>
						<span class="bold">제3조 (약관 등의 명시와 설명 및 개정) </span> ① “도담도담”는 이 약관의
						내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호,
						모사전송번호, 전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보관리책임자등을 이용자가 쉽게 알 수 있도록
						도담도담의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수
						있습니다. ② “도담도담"는 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회, 배송책임,
						환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의
						확인을 구하여야 합니다. ③ “도담도담”는「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」,
						「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한
						법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수
						있습니다. ④ “도담도담”가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그
						적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한
						30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 "도담도담“는 개정 전 내용과 개정 후 내용을 명확하게
						비교하여 이용자가 알기 쉽도록 표시합니다. ⑤ “도담도담”가 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에
						체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미
						계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 “도담도담”에
						송신하여 “도담도담”의 동의를 받은 경우에는 개정약관 조항이 적용됩니다. ⑥ 이 약관에서 정하지 아니한 사항과 이
						약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가
						정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.<br>
						<span class="bold">제4조(서비스의 제공 및 변경) </span> ① “도담도담”는 다음과 같은 서비스를
						제공합니다.<br>
						<span class="depth2">1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결</span><br>
						<span class="depth2">2. 구매계약이 체결된 재화 또는 용역의 배송</span><br>
						<span class="depth2">3. 이용자의 “도담도담” 서비스 이용에 도움이 되는 알람 및 콘텐츠
							제공 </span><br>
						<span class="depth2">4. 기타 “도담도담”가 정하는 업무 </span> ② “도담도담”가 제공하는
						재화 또는 용역 서비스는 비의료 건강관리서비스로서 질환의 치료 목적의 서비스가 아닌 보조적 건강관리 서비스입니다. 특히
						만성질환자의 경우 본 서비스 이용대상자가 아니며 의사 또는 의료기관의 도움을 받으시기를 권고 드립니다. ③
						“도담도담”는 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화
						또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화
						또는 용역의 내용을 게시한 곳에 즉시 공지합니다. ④ “도담도담”가 제공하기로 이용자와 계약을 체결한 서비스의 내용을
						재화등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시
						통지합니다. ⑤ 전항의 경우 “도담도담”는 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, “도담도담”가 고의
						또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.<br>
						<span class="bold">제5조(서비스의 중단) </span> ① “도담도담”는 연중무휴, 1일 24시간
						제공을 원칙으로 합니다. 단, 컴퓨터 등 정보통신설비의 보수점검, 교체 및 고장, 통신의 두절 등의 사유가 발생한
						경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다. ② “도담도담”는 제1항의 사유로 서비스의 제공이 일시적으로
						중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, “도담도담”가 고의 또는 과실이 없음을
						입증하는 경우에는 그러하지 아니합니다. ③ 사업종목의 전환, 사업의 포기, 업체 간의 통합 등의 이유로 서비스를 제공할
						수 없게 되는 경우에는 “도담도담”는 제8조에 정한 방법으로 이용자에게 통지하고 당초 “도담도담”에서 제시한 조건에
						따라 소비자에게 보상합니다. 다만, “도담도담”가 보상기준 등을 고지하지 아니한 경우에는 이용자들의 포인트 또는 적립금
						등을 “도담도담”에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다. ④ 제3항에도 불구하고
						“도담도담”가 이용자에게 사전에 통지할 수 없는 부득이한 사유가 있는 경우 사후에 통지할 수 있습니다.<br>
					</p>
					<h4 id="item-2">제6조(회원가입)</h4>
					<p>
						<span class="bold">제6조(회원가입) </span> ① 이용자는 “도담도담”가 정한 가입 양식에 따라
						회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다. ② “도담도담”는 제1항과 같이
						회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.<br>
						<span class="depth2">1. 가입신청자가 이 약관 제7조제3항에 의하여 이전에 회원자격을
							상실한 적이 있는 경우, 다만 제7조제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 “도담도담”의 회원재가입
							승낙을 얻은 경우에는 예외로 함.</span><br>
						<span class="depth2">2. 등록 내용에 허위, 기재누락, 오기가 있는 경우 </span><br>
						<span class="depth2">3. 기타 회원으로 등록하는 것이 “도담도담”의 기술상 현저히 지장이
							있다고 판단되는 경우 </span><br>
						<span class="depth2">4. 회원가입 및 전자상거래상의 계약에 관한 서비스는 만 14세
							이상인자에 한함 </span> ③ 회원가입계약의 성립 시기는 “도담도담”의 승낙이 회원에게 도달한 시점으로 합니다. ④ 회원은
						회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 “도담도담”에 대하여 회원정보 수정 등의 방법으로 그
						변경사항을 알려야 합니다.<br>
						<span class="bold">제7조(회원 탈퇴 및 자격 상실 등) </span> ① 회원은 “도담도담”에 언제든지
						탈퇴를 요청할 수 있으며 “도담도담”는 즉시 회원탈퇴를 처리합니다. ② 회원이 다음 각 호의 사유에 해당하는 경우,
						“도담도담”는 회원자격을 제한 및 정지시킬 수 있습니다. <span class="depth2">1. 가입
							신청 시에 허위 내용을 등록한 경우 </span><br>
						<span class="depth2">2. “도담도담”를 이용하여 구입한 재화 등의 대금, 기타
							“도담도담”이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우 </span><br>
						<span class="depth2">3. 다른 사람의 “도담도담” 이용을 방해하거나 그 정보를 도용하는
							등 전자상거래 질서를 위협하는 경우 </span><br>
						<span class="depth2">4. “도담도담”를 이용하여 법령 또는 이 약관이 금지하거나
							공서양속에 반하는 행위를 하는 경우 </span> ③ “도담도담”가 회원 자격을 제한․정지 시킨 후, 동일한 행위가 2회 이상
						반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 “도담도담”는 회원자격을 상실시킬 수 있습니다. ④
						“도담도담”가 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소
						전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.<br>
						<span class="bold">제8조(회원에 대한 통지) </span> ① “도담도담”가 회원에 대한 통지를 하는
						경우, 회원이 “도담도담”와 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다. ② “도담도담”는 불특정다수 회원에
						대한 통지의 경우 1주일이상 “도담도담” 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의
						거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.<br>
						<span class="bold">제9조(구매신청) </span> “도담도담”이용자는 “도담도담”상에서 다음 또는 이와
						유사한 방법에 의하여 구매를 신청하며, “도담도담”는 이용자가 구매신청을 함에 있어서 다음의 각 내용을 알기 쉽게
						제공하여야 합니다.<br>
						<span class="depth2">1. 재화 등의 검색 및 선택 </span><br>
						<span class="depth2">2. 받는 사람의 성명, 주소, 전화번호, 전자우편주소(또는
							이동전화번호) 등의 입력 </span><br>
						<span class="depth2">3. 약관내용, 청약철회권이 제한되는 서비스, 배송료 등의 비용부담과
							관련한 내용에 대한 확인 </span><br>
						<span class="depth2">4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는
							표시(예, 마우스 클릭) </span><br>
						<span class="depth2">5. 재화등의 구매신청 및 이에 관한 확인 또는 “도담도담”의 확인에
							대한 동의 </span><br>
						<span class="depth2">6. 결제방법의 선택 </span><br>
						<span class="bold">제10조 (계약의 성립) </span> ① “도담도담”는 제9조와 같은 구매신청에
						대하여 다음 각 호에 해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의
						동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다.<br>
						<span class="depth2">1. 신청 내용에 허위, 기재누락, 오기가 있는 경우 </span><br>
						<span class="depth2">2. 미성년자가 담배, 주류 등 청소년보호법에서 금지하는 재화 및
							용역을 구매하는 경우 </span><br>
						<span class="depth2">3. 기타 구매신청에 승낙하는 것이 “도담도담” 기술상 현저히 지장이
							있다고 판단하는 경우 </span> ② “도담도담”의 승낙이 제13조 제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이
						성립한 것으로 봅니다. ③ “도담도담”의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부,
						구매신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다.<br>
					</p>
					<h4 id="item-3">제11조(지급방법)</h4>
					<p>
						<span class="bold">제11조(지급방법) </span> “도담도담”에서 구매한 재화 또는 용역에 대한
						대금지급방법은 다음 각 호의 방법중 가용한 방법으로 할 수 있습니다. 단, “도담도담”는 이용자의 지급방법에 대하여
						재화 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다. ① 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종
						계좌이체 ② 선불카드, 직불카드, 신용카드 등의 각종 카드의 비인증식 정기결제 ③ 선불카드, 직불카드, 신용카드 등의
						각종 카드의 인증식 일반결제 ④ 온라인무통장입금 ⑤ 포인트 등 “도담도담”가 지급한 적립금에 의한 결제 (단,
						정기구매의 경우 최초 구매 신청시 1회 사용 가능) ⑥ “도담도담"와 계약을 맺었거나 “도담도담"가 인증한 상품권에
						의한 결제 ⑦ 기타 전자적 지급 방법에 의한 대금 지급 등 (각종 간편 결제 서비스)<br>
						<span class="bold">제12조(프로모션코드) </span> ① 프로모션코드는 회원에게 무상으로 발행되는
						것으로 “도담도담"는 회원이 프로모션코드를 사이트에서 상품 구매 시 적용할 수 있도록 사용방법, 사용기간, 사용대상,
						할인액 또는 할인율 등을 정할 수 있습니다. 프로모션코드의 종류와 내용은 “도담도담"의 정책에 따라 달라질 수
						있습니다. ② 프로모션코드는 현금으로 환급될 수 없으며, 프로모션코드의 사용기간이 만료되거나 구매 취소 시 또는
						이용계약이 종료되면 소멸됩니다. ③ “회원”은 허락되지 않은 방법으로 프로모션코드를 제3자에게 또는 다른 아이디로
						양도할 수 없으며, 유상으로 거래하거나 현금으로 전환할 수 없습니다. ④ “도담도담”는 회원이 “도담도담”가 승인하지
						않은 방법으로 프로모션코드를 획득하거나 부정한 목적이나 용도로 프로모션코드를 사용하는 경우 프로모션코드의 사용을
						제한하거나 프로모션코드를 사용한 구매신청을 취소하거나 회원 자격을 정지할 수 있습니다. ⑤ “도담도담”는 “회원"이
						사용한 프로모션코드와 동일한 프로모션코드로 재구매 시 해당 프로모션코드 적용을 하지 않을 수 있습니다.<br>
						<span class="bold">제13조(수신확인통지, 구매신청 변경 및 취소) </span> ① “도담도담”는
						이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다. ② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이
						있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 “도담도담”는 배송 전에 이용자의
						요청이 있는 경우에는 지체 없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제16조의
						청약철회 등에 관한 규정에 따릅니다.<br>
						<span class="bold">제14조(재화 등의 공급) </span> ① “도담도담”는 이용자와 재화 등의
						공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터 7일 이내에 재화 등을 배송할 수 있도록
						주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, “도담도담”가 이미 재화 등의 대금의 전부 또는 일부를 받은
						경우에는 대금의 전부 또는 일부를 받은 날부터 3영업일 이내에 조치를 취합니다. 이때 “도담도담”는 이용자가 재화 등의
						공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다. ② “도담도담”는 이용자가 구매한 재화에 대해
						배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 “도담도담”가 약정 배송기간을 초과한
						경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 “도담도담”가 고의․과실이 없음을 입증한 경우에는 그러하지
						아니합니다. ③ 이용자는 “도담도담”가 지정하는 일부 서비스 항목 또는 “도담도담”가 지정한 기한에 한하여 회원가입
						없이 무상으로 서비스를 이용할 수 있습니다.<br>
						<span class="bold">제15조(적립금 제도의 운영) </span> ① “도담도담”는 회원이 정기구매서비스를
						이용하여 재화를 구매하거나 이벤트에 참여하는 등의 일정한 경우 적립금으로서 포인트를 부여할 수 있습니다. 이러한
						포인트의 부여는 다음 각 호의 방법에 따르되, 그 구체적인 운영방법은 회사의 운영정책에 따릅니다.<br>
						<span class="depth2">1. “도담도담”는 회원의 결제금액에 대하여 서비스 페이지에 고지한
							특정한 비율만큼 포인트를 부여할 수 있습니다. 단, 이 경우 적립대상금액은 쿠폰, 프로모션 등 기타 방법을 통해 할인
							받은 금액은 제외됩니다.</span><br>
						<span class="depth2">2. “도담도담”는 회원이 서비스나 이벤트 등에 참여할 경우 포인트를
							부여할 수 있습니다.</span><br>
						<span class="depth2">3. “도담도담”에서 회원이 구매한 재화를 반품하였을 때 해당 구매로
							적립된 포인트는 환수됩니다.</span> ② 포인트는 “도담도담”의 서비스 제도로서 “도담도담”가 회원에게 사전 고지한 조건 및
						비율에 따라 “도담도담”의 포인트몰에서 특정 재화로 교환이 가능합니다. 단, 포인트는 사은의 형태로 “도담도담”에서
						지급하는 것으로 현금으로 환불되지는 않으며 타인에게 양도할 수 없습니다. ③ 포인트의 사용기한은 최초 적립일로부터
						1년이며, 기한내 사용하지 않은 포인트는 소멸됩니다. 단일상품의 구매로 인하여 일시에 부여된 포인트에 대해서 그 중
						일부만을 사용한 경우에도 동일합니다. 단, 포인트 부여시 적립금 사용기간에 대해 별도의 사전 고지 또는 특약이 있는
						경우에는 그 사용기간 이내에 사용하여야 합니다. ④ 다음의 경우 포인트가 소멸됩니다.<br>
						<span class="depth2">1. 회원을 탈퇴한 경우</span><br>
						<span class="depth2">2. 사용기간이 경과한 경우</span><br>
						<span class="depth2">3. 사용가능 조건 및 소멸에 대한 내용이 별도로 공지된 경우</span> ⑤
						포인트를 이용하여 부당 이득을 취하거나, 악의적인 상거래가 발생할 경우, “도담도담”는 포인트에 대해 지급을 중지하며
						기지급된 포인트를 환수할 수 있습니다.<br>
					</p>
					<h4 id="item-4">제16조(환급)</h4>
					<p>
						<span class="bold">제16조(환급) </span> “도담도담”는 이용자가 구매신청한 재화 등이 품절 등의
						사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은
						경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다. <br>
						<span class="bold">제17조(청약철회 등) </span> ① “도담도담”와 재화등의 구매에 관한 계약을
						체결한 이용자는 「전자상거래 등에서의 소비자보호에 관한 법률」 제13조 제2항에 따른 계약내용에 관한 서면을 받은
						날(그 서면을 받은 때보다 재화 등의 공급이 늦게 이루어진 경우에는 재화 등을 공급받거나 재화 등의 공급이 시작된 날을
						말합니다)부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 청약철회에 관하여 「전자상거래 등에서의 소비자보호에
						관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다. ② 이용자는 재화 등을 배송 받은 경우 다음 각 호의
						1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.<br>
						<span class="depth2">1. 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우
							(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다) </span><br>
						<span class="depth2">2. 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히
							감소한 경우 </span><br>
						<span class="depth2">3. 시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가
							현저히 감소한 경우 </span><br>
						<span class="depth2">4. 같은 성능을 지닌 재화 등으로 복제가 가능한 경우 그 원본인
							재화 등의 포장을 훼손한 경우 </span> ③ 제2항제2호 내지 제4호의 경우에 “도담도담”가 사전에 청약철회 등이 제한되는
						사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회 등이
						제한되지 않습니다. ④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화 등의 내용이 표시•광고 내용과 다르거나
						계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던
						날부터 30일 이내에 청약철회 등을 할 수 있습니다.<br>
						<span class="bold">제18조(청약철회 등의 효과) </span> ① “도담도담”는 이용자로부터 재화 등을
						반환받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합니다. 이 경우 “도담도담”가 이용자에게 재화등의
						환급을 지연한 때에는 그 지연기간에 대하여 「전자상거래 등에서의 소비자보호에 관한 법률 시행령」제21조의2에서 정하는
						지연이자율(괄호 부분 삭제)을 곱하여 산정한 지연이자를 지급합니다. ② “도담도담”는 위 대금을 환급함에 있어서
						이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화 등의 대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한
						사업자로 하여금 재화 등의 대금의 청구를 정지 또는 취소하도록 요청합니다. ③ 청약철회 등의 경우 공급받은 재화 등의
						반환에 필요한 비용은 이용자가 부담합니다. “도담도담”는 이용자에게 청약철회 등을 이유로 위약금 또는 손해배상을
						청구하지 않습니다. 다만 재화 등의 내용이 표시•광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회 등을 하는
						경우 재화 등의 반환에 필요한 비용은 “도담도담”가 부담합니다. ④ 이용자가 재화 등을 제공받을 때 발송비를 부담한
						경우에 “도담도담”는 청약철회 시 그 비용을 누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.<br>
						<span class="bold">제19조(“도담도담“의 의무) </span> ① “도담도담”는 법령과 이 약관이
						금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화․용역을
						제공하는데 최선을 다하여야 합니다. ② “도담도담”는 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의
						개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다. ③ “도담도담”가 상품이나 용역에 대하여
						「표시․광고의 공정화에 관한 법률」 제3조 소정의 부당한 표시․광고행위를 함으로써 이용자가 손해를 입은 때에는 이를
						배상할 책임을 집니다. ④ “도담도담”는 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.<br>
						<span class="bold">제20조(회원의 ID 및 비밀번호에 대한 의무) </span> ① ID와 비밀번호에
						관한 관리책임은 회원에게 있으며, 어떠한 경우에도 본인의 ID 또는 비밀번호를 양도하거나 대여할 수 없습니다. ②
						회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안되며, “도담도담”의 귀책사유 없이 이를 유출, 양도,
						대여한 행위로 인하여 발생하는 손실이나 손해에 대하여는 회원 본인이 그에 대한 책임을 부담합니다. ③ 회원이 자신의
						ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 “도담도담”에 통보하고 “도담도담”의
						안내가 있는 경우에는 그에 따라야 합니다.<br>
					</p>
					<h4 id="item-5">제21조(이용자의 의무)</h4>
					<p>
						<span class="bold">제21조(이용자의 의무) </span> 이용자는 다음 행위를 하여서는 안 됩니다.<br>
						<span class="depth2">1. 신청 또는 변경 시 허위 내용의 등록 </span><br>
						<span class="depth2">2. 타인의 정보 도용 </span><br>
						<span class="depth2">3. “도담도담”에 게시된 정보의 변경 </span><br>
						<span class="depth2">4. “도담도담”가 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의
							송신 또는 게시 </span><br>
						<span class="depth2">5. “도담도담” 기타 제3자의 저작권 등 지적재산권에 대한 침해 </span><br>
						<span class="depth2">6. “도담도담” 기타 제3자의 명예를 손상시키거나 업무를 방해하는
							행위 </span><br>
						<span class="depth2">7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에
							반하는 정보를 몰에 공개 또는 게시하는 행위 </span><br>
						<span class="bold">제22조(정기구매서비스 제공 및 이용자격) </span> ① 정기구매서비스는
						“도담도담" 회원의 편의를 위하여 상품을 정기적으로 결제하고 배송하는 서비스입니다. ② 정기구매서비스는
						“도담도담"회원이면 누구나 정기구매서비스를 신청함으로써 이용 가능합니다.<br>
						<span class="bold">제23조(정기구매서비스 상품의 결제 등) </span> ① “도담도담"는
						정기구매서비스 상품에 대하여 할인혜택을 제공할 수 있으며, 할인율 및 거래조건 등은 상품별로 다를 수 있고 변경될 수
						있습니다. 할인율 및 거래조건 등이 회원에게 불리하게 변경되는 경우 “도담도담"는 2주 이상의 상당한 기간 동안 위
						변경에 대하여 공지하고, 회원은 위 변경에 동의하지 않으면 위 기간 동안 본 서비스를 종료시킬 수 있으며, 위 기간
						동안 서비스를 종료시키지 않으면 위 변경에 회원이 동의한 것으로 봅니다. ② 정기구매서비스의 특성상 상품의 가격은
						계속적으로 변경될 수 있으며, 회원에게 고지된 시점의 상품가격을 기준으로 결제가 이루어집니다. 가격 결정의 기준 시점은
						변경될 수 있습니다. ③ 정기구매서비스 상품의 추가 또는 변경 시 결제되는 총 상품의 금액은 변경될 수 있습니다. ④
						카드한도 초과 등 상품의 결제가 이루어지지 않을 경우, 해당 회차의 정기구매 주문은 이루어지지 않을 수 있으며, 위와
						같은 상황이 2회 이상 지속되는 경우 “도담도담"는 정기구매서비스를 중지할 수 있습니다.<br>
						<span class="bold">제24조(정기구매서비스 상품의 판매 종료 등) </span> ① 정기구매서비스의 대상
						상품을 품절 등의 사유로 더 이상 판매할 수 없거나 해당 상품을 정기구매서비스로 제공할 수 없는 사유가 있는 경우,
						“도담도담"는 해당 상품의 정기구매서비스를 종료하거나 해당 회차의 상품을 공급하지 않을 수 있습니다. ② 재화 등의
						대금을 환급하여야 하는 경우 제16조에서 정한 사항에 따릅니다.<br>
						<span class="bold">제25조(정기구매서비스의 종료) </span> ① 회원이 “도담도담"에게
						정기구매서비스의 종료를 통지하거나, “도담도담"의 마이페이지에서 해지 신청함으로써 정기구매서비스를 종료시킬 수
						있습니다. ② 정기구매서비스가 종료된 경우 해당 정기구매서비스에 적용된 프로모션코드와 장기구매고객할인 등 각종 혜택은
						동시에 종료됩니다.<br>
					</p>
					<h4 id="item-6">제26조(정기구매서비스 이용의 제한)</h4>
					<p>
						<span class="bold">제26조(정기구매서비스 이용의 제한) </span> ① 회원의 통지 또는 과실에
						의해서 정기구매서비스가 중지되는 경우, 해당 상품의 정기구매 서비스 신청이 2개월의 범위 내에서 제한될 수 있습니다.
						② “도담도담"는 특정상품에 대하여 구매 수량을 제한할 수 있습니다. ③ “도담도담"는 상품의 재판매 가능성이 있는
						경우, 또는 불법적이거나 부당한 행위와 관련된 경우 정기구매서비스 제공을 제한할 수 있습니다. ④ 서비스 이용의 제한에
						대한 구체적인 기준은 내부 운영정책에 따라 적용됩니다. ⑤ “도담도담"는 자체적인 시스템을 통해 모니터링과 각종
						기관에서 접수된 민원 내용, 수사기관의 정보 등을 통해 정황을 확인한 후 정기구매서비스 제한 사유행위를 한 것으로
						추정되는 경우 정기구매서비스 이용을 제한할 수 있습니다.<br>
						<span class="bold">제27조(저작권의 귀속 및 이용제한) </span> ① “도담도담“가 작성한 저작물에
						대한 저작권 기타 지적재산권은 "도담도담"에 귀속합니다. ② 이용자는 “도담도담”를 이용함으로써 얻은 정보 중
						“도담도담”에게 지적재산권이 귀속된 정보를 “도담도담”의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에
						의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다. ③ “도담도담”는 약정에 따라 이용자에게 귀속된
						저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다. <br>
						<span class="bold">제28조(면책조항) </span> ① “도담도담”는 천재지변 또는 이에 준하는
						불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다. ② “도담도담”는 의
						귀책사유로 인한 서비스 이용의 장애에 대하여 책임을 지지 않습니다. ③ “도담도담”는 회원이 서비스를 이용하여 기대하는
						수익을 상실한 것에 대하여 책임을 지지 않으며, 그 밖의 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지
						않습니다. ④ “도담도담”는 회원이 게재한 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 관해서는 책임을 지지
						않습니다. ⑤ “도담도담”는 회원 간 또는 회원과 제3자 상호간에 서비스를 매개로 하여 거래 등을 한 경우에는 책임을
						지지 않습니다.<br>
						<span class="bold">제29조(분쟁해결) </span> ① “도담도담”는 이용자가 제기하는 정당한 의견이나
						불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치․운영합니다. ② “도담도담”는 이용자로부터
						제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그
						사유와 처리일정을 즉시 통보해 드립니다. ③ “도담도담”와 이용자 간에 발생한 전자상거래 분쟁과 관련하여 이용자의
						피해구제신청이 있는 경우에는 공정거래위원회 또는 시•도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.<br>
						<span class="bold">제30조(재판권 및 준거법)</span> ① “도담도담”와 이용자 간에 발생한
						전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의
						전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의
						관할법원에 제기합니다. ② “도담도담”와 이용자 간에 제기된 전자상거래 소송에는 한국 법을 적용합니다. 이 약관은
						2020년 8월 11일부터 시행됩니다. 단, 본 약관의 공지 이후 시행일 이전에 본 약관에 동의한 경우에는 동의 시부터
						본 약관이 적용됩니다. <br>
						<br>
						<br>
					</p>
				</div>
			</div>
			<div id="menu4" class="container tab-pane fade">
				<br>
				<h3 align="center">추가 문의 사항</h3>
				<hr style="border: none; border: 5px double orange;">
				<address>
					<p align="center">
						<span>고객 문의 email address : <a href="mailto:rlaalsdn8@gmail.com">rlaalsdn8@gmail.com</a></span><br><br><br>
						<span>고객 문의 전화 tell : <a href="tel://010-9255-9798">010-9255-9798</a></span><br><br><br>
					</p>
					<p align="center">
						<span>제휴문의 email address : <a href="mailto:rlaalsdn8@naver.com">rlaalsdn8@naver.com</a></span><br><br><br>
						<span>제휴 문의 전화 tell : <a href="tel://010-9255-9798">010-9255-9798</a></span><br><br><br>
					</p>
					<p align="center">
						<span>문자 상담: <a href="sms:010-9255-9798">010-9255-9798</a></span>
					</p>
				</address>
			</div>
		</div>
	</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>