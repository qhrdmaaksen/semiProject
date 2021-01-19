<%@page import="utility.Paging" %>
<%@page import="DAO.ProductDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="./../common/nav.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.mdb-select').materialSelect();
            $('.select-wrapper.md-form.md-outline input.select-dropdown').bind('focus blur', function () {
                $(this).closest('.select-outline').find('label').toggleClass('active');
                $(this).closest('.select-outline').find('.caret').toggleClass('active');
            });
        })
    </script>
    <style>
        .nodiscount{
            position: relative;
            right: 71px;
            bottom: 20px;
        }
    </style>
</head>
<body id="cartlist_body">
    <div class="px-4 px-lg-0">
        <!-- For demo purpose -->
        <div class="container text-#8B4513 py-5 text-center">
            <h3><i class="fas fa-shopping-cart"></i> Shopping Cart</h3>
        </div>
        <!-- End -->

        <div class="container">
            <!-- Nav tabs -->
            <ul ul class="nav nav-pills nav-justified btn-light" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#home">일반 상품 주문</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu1">정기 상품 주문</a>
                </li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div id="home" class="container tab-pane active"><br>
                    <h3>일반 주문</h3>
                    <br>
                    <div class="pb-5">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-12 p-5 bg-white rounded shadow-sm mb-5">
                                    <!-- Shopping cart table -->
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="p-2 px-3 text-uppercase">Product</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Price</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Quantity</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Remove</div>
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${sessionScope.shoplists}" var="shopinfo">
                                                    <tr>
                                                        <th scope="row" class="border-0">
                                                            <div class="p-2">
                                                                <c:if test="${applicationScope.debugMode == true}">
                                                                    이미지 경로<br>${applicationScope.uploadedPath}/${shopinfo.images}
                                                                </c:if>
                                                                <img src="${applicationScope.uploadedPath}/${shopinfo.images}"
                                                                     alt="" width="70" class="img-fluid rounded shadow-sm">
                                                                <div class="ml-3 d-inline-block align-middle">
                                                                    <h5 class="mb-0"><a href="#"
                                                                                        class="text-dark d-inline-block align-middle">
                                                                            ${shopinfo.productname}</a></h5>
                                                                    <span class="text-muted font-weight-normal font-italic d-block">Category: Watches</span>
                                                                </div>
                                                            </div>
                                                        </th>
                                                        <td class="border-0 align-middle">
                                                            <span class="text-danger mr-1 ">
                                                                <strong>￦<fmt:formatNumber value="${shopinfo.productprice*0.8}" pattern="###,###"/></strong>
                                                            </span>
                                                            <span class="text-grey nodiscount"><s>
                                                                ￦<fmt:formatNumber value="${shopinfo.productprice}" pattern="###,###"/>
                                                            </s></span>
                                                        </td>
                                                        <td class="border-0 align-middle"><strong>${shopinfo.qty}</strong></td>
                                                        <td class="border-0 align-middle">
                                                            <a href="<%=NoForm%>mallcartdelete&productcode=${shopinfo.productcode}&qty=${shopinfo.qty}" type="button"
                                                               class="card-link-secondary small text-uppercase mr-3">
                                                                Delete
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- End -->
                                </div>
                            </div>
                            <div class="row py-5 p-4 bg-white rounded shadow-sm">
                                <div class="col-lg-6">
                                    <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Coupon
                                        code
                                    </div>
                                    <div class="p-4">
                                        <p class="font-italic mb-4">If you have a coupon code, please enter it in the box below</p>
                                        <div class="input-group mb-4 border rounded-pill p-2">
                                            <input type="text" placeholder="Apply coupon" aria-describedby="button-addon3" class="form-control border-0">
                                            <div class="input-group-append border-0">
                                                <button id="button-addon3" type="button" class="btn btn-dark px-4 rounded-pill">
                                                    <i class="fa fa-gift mr-2"></i>Apply coupon
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">
                                        Order summary
                                    </div>
                                    <div class="p-4">
                                        <p class="font-italic mb-4">총 구매금액이 50,000원 이상 일 경우 배송비가 부과되지 않습니다.</p>
                                        <ul class="list-unstyled mb-4">
                                            <li class="d-flex justify-content-between py-3 border-bottom">
                                                <strong class="text-muted">Pre-discount totalamount </strong>
                                                <strong>￦<fmt:formatNumber value="${sessionScope.totalAmount}" pattern="###,###"/></strong>
                                            </li>
                                            <li class="d-flex justify-content-between py-3 border-bottom">
                                                <strong class="text-muted">
                                                    <i class='fas fa-shipping-fast'></i>
                                                    Shipping and handling
                                                </strong>
                                                <strong>
                                                    <c:if test="${sessionScope.totalAmount*0.8>=50000}">
                                                        <span class="text-grey">
                                                            <s>￦<fmt:formatNumber value="3000" pattern="###,###"/></s>
                                                        </span>
                                                        ￦<fmt:formatNumber value="0" pattern="###,###"/>
                                                    </c:if>
                                                    <c:if test="${sessionScope.totalAmount*0.8 < 50000}">
                                                        ￦<fmt:formatNumber value="3000" pattern="###,###"/></c:if>
                                                </strong>
                                            </li>
                                            <li class="d-flex justify-content-between py-3 border-bottom">
                                                <strong class="text-muted">Discount</strong>
                                                <strong class="red">￦<fmt:formatNumber value="${sessionScope.totalAmount*(1-0.8)}" pattern="###,###"/></strong>
                                            </li>
                                            <li class="d-flex justify-content-between py-3 border-bottom">
                                                <strong class="text-muted">Total</strong>
                                                <h5 class="font-weight-bold">￦<fmt:formatNumber value="${sessionScope.totalAmount*0.8}" pattern="###,###"/></h5>
                                            </li>
                                        </ul>
                                        <form id="order" action="<%=YesForm%>" method="post">
                                            <button type="button" class="btn btn-dark rounded-pill py-2 btn-block" onclick="goOrder()">Procceed to checkout</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu1" class="container tab-pane fade"><br>
                    <h3>정기 주문</h3>
                    <br>
                    <div class="pb-5">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-12 p-5 bg-white rounded shadow-sm mb-5">
                                    <!-- Shopping cart table -->
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="p-2 px-3 text-uppercase">Product</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Price</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Months</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Remove</div>
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${sessionScope.Rshoplists}" var="Rshopinfo">
                                                    <tr>
                                                        <th scope="row" class="border-0">
                                                            <div class="p-2">
                                                                <c:if test="${applicationScope.debugMode == true}">
                                                                    이미지 경로<br>${applicationScope.uploadedPath}/${Rshopinfo.images}
                                                                </c:if>
                                                                <img src="${applicationScope.uploadedPath}/${Rshopinfo.images}"
                                                                     alt="" width="70" class="img-fluid rounded shadow-sm">
                                                                <div class="ml-3 d-inline-block align-middle">
                                                                    <h5 class="mb-0">
                                                                        <a href="#" class="text-dark d-inline-block align-middle">${Rshopinfo.productname}</a>
                                                                    </h5>
                                                                    <span class="text-muted font-weight-normal font-italic d-block">Category: Watches</span>
                                                                </div>
                                                            </div>
                                                        </th>
                                                        <td class="border-0 align-middle" id="productprice">
                                                            <c:if test="${Rshopinfo.months>1}">
                                                                <span class="text-danger mr-1 ">
                                                                    <strong>￦<fmt:formatNumber value="${Rshopinfo.productprice * 0.7}" pattern="###,###"/></strong>
                                                                </span>
                                                            </c:if>
                                                            <c:if test="${Rshopinfo.months==1}">
                                                                <span class="text-danger mr-1 ">
                                                                    <strong>￦<fmt:formatNumber value="${Rshopinfo.productprice * 0.8}" pattern="###,###"/></strong>
                                                                </span>
                                                            </c:if>
                                                            <span class="text-grey nodiscount"><s>
                                                                ￦<fmt:formatNumber value="${Rshopinfo.productprice}" pattern="###,###"/>
                                                            </s></span>
                                                        </td>
                                                        <td class="border-0 align-middle">
                                                            <div class="select-outline position-relative w-24">
                                                                <form class="form-inline" role="form" name="myform" action="<%=YesForm%>" method="post">
                                                                    <input type="hidden" name="command" value="mallcartmodify">
                                                                    <input type="hidden" name="productcode" value="${Rshopinfo.productcode}">
                                                                    <select class="mdb-select md-form md-outline" name="months">
                                                                        <option value="${Rshopinfo.months}" disabled selected>${Rshopinfo.months} 개월</option>
                                                                        <option value="1">1개월</option>
                                                                        <option value="2">2개월</option>
                                                                        <option value="3">3개월</option>
                                                                        <option value="4">4개월</option>
                                                                        <option value="5">5개월</option>
                                                                        <option value="6">6개월</option>
                                                                    </select>
                                                                    <button type="submit"
                                                                            class="btn btn-outline-info btn-sm mb-2">수량 변경
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </td>
                                                        <td class="border-0 align-middle">
                                                            <a href="<%=NoForm%>mallcartdelete&productcode=${Rshopinfo.productcode}&months=${Rshopinfo.months}" type="button" class="card-link-secondary small text-uppercase mr-3">Delete</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- End -->
                                </div>
                            </div>
                            <div class="row py-5 p-4 bg-white rounded shadow-sm">
                                <div class="col-lg-6">
                                    <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Coupon code</div>
                                    <div class="p-4">
                                        <p class="font-italic mb-4">If you have a coupon code, please enter it in the box below</p>
                                        <div class="input-group mb-4 border rounded-pill p-2">
                                            <input type="text" placeholder="Apply coupon" aria-describedby="button-addon3" class="form-control border-0">
                                            <div class="input-group-append border-0">
                                                <button id="button-addon3" type="button" class="btn btn-dark px-4 rounded-pill">
                                                    <i class="fa fa-gift mr-2"></i>Apply coupon
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Order summary</div>
                                    <div class="p-4">
                                        <p class="font-italic mb-4">정기 배송의 경우 배송비가 부과되지 않습니다.</p>
                                        <ul class="list-unstyled mb-4">
                                            <li class="d-flex justify-content-between py-3 border-bottom">
                                                <strong class="text-muted">Pre-discount totalamount </strong>
                                                <strong id=totalprice>￦<fmt:formatNumber value="${sessionScope.RtotalAmount}" pattern="###,###"/></strong>
                                            </li>
                                            <li class="d-flex justify-content-between py-3 border-bottom">
                                                <strong class="text-muted">
                                                    <i class='fas fa-shipping-fast'></i> Shipping and handling
                                                </strong>
                                                <strong>
                                                    <span class="text-grey">
                                                        <s>￦<fmt:formatNumber value="3000" pattern="###,###"/></s>
                                                    </span>
                                                    ￦<fmt:formatNumber value="0" pattern="###,###"/>
                                                </strong>
                                            </li>
                                            <li class="d-flex justify-content-between py-3 border-bottom">
                                                <strong class="text-muted">Discount</strong>
                                                <strong>
                                                    <h5 class="font-weight-bold">￦<fmt:formatNumber value="${sessionScope.RtotalAmount*0.2}" pattern="###,###"/></h5>
                                                </strong>
                                            </li>
                                            <li class="d-flex justify-content-between py-3 border-bottom">
                                                <strong class="text-muted">Total</strong>
                                                <h5 class="font-weight-bold">￦<fmt:formatNumber value="${sessionScope.RtotalAmount*0.8}" pattern="###,###"/></h5>
                                            </li>
                                        </ul>
                                        <form id="reguler" action="<%=YesForm%>" method="post">
                                            <button type="button" class="btn btn-dark rounded-pill py-2 btn-block"  onclick="goReguler()">Procceed to checkout</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        var command = "<input type='hidden' name='command' value='payment'>";
        var directbuy = "<input type='hidden' name='directbuy' value='-1'>"

        function goOrder(){
            $("#order").append(command);
            $("#order").append(directbuy);
            $("#order").append("<input type='hidden' name='regular' value='-1'>");
            $("#order").submit();
        }

        function goReguler(){
            $("#reguler").append(command);
            $("#reguler").append(directbuy);
            $("#reguler").append("<input type='hidden' name='regular' value='1'>");
            $("#reguler").submit();
        }
    </script>
</body>
</html>