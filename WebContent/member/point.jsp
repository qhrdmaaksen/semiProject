<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2021-01-05
  Time: 오전 9:46
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="mypage.jsp"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%!
    String fromDate = null ;
    String toDate = null ;
%>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar fromtime = Calendar.getInstance();
    Calendar totime = Calendar.getInstance();
    Calendar now = Calendar.getInstance();
    fromtime.add(Calendar.MONTH, -1);

    fromDate = request.getParameter("fromdate")==null?sdf.format(fromtime.getTime()):request.getParameter("fromdate");
    toDate = request.getParameter("todate")==null?sdf.format(totime.getTime()):request.getParameter("todate");
%>
<html>
<head>
    <title><%=NAME%>, 마이페이지 - 쿠폰</title>
    <style>
        .point{
            margin-top: 150px;
            background-color: #edeff2;
            border: 1px solid #ced4da;
            color: #4e555b;
        }
        .point-header1{
            font-size: 20px;
            padding: 10px 0px 0px 15px;
        }
        .point-amount1{
            font-size: 80px;
        }
        .point-amount2{
            font-size: 40px;
        }
        .month{
            padding-left: 15px;
            float: left;
        }
        .month-lists{
            list-style: none;
            margin: 0px;
            padding: 0px;
        }
        .month-list{
            width: 50px;
            height: 32px;
            font-size: 11px;
            text-align: center;
            padding: 7px 0px;
            margin: 0px;
            float: left;
            border: 1px solid #ced4da;
            background-color: #fff;
            border-right: 0px;
        }
        .month-list:hover{
            cursor:pointer;
            text-decoration: underline;
        }
        .month-list:nth-last-child(1){
            border-right: 1px solid #ced4da;
        }

        .date-form{
            width: 240px;
            height: 32px;
            float: left;
        }
        .date-box{
            position: relative;
            float: left;
            padding-left: 20px;
            font-weight: normal;
        }
        .wave{
            top: 3px;
            right: 0px;
            position: absolute;
        }
        .date-input{
            padding: 0px 4px;
            font-size: 13px;
            width: 100px;
            height: 32px;
            border: 1px solid #ced4da;
        }
        .date-input:hover{cursor: pointer;}
        .cal-ico{
            width: 15px;
            height: 15px;
            position: absolute;
            top: 10px;
            right: 6px;
            background: url(http://localhost:8999/images/sp_saving_ico.png) no-repeat;
        }

        .form-controls{
            width: 150px;
            padding-left: 20px;
            float: left;
        }
        .date-config{
            width: 120px;
            height: 32px;
            font-size: 13px;
            border: 1px solid #ced4da;
            border-radius: 0px;
        }
        .date-config:hover{cursor: pointer;}
        .search-ico{
            width: 60px;
            height: 32px;
            position: absolute;
            margin-left: 5px;
            background: url(http://localhost:8999/images/sp_search.png) no-repeat;
        }
        .search-ico:hover{cursor: pointer;}
    </style>
</head>
<body>
            <div class="container-fluid">
                <table class="table table-bordered point">
                    <colgroup>
                        <col width="50%">
                        <col width="50%">
                    </colgroup>
                    <tr>
                        <th rowspan="2">
                            <div class="point-header1">
                                <strong>사용가능 포인트</strong>
                                <div>
                                    <span class="point-amount1"><fmt:formatNumber value="${sessionScope.loginfo.point}" pattern="#,###" /></span>
                                    <span>포인트</span>
                                </div>
                            </div>
                        </th>
                        <th>
                            <div class="point-header2">
                                <strong>적립 예정</strong>
                                <div>
                                    <span class="point-amount2"><fmt:formatNumber value="${requestScope.scPoint}" pattern="#,###" /></span>
                                    <span>포인트</span>
                                </div>
                            </div>
                        </th>
                    </tr>
                    <tr>
                        <th>
                            <div class="point-header2">
                                <strong>한 달 이내 소멸예정</strong>
                                <div>
                                    <span class="point-amount2"><fmt:formatNumber value="${requestScope.exPoint}" pattern="#,###" /></span>
                                    <span>포인트</span>
                                </div>
                            </div>
                        </th>
                    </tr>
                    <tr class="month-box">
                        <th colspan="2">
                            <div class="month">
                                <ul class="month-lists">
                                    <% now.add(now.MONTH,-5); %>
                                    <li class="month-list" onclick="searchMonth(5)"><%=now.get(now.MONTH)+1%>월</li>
                                    <% now.add(now.MONTH,1); %>
                                    <li class="month-list" onclick="searchMonth(4)"><%=now.get(now.MONTH)+1%>월</li>
                                    <% now.add(now.MONTH,1); %>
                                    <li class="month-list" onclick="searchMonth(3)"><%=now.get(now.MONTH)+1%>월</li>
                                    <% now.add(now.MONTH,1); %>
                                    <li class="month-list" onclick="searchMonth(2)"><%=now.get(now.MONTH)+1%>월</li>
                                    <% now.add(now.MONTH,1); %>
                                    <li class="month-list" onclick="searchMonth(1)"><%=now.get(now.MONTH)+1%>월</li>
                                    <% now.add(now.MONTH,1); %>
                                    <li class="month-list" onclick="searchMonth(0)"><%=now.get(now.MONTH)+1%>월</li>
                                </ul>
                            </div>
                            <div class="date-form">
                                <div class="date-box">
                                    <input type="text" id="fromdate" name="fromdate" class="date-input" value="<%=fromDate%>">
                                    <sapn class="cal-ico"></sapn>
                                </div>
                                <div class="date-box">
                                    <span class="wave">&nbsp;~&nbsp;</span>
                                </div>
                                <div class="date-box">
                                    <input type="text" id="todate" name="todate" class="date-input"  value="<%=toDate%>">
                                    <sapn class="cal-ico"></sapn>
                                </div>
                            </div>
                            <div class="form-controls">
                                <select class="form-control date-config" name="mode" id="mode">
                                    <option value="all" selected="selected">전체
                                    <option value="save">적립
                                    <option value="use">사용
                                </select>
                            </div>
                            <sapn class="search-ico" onclick="search();"></sapn>
                        </th>
<%--                        <input type="text" id="datePicker" class="form-control" value="2019-06-27">--%>
                    </tr>
                </table>
                <table class="table">
                    <colgroup>
                        <col width="100">
                        <col>
                        <col width="150">
                        <col width="130">
                    </colgroup>
                    <thead>
                        <th>구분</th>
                        <th>내역</th>
                        <th>금액</th>
                        <th>날짜</th>
                    </thead>
                    <tbody>
                        <c:forEach var="point" items="${requestScope.points}">
                            <tr>
                                <td>
                                    <c:if test="${!point.plma}">
                                        <span class="point-pl">적립</span>
                                    </c:if>
                                    <c:if test="${point.plma}">
                                        <span class="point-ma">사용</span>
                                    </c:if>
                                </td>
                                <td>${point.po_subject}</td>
                                <td><fmt:formatNumber value="${point.point}" pattern="#,###" /></td>
                                <td>${point.po_date}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div align="center">
                <footer>${requestScope.pagingHtml}</footer>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function() {
            $('#fromdate').datepicker({
                format: "yyyy-mm-dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
                language : "ko" //달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
            });//datepicker end
        });//ready end

        $(function() {
            $('#todate').datepicker({
                format: "yyyy-mm-dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
                language : "ko" //달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
            });//datepicker end
        });//ready end

        function search(){
            location.href='<%=NoForm%>point&mode='+$('#mode').val()+'&fromdate='+$('#fromdate').val()+'&todate='+$('#todate').val();
        }
        function searchMonth(month){
            var now = new Date();
            var fromdate_ = new Date(now.getFullYear(), now.getMonth()-month, 1);
            var fromdate = fromdate_.getFullYear() + '-' + ("0"+(fromdate_.getMonth()+1)).slice(-2) + '-' + ("0"+(fromdate_.getDate())).slice(-2);

            var todate_ = new Date(now.getFullYear(), now.getMonth()+1-month, 0);
            var todate = todate_.getFullYear() + '-' + ("0"+(todate_.getMonth()+1)).slice(-2) + '-' + ("0"+(todate_.getDate())).slice(-2);
            location.href='<%=NoForm%>point&mode=' + $('#mode').val() + '&fromdate=' + fromdate + '&todate=' + todate;
        }

        /* 방금 전 선택한 콤보 박스를 그대로 보여 주기 */
        $('#mode option').each(function (index){
            if( $(this).val() == '${requestScope.mode}' ){
                $(this).attr('selected', 'selected') ;
            }
        });
    </script>
</body>
</html>
