<html>
<head>
<title>Update Customer Information</title>
<link rel="stylesheet" href="styles.css">
<%@ include file="jdbc.jsp" %>
<%@ include file="updateuser.html" %>

</head>
<body>
      <%
      try {
          getConnection();
          String sql = "UPDATE customer SET firstName = ?, lastName = ?, email = ?, phonenum = ?, address = ?, city = ?, state = ?, postalCode = ?, country = ?, userid = ?, password = ? WHERE customerId = ?";
          PreparedStatement stmt = con.prepareStatement(sql);
          
          stmt.setString(1, request.getParameter("fname"));
          stmt.setString(2, request.getParameter("lname"));
          stmt.setString(3, request.getParameter("email"));
          stmt.setString(4, request.getParameter("pnum"));
          stmt.setString(5, request.getParameter("addy"));
          stmt.setString(6, request.getParameter("city"));
          stmt.setString(7, request.getParameter("st"));
          stmt.setString(8, request.getParameter("pcode"));
          stmt.setString(9, request.getParameter("ctry"));
          stmt.setString(10, request.getParameter("id"));
          stmt.setString(11, request.getParameter("pss"));
          stmt.setInt(12, Integer.parseInt(request.getParameter("cid")));
          int test = stmt.executeUpdate();
          System.out.println(test);

          out.print("Customer Information has been updated!");
      } finally {
          closeConnection();
          System.out.println("Connection has closed");
      }
      %>

      <form action="admin.jsp">
        <input type="submit" value="Return to Admin">
      </form>
      
</body>
</html>
