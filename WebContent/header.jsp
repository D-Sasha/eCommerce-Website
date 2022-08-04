<link rel="stylesheet" href="styles.css">
<div class="topBar">
    <div class="spacer">
                <%
                        String userName = (String) session.getAttribute("authenticatedUser");
                        if(userName != null){
                                out.println("<h2 align=\"center\" style=\"padding-top: 30px\">"+userName+"</h2>");
                        }else{
                                out.println("<h2 align=\"center\" style=\"padding-top: 30px\"><a href=\"login.jsp\">Login</a></h2>");
                        }
                %>
    </div>
    <h1 align="center" style="padding-top: 20px;">Cosmic Real Estate</h1>
    <div class="spacer">
            <h2 align="center" style="padding-top: 30px;"><a href="index.jsp">Home</a></h2>
            <h2 align="center" style="padding-top: 30px;"><a href="listprod.jsp">Shopping</a></h2>
            <h2 align="center" style="padding-top: 30px;"><a href="listorder.jsp">Orders</a></h2>
            <h2 align="center" style="padding-top: 30px;"><a href="showcart.jsp">Cart</a></h2>
    </div>
</div>