<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Cosmic Real Estate - Product Information</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>

	<%@ include file="header.jsp" %>

<div class="content">
<%
// Get product name to search for
String productId = request.getParameter("id");

String sql = "SELECT productId, productName, productPrice, productImageURL, productDesc FROM Product P  WHERE productId = ?";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{
	getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(productId));			
	
	ResultSet rst = pstmt.executeQuery();
			
	if (!rst.next())
	{
		out.println("Invalid product");
	}
	else
	{		
		out.println("<h1>"+rst.getString(2)+"</h1>");
		
		int prodId = rst.getInt(1);
		out.println("<table style=\"box-shadow: none;\"><tr>");
		out.println("<th>Id</th><td>" + prodId + "</td></tr>"				
				+ "<tr><th>Price</th><td>" + "$" + (rst.getBigDecimal(3)) + "</td></tr></table>");
		
		//  Retrieve any image with a URL
		String imageLoc = rst.getString(4);
		if (imageLoc != null)
			out.println("<img src='" + imageLoc + "?"+System.currentTimeMillis() + "' />");
	
		out.println("<h3>"+rst.getString(5)+"</h3>");

		out.println("<h2><a href=\"addcart.jsp?id="+prodId+ "&name=" + rst.getString(2)
								+ "&price=" + rst.getBigDecimal(3)+"\">Add to Cart</a></h2>");		
		
		out.println("<h2><a href=\"listprod.jsp\">Continue Shopping</a>");

		//review stuff here

		out.println("<br><br><br><h1>Reveiws</h1>");

		String sql2 = "SELECT reviewId, reviewRating, reviewDate, userid, productId, reviewComment FROM review LEFT JOIN customer ON review.customerId = customer.customerId WHERE productId = ?";
		PreparedStatement pstmt2 = con.prepareStatement(sql2);
		pstmt2.setInt(1, Integer.parseInt(productId));
		ResultSet rst2 = pstmt2.executeQuery();
		if(!rst2.next()){
			out.println("<h3>No reviews</h3>");
		}else{
			out.println("<table border=1>");
			out.println("<tr><th>Rating 0-5</th><th>Date</th><th>Customer</th><th>Comment</th></tr>");
			out.println("<tr><td>"+rst2.getInt("reviewRating")+"/5</td><td>"+rst2.getDate("reviewDate")+"</td><td>"+rst2.getString("userid")+"</td><td>"+rst2.getString("reviewComment")+"</td></tr>");
			out.println("</table>");
			while(rst2.next())
        	{
				out.println("<table border=1>");
				out.println("<tr><th>Rating 0-5</th><th>Date</th><th>Customer</th><th>Comment</th></tr>");
				out.println("<tr><td>"+rst2.getInt("reviewRating")+"/5</td><td>"+rst2.getDate("reviewDate")+"</td><td>"+rst2.getString("userid")+"</td><td>"+rst2.getString("reviewComment")+"</td></tr>");
				out.println("</table>");
			}
		}
	}
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}
%>
<form action="createreview.jsp">
	<input type="submit" value="Write a review">
	<input type="hidden" id="prodId" name="prodId" value="<%= productId %>">
</form>

</div>
</body>
</html>