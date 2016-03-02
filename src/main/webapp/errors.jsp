<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/cart-styles.css">
    <title>User Logged out</title>
</head>
<body>
<div id="container">
    <div id="header-area">
        <img src="images/cart-logo.gif" alt="Logo" vspace="10" />

    </div>
    <div id="content-area">
        <div class="cart-tabs">
            <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td class="cart-tab-left"><img src="images/cart-tab-left.gif"
                                                   alt="-"></td>
                    <td class="cart-tab-mid"><a>Home</a></td>
                    <td class="cart-tab-right"><img
                            src="images/cart-tab-right.gif" alt="-"></td>
                </tr>
            </table>
        </div>
        <table cellpadding="0" cellspacing="0" border="0" class="cart-expbox">
            <tr>
                <td><img src="images/cart-expbox-01.gif" alt="-"></td>
                <td class="cart-expbox-02">&nbsp</td>
                <td><img src="images/cart-expbox-03.gif" alt="-"></td>
            </tr>
            <tr>
                <td class="cart-expbox-08">&nbsp</td>
                <td class="cart-expbox-09">
                    <!--all content for cart and links goes here-->
                </td>
                <td class="cart-expbox-04">&nbsp</td>
            </tr>
            <tr>
                <td><img src="images/cart-expbox-07.gif" alt="-"></td>
                <td class="cart-expbox-06">&nbsp</td>
                <td><img src="images/cart-expbox-05.gif" alt="-"></td>
            </tr>

        </table>
        <h1>Travelocity.COM</h1>
        <hr />
        <a href="../avis.com"> Avis.COM </a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="index.jsp"> Go to Login page </a>
        <hr/>
        <h2>An error has occurred</h2>
        <%=exception.getMessage()%>
        <hr/>
    </div>
    <div id="footer-area">
        <p>©2015 WSO2</p>
    </div>
</div>
</body>
</html>
