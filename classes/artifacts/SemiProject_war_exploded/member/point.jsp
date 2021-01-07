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
    fromtime.add(Calendar.MONTH, -1);

    fromDate = request.getParameter("name")==null?sdf.format(fromtime.getTime()):request.getParameter("name");
    toDate = request.getParameter("name")==null?sdf.format(totime.getTime()):request.getParameter("name");
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
    <script type="text/javascript">
        $(function() {
            $('#fromDate').datepicker({
                format: "yyyy-mm-dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
                language : "ko" //달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
            });//datepicker end
        });//ready end

        $(function() {
            $('#toDate').datepicker({
                format: "yyyy-mm-dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
                language : "ko" //달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
            });//datepicker end
        });//ready end

        // $(function() {
        //     $('#datePicker').datepicker({
        //         format: "yyyy-mm-dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
        //         startDate: '-10d',	//달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
        //         endDate: '+10d',	//달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
        //         autoclose : true,	//사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
        //         calendarWeeks : false, //캘린더 옆에 몇 주차인지 보여주는 옵션 기본값 false 보여주려면 true
        //         clearBtn : false, //날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
        //         datesDisabled : ['2019-06-24','2019-06-26'],//선택 불가능한 일 설정 하는 배열 위에 있는 format 과 형식이 같아야함.
        //         daysOfWeekDisabled : [0,6],	//선택 불가능한 요일 설정 0 : 일요일 ~ 6 : 토요일
        //         daysOfWeekHighlighted : [3], //강조 되어야 하는 요일 설정
        //         disableTouchKeyboard : false,	//모바일에서 플러그인 작동 여부 기본값 false 가 작동 true가 작동 안함.
        //         immediateUpdates: false,	//사용자가 보는 화면으로 바로바로 날짜를 변경할지 여부 기본값 :false
        //         multidate : false, //여러 날짜 선택할 수 있게 하는 옵션 기본값 :false
        //         multidateSeparator :",", //여러 날짜를 선택했을 때 사이에 나타나는 글짜 2019-05-01,2019-06-01
        //         templates : {
        //             leftArrow: '&laquo;',
        //             rightArrow: '&raquo;'
        //         }, //다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징
        //         showWeekDays : true ,// 위에 요일 보여주는 옵션 기본값 : true
        //         title: "테스트",	//캘린더 상단에 보여주는 타이틀
        //         todayHighlight : true ,	//오늘 날짜에 하이라이팅 기능 기본값 :false
        //         toggleActive : true,	//이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
        //         weekStart : 0 ,//달력 시작 요일 선택하는 것 기본값은 0인 일요일
        //         language : "ko"	//달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
        //
        //     }).on("changeDate", function (e) {
        //         console.log(e);
        //     });//datepicker end
        // });//ready end
    </script>
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
                                    <span class="point-amount2">10,000</span>
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
                                    <span class="point-amount2"><fmt:formatNumber value="${sessionScope.exPoint}" pattern="#,###" /></span>
                                    <span>포인트</span>
                                </div>
                            </div>
                        </th>
                    </tr>
                    <tr class="month-box">
                        <th colspan="2">
                            <div class="month">
                                <ul class="month-lists">
                                    <li class="month-list">8월</li>
                                    <li class="month-list">9월</li>
                                    <li class="month-list">10월</li>
                                    <li class="month-list">11월</li>
                                    <li class="month-list">12월</li>
                                    <li class="month-list">1월</li>
                                </ul>
                            </div>
                            <div class="date-form">
                                <div class="date-box">
                                    <input type="text" id="fromDate" class="date-input" value="<%=fromDate%>">
                                    <sapn class="cal-ico"></sapn>
                                </div>
                                <div class="date-box">
                                    <span class="wave">&nbsp;~&nbsp;</span>
                                </div>
                                <div class="date-box">
                                    <input type="text" id="toDate" class="date-input"  value="<%=toDate%>">
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
                            <sapn class="search-ico"></sapn>
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
                        <tr>
                            <td>입금</td>
                            <td>첫번째</td>
                            <td>10,000원</td>
                            <td>2020-12-25</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
