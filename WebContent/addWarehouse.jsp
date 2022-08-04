<html>
<head>
<title>Warehouse Creation</title>
<link rel="stylesheet" href="styles.css">
<%@ include file="jdbc.jsp" %>
<%@ include file="createwarehouse.html" %>

</head>
<body>
      <%
      try {
          getConnection();
          String sql = "INSERT INTO warehouse(warehouseName) VALUES(?)";
          PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

          pstmt.setString(1, request.getParameter("wname"));
          int test = pstmt.executeUpdate();
          System.out.println(test);

          out.print("Warehouse has been created!");
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
