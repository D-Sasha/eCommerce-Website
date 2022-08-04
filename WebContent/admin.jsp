<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="content">
    <%@ include file="jdbc.jsp" %>
    <%@ include file="header.jsp" %>

<%
    getConnection();
// TODO: Include files auth.jsp and jdbc.jsp
boolean authenticated = session.getAttribute("authenticatedUser") == null ? false : true;

    if (!authenticated || !userName.equals("bobby"))
    {
        String loginMessage = "You have not been authorized to access the URL "+request.getRequestURL().toString();
        session.setAttribute("loginMessage",loginMessage);
        response.sendRedirect("login.jsp");
    }
    closeConnection();
%>

<form action="inventory.html">
    <input type="submit" value="Visit Warehouse" />
</form>
<form action="listCust.jsp">
    <input type="submit" value="Customer List" />
</form>
<form action="listOrd.jsp">
    <input type="submit" value="Order List" />
</form>
<form action="createproduct.html">
    <input type="submit" value="Create Product" />
</form>
<form action="updateproduct.html">
    <input type="submit" value="Update Product" />
</form>
<form action="deleteproduct.html">
    <input type="submit" value="Delete Product" />
</form>
<form action="createwarehouse.html">
    <input type="submit" value="Create Warehouse" />
</form>
<form action="updatewarehouse.html">
    <input type="submit" value="Update Warehouse" />
</form>
<form action="usercreate.html">
    <input type="submit" value="Create Customer Account" />
</form>
<form action="updateuser.html">
    <input type="submit" value="Update Customer Account" />
</form>

</div>
</body>
</html>
