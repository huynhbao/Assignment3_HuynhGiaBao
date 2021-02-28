<%-- 
    Document   : cart
    Created on : Jan 9, 2021, 4:48:33 PM
    Author     : HuynhBao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
              integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
              crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <style>

            a:hover {
                text-decoration: none!important;
            }
            .cart-title {
                font-weight: 700;
                font-size: 24px;
                color: #000;
                margin-bottom: 30px;
                text-transform: uppercase;
                letter-spacing: 3px;
            }

            #checkout-table {
                width: 100px;
            }

            #checkout-table tr, #checkout-table td, #checkout-table th {
                border: 1px solid #d2d2d2;
                padding: 15px;
                text-align: left;
            }
        </style>
    </head>
    <body>
        <jsp:include page="menu.jsp"/>
        <div class="container" style="margin-top: 140px;">
            <div class="row w-100">
                <div class="col-lg-12 col-md-12 col-12">
                    <!-- Modal -->
                    <div class="modal hide fade" id="confirm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Do you want to delete?</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="delete">Yes</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <c:choose>
                        <c:when test="${empty sessionScope.CART.cart}">
                            <div class="cart-empty text-center">
                                <h2>Cart Empty</h2>
                                <img class="cart-empty-image" src="images/empty-cart.png" alt="cart-empty">
                            </div>
                        </c:when>
                        <c:otherwise>
                            <h2 class="cart-title text-left">Shopping Cart</h2>
                            <br>
                            <table id="shoppingCart" class="table table-condensed table-responsive">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th style="width:40%">Name</th>
                                        <th>Category</th>
                                        <th style="width:10%">Quantity</th>
                                        <th>Num of days</th>
                                        <th class="text-center">Price</th>
                                        <th class="text-center">Total</th>
                                        <th class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="total" value="0"/>
                                    <c:forEach var="cart" items="${sessionScope.CART.getCart().values()}" varStatus="counter">

                                        <tr>
                                            <td>${counter.count}</td>
                                            <td data-th="Product">
                                                <div class="row">
                                                    <div class="col-md-4 text-left">
                                                        <img src="images/bg-car-rental.png" alt="" class="d-none d-md-block rounded mb-2 shadow " style="width: 120px;">
                                                    </div>
                                                    <div class="col-md-8 text-left mt-sm-2">
                                                        <h4>${cart.name}</h4>
                                                        <p class="font-weight-light">Color: ${cart.color} | Year: ${cart.year}</p>
                                                        <fmt:formatDate var="startDate" value="${cart.startDate}" pattern="dd-MM-yyyy"/>
                                                        <fmt:formatDate var="endDate" value="${cart.endDate}" pattern="dd-MM-yyyy"/>
                                                        <p class="font-weight-light">Start Date: ${startDate}<br>End Date: ${endDate}</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td data-th="Category">${cart.category.name}</td>
                                            <td data-th="Quantity">
                                                <form action="UpdateCar" id="updateCarForm + ${counter.count}">
                                                    <input type="text" class="form-control form-control-lg text-center" name="txtQuantity" value="${cart.quantity}">
                                                    <input type="hidden" name="txtKey" value="${sessionScope.CART.getKey(cart)}" />
                                                </form>
                                                <small class="text-danger">
                                                    ${requestScope.ERROR_QUANTITY}
                                                </small>
                                            </td>
                                            <td data-th="NumOfDays" class="text-center">

                                                <fmt:formatNumber var="numOfDays" value="${(cart.endDate.time - cart.startDate.time) / (1000*60*60*24)}" minFractionDigits="0" maxFractionDigits="0"/>
                                                <c:out value = "${numOfDays}" />
                                            </td>
                                            <td data-th="Price" class="text-center">$${cart.price}</td>
                                            <td data-th="Total" class="text-center">$${cart.price * cart.quantity * numOfDays}</td>
                                            <td class="actions" data-th="">
                                                <div class="text-center">
                                                    <button type="submit" form="updateCarForm + ${counter.count}" value="Update Item" class="btn btn-white border-secondary bg-white btn-md mb-2">
                                                        <i class="fa fa-refresh"></i>
                                                    </button>

                                                    <c:url var="deleteLink" value="DeleteCar">
                                                        <c:param name="txtKey" value="${sessionScope.CART.getKey(cart)}"/>
                                                    </c:url>
                                                    <a class="btn btn-white border-secondary bg-white btn-md mb-2 launchConfirm" onclick="deleteProduct(this); return;" data-toggle="modal" data-target="#confirm" href="${deleteLink}"><i class="fa fa-trash"></i></a>

                                                </div>
                                            </td>
                                            <td>
                                                <c:if test="${not empty requestScope.OUT_OF_STOCK_LIST}">
                                                    <c:forEach var="outStockList" items="${requestScope.OUT_OF_STOCK_LIST}">
                                                        <c:if test="${outStockList.carID == cart.carID}">
                                                            This item has only ${outStockList.quantity} product left
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </td>
                                        </tr>
                                        <c:set var="total" value="${total + (cart.price * cart.quantity)}"/>
                                    </c:forEach>

                                </tbody>
                            </table>
                            <div class="mt-3 float-right text-right">
                                <h4>Subtotal:</h4>
                                <h1>$${total}</h1>
                                <table id="checkout-table" border="1">
                                    <tr>
                                        <th>Discount</th>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th>Total</th>
                                        <td>$${total}</td>
                                    </tr>
                                </table>

                            </div>



                            <hr class="mb-4">


                        </c:otherwise>
                    </c:choose>



                </div>
            </div>
            <c:if test="${not empty sessionScope.CART.cart}">
                <div class="row mt-4 d-flex align-items-center">
                    <div class="col-sm-12 order-md-12 text-center">
                        <hr class="mb-4">
                        <h4 class="mb-3">Payment</h4>
                        <form action="MainController">

                            <div class="d-block my-3">
                                <div class="custom-control custom-radio">
                                    <input id="credit" name="paymentMethod" type="radio" class="custom-control-input" checked="" value="cash">
                                    <label class="custom-control-label" for="credit">Cash payment upon delivery</label>
                                </div>
                                <div class="custom-control custom-radio mt-2">
                                    <input id="paypal" name="paymentMethod" type="radio" class="custom-control-input" value="paypal">
                                    <label class="custom-control-label" for="paypal">PayPal</label>
                                </div>
                            </div>
                            <input type="submit" class="btn btn-primary mb-4 btn-lg pl-5 pr-5" name="btnAction" value="Confirm" />
                        </form>
                    </div>

                </div>
            </c:if>
            <div class="col-sm-6 mb-3 mb-m-1 order-md-1 text-md-left">
                <a href="shopping">
                    <i class="fa fa-arrow-left mr-2"></i> Continue Shopping</a>
            </div>
        </div>

        <script>


            function deleteProduct(ele) {
                $('#confirm')
                        .modal({backdrop: 'static', keyboard: false})
                        .one('click', '#delete', function (e) {
                            var href = ele.getAttribute("href");
                            window.location.href = href;
                        });
            }
            ;
        </script>

    </body>
</html>
