<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header Page</title>
        <link href="css/header.css" rel="stylesheet">
    </head>
    <body>
        <header class="header" id="header">
            <nav class="navbar navbar-expand-lg navbar-light">
                <h2><a exact="true" class="logo" href="${sessionScope.LOGIN_USERDTO.roleID == 'student' ? 'student' : 'management'}">Quiz</a></h2>

                <c:if test="${sessionScope.LOGIN_USERDTO != null}">
                    <c:if test="${sessionScope.LOGIN_USERDTO.roleID == 'admin'}">
                        <a class="navbar-brand mr-3" href="management">Admin Management</a>
                    </c:if>
                </c:if>



                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                    </li>
                </ul>
                <c:choose>
                    <c:when test="${sessionScope.LOGIN_USERDTO == null}">
                        <a class="navbar-brand" href="login">Login</a>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${sessionScope.LOGIN_USERDTO.roleID == 'US'}">
                            <div class="cart">
                                <a href="MainController?btnAction=Cart">
                                    <c:set var="totalProduct" value="0"/>
                                    <c:if test="${sessionScope.CART != null}">
                                        <c:set var="totalProduct" value="${sessionScope.CART.getCart().values().size()}"/>
                                    </c:if>
                                    <span class="nb">${totalProduct}</span>
                                    <img src="images/cart.svg" alt="cart">
                                </a>
                            </div>
                        </c:if>
                        <ul class="navbar-nav">
                            <li class="nav-item dropdown">
                                <a class="nav-link" href="#" id="navbarDropdown" style=" color: #7d99ff; " data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Welcome, ${sessionScope.LOGIN_USERDTO.name}
                                </a>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                                    <c:if test="${sessionScope.LOGIN_USERDTO.roleID == 'student'}">
                                        <a class="dropdown-item" href="history">History</a>
                                    </c:if>
                                    <a class="dropdown-item" href="logout">Logout</a>
                                </div>
                            </li>
                        </ul>
                    </c:otherwise>
                </c:choose>

            </nav>
        </header>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>