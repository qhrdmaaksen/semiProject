<%@  page contentType="text/html;charset=UTF-8" language="java"%>
 <%@ include file="../common/nav.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>BootStrap Sample</title>
	<style type="text/css">
		/*.panel-body{ margin-bottom: -30px;}*/
		.form-group {
			margin-bottom: 3px;
		}
		
		.form-control {
			height: 25px;
		}


		/* 댓글들을 위한 스타일 지정 */
		* {
			padding: 0;
			margin: 0;
			color: #333;
		}
		ul { list-style: none; }
		#container { padding: 30px 20px; }
		#comment_write {
			padding: 20px 15px;
			border-bottom: 1px solid #7BAEB5;
		}

		#comment_write label {
			display: inline-block;
			width: 80px;
			font-size: 14px;
			font-weight: bold;
			margin-bottom: 10px;
		}

		#comment_write input[type='text'], #comment_write textarea {
			border: 1px solid #ccc;
			vertical-align: middle;
			padding: 3px 10px;
			font-size: 12px;
			line-height: 150%;
		}

		#comment_write textarea {
			width: 450px;
			height: 120px ;
		}

		.comment_item {
			font-size: 13px;
			color: #333;
			padding: 15px;
			border-bottom: 1px dotted #ccc;
			line-height: 150%;
		}

		.comment_item .writer {
			color: #555;
			line-height: 200%;
		}

		.comment_item .writer input {
			vertical-align: middle;
		}

		.comment_item .writer .name {
			color: #222;
			font-weight: bold;
			font-size: 14px;
		}
		
		.form-group {
			margin-bottom: 3px;
		}
		
		.form-control {
			height: 25px;
		}
	</style>
	<script type="text/javascript">
		
	function gotoBack(){
		location.href='<%=NoForm%>boList&${requestScope.parameters}';
		//alert('${requestScope.parameter}') ;
	}
	
		function like(){
			
			location.href='<%=NoForm%>like&${requestScope.parameters}';
			//alert('${requestScope.parameter}') ;
		}
	
	

		
		function addNewItem(cnum, id, content, postdate) {
			/* 댓글 1개를 추가해 주는 함수 */
			var litag = $("<li>"); // 새로운 글이 추가될 li태그 객체
			litag.addClass("comment_item");
			
			var ptag = $("<p>");// 작성자 정보가 지정될 <p>태그
			ptag.addClass("id");
			
			var spantag = $("<span>");// 작성자 정보의 이름
			spantag.addClass("name");
			spantag.html(id + "님");
			
			var spandate = $("<span>");// 작성 일시
			spandate.html("&nbsp;&nbsp;/&nbsp;&nbsp;" + postdate + " ");
			
			var inputtag = $("<input>");// 삭제하기 버튼
			inputtag.attr({"class" : "btn btn-default btn-xs", "type" : "button", "value" : "삭제하기", "pmkey" : cnum});
			inputtag.addClass("delete_btn");
	
			var content_p = $("<p>");// 내용
			content_p.html( content );
	
			// 조립하기
			ptag.append(spantag).append(spandate).append(inputtag);
			litag.append(ptag).append(content_p);
			
			$("#comment_list").append(litag);
		}
		
		function getListComment(){ /* 댓글 목록을 읽어 온다. */
			$("#comment_list").empty() ;
			$.ajax({ /* 유효성 검사를 통과 했을 때 Ajax 함수 호출 */
	            url: '<%=MakeCommand("list.com")%>',
	            data : 'no=' + '${bean.no}', 
	    		type : "get",             
	            dataType: "json",
	            success: function (obj, textStatus) {
		           	/* var obj = JSON.parse(data); */
		           	 
					$.each(obj, function (idx) {
		           		 var cnum = obj[idx].cnum ;	 
		           		 var id = obj[idx].id ;
		           		 var content = obj[idx].content ;	 
		           		 var postdate = obj[idx].postdate ;
		           		 addNewItem(cnum, id, content, postdate);
		           	});
	            }
	        });
		}
		
		/** 삭제 버튼 클릭시에 항목 삭제하도록 "미리" 지정 */
		$(document).on("click", ".delete_btn", function() {
			if (confirm("정말 선택하신 항목을 삭제하시겠습니까?")) {
				
				$.ajax({ /* 유효성 검사를 통과 했을 때 Ajax 함수 호출 */
		            url: '<%=MakeCommand("delete.com")%>',
		            data : 'cnum=' + $(this).attr('pmkey') + '&no=' + '${bean.no}',  
		    		type : "post",             
		            dataType: "text",
		            success: function (data, textStatus) { /* 댓글 삭제 */	            	
		            	getListComment() ; /* 목록 갱신 */		           
		            }
		        });			
			}
		});	
		
		$(document).ready(function() {
			getListComment() ; /* 시작하자 마자 읽어 오기 */		 
			 
			/** 덧글 내용 저장 이벤트 */
			$("#comment_form").submit(function(){
				// 작성자 이름에 대한 입력여부 검사
				if (!$("#writer").val()) {
					alert("이름을 입력하세요.");
					$("#writer").focus();
					return false;
				}
	
				// 내용에 대한 입력여부 검사
				if (!$("#content").val()) {
					alert("내용을 입력하세요.");
					$("#content").focus();
					return false;
				}		
				
				var url = '<%=MakeCommand("insert.com")%>' ;
				var parameter = $('#comment_form').serialize() ;
				$.post(url, parameter, function( data ) {
					/* alert( '댓글이 작성되었읍니다.' ) ; */
					getListComment(0) ; /* 목록 갱신 */
					$("#writer").val('') ;
					$("#content").val('') ;
					
				}).fail(function() {
					alert("덧글 작성에 실패했습니다. 잠시 후에 다시 시도해 주세요.");
				});
				return false ;
			});
			
		});	
		
		function writeForm(){
			location.href='<%=NoForm%>comment';
	}
		
		
	</script>
	
</head>
<%
	int myoffset = 2; //전체 외관의 옵셋
	int mywidth = 12 - 2 * myoffset;
	int leftside = 4; //판넬의 좌측
	int rightside = 12 - leftside; //판넬의 우측
%>
<body>
	<div class="container col-sm-offset-<%=myoffset%> col-sm-<%=mywidth%>">
		<div class="panel panel-default panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title" align="left">Detail View</h1>
			</div>
			<div class="panel-body">
				

					
				<div class="col-sm-<%=rightside%> col-sm-<%=rightside%>">
					<table class="table table-hover table-condensed">
						<tr>
							<td width="25%" align="center">작성자</td>
							<td width="75%" align="left">${bean.id}</td>
						</tr>					
						
						<tr>
							<td width="25%" align="center">제목</td>
							<td width="75%" align="left">${bean.title}</td>
						</tr>
						
						<tr>
							<td></td>
							<td align="center"><img align="middle" src="${applicationScope.uploadedPath}/${bean.image}"
								class="img-rounded" width="200" height="200"></td>
						</tr>
					
						
						<tr>
							<td width="25%" align="center">글 내용</td>
							<td width="75%" align="left">${bean.content}
							</td>
						</tr> 
						<tr>
							<td width="25%" align="center">작성 일자</td>
							<td width="75%" align="left">${bean.postdate}</td>
						</tr>
						<tr>
							<td width="25%" align="center">좋아요 수</td>
							<td width="75%" align="left">${bean.likenumber}</td>
						</tr>
						
					</table>
				</div>
				<hr>
		
				
				<div class="col-sm-offset-5 col-sm-4">
					<a href="<%=NoForm%>like&no=${bean.no}&${requestScope.parameters}">
					<button class="btn btn-primary" >
						게시물 좋아요</button>
					</a>
				</div>
				
				
				
				
				<br><br><br>
				
				
			<div>	
				<table>
					<tr>
						<td width="50%" align="center">
						<c:if test="${sessionScope.loginfo.id == bean.id}">
						<a href="<%=NoForm%>boDelete&no=${bean.no}&${requestScope.parameters}">
								<button>삭제</button>
							</a>
						</c:if>
						<c:if test="${sessionScope.loginfo.id != bean.id}">
								삭제
						</c:if>
						</td>
						
						
						
						<td width="50%" align="left">
						<c:if test="${sessionScope.loginfo.id == bean.id}">
								<a href="<%=NoForm%>boUpdate&no=${bean.no}&${requestScope.parameters}">
								
								<button>수정</button>
								</a>
						</c:if>
						
						<c:if test="${sessionScope.loginfo.id != bean.id}">
								수정
								<!-- 로그인 한 아이디가 아니면 수정불가.   -->
						</c:if>
						
						</td>
						
				</table>
			</div>
			<!-- 댓글 영역 -->
				<hr>
				
				<form class="form-inline" role="form" name="myform" action="<%=YesForm%>" method="get">
					<input type="hidden" name="command" value="comment">
					<div class="form-group">
					<input type="hidden" name="no" id="no" value="${bean.no}">
					</div>
				<a href="<%=NoForm%>comment&no=${bean.no}&${requestScope.parameters}">
									<button>댓글달기</button>
								</a>
									
					
					<input type="hidden" name="comment" value="comment">
					<div class="form-group">
							<input type="hidden" name="no" id="no"
								value="${bean.no}">
						</div>
					</div>
				
				</form>
				<table class="table table-condensed">
						<thead>
							<tr>
								<th class="text-center">작성자</th>
								<th class="text-center">댓글</th>
								<th class="text-center">작성일자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${requestScope.comment}" var="bean">
								<tr class="record">
									<td align="center">${bean.id}</td>
									<td align="center">${bean.comment}</td>
									<td align="center">${bean.commentdate}</td>
								</tr>
							</c:forEach>
						
						</tbody>
						
					</table>
				</div>
			</div>

		</div>
	<script>
		$(document).ready(function() {
			$('[data-toggle="popover"]').popover();
		});
	</script>
</body>
</html>