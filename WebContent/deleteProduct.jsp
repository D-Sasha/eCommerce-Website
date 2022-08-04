<html>
<head>
<title>Product Deletion</title>
<link rel="stylesheet" href="styles.css">
<%@ include file="jdbc.jsp" %>
<%@ include file="deleteproduct.html" %>

</head>
<body>
      <%
      try {
          getConnection();
          String sql = "DELETE FROM product WHERE productId = ?";
          PreparedStatement pstmt = con.prepareStatement(sql);
          pstmt.setInt(1, Integer.parseInt(request.getParameter("pid")));
          int test = pstmt.executeUpdate();
          System.out.println(test);

          out.print("Product has been deleted!");
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
