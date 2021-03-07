<%-- 
    Document   : checkout
    Created on : Jan 10, 2021, 2:11:13 PM
    Author     : HuynhBao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
              integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
              crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        <jsp:include page="menu.jsp"/>
        <div class="container" style="margin-top: 140px;">
            <c:choose>
                <c:when test="${requestScope.SUCCESS}">
                    <h2 class="text-center">You have placed your order successfully</h2>
                    <a href="shopping" style="margin-top: 150px;">Continue to shopping</a>
                </c:when>
                <c:otherwise>
                    <h2 class="text-center">Order ERROR!</h2>
                    <a href="cart" style="margin-top: 150px;">Back to cart</a>
                </c:otherwise>
            </c:choose>
            
        </div>
    </body>
</html>
