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

            table#checkout-table {
                width: 450px;
            }

            #checkout-table th {
                width: 25%;
            }

            table#checkout-table td {
                text-align: center;
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
                                        <th style="width:35%">Name</th>
                                        <th>Category</th>
                                        <th style="width:10%">Quantity</th>
                                        <th>Days</th>
                                        <th class="text-center">Price</th>
                                        <th class="text-center">Total</th>
                                        <th class="text-center">Action</th>
                                        <th class="text-center">Note</th>
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
                                                <c:out value = "${cart.days}" />
                                            </td>
                                            <td data-th="Price" class="text-center">$${cart.price}</td>
                                            <td data-th="Total" class="text-center">$${cart.price * cart.quantity * cart.days}</td>
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
                                                <c:if test="${requestScope.OUT_OF_STOCK_LIST != null and not empty requestScope.OUT_OF_STOCK_LIST}">
                                                    <c:forEach var="outStockList" items="${requestScope.OUT_OF_STOCK_LIST}">
                                                        <c:if test="${sessionScope.CART.getKey(cart) == sessionScope.CART.getKey(outStockList)}">
                                                            There are ONLY ${outStockList.quantity} cars left
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </td>
                                        </tr>
                                        <c:set var="total" value="${total + (cart.price * cart.quantity * cart.days)}"/>
                                    </c:forEach>

                                </tbody>
                            </table>
                            <div class="mt-3 float-left text-left">
                                <h4 class="text-center">User Information</h4>
                                <hr>
                                <form action="checkout" method="POST" id="checkout-form">
                                    <input type="hidden" id="text-discountID" name="txtDiscountID" value="" />
                                    <div class="form-group">
                                        <label for="txtFullName">Full Name</label>
                                        <input type="text" class="form-control" name="txtFullName" style=" width: 300px;" value="${sessionScope.LOGIN_USERDTO.name}">
                                    </div>
                                    <div class="form-group">
                                        <label for="txtPhone">Phone Number</label>
                                        <input type="text" class="form-control" name="txtPhone" style=" width: 300px;" value="${sessionScope.LOGIN_USERDTO.phone}">
                                    </div>
                                    <div class="form-group">
                                        <label for="txtAddress">Address</label>
                                        <input type="text" class="form-control" name="txtAddress" style=" width: 300px;" value="${sessionScope.LOGIN_USERDTO.address}">
                                    </div>
                                </form>
                            </div>
                            <div class="mt-3 float-right text-right">
                                <h4 class="text-center">Cart Information</h4>
                                <hr>
                                <div>
                                    <table id="checkout-table" border="1">
                                        <tr>
                                            <th>Discount</th>
                                            <td>
                                                <form action="CheckDiscount" id="check-discount">
                                                    <div>
                                                        <input type="hidden" name="txtTotal" value="${total}" />
                                                        <input type="text" class="form-control text-center" name="txtDiscount" id="txtDiscount" style=" width: auto; display: inline-block; text-transform: uppercase;" value="">
                                                        <!--<input type="submit" class="btn" style=" margin-top: -5px; background-color: #000000; color: #fff;">Apply</button>-->
                                                        <button type="submit" id="btn-discount" class="btn" style=" margin-top: -5px; background-color: #000000; color: #fff;">Apply</button>
                                                    </div>
                                                </form>
                                                <small class="text-danger" id="text-discount">

                                                </small>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Total</th>
                                            <td class="font-weight-bold">
                                                <div>
                                                    $${total}
                                                </div>
                                                <div id="total-discount">

                                                </div>
                                            </td>

                                        </tr>
                                    </table>
                                </div>
                                <div class="d-block my-3">
                                    <input type="submit" form="checkout-form" class="btn btn-primary mb-4 btn-lg pl-5 pr-5" value="Confirm" />
                                </div>
                            </div>



                            <hr class="mb-4">


                        </c:otherwise>
                    </c:choose>



                </div>
            </div>

            <div class="col-sm-6 mb-3 mb-m-1 order-md-1 text-md-left mt-3">
                <a href="shopping">
                    <i class="fa fa-arrow-left mr-2"></i> Continue Shopping</a>
            </div>
        </div>

        <script>

            $(document).ready(function () {
                var msgBox = ${requestScope.MSG == null ? false : true};

                if (msgBox) {
                    $('#msgModal').modal('show');
                }
            });

            var appliedDiscount = false;
            $("#check-discount").submit(function (e) {
                $("#text-discount").html("");
                $("#text-discountID").val("");
                $("#total-discount").html("");
                $("#txtDiscount").prop('disabled', false);
                $("#btn-discount").html('Apply');
                e.preventDefault();

                if (!appliedDiscount) {
                    $.ajax({
                        url: 'checkDiscount',
                        type: 'GET',
                        data: $("#check-discount").serialize(),
                        success: function (result) {
                            if (result !== null) {
                                if (result === "NotFound") {
                                    $("#text-discount").html("Discount was not found!");
                                } else if (result === "Empty") {
                                    $("#text-discount").html("Input discount!");
                                } else if (result === "Expired") {
                                    $("#text-discount").html("Discount was expired!");
                                } else {
                                    var discount = JSON.parse(JSON.stringify(result));
                                    if (typeof (discount.name) !== 'undefined') {
                                        $("#txtDiscount").prop('disabled', true);
                                        $("#total-discount").html("Discount: -$" + discount.discountValue + "<br>New Price: $" + discount.newTotal);
                                        $("#text-discount").html("Discount " + discount.name + " has been applied successful!");
                                        $("#text-discountID").val(discount.discountID);
                                        $("#btn-discount").html('Remove');
                                        appliedDiscount = true;
                                    } else {
                                        window.location.href = 'login';
                                    }
                                }
                            }
                        },
                        error: function () {
                            alert("Cannot apply this discount!");
                        }
                    });
                } else {
                    appliedDiscount = false;
                    $("#txtDiscount").val("");
                }
            });

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
        <jsp:include page="footer.jsp"/>
    </body>
</html>
