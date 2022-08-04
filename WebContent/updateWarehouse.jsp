<html>
<head>
<title>Update Warehouse Information</title>
<%@ include file="jdbc.jsp" %>
<%@ include file="updatewarehouse.html" %>
<link rel="stylesheet" href="styles.css">

</head>
<body>
      <%
      try {
          getConnection();
          String sql = "UPDATE warehouse SET warehouseName = ? WHERE warehouseId = ?";
          PreparedStatement pstmt = con.prepareStatement(sql);
          
          pstmt.setString(1,request.getParameter("wname"));
          pstmt.setInt(2,Integer.parseInt(request.getParameter("wid")));
          int test = pstmt.executeUpdate();
          System.out.println(test);

          out.print("Warehouse Information has been updated!");
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
