<!DOCTYPE html>
<html>
<head>
        <title>Cosmic Real Estate Main Page</title>
        <link rel="stylesheet" href="styles.css">
</head>
<body>
        <div class="topBar">
                <div class="spacer">
                <%
                        String userName = (String) session.getAttribute("authenticatedUser");
                        if(userName != null){
                                out.println("<h2 align=\"center\" style=\"padding-top: 30px\">"+userName+"</h2>");
                        }else{
                                out.println("<h2 align=\"center\" style=\"padding-top: 30px\"><a href=\"login.jsp\">Login</a></h2>");
                                out.println("<h2 align=\"center\" style=\"padding-top: 30px\"><a href=\"usercreate.html\">Create Account</a></h2>");
                        }
                %>
                </div>
                <h1 align="center" style="padding-top: 20px;">Cosmic Real Estate</h1>
                <div class="spacer">
                        <h2 align="center" style="padding-top: 30px;"><a href="index.jsp" style="color: var(--bg-color); background-color: var(--lk-color);">Home</a></h2>
                        <h2 align="center" style="padding-top: 30px;"><a href="listprod.jsp">Shopping</a></h2>
                        <h2 align="center" style="padding-top: 30px;"><a href="listorder.jsp">Orders</a></h2>
                        <h2 align="center" style="padding-top: 30px;"><a href="showcart.jsp">Cart</a></h2>
                </div>
        </div>
        <div class="content">
                <h1 align="center">Welcome to Cosmic Real Estate</h1>

                <h2 align="center" style="margin-top: 80px;"><a href="login.jsp">Login</a></h2>

                <h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

                <h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

                <h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

                <h2 align="center"><a href="admin.jsp">Administrators</a></h2>

                <h2 align="center"><a href="logout.jsp">Log out</a></h2>
        </div>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)	
%>
</body>
</head>


