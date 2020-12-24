<%--
  Created by IntelliJ IDEA.
  User: lomuh
  Date: 2020-12-24
  Time: 오전 10:06
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="./../common/nav.jsp"%>
<html>
<head>
    <title><%=NAME%>, 마이페이지</title>
    <style>
        dl, dt, dd, ul, ol, menu, li {list-style: none; margin: 0px; padding: 0px}

        #container {
            min-width: 980px;
            margin: 0 auto;
            padding: 0 30px;
        }
        .mypage {
            float: left;
        }
        .mypage_left {
            width: 140px;
            background-color: rgb(40, 109, 180);
        }
        .nav_box_h {
            height: 80px;
            box-sizing: border-box;
            color: #FFFFFF;
        }
        .nav_box_header {
            width: 110px;
            background-position: 0px 0px;
            margin: 42px auto 0px;
        }
        .mypage_nav {
            background-color: rgb(249, 249, 249);
            border-width: 0px 1px 1px;
            border-style: solid;
            border-color: rgb(225, 228, 230);
            color: rgb(17, 17, 17);
            padding: 10px 0px 0px;
            margin: 0px;
        }
        .nav_boxes {
            padding: 15px 10px 16px 17px;
            border-bottom: 1px solid rgb(225, 228, 230);
        }
        .nav_boxes_list_f{
            font-weight: bold;
            font-size: 15px;
            line-height: 20px;
            margin-bottom: 11px;
        }
        .nav_boxes_list_c{
            font-size: 13px;
            line-height: 16px;
            padding: 3px 0px;
        }
        .mypage_right {
            width: 840px;
            background-color: rgb(130, 188, 226);
        }
        .content_box {
            border-width: 1px 1px 1px 0px;
            border-top-style: solid;
            border-right-style: solid;
            border-bottom-style: solid;
            border-top-color: rgb(119, 174, 209);
            border-right-color: rgb(119, 174, 209);
            border-bottom-color: rgb(119, 174, 209);
            height: 120px;
            box-sizing: content-box;
            color: #FFFFFF;
            float: left;
        }
        .content_box_c {
            float: left;
            text-align: center;
            width: 140px;
            padding: 20px 0px 16px;
            text-shadow: rgba(0, 0, 0, 0.2) 0px 1px 0px;
            border-right: 1px solid rgb(155, 201, 232);
            border-left: 1px solid rgb(120, 173, 208);
            box-sizing: content-box;
        }
        .content_box_c:last-child {
            float: left;
            text-align: center;
            width: 269px;
            padding: 20px 0px 16px;
            text-shadow: rgba(0, 0, 0, 0.2) 0px 1px 0px;
            border-right: 1px solid rgb(155, 201, 232);
            border-left: 1px solid rgb(120, 173, 208);
            box-sizing: content-box;
        }
        .content_box_content {
            margin-bottom: 13px;
            height: 21px;
            color: rgb(255, 255, 255);
            font-size: 17px;
            font-weight: bold;
        }
        .content_box_content_no{
            font-size: 40px;
        }
        .content_box_content_font{
            font-size: 15px;
        }
    </style>
</head>
<body>
    <div id="container">
        <div class="mypage mypage_left">
            <div class="nav_box_h">
                <h3 class="nav_box_header">MY 쿠팡</h3>
            </div>
            <nav class="mypage_nav">
                <div class="nav_boxes">
                    <ul class="nav_boxes_list">
                        <li class="nav_boxes_list_f">MY 쇼핑</li>
                        <li class="nav_boxes_list_c">주문목록/배송조회</li>
                        <li class="nav_boxes_list_c">교환/반품 내역</li>
                        <li class="nav_boxes_list_c">정기배송 내역</li>
                    </ul>
                </div>
                <div class="nav_boxes">
                    <ul class="nav_boxes_list">
                        <li class="nav_boxes_list_f">MY 혜택</li>
                        <li class="nav_boxes_list_c">보유 쿠폰 조회</li>
                        <li class="nav_boxes_list_c">보유 포인트 내역</li>
                    </ul>
                </div>
                <div class="nav_boxes">
                    <ul class="nav_boxes_list">
                        <li class="nav_boxes_list_f">MY 정보</li>
                        <li class="nav_boxes_list_c">개인정보 확인/수정</li>
                        <li class="nav_boxes_list_c">결제 수단 관리</li>
                        <li class="nav_boxes_list_c">배송지 관리</li>
                    </ul>
                </div>
            </nav>
        </div>
        <div class="mypage mypage_right">
            <ul class="content_box">
                <li class="content_box_c">
                    <strong class="content_box_content">보유중인 쿠폰</strong>
                    <div>
                        <span class="content_box_content_no">3</span>
                        <span class="content_box_content_font">장</span>
                    </div>
                </li>
                <li class="content_box_c">
                    <strong class="content_box_content">결제완료</strong>
                    <div>
                        <span class="content_box_content_no">3</span>
                        <span class="content_box_content_font">건</span>
                    </div>
                </li>
                <li class="content_box_c">
                    <strong class="content_box_content">배송중</strong>
                    <div>
                        <span class="content_box_content_no">3</span>
                        <span class="content_box_content_font">건</span>
                    </div>
                </li>
                <li class="content_box_c">
                    <strong class="content_box_content">배송완료</strong>
                    <div>
                        <span class="content_box_content_no">3</span>
                        <span class="content_box_content_font">건</span>
                    </div>
                </li>
                <li class="content_box_c">
                    <strong class="content_box_content">보유한 포인트</strong>
                    <div>
                        <span class="content_box_content_no">100,000</span>
                        <span class="content_box_content_font">원</span>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</body>
</html>
