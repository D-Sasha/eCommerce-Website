<!DOCTYPE html>
<html>
<head>
	<title>Customer Page</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<div class="content">
	<h1 align="center">User Information</h1>

	<%
	// TODO: Print Customer information
	String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM Customer C  WHERE userId = ?";

	try {
		getConnection();
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, userName);
		ResultSet rst = pstmt.executeQuery();

		if (!rst.next()) {
			out.println("Invalid customer");
		} else {
			out.println("<h3>"+"Customer Id: "+rst.getString(1)+"</h3>");
			out.println("<h3>"+"First Name: "+rst.getString(2)+"</h3>");
			out.println("<h3>"+"Last Name: "+rst.getString(3)+"</h3>");
			out.println("<h3>"+"Email: "+rst.getString(4)+"</h3>");
			out.println("<h3>"+"Phone Number: "+rst.getString(5)+"</h3>");
			out.println("<h3>"+"Address: "+rst.getString(6)+"</h3>");
			out.println("<h3>"+"City: "+rst.getString(7)+"</h3>");
			out.println("<h3>"+"State: "+rst.getString(8)+"</h3>");
			out.println("<h3>"+"Postal Code: "+rst.getString(9)+"</h3>");
			out.println("<h3>"+"Country: "+rst.getString(10)+"</h3>");
			out.println("<h3>"+"User ID: "+rst.getString(11)+"</h3>");
			out.println("<h3>"+"Password: "+rst.getString(12)+"</h3>");

			out.println("<h2 align=\"center\" style=\"padding-top: 30px\"><a href=\"updateuser.html\">Update Account Details</a></h2>");

		}
	} catch (SQLException ex) {
		out.println(ex);
	} finally {
		// Make sure to close connection
		closeConnection();
	}
	%>
</div>

</body>
</html>

