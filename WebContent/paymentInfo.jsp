<html>
<head>
<link rel="stylesheet" href="style.css"/>
<%@ include file="header.jsp" %> 
<title>Cosmic Real Estate</title>
<style type="text/css">



</style>
</head>
<body>
  <h1>Please complete the following information to complete your order</h1>
<div class="row">
      <%
      String custId = request.getParameter("customerId");
      session.setAttribute("customerId", custId);
      %>
      <form method="get" action="order.jsp">
        <input type = "hidden" name = "customerId" value = <%out.print(custId);%>>
        <div class="row">
            <h3>Shipping Address</h3>
            <label for="fname">Full Name</label>
            <input type="text" id="fname" name="firstname" placeholder="Matthew Frans">
            </div>
        <div class="row">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="matt@gmail.com">
          </div>
        <div class="row">
            <label for="adr">Address</label>
            <input type="text" id="adr" name="address" placeholder="1337 Kingston Avenue">
          </div>
        <div class="row">
            <label for="city">City</label>
            <input type="text" id="city" name="city" placeholder="Kelowna">
          </div>
        <div class="row">
            <label for="state">State</label>
            <input type="text" id="state" name="state" placeholder="BC" required minlength="2" maxlength="2">
          </div>
        <div class="row">
            <label for="postalCode">Postal Code</label>
            <input type="text" id="postalCode" name="postalCode" placeholder="V1V1V1" required minlength="6" maxlength="6">
          </div>
          <label>
            <input type="checkbox" checked="checked" name="billingaddress"> Billing address same as Shipping address
          </label>
          <div class="row">
            <h3>Payment Information</h3>
            <label for="customername">Name on Card</label>
            <input type="text" id="customername" name="cardname" placeholder="Matthew Frans">
            <label for="creditcardnum">Credit Card Number</label>
            <input type="number" id="creditcardnum" name="cardnumber" placeholder="1111222233334444" oninput="this.value=this.value.slice(0,this.maxLength)" required minlength="16" maxlength="16">
          </div>
            <div class="row">
                <label for="expmonth">Exp Month / Exp Year</label>
                <input type="month" id="expdate" name="expdate">
            </div>
              <div class="row">
                <label for="cvv">CVV</label>
                <input type="number" id="cvv" name="cvv" placeholder="111" oninput="this.value=this.value.slice(0,this.maxLength)" required minlength="3" maxlength="3">
              </div>
        <input type="submit" value="Continue to checkout" class="btn">
      </form>
    </div>
  </div>
</div>


