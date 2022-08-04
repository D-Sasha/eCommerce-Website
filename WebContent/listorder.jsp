<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<title>Cosmic Real Estate</title>
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
                        }
                %>
        </div>
        <h1 align="center" style="padding-top: 20px;">Cosmic Real Estate</h1>
        <div class="spacer">
                <h2 align="center" style="padding-top: 30px;"><a href="index.jsp">Home</a></h2>
                <h2 align="center" style="padding-top: 30px;"><a href="listprod.jsp">Shopping</a></h2>
                <h2 align="center" style="padding-top: 30px;"><a href="listorder.jsp" style="color: var(--bg-color); background-color: var(--lk-color);">Orders</a></h2>
                <h2 align="center" style="padding-top: 30px;"><a href="showcart.jsp">Cart</a></h2>
        </div>
    </div>
    <%@ include file="auth.jsp"%>
    <div class="content">
<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{    // Load driver class
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
    out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

// Write query to retrieve all order summary records
try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) 
{
    PreparedStatement pstmt1 = con.prepareStatement("SELECT orderId, orderDate, customer.customerId, firstname, lastname, totalAmount, customer.userId FROM orderSummary JOIN customer ON orderSummary.customerId = customer.customerId WHERE customer.userId = ?");
    String user = (String) session.getAttribute("authenticatedUser");
    pstmt1.setString(1, user);
    ResultSet rst1 = pstmt1.executeQuery();
        while(rst1.next())
        {
            out.println("<table border=1><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
            out.println("<tr><td>"+rst1.getInt("orderId")+"</td><td>"+rst1.getDate("orderDate")+"</td><td>"+rst1.getInt("customerId")+"</td><td>"+rst1.getString("firstname")+ " " + rst1.getString("lastname")+"</td><td>$"+rst1.getDouble("totalAmount")+ "</td></tr>");
            out.println("<tr><td colspan=5 align=\"right\">");
            PreparedStatement pstmt2 = con.prepareStatement("SELECT orderproduct.productId, orderproduct.quantity, orderproduct.price FROM ordersummary JOIN orderproduct ON ordersummary.orderId = orderproduct.orderId WHERE ordersummary.orderId = ?");
            pstmt2.setInt(1,rst1.getInt("orderId"));
            ResultSet rst2 = pstmt2.executeQuery();
			out.println("<tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
            while(rst2.next()){
                out.println("<tr><td>"+rst2.getInt("productId")+"</td><td>"+rst2.getInt("quantity")+"</td><td>$"+rst2.getDouble("price")+"</td></tr>");
            }
        }
    out.println("</table>");
    }catch (SQLException ex) 
{     out.println(ex); 
}

// For each order in the ResultSet

    // Print out the order summary information
    // Write a query to retrieve the products in the order
    //   - Use a PreparedStatement as will repeat this query many times
    // For each product in the order
        // Write out product information 

// Close connection
%>
    </div>
</body>
</html>
