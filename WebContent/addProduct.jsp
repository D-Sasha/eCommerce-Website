<html>
<head>
<title>Product Creation</title>
<link rel="stylesheet" href="styles.css">
<%@ include file="jdbc.jsp" %>
<%@ include file="createproduct.html" %>

</head>
<body>
      <%
      try {
          getConnection();
          String sql = "INSERT INTO product(productName, productPrice, productDesc) VALUES(?,?,?)";
          PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
          
          pstmt.setString(1, request.getParameter("pname"));
          pstmt.setDouble(2, Double.parseDouble(request.getParameter("pprice")));
          pstmt.setString(3, request.getParameter("pdesc"));
          int test = pstmt.executeUpdate();
          System.out.println(test);

          out.print("Product has been created!");
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
