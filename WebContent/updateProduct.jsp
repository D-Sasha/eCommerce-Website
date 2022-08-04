<html>
<head>
<title>Update Product Information</title>
<link rel="stylesheet" href="styles.css">
<%@ include file="jdbc.jsp" %>
<%@ include file="updateproduct.html" %>

</head>
<body>
      <%
      try {
          getConnection();
          String sql = "UPDATE product SET productName = ?, productPrice = ?, productDesc = ? WHERE productId = ?";
          PreparedStatement pstmt = con.prepareStatement(sql);
          
          pstmt.setString(1,request.getParameter("pname"));
          pstmt.setDouble(2,Double.parseDouble(request.getParameter("pprice")));
          pstmt.setString(3,request.getParameter("pdesc"));
          pstmt.setInt(4,Integer.parseInt(request.getParameter("pid")));
          int test = pstmt.executeUpdate();
          System.out.println(test);

          out.print("Product Information has been updated!");
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
