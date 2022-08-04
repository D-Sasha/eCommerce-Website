<!DOCTYPE html>
<html>
<head>
<title>Cosmic Real Estate Checkout Line</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>
    <%@ include file="header.jsp" %>
<div class="content">

<h1>Enter your customer id and password to complete the transaction:</h1>

<form method="get" action="paymentInfo.jsp">
<table style="display:inline; box-shadow: none;">
<tr><td>Customer ID:</td><td><input type="text" name="customerId" size="20"></td></tr>
<tr><td>Password:</td><td><input type="password" name="password" size="20"></td></tr>
<tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
</table>
</form>

</div>
</body>
</html>
