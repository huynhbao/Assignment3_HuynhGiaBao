<%-- 
    Document   : shopping-history
    Created on : Jan 10, 2021, 8:05:01 PM
    Author     : HuynhBao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping History Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
              integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
              crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

        <style>
            h2.title {
                font-weight: 700;
                font-size: 24px;
                color: #000;
                margin-bottom: 30px;
                text-transform: uppercase;
                letter-spacing: 3px;
            }

            .card-header {
                background-color: #7d9fffc7 !important;
            }

            .quantity {
                float: left;
                margin-right: 15px;
                background-color: #eee;
                position: relative;
                width: 80px;
                overflow: hidden
            }

            .quantity input {
                margin: 0;
                text-align: center;
                width: 15px;
                height: 15px;
                padding: 0;
                float: right;
                color: #000;
                font-size: 20px;
                border: 0;
                outline: 0;
                background-color: #F6F6F6
            }

            .quantity input.qty {
                position: relative;
                border: 0;
                width: 100%;
                height: 40px;
                padding: 10px 25px 10px 10px;
                text-align: center;
                font-weight: 400;
                font-size: 15px;
                border-radius: 0;
                background-clip: padding-box
            }

            .quantity .minus, .quantity .plus {
                line-height: 0;
                background-clip: padding-box;
                -webkit-border-radius: 0;
                -moz-border-radius: 0;
                border-radius: 0;
                -webkit-background-size: 6px 30px;
                -moz-background-size: 6px 30px;
                color: #bbb;
                font-size: 20px;
                position: absolute;
                height: 50%;
                border: 0;
                right: 0;
                padding: 0;
                width: 25px;
                z-index: 3
            }

            .quantity .minus:hover, .quantity .plus:hover {
                background-color: #dad8da
            }

            .quantity .minus {
                bottom: 0
            }
            .shopping-cart {
                margin-top: 20px;
            }

            .hide {
                display:none;
            }

            .vertical-align {
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: row;
                margin: 10px 0px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="menu.jsp"/>
        <!-- Modal MsgBox -->
        <div class="modal fade" id="msgModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        Message
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="modal-msg">Successful!</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="container" style="margin-top: 140px;">
            <div class="d-flex justify-content-between">
                <div>
                    <h2 class="title text-left">Shopping History</h2>
                </div>
                <div>
                    <button class="btn btn-outline-secondary" id="btn-search-panel" type="button">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </div>
            <c:set var="searching" value="${not empty param.txtSearchDate or not empty param.txtSearchName}" />
            <div class="search-container mb-5 ${searching == true ? '' : 'hide'}">
                <div class="bg-white p-3 rounded shadow">
                    <form action="history">
                        <div class="form-group mb-4">
                            <input class="form-control border-primary" type="text" name="txtSearchName" value="${param.txtSearchName}" placeholder="Car Name">
                        </div>
                        <div class="form-group mb-4">
                            <input class="form-control border-primary" type="date" name="txtSearchDate" value="${param.txtSearchDate}">
                        </div>
                        <div class="form-group mb-4 text-center">
                            <p class="text-danger">${requestScope.ERROR_SEARCH_DATE}</p>
                            <button type="submit" class="btn btn-primary btn-lg btn-radius" value="Search">Search</button>
                        </div>

                    </form>
                    <!-- End -->

                </div>
            </div>

            <c:if test="${requestScope.LIST != null}">
                <c:if test="${not empty requestScope.LIST}">
                    <c:forEach items="${requestScope.LIST}" var="order" varStatus="counter">
                        <div class="card shopping-cart">
                            <div class="card-header text-light">
                                <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                Order No #${order.orderID}
                                <div class="clearfix"></div>
                            </div>
                            <div class="card-body">
                                <c:set var="checkCancel" value="${true}" />
                                <!-- PRODUCT -->
                                <c:forEach items="${order.orderDetail}" var="orderDetail" varStatus="counterOD">
                                    <div class="row">
                                        <div class="col-12 col-sm-12 col-md-2 text-center">
                                            <img class="img-responsive" src="images/bg-car-rental.png" alt="prewiew" width="120" height="80">
                                        </div>
                                        <div class="col-12 text-sm-center col-sm-12 text-md-left col-md-2">
                                            <h4 class="product-name"><strong>${orderDetail.car.name}</strong></h4>
                                            <h6>
                                                <small>Color: ${orderDetail.car.color} | Year: ${orderDetail.car.year}</small>
                                            </h6>
                                            <h6>
                                                <small>Category ${orderDetail.car.category.name}</small>
                                            </h6>
                                        </div>
                                        <div class="col-12 col-sm-12 text-sm-center col-md-4 text-md-right row">
                                            <fmt:formatDate var="startDate" pattern="dd-MM-yyyy" value="${orderDetail.car.startDate}" />
                                            <fmt:formatDate var="endDate" pattern="dd-MM-yyyy" value="${orderDetail.car.endDate}" />
                                            <h6 class="mr-4"><small>Start Date: ${startDate}</small></h6>

                                            <h6 class="mr-4"><small>End Date: ${endDate}</small></h6>

                                            <h6><small>Num of days ${orderDetail.car.days}</small></h6>

                                        </div>
                                        <div class="col-12 col-sm-12 text-sm-center col-md-4 text-md-right row">

                                            <h6 class="mr-4"><strong>Price: $${orderDetail.car.price}</strong></h6>

                                            <h6 class="mr-4"><strong>Quantity: ${orderDetail.car.quantity}</strong></h6>

                                            <h6><strong>Total: $${orderDetail.car.quantity * orderDetail.car.price * orderDetail.car.days}</strong></h6>
                                            <jsp:useBean id="now" class="java.util.Date"/>

                                            <c:if test="${now.time > orderDetail.car.startDate.time}">
                                                <c:set var="checkCancel" value="${false}" />
                                            </c:if>
                                        </div>
                                    </div>
                                    <c:if test="${counterOD.count != order.orderDetail.size()}">
                                        <hr>
                                    </c:if>
                                </c:forEach>
                                <!-- END PRODUCT -->

                            </div>
                            <div class="card-footer">
                                <div class="row vertical-align">
                                    <div class="coupon col-md-4" style="">
                                        <fmt:formatDate var="date" pattern="dd-MM-yyyy HH:mm:ss" value="${order.date}" />
                                        Order Date: <strong>${date}</strong>
                                    </div>
                                    <div class="col-md-4 text-center">
                                        <c:choose>
                                            <c:when test="${order.status}">
                                                <c:if test="${checkCancel}">
                                                    <form action="order" method="POST">
                                                        <input type="hidden" name="txtOrderID" value="${order.orderID}" />
                                                        <button class="btn btn-primary">Cancel</button>
                                                    </form>
                                                </c:if>
                                            </c:when>
                                            <c:otherwise>
                                                This order has been cancelled!
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-4 text-right" style="">
                                        Total price: <b>$${order.total}</b>
                                        <c:if test="${order.discount != null}">
                                            <br>
                                            Discount: <strong>-$${order.discount.discountValue}</strong>
                                            <br>
                                            New Price: <strong>$${order.discount.newTotal}</strong>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="row">
                        <div class="col-lg-6 offset-lg-3 py-5 d-flex">
                            <jsp:include page="paging.jsp" >
                                <jsp:param name="currentPage" value="${requestScope.currentPage}" />
                                <jsp:param name="noOfPages" value="${requestScope.noOfPages}" />
                                <jsp:param name="hrefLink" value="history?${requestScope.PAGING_LINK}" />
                            </jsp:include>
                        </div>
                    </div>
                </c:if>
            </c:if>
            <c:if test="${empty requestScope.LIST}">
                <div class="row">
                    <div class="col-12 text-center">
                        <img class="center-block img-responsive" src="images/not-found.jpg" alt="product-empty"/>
                    </div>
                </div>
            </c:if>
        </div>
        <script>
            $(document).ready(function () {
                var checkAttr = ${requestScope.SUCCESS == null};
                if (checkAttr) {
                    var msgBox = ${requestScope.SUCCESS};
                    if (msgBox) {
                        $('#modal-msg').html('Success');
                    } else {
                        $('#modal-msg').html('Failed');
                    }
                    $('#msgModal').modal('show');
                }
            });

            $('#btn-search-panel').click(function () {
                $('.search-container').slideToggle('slow');
            });
        </script>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
