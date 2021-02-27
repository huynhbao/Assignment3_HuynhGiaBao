<%-- 
    Document   : invalid
    Created on : Jan 19, 2021, 11:28:08 AM
    Author     : HuynhBao
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invalid Page</title>
    </head>
    <body>
        <div style="text-align: center;">
            <h1 style="margin-top: 140px;">${requestScope.MSG != null ? requestScope.MSG : 'ERROR! Try again!!'}</h1>
            <c:set var="url" value="student"/>
            <a href="shopping" style="margin-top: 150px;">Back to home</a>
        </div>
    </body>
</html>
