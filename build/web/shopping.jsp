<%-- 
    Document   : index
    Created on : Jan 6, 2021, 7:34:06 PM
    Author     : HuynhBao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
              integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
              crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="css/filter.css" rel="stylesheet">
        <style>
            .hide {
                display:none;
            }

            #category-select-box {
                padding: 10px 80px 10px 40px;
                height: 70px;
                border-width: 2px 0px 0px 0px;
                border-radius: 0px;
                border-top-color: #00b7e8 !important;
            }
        </style>
    </head>
    <body>



        <jsp:include page="menu.jsp"/>



        <div class="container py-5" style="margin-top: 110px;">
            <div class="filter">
                <div class="filter-left">
                </div>
                <div class="filter-right">
                    <button class="btn btn-outline-secondary" id="btn-search-panel" type="button">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </div>
            <c:set var="searching" value="${not empty param.txtSearchCarName or not empty param.cbCategory or not empty param.txtStartDate or not empty param.txtEndDate or not empty param.txtQuantity}" />
            <div class="search-container mb-5">
                <form action="shopping">
                    <div class="basic-search">
                        <div class="input-field">
                            <input class="form-control border-primary" type="text" placeholder="Search Car Name" name="txtSearchCarName" value="${param.txtSearchCarName}">
                        </div>
                        <div class="input-group">
                            <select class="form-control" id="category-select-box" name="cbCategory">
                                <option ${param.cbCategory == '' ? 'selected' : ''} value="">Select Category</option>
                                <c:forEach items="${requestScope.CATEGORY_LIST}" var="category">
                                    <option ${param.cbCategory == category.categoryID ? 'selected' : ''} value="${category.categoryID}">${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="bg-white p-3 rounded shadow advance-search">
                        <div class="text-center">
                            <small class="text-danger">
                                ${requestScope.ERROR_NAME}
                            </small>
                            <br>
                            <small class="text-danger">
                                ${requestScope.ERROR_CATEGORY}
                            </small>
                        </div>
                        <span class="desc">ADVANCED SEARCH</span>

                        <div class="form-group mb-4">
                            <div class="form-group">
                                <label for="txtPrice">Start Date</label>
                                <input type="date" class="form-control" id="txtStartDate" name="txtStartDate" placeholder="Enter Start Date" value="${param.txtStartDate}">
                                <small class="text-danger">
                                    ${requestScope.ERROR_START_DATE}
                                </small>
                            </div>

                        </div>

                        <div class="form-group mb-4">
                            <div class="form-group">
                                <label for="txtEndDate">End Date</label>
                                <input type="date" class="form-control" id="txtPrice" name="txtEndDate" placeholder="Enter End Date" value="${param.txtEndDate}">
                                <small class="text-danger">
                                    ${requestScope.ERROR_END_DATE}
                                </small>
                            </div>

                        </div>


                        <div class="form-group mb-4">
                            <div class="form-group">
                                <label for="txtPrice">Quantity</label>
                                <input type="text" class="form-control" id="txtPrice" name="txtQuantity" placeholder="Enter Quantity" value="${param.txtQuantity}">
                                <small class="text-danger">
                                    ${requestScope.ERROR_QUANTITY}
                                </small>
                            </div>

                        </div>



                        <div class="form-group mb-4 text-center">
                            <button type="submit" class="btn btn-primary btn-lg btn-radius btn-search">Search</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="row pb-5 mb-4">
                <c:forEach items="${requestScope.PRODUCT_LIST}" var="product">
                    <div class="col-4 mt-4">
                        <!-- Card-->
                        <div class="card rounded shadow-sm border-0">
                            <div class="card-body p-4"><img src="images/bg-car-rental.png" alt="" class="card-img-top embed-responsive-item" style="width: 100%; height: 170px; object-fit: cover;">
                                <h5> <a href="#" class="text-dark">${product.name}</a></h5>
                                <h6>Price: ${product.price}$/per day</h6>
                                <h6>Quantity: ${product.quantity} left</h6>
                                <p class="small text-muted font-italic">Color: ${product.color}, Year: ${product.year}</p>
                                <ul class="list-inline small">
                                    <li class="list-inline-item m-0">Category: ${product.category.name}</li>
                                </ul>
                                <form action="AddCar" method="POST">
                                    <input type="hidden" name="txtCarID" value="${product.carID}" />
                                    <input type="hidden" name="txtStartDate" value="${param.txtStartDate}" />
                                    <input type="hidden" name="txtEndDate" value="${param.txtEndDate}" />
                                    <input type="hidden" name="txtQuantity" value="${param.txtQuantity}" />
                                    <button type="submit" class="btn btn-outline-primary w-100" id="btn-search-panel"><i class="fa fa-cart-plus"></i></button>
                                </form>
                                <c:url value = "AddCar" var = "addLink">
                                    <c:param name="txtCarID" value="${product.carID}" />
                                    <c:param name="txtStartDate" value="${param.txtStartDate}" />
                                    <c:param name="txtEndDate" value="${param.txtEndDate}" />
                                </c:url>
<!--                                <a class="btn btn-outline-primary w-100" id="btn-search-panel" href="${addLink}">
                                    <i class="fa fa-cart-plus"></i>
                                </a>-->
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
            <c:if test="${empty requestScope.PRODUCT_LIST and searching}">
                <div class="row">
                    <div class="col-12 text-center">
                        <img class="center-block img-responsive" src="images/not-found.jpg" alt="product-empty"/>
                    </div>
                </div>
            </c:if>
            <div class="row">
                <div class="col-lg-6 offset-lg-3 py-5 d-flex">
                    <jsp:include page="paging.jsp" >
                        <jsp:param name="currentPage" value="${currentPage}" />
                        <jsp:param name="noOfPages" value="${noOfPages}" />
                        <jsp:param name="hrefLink" value="shopping?txtSearchCarName=${param.txtSearchCarName}&cbCategory=${param.cbCategory}&txtStartDate=${param.txtStartDate}&txtEndDate=${param.txtEndDate}&txtQuantity=${param.txtQuantity}" />
                    </jsp:include>
                </div>
            </div>



        </div>

        <script>
            $('#btn-search-panel').click(function () {
                $('.search-container').slideToggle('slow');
            });
        </script>

        <jsp:include page="footer.jsp"/>

    </body>
</html>
