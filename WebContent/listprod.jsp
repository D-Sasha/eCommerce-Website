<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
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
                <h2 align="center" style="padding-top: 30px;"><a href="listprod.jsp" style="color: var(--bg-color); background-color: var(--lk-color);">Shopping</a></h2>
                <h2 align="center" style="padding-top: 30px;"><a href="listorder.jsp">Orders</a></h2>
				<h2 align="center" style="padding-top: 30px;"><a href="showcart.jsp">Cart</a></h2>
        </div>
	</div>
	<div class="content">

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp" style="padding-left: 20px;">
	<p align="left">
	<select size="1" name="categoryName">
	<option>All</option>  
	<option>Habitable Planets</option>
	<option>Uninhabitable Planets</option>
	<option>Asteroids</option>
	</select>
	<input type="text" name="productName" size="50">
	<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)</p>
  </form>

  <%
// Colors for different item categories
HashMap<String,String> colors = new HashMap<String,String>();
colors.put("Habitable Planets", "#00CC00");
colors.put("Uninhabitable Planets", "#FF0000");
colors.put("Asteroids", "#C4A484");
%>

<% // Get product name to search for
String name = request.getParameter("productName");
String category = request.getParameter("categoryName");

boolean hasNameParam = name != null && !name.equals("");
boolean hasCategoryParam = category != null && !category.equals("") && !category.equals("All");
String filter = "", sql = "";

if (hasNameParam && hasCategoryParam)
{
	filter = "<h3>Products containing '"+name+"' in category: '"+category+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL FROM Product P LEFT JOIN Category C ON P.categoryId = C.categoryId WHERE productName LIKE ? AND categoryName = ?";
}
else if (hasNameParam)
{
	filter = "<h3>Products containing '"+name+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL FROM Product P LEFT JOIN Category C ON P.categoryId = C.categoryId WHERE productName LIKE ?";
}
else if (hasCategoryParam)
{
	filter = "<h3>Products in category: '"+category+"'</h3>";
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL FROM Product P LEFT JOIN Category C ON P.categoryId = C.categoryId WHERE categoryName = ?";
}
else
{
	filter = "<h3>All Products</h3>";
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL FROM Product P LEFT JOIN Category C ON P.categoryId = C.categoryId";
}

out.println(filter);
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

System.out.println("Connecting to database.");
Connection con = DriverManager.getConnection(url, uid, pw);

// Print out the ResultSet
try {
	PreparedStatement pstmt = con.prepareStatement(sql);
	if (hasNameParam)
	{
		pstmt.setString(1, name);	
		if (hasCategoryParam)
		{
			pstmt.setString(2, category);
		}
	}
	else if (hasCategoryParam)
	{
		pstmt.setString(1, category);
	}
	
	ResultSet rst = pstmt.executeQuery();

	out.print("<font face=\"Century Gothic\" size=\"3\"><table class=\"table\" border=\"1\"><tr><th class=\"col-md-1\"></th><th>Product Image</th>");
		out.println("<th>Product Name</th><th>Category</th><th>Price</th></tr>");
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();


	while (rst.next()) 
	{
		int id = rst.getInt(1);
		out.print("<td class=\"col-md-1\"><a href=\"addcart.jsp?id=" + id + "&name=" + rst.getString(2)
				+ "&price=" + rst.getBigDecimal(3) + "\">Add to Cart</a></td>");

		String itemCategory = rst.getString(4);
		String imageLoc = rst.getString(5);
		String color = (String) colors.get(itemCategory);
		if (color == null)
			color = "#FFFFFF";

		System.out.println(rst.getString(2));
		out.println("<td><img style='height: 50%; width: 50%; object-fit: contain' src='" + imageLoc + "?"+System.currentTimeMillis() + "'></td>"
				+ "<td><a href=\"product.jsp?id="+id+"\"<font color=\"" + color + "\">" + rst.getString(2) + "</font></td>"
				+ "<td><font color=\"" + color + "\">" + itemCategory + "</font></td>"
				+ "<td><font color=\"" + color + "\">" + "$" + rst.getBigDecimal(3)
				+ "</font></td></tr>");
	}
	out.println("</table></font>");
} catch (SQLException ex) { 
	out.println(ex); 
}

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice

// Close connection
try {
	if (con != null) {
	    con.close();
	}
} catch (SQLException ex) {
	System.out.println(ex);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0));	// Prints $5.00
%>
	</div>
</body>
</html>