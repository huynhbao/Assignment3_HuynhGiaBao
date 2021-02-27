<%-- 
    Document   : register
    Created on : Jan 22, 2021, 8:26:38 PM
    Author     : HuynhBao
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
              integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
              crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="css/login.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="menu.jsp"/>
        <div class="container" style="margin-top: 140px;">
            <div class="row main-content">
                <div class="col-md-6 bg">
                    <img src="images/login-img.jpg" alt="login-img">
                </div>
                <div class="col-md-6 login_form">
                    <div class="container" style=" padding: 0px; margin-top: 20px; ">
                        <form action="register" method="POST" id="login-form" class="form-group">
                            <p class="text-danger">${REGISTER_MSG}</p>
                            <div class="form-group">
                                <p class="text-danger">${ERROR_EMAIL}</p>
                                <input type="email" name="txtEmail" value="${param.txtEmail}" class="form__input" placeholder="Email">
                            </div>
                            <div class="form-group">
                                <p class="text-danger">${ERROR_NAME}</p>
                                <input type="text" name="txtName" value="${param.txtName}" class="form__input" placeholder="Name">
                            </div>
                            <div class="form-group">
                                <p class="text-danger">${ERROR_PHONE}</p>
                                <input type="text" name="txtPhone" value="${param.txtPhone}" class="form__input" placeholder="Phone Number">
                            </div>
                            <div class="form-group">
                                <p class="text-danger">${ERROR_ADDRESS}</p>
                                <input type="text" name="txtAddress" value="${param.txtAddress}" class="form__input" placeholder="Address">
                            </div>
                            <div class="form-group">
                                <p class="text-danger">${ERROR_PASSWORD}</p>
                                <input type="password" name="txtPassword" class="form__input" placeholder="Password">
                            </div>
                            <div class="form-group">
                                <input type="password" name="txtConfirm" class="form__input" placeholder="Confirm Password">
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6 text-left">
                                        <button type="submit" id="btn-add" class="btn btn-primary" form="login-form">
                                            Register
                                        </button>
                                    </div>
                                    <div class="col-md-6 text-right">
                                        <a href="login">Login</a>
                                    </div>
                                </div>
                            </div>

                        </form>


                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
