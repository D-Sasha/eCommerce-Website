<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Grocery Order Processing</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>

<% 
// Make connection, need url uid & pw

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(new java.util.Locale("en", "CA"));

System.out.println("Connecting to database.");
Connection con = DriverManager.getConnection(url, uid, pw);

try {

    // Get customer id
    String custId = request.getParameter("customerId");
    @SuppressWarnings({"unchecked"})
    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

    // Determine if valid customer id was entered
    try{
        PreparedStatement idcheck = con.prepareStatement("IF EXISTS (SELECT customerId FROM customer WHERE customerid = ?)");
        idcheck.setString(1, custId);
        ResultSet rst = idcheck.executeQuery();
        rst.next();
        if (rst.getBoolean(1) == true)
            return;
        else
        System.out.println("Invalid Customer Id");
    }catch(SQLException e){
        System.out.println("Invalid Customer Id");
    }

    // Determine if there are products in the shopping cart
    try{
        PreparedStatement cartcheck = con.prepareStatement("IF EXISTS (SELECT productId FROM incart)");
        ResultSet rst = cartcheck.executeQuery();
        rst.next();
        if(rst.getBoolean(1) == true)
            return;
        else
        System.out.println("No Products In Cart");
    }catch(SQLException e){
        System.out.println("No Products In Cart");
    }

    // If either are not true, display an error message

    // Save order information to database
    String sql = "SELECT city, state, postalCode, country, customerId FROM customer WHERE customerId = ?";
    PreparedStatement stmt = con.prepareStatement(sql);
    stmt.setString(1, custId);
    ResultSet rst = stmt.executeQuery();
    rst.next();

    String sql1 = "SELECT price * quantity AS totalAmount FROM incart";
    PreparedStatement stmt1 = con.prepareStatement(sql1);
    ResultSet rst1 = stmt1.executeQuery();
    rst1.next();



    // Retrieve auto-generated key for orderId
    stmt = con.prepareStatement("INSERT INTO ordersummary(customerId, totalAmount, orderDate) VALUES (?, 0, ?);", Statement.RETURN_GENERATED_KEYS);
    stmt.setInt(1, Integer.parseInt(custId));
    stmt.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
    stmt.executeUpdate();
    ResultSet keys = stmt.getGeneratedKeys();
    keys.next();
    int orderId = keys.getInt(1);

    out.println("<h1>Your Order Summary</h1>");
        out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

        double total =0;
        Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
        while (iterator.hasNext())
        { 
            Map.Entry<String, ArrayList<Object>> entry = iterator.next();
            ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
            String productId = (String) product.get(0);
            out.print("<tr><td>"+productId+"</td>");
            out.print("<td>"+product.get(1)+"</td>");
            out.print("<td align=\"center\">"+product.get(3)+"</td>");
            String price = (String) product.get(2);
            double pr = Double.parseDouble(price);
            int qty = ( (Integer)product.get(3)).intValue();
            out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
            out.print("<td align=\"right\">"+currFormat.format(pr * qty)+"</td></tr>");
            out.println("</tr>");
            total = total +pr * qty;
            sql = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES(?, ?, ?, ?)";
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, orderId);
            stmt.setInt(2, Integer.parseInt(productId));
            stmt.setInt(3, qty);
            stmt.setString(4, price);
            stmt.executeUpdate();
        }
        out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
                       +"<td aling=\"right\">"+currFormat.format(total)+"</td></tr>");
        out.println("</table>");

     // Update order total
            sql = "UPDATE OrderSummary SET totalAmount=? WHERE orderId=?";
            stmt = con.prepareStatement(sql);
            stmt.setDouble(1, total);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();

    // Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

    // Print out order summary
        Iterator<Map.Entry<String, ArrayList<Object>>> iterator2 = productList.entrySet().iterator();
            while (iterator2.hasNext())
            { 
                Map.Entry<String, ArrayList<Object>> entry = iterator2.next();
                ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
                String productId = (String) product.get(0);
                String productName = (String) product.get(1);
                String quantity = (String) product.get(2);
                double qty = ( (Integer)product.get(3)).intValue();
                double pr = ( (Integer)product.get(3)).intValue();
                double sub=qty*pr;
                out.println("</table>");
            }
    out.println("</table>");
    out.println("<h1>Order completed. Will Be shipped soon...</h1>");
    out.println("<h1>Your order refrence number is: "+orderId+"</h1>");
    out.println("<h1>Shipping to customer: "+custId+"</h1>");

    // Clear cart if order placed successfully
    session.setAttribute("productList", null);
    con.close();

} catch (SQLException e) {
    System.out.println(e);
}
%>
</BODY>
</HTML>

